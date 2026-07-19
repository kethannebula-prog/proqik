package com.proqik.controller;

import com.proqik.repository.UserRepository;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.Base64;

public class OAuth2CallbackServlet extends HttpServlet {

    private static final String CLIENT_ID = System.getenv("GOOGLE_CLIENT_ID") != null ? System.getenv("GOOGLE_CLIENT_ID") : "";
    private static final String CLIENT_SECRET = System.getenv("GOOGLE_CLIENT_SECRET") != null ? System.getenv("GOOGLE_CLIENT_SECRET") : "";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String code = req.getParameter("code");
        String state = req.getParameter("state");
        String error = req.getParameter("error");

        HttpSession session = req.getSession(false);

        if (error != null || session == null) {
            System.out.println("OAuth callback: error=" + error + " session=" + (session != null));
            res.sendRedirect(req.getContextPath() + "/signup" + (error != null ? "?error=" + error : ""));
            return;
        }

        String savedState = (String) session.getAttribute("oauthState");
        if (savedState == null || !savedState.equals(state)) {
            System.out.println("OAuth callback: state mismatch saved=" + savedState + " received=" + state);
            res.sendRedirect(req.getContextPath() + "/signup");
            return;
        }
        session.removeAttribute("oauthState");

        String idToken = exchangeCodeForToken(code, req);
        if (idToken == null) {
            System.out.println("OAuth callback: token exchange failed");
            res.sendRedirect(req.getContextPath() + "/signup");
            return;
        }

        String payload = decodeJwtPayload(idToken);
        if (payload == null) {
            System.out.println("OAuth callback: failed to decode ID token");
            res.sendRedirect(req.getContextPath() + "/signup");
            return;
        }

        String email = extractJsonValue(payload, "email");
        String name = extractJsonValue(payload, "name");
        if (email == null) {
            System.out.println("OAuth callback: email not found in ID token");
            res.sendRedirect(req.getContextPath() + "/signup");
            return;
        }

        System.out.println("OAuth callback: success for email=" + email + " name=" + name);

        String[] existingUser = UserRepository.getUser(email);
        if (existingUser != null) {
            String status = existingUser.length > 3 ? existingUser[3] : "complete";
            System.out.println("OAuth callback: existing user, status=" + status);

            if ("complete".equals(status) || "active".equals(status) || "approved".equals(status)) {
                session.setAttribute("user", email);
                session.setAttribute("userName", existingUser[1]);
                session.setAttribute("role", existingUser[2]);
                session.setAttribute("profileStatus", status);
                res.sendRedirect(req.getContextPath() + "/dashboard");
                return;
            } else if ("rejected".equals(status)) {
                res.sendRedirect(req.getContextPath() + "/login?error=rejected");
                return;
            } else {
                res.sendRedirect(req.getContextPath() + "/login?error=pending");
                return;
            }
        }

        session.setAttribute("google_email", email);
        session.setAttribute("google_name", name != null ? name : "New Vendor");
        session.setAttribute("google_verified", true);

        res.sendRedirect(req.getContextPath() + "/signup?google=success");
    }

    private String exchangeCodeForToken(String code, HttpServletRequest req) {
        try {
            URL url = new URL("https://oauth2.googleapis.com/token");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(10000);

            String body = "code=" + URLEncoder.encode(code, "UTF-8")
                + "&client_id=" + URLEncoder.encode(CLIENT_ID, "UTF-8")
                + "&client_secret=" + URLEncoder.encode(CLIENT_SECRET, "UTF-8")
                + "&redirect_uri=" + URLEncoder.encode(getRedirectUri(req), "UTF-8")
                + "&grant_type=authorization_code";

            OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
            writer.write(body);
            writer.flush();
            writer.close();

            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                BufferedReader errReader = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
                StringBuilder errBody = new StringBuilder();
                String line;
                while ((line = errReader.readLine()) != null) {
                    errBody.append(line);
                }
                errReader.close();
                System.out.println("Token exchange HTTP " + responseCode + ": " + errBody.toString());
                return null;
            }

            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();

            String json = response.toString();
            System.out.println("Token exchange response (200, " + json.length() + " chars): " + json);
            int keyIdx = json.indexOf("\"id_token\"");
            if (keyIdx < 0) {
                System.out.println("Token exchange: id_token key not found in response");
                return null;
            }
            int colonIdx = json.indexOf(":", keyIdx);
            if (colonIdx < 0) return null;
            int quoteIdx = json.indexOf("\"", colonIdx);
            if (quoteIdx < 0) return null;
            int start = quoteIdx + 1;
            int end = json.indexOf("\"", start);
            if (end < 0) return null;
            return json.substring(start, end);

        } catch (Exception e) {
            System.out.println("Token exchange failed: " + e.getMessage());
            return null;
        }
    }

    private String decodeJwtPayload(String idToken) {
        try {
            String[] parts = idToken.split("\\.");
            if (parts.length < 2) return null;
            return new String(Base64.getUrlDecoder().decode(parts[1]));
        } catch (Exception e) {
            System.out.println("Failed to decode ID token: " + e.getMessage());
            return null;
        }
    }

    private String extractJsonValue(String json, String key) {
        String search = "\"" + key + "\":\"";
        int start = json.indexOf(search);
        if (start < 0) {
            search = "\"" + key + "\": \"";
            start = json.indexOf(search);
            if (start < 0) return null;
        }
        start += search.length();
        int end = json.indexOf("\"", start);
        if (end < 0) return null;
        return json.substring(start, end);
    }

    public static String generateState() {
        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[32];
        random.nextBytes(bytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(bytes);
    }

    private static String getRedirectUri(HttpServletRequest req) {
        String forwardedProto = req.getHeader("X-Forwarded-Proto");
        String scheme = forwardedProto != null ? forwardedProto : req.getScheme();
        String forwardedHost = req.getHeader("X-Forwarded-Host");
        String host = forwardedHost != null ? forwardedHost : req.getServerName();
        String ctx = req.getContextPath();
        int port = req.getServerPort();
        if (forwardedHost != null) {
            if (forwardedHost.contains(":")) {
                String[] parts = forwardedHost.split(":");
                host = parts[0];
                port = Integer.parseInt(parts[1]);
            } else {
                port = "https".equals(scheme) ? 443 : 80;
            }
        }
        if ((scheme.equals("http") && port == 80) || (scheme.equals("https") && port == 443)) {
            return scheme + "://" + host + ctx + "/oauth2callback";
        }
        return scheme + "://" + host + ":" + port + ctx + "/oauth2callback";
    }

    public static String buildAuthUrl(HttpServletRequest req) throws java.io.UnsupportedEncodingException {
        HttpSession session = req.getSession(true);
        String state = generateState();
        session.setAttribute("oauthState", state);

        String redirectUri = getRedirectUri(req);
        String authUrl = "https://accounts.google.com/o/oauth2/v2/auth"
            + "?client_id=" + CLIENT_ID
            + "&redirect_uri=" + URLEncoder.encode(redirectUri, "UTF-8")
            + "&response_type=code"
            + "&scope=openid%20email%20profile"
            + "&access_type=offline"
            + "&state=" + state
            + "&prompt=select_account";

        System.out.println("OAuth auth URL: " + authUrl);
        return authUrl;
    }
}
