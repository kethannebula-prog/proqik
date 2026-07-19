package com.proqik.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class RegisterServlet extends HttpServlet {

    private static final Map<String, String[]> USERS = new HashMap<>();
    
    static {
        USERS.put("admin@proqik.in", new String[]{"admin123", "Admin", "ADMIN", "complete"});
        USERS.put("vendor@proqik.in", new String[]{"vendor123", "Vendor", "VENDOR", "incomplete"});
        USERS.put("testvendor@proqik.in", new String[]{"vendor123", "Test Vendor", "VENDOR", "complete"});
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html");
        res.getWriter().write("<!DOCTYPE html><html><head><title>Register</title>" +
            "<link href='https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700&display=swap' rel='stylesheet'>" +
            "<style>body{font-family:'Plus Jakarta Sans',sans-serif;background:#f0f5ff;display:flex;align-items:center;justify-content:center;min-height:100vh;margin:0}.box{background:#fff;padding:40px;border-radius:12px;box-shadow:0 4px 24px rgba(18,47,102,0.1);width:100%;max-width:400px}h1{color:#122f66;margin:0 0 8px}p{margin:0 0 24px;color:#666}.f{margin-bottom:16px}l{display:block;color:#122f66;font-weight:600;margin-bottom:6px;font-size:14px}i{width:100%;padding:12px;border:2px solid #eef1f8;border-radius:8px;font-size:15px}input:focus{outline:none;border-color:#122f66}b{width:100%;padding:14px;background:#122f66;color:#fff;border:none;border-radius:8px;font-size:16px;font-weight:600;cursor:pointer}.btn:hover{background:#1e55b0}.link{text-align:center;margin-top:20px;color:#666}a{color:#122f66;font-weight:600;text-decoration:none}</style>" +
            "</head><body><div class=box><h1>Create Account</h1><p class=p>Join ProQik as a vendor</p>" +
            "<form action='' method='POST'>" +
            "<div class=f><l>Full Name</l><input type=text name=fullName required placeholder='Your name'></div>" +
            "<div class=f><l>Email</l><input type=email name=email required placeholder='you@example.com'></div>" +
            "<div class=f><l>Phone</l><input type=tel name=phone required placeholder='+91 9876543210'></div>" +
            "<div class=f><l>Password</l><input type=password name=password required minlength=6 placeholder='Min 6 chars'></div>" +
            "<div class=f><l>Service</l><select name=service><option value=photography>Photography<option value=videography>Videography<option value=catering>Catering<option value=decoration>Decoration</select></div>" +
            "<div class=f><l>Specialty</l><select name=categories><option value=Wedding>Wedding<option value=Corporate>Corporate<option value=Birthday>Birthday<option value=Events>Events</select></div>" +
            "<button type=submit class=btn>Create Account</button></form>" +
            "<div class=link>Already have account? <a href='"+req.getContextPath()+"/login'>Sign In</a></div>" +
            "</div></body></html>");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String service = req.getParameter("service");
        String categories = req.getParameter("categories");
        
        if(fullName == null || fullName.trim().isEmpty()) fullName = "New Vendor";
        if(email == null || email.trim().isEmpty()) email = "vendor" + System.currentTimeMillis() + "@proqik.in";
        if(phone == null || phone.trim().isEmpty()) phone = "+919999999999";
        if(password == null || password.trim().isEmpty()) password = "vendor123";
        if(service == null || service.isEmpty()) service = "photography";
        if(categories == null || categories.isEmpty()) categories = "Wedding";
        
        USERS.put(email, new String[]{password, fullName, "VENDOR", "complete"});
        
        HttpSession session = req.getSession(true);
        session.setAttribute("user", email);
        session.setAttribute("userName", fullName);
        session.setAttribute("role", "VENDOR");
        session.setAttribute("profileStatus", "complete");
        session.setAttribute("vendorCategory", service);
        session.setAttribute("vendorService", service);
        
        res.sendRedirect(req.getContextPath() + "/dashboard");
    }
}