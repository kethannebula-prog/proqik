package com.proqik.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class VendorSetupServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        String email = (String) session.getAttribute("user");
        String profileEmail = req.getParameter("email");
        
        if (profileEmail != null && !profileEmail.equals(email)) {
            res.sendRedirect(req.getContextPath() + "/vendor/setup?email=" + email);
            return;
        }
        
        if (profileEmail == null) {
            profileEmail = email;
        }
        
        req.setAttribute("email", profileEmail);
        req.getRequestDispatcher("/WEB-INF/views/auth/vendor-setup.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        String step = req.getParameter("step");
        String category = req.getParameter("category");
        String businessName = req.getParameter("businessName");
        String experience = req.getParameter("experience");
        String location = req.getParameter("location");
        String description = req.getParameter("description");
        String serviceName = req.getParameter("serviceName");
        String priceStart = req.getParameter("priceStart");
        String duration = req.getParameter("duration");
        String serviceIncludes = req.getParameter("serviceIncludes");
        
        if (category != null && !category.isEmpty()) {
            session.setAttribute("vendorCategory", category);
        }
        if (businessName != null && !businessName.isEmpty()) {
            session.setAttribute("vendorBusinessName", businessName);
        }
        if (experience != null && !experience.isEmpty()) {
            session.setAttribute("vendorExperience", experience);
        }
        if (location != null && !location.isEmpty()) {
            session.setAttribute("vendorLocation", location);
        }
        if (description != null && !description.isEmpty()) {
            session.setAttribute("vendorDescription", description);
        }
        if (serviceName != null && !serviceName.isEmpty()) {
            session.setAttribute("vendorServiceName", serviceName);
        }
        if (priceStart != null && !priceStart.isEmpty()) {
            session.setAttribute("vendorPriceStart", priceStart);
        }
        if (duration != null && !duration.isEmpty()) {
            session.setAttribute("vendorDuration", duration);
        }
        if (serviceIncludes != null && !serviceIncludes.isEmpty()) {
            session.setAttribute("vendorServiceIncludes", serviceIncludes);
        }
        
        session.setAttribute("profileStatus", "pending_verify");
        
        res.sendRedirect(req.getContextPath() + "/dashboard");
    }
}