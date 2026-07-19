package com.proqik.controller;

import com.proqik.util.OtpService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class OtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String path = req.getServletPath();
        res.setContentType("application/json");
        res.setCharacterEncoding("UTF-8");

        if ("/send-otp".equals(path)) {
            handleSendOtp(req, res);
        } else if ("/verify-otp".equals(path)) {
            handleVerifyOtp(req, res);
        } else {
            res.setStatus(HttpServletResponse.SC_NOT_FOUND);
            res.getWriter().write("{\"success\":false,\"message\":\"Unknown endpoint\"}");
        }
    }

    private void handleSendOtp(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String email = req.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            res.getWriter().write("{\"success\":false,\"message\":\"Email is required\"}");
            return;
        }

        try {
            OtpService.sendOtp(email.trim());
            res.getWriter().write("{\"success\":true,\"message\":\"OTP sent to your email\"}");
        } catch (Exception e) {
            res.getWriter().write("{\"success\":false,\"message\":\"Failed to send OTP: " + e.getMessage() + "\"}");
        }
    }

    private void handleVerifyOtp(HttpServletRequest req, HttpServletResponse res) throws IOException {
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        if (email == null || otp == null || email.trim().isEmpty() || otp.trim().isEmpty()) {
            res.getWriter().write("{\"success\":false,\"message\":\"Email and OTP are required\"}");
            return;
        }

        boolean valid = OtpService.verifyOtp(email.trim(), otp.trim());
        if (valid) {
            res.getWriter().write("{\"success\":true,\"message\":\"OTP verified successfully\"}");
        } else {
            res.getWriter().write("{\"success\":false,\"message\":\"Invalid or expired OTP\"}");
        }
    }
}
