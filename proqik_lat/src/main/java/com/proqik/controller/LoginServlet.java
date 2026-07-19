package com.proqik.controller;

import com.proqik.repository.UserRepository;
import com.proqik.controller.OAuth2CallbackServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        System.out.println("=== LoginServlet.doGet called ===");
        req.setAttribute("googleAuthUrl", OAuth2CallbackServlet.buildAuthUrl(req));
        req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        System.out.println("=== LoginServlet.doPost called ===");
        String action = req.getParameter("action");
        String role = req.getParameter("role");
        
        if ("register".equals(action)) {
            handleRegister(req, res);
            return;
        }
        
        if ("vendor-register".equals(action)) {
            handleVendorRegister(req, res);
            return;
        }
        
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Please enter email and password");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, res);
            return;
        }

        // Try DB login
        System.out.println("DEBUG: Checking DB for user: " + email);
        String[] userData = UserRepository.getUser(email);
        System.out.println("DEBUG: User data from DB: " + (userData != null ? "found" : "null"));
        
        if (userData != null && userData[0].equals(password)) {
            System.out.println("DEBUG: DB login success, role: " + userData[2]);
            HttpSession session = req.getSession();
            session.setAttribute("user", email);
            session.setAttribute("userName", userData[1]);
            session.setAttribute("role", userData[2]);
            System.out.println("DEBUG: Session created, role=" + userData[2] + ", redirecting to dashboard");
            
            String profileStatus = userData.length > 3 ? userData[3] : "complete";
            session.setAttribute("profileStatus", profileStatus);
            
            res.sendRedirect(req.getContextPath() + "/dashboard");
        } else {
            System.out.println("DEBUG: Login FAILED - password mismatch or null. userData=" + (userData != null) + ", stored=" + (userData != null ? userData[0] : "null") + ", input=" + password);
            req.setAttribute("error", "Invalid email or password");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, res);
        }
    }
    
    private void handleVendorRegister(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        
        if (fullName == null || email == null || phone == null || password == null || 
            fullName.isEmpty() || email.isEmpty() || phone.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "All fields are required");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, res);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, res);
            return;
        }
        
        // Check in DB
        if (UserRepository.getUser(email) != null) {
            req.setAttribute("error", "An account with this email already exists");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, res);
            return;
        }
        
        UserRepository.createUser(email, password, fullName, "VENDOR", "complete", phone, "Photographer");
        
        HttpSession session = req.getSession();
        session.setAttribute("user", email);
        session.setAttribute("userName", fullName);
        session.setAttribute("role", "VENDOR");
        session.setAttribute("profileStatus", "complete");
        session.setAttribute("vendorCategory", "Photographer");
        
        res.sendRedirect(req.getContextPath() + "/dashboard");
    }
    
    private void handleRegister(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String password = req.getParameter("password");
        String service = req.getParameter("service");
        String categories = req.getParameter("categories");
        
        System.out.println("Register - name: " + fullName + ", email: " + email + ", service: " + service);
        
        if (fullName == null || email == null || phone == null || password == null || 
            fullName.trim().isEmpty() || email.trim().isEmpty() || phone.trim().isEmpty() || password.trim().isEmpty()) {
            req.setAttribute("error", "All fields are required");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, res);
            return;
        }
        
        if (password.length() < 6) {
            req.setAttribute("error", "Password must be at least 6 characters");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, res);
            return;
        }
        
        // Check in DB
        if (UserRepository.getUser(email) != null) {
            req.setAttribute("error", "An account with this email already exists");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, res);
            return;
        }
        
        UserRepository.createUser(email, password, fullName, "VENDOR", "complete", phone, service != null ? service : "Photographer");
        
        HttpSession session = req.getSession();
        session.setAttribute("user", email);
        session.setAttribute("userName", fullName);
        session.setAttribute("role", "VENDOR");
        session.setAttribute("profileStatus", "complete");
        session.setAttribute("vendorCategory", service != null ? service : "Photographer");
        session.setAttribute("vendorService", service);
        session.setAttribute("vendorCategories", categories);
        
        System.out.println("User created, redirecting to dashboard");
        
        res.sendRedirect(req.getContextPath() + "/dashboard");
    }
}