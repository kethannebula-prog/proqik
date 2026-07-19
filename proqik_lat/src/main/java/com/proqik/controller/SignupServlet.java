package com.proqik.controller;

import com.proqik.repository.UserRepository;
import com.proqik.util.DBConnection;
import com.proqik.controller.OAuth2CallbackServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class SignupServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(true);

        String googleParam = req.getParameter("google");
        if ("success".equals(googleParam)) {
            Boolean gv = (Boolean) session.getAttribute("google_verified");
            String ge = (String) session.getAttribute("google_email");
            String gn = (String) session.getAttribute("google_name");
            if (gv != null && gv && ge != null) {
                req.setAttribute("googleVerified", true);
                req.setAttribute("googleEmail", ge);
                req.setAttribute("googleName", gn);
                req.setAttribute("justVerified", true);
                String savedName = (String) session.getAttribute("signup_name");
                String savedPhone = (String) session.getAttribute("signup_phone");
                if (savedName != null) req.setAttribute("savedName", savedName);
                if (ge != null) req.setAttribute("savedEmail", ge);
                if (savedPhone != null) req.setAttribute("savedPhone", savedPhone);
            }
        }

        req.getRequestDispatcher("/WEB-INF/views/auth/signup.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String googleAction = req.getParameter("google");
        if ("1".equals(googleAction)) {
            HttpSession session = req.getSession(true);
            session.setAttribute("signup_name", req.getParameter("fullName"));
            session.setAttribute("signup_phone", req.getParameter("phone"));
            session.setAttribute("signup_service", req.getParameter("service"));
            String authUrl = OAuth2CallbackServlet.buildAuthUrl(req);
            System.out.println("Google OAuth: saved form data, redirecting to Google");
            res.sendRedirect(authUrl);
            return;
        }

        System.out.println("=== SignupServlet.doPost START ===");

        HttpSession session = req.getSession(true);
        Boolean googleVerified = (Boolean) session.getAttribute("google_verified");
        String googleEmail = (String) session.getAttribute("google_email");
        String googleName = (String) session.getAttribute("google_name");

        if (googleVerified == null || !googleVerified || googleEmail == null) {
            System.out.println("ERROR: Google verification required for signup");
            res.sendRedirect(req.getContextPath() + "/signup?error=googleRequired");
            return;
        }

        String email = googleEmail;
        String fullName = req.getParameter("fullName");
        if (fullName == null || fullName.trim().isEmpty()) {
            fullName = googleName != null ? googleName : "New Vendor";
        }
        String phone = req.getParameter("phone");
        if (phone == null || phone.trim().isEmpty()) {
            phone = "0000000000";
        }
        String service = req.getParameter("service");
        if (service == null || service.isEmpty()) {
            service = "photography";
        }
        String categories = req.getParameter("categories");
        if (categories == null || categories.isEmpty()) {
            categories = "Wedding";
        }
        String password = "google_" + System.currentTimeMillis();

        System.out.println("Received - name: " + fullName + ", email: " + email + ", service: " + service);

        boolean dbConnected = DBConnection.testConnection();
        System.out.println("DB Connected: " + dbConnected);

        boolean savedToDB = false;
        if (dbConnected) {
            UserRepository.initTable();
            String[] existingUser = UserRepository.getUser(email);
            System.out.println("DEBUG: checking user " + email + ", found: " + (existingUser != null));
            if (existingUser != null) {
                System.out.println("User already exists: " + email);
                res.sendRedirect(req.getContextPath() + "/signup?error=exists");
                return;
            }
            savedToDB = UserRepository.createUser(email, password, fullName, "VENDOR", "incomplete", phone, service);
            System.out.println("Saved to DB: " + savedToDB + ", service: " + service);
        }

        if (!savedToDB && !dbConnected) {
            System.out.println("WARNING: DB unavailable");
        }

        if (!savedToDB && !dbConnected) {
            res.sendRedirect(req.getContextPath() + "/signup?error=dbError");
            return;
        }

        session.removeAttribute("google_verified");
        session.removeAttribute("google_email");
        session.removeAttribute("google_name");
        session.removeAttribute("signup_name");
        session.removeAttribute("signup_phone");
        session.removeAttribute("signup_service");

        System.out.println("User created, redirecting to success page: " + email);
        res.sendRedirect(req.getContextPath() + "/signup?submitted=true");
    }
}