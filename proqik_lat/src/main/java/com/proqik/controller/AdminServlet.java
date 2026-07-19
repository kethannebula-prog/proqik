package com.proqik.controller;

import com.proqik.repository.UserRepository;
import com.proqik.util.OtpService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        System.out.println("=== AdminServlet.doGet called ===");
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("DEBUG Admin: No session user, redirecting to login");
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        String role = (String) session.getAttribute("role");
        System.out.println("DEBUG Admin: Session role = " + role);
        if (!"ADMIN".equals(role)) {
            System.out.println("DEBUG Admin: Not admin, redirecting to dashboard");
            res.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }
        
        // Check for init test data action
        String initAction = req.getParameter("init");
        if ("testdata".equals(initAction)) {
            UserRepository.initTestData();
            System.out.println("DEBUG Admin: Test data initialized");
        }
        
        // Handle approve/reject actions from GET links
        String action = req.getParameter("action");
        String vendorEmail = req.getParameter("email");
        if (vendorEmail != null && action != null && !action.isEmpty() && !vendorEmail.isEmpty()) {
            System.out.println("DEBUG Admin doGet: action=" + action + ", email=" + vendorEmail);
            if ("approve".equals(action)) {
                UserRepository.updateStatus(vendorEmail, "complete");
                System.out.println("Approved vendor: " + vendorEmail);
                req.setAttribute("flashMsg", "Vendor <strong>" + vendorEmail + "</strong> approved successfully.");
                String vName = UserRepository.getVendorName(vendorEmail);
                OtpService.sendStatusNotification(vendorEmail, vName, "approved");
            } else if ("reject".equals(action)) {
                UserRepository.updateStatus(vendorEmail, "rejected");
                System.out.println("Rejected vendor: " + vendorEmail);
                req.setAttribute("flashMsg", "Vendor <strong>" + vendorEmail + "</strong> rejected.");
                String vName = UserRepository.getVendorName(vendorEmail);
                OtpService.sendStatusNotification(vendorEmail, vName, "rejected");
            } else if ("view".equals(action)) {
                System.out.println("DEBUG Admin: Viewing vendor portfolio for " + vendorEmail);
                Map<String, Object> vendorData = UserRepository.getVendorByEmail(vendorEmail);
                String vName = vendorData != null ? (String) vendorData.get("name") : vendorEmail;
                if (vName == null) vName = vendorEmail;
                String vCategory = vendorData != null ? (String) vendorData.get("category") : "Photography";
                if (vCategory == null) vCategory = "Photography";
                req.setAttribute("vendorName", vName);
                req.setAttribute("vendorEmail", vendorEmail);
                req.setAttribute("vendorCategory", vCategory);
                req.setAttribute("adminView", true);
                req.getRequestDispatcher("/WEB-INF/views/vendors/portfolio.jsp").forward(req, res);
                return;
            }
        }
        
        List<Map<String, Object>> pendingVendors = UserRepository.getPendingVendors();
        List<Map<String, Object>> allVendors = UserRepository.getAllVendors();
        List<Map<String, Object>> allUsers = UserRepository.getAllUsers();
        System.out.println("DEBUG Admin: Found " + pendingVendors.size() + " pending, " + allVendors.size() + " total vendors, " + allUsers.size() + " total users");
        req.setAttribute("pendingVendors", pendingVendors);
        req.setAttribute("allVendors", allVendors);
        req.setAttribute("allUsers", allUsers);
        req.getRequestDispatcher("/WEB-INF/views/dashboard/admin.jsp").forward(req, res);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        System.out.println("=== AdminServlet.doPost called ===");
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            System.out.println("DEBUG Admin POST: No session, redirecting to login");
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            res.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }
        
        String action = req.getParameter("action");
        String vendorEmail = req.getParameter("email");
        System.out.println("DEBUG Admin POST: action=" + action + ", email=" + vendorEmail);
        
        if (vendorEmail != null && action != null) {
            if ("approve".equals(action)) {
                String adminNote = req.getParameter("adminNote");
                boolean result = UserRepository.updateStatus(vendorEmail, "complete");
                System.out.println("Approved vendor: " + vendorEmail + " result=" + result + (adminNote != null ? " Note: " + adminNote : ""));
                // TODO: Send approval email to vendor
            } else if ("reject".equals(action)) {
                String rejectionReason = req.getParameter("rejectionReason");
                String adminNote = req.getParameter("adminNote");
                boolean result = UserRepository.updateStatus(vendorEmail, "rejected");
                System.out.println("Rejected vendor: " + vendorEmail + " result=" + result + " Reason: " + rejectionReason + (adminNote != null ? " Note: " + adminNote : ""));
                // TODO: Send rejection email to vendor
            } else if ("viewDetails".equals(action)) {
                // View vendor full details - redirect to vendor details page
                Map<String, Object> vendor = UserRepository.getVendorByEmail(vendorEmail);
                req.setAttribute("vendorDetails", vendor);
                req.getRequestDispatcher("/WEB-INF/views/dashboard/admin-vendor-details.jsp").forward(req, res);
                return;
            } else if ("updateProfile".equals(action)) {
                String fullName = req.getParameter("fullName");
                String phone = req.getParameter("phone");
                String category = req.getParameter("category");
                String business = req.getParameter("business");
                String location = req.getParameter("location");
                boolean result = UserRepository.updateVendorProfile(vendorEmail, fullName, phone, category, business, location, "complete");
                System.out.println("Updated profile: " + vendorEmail + " result=" + result);
            } else if ("updateStats".equals(action)) {
                String earnings = req.getParameter("earnings");
                String bookings = req.getParameter("bookings");
                String rating = req.getParameter("rating");
                int earn = earnings != null ? Integer.parseInt(earnings) : 0;
                int book = bookings != null ? Integer.parseInt(bookings) : 0;
                boolean result = UserRepository.updateVendorStats(vendorEmail, earn, book, rating);
                System.out.println("Updated stats: " + vendorEmail + " result=" + result);
            }
        }
        
        res.sendRedirect(req.getContextPath() + "/admin");
    }
}