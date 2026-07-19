package com.proqik.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import com.proqik.repository.UserRepository;

public class DashboardServlet extends HttpServlet {

    private static final List<Map<String, Object>> PROFESSIONALS = new ArrayList<>();

    static {
        PROFESSIONALS.add(createPro("Ravi Kumar", "photography", 4.9f, 128, 15000));
        PROFESSIONALS.add(createPro("Ana Volau", "videography", 5.0f, 84, 12000));
        PROFESSIONALS.add(createPro("Jone Taukei", "album-editing", 4.8f, 56, 8500));
        PROFESSIONALS.add(createPro("Kavya Sharma", "photography", 4.7f, 42, 6200));
        PROFESSIONALS.add(createPro("Mitieli Cova", "videography", 4.9f, 38, 5800));
    }

    private static Map<String, Object> createPro(String name, String category, float rating, int bookings, int earnings) {
        Map<String, Object> pro = new HashMap<>();
        pro.put("name", name);
        pro.put("category", category);
        pro.put("rating", rating);
        pro.put("bookings", bookings);
        pro.put("earnings", earnings);
        return pro;
    }

@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        System.out.println("=== DashboardServlet.doGet called ===");
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

String role = (String) session.getAttribute("role");
        
        // Keep existing profileStatus - don't overwrite
        
if ("VENDOR".equals(role)) {
            String userEmail = (String) session.getAttribute("user");
            String userName = (String) session.getAttribute("userName");
            if (userName == null) userName = "New Vendor";
            
            // Fetch from DB
            Map<String, Object> vendorData = UserRepository.getVendorByEmail(userEmail);
            System.out.println("DEBUG Vendor: vendorData is " + (vendorData == null ? "NULL" : "found with " + vendorData.size() + " fields"));
            
            // Initialize test data if no profile exists
            if (vendorData == null || vendorData.get("name") == null || ((String)vendorData.get("name")).isEmpty()) {
                UserRepository.initTestData();
                vendorData = UserRepository.getVendorByEmail(userEmail);
            }
            
            // Use name from DB if available
            String vendorName = vendorData != null && vendorData.get("name") != null ? (String)vendorData.get("name") : userName;
            String vendorService = vendorData != null && vendorData.get("category") != null ? (String)vendorData.get("category") : "Photographer";
            String vendorCategory = vendorService;
            String vendorLocation = vendorData != null && vendorData.get("location") != null ? (String)vendorData.get("location") : "India";
            String phone = vendorData != null && vendorData.get("phone") != null ? (String)vendorData.get("phone") : "";
            String business = vendorData != null && vendorData.get("business") != null ? (String)vendorData.get("business") : "";
            String status = vendorData != null ? (String)vendorData.get("status") : "incomplete";
            System.out.println("DEBUG Vendor status from DB: status=" + status);
            java.sql.Timestamp created = vendorData != null ? (java.sql.Timestamp)vendorData.get("created") : null;
            
            // Get vendor stats
            Map<String, Object> stats = UserRepository.getVendorStats(userEmail);
            if (stats == null || stats.get("earnings") == null || (Integer)stats.get("earnings") == 0) {
                UserRepository.initTestData();
                stats = UserRepository.getVendorStats(userEmail);
            }
            String earnings = stats != null && stats.get("earnings") != null ? String.valueOf(stats.get("earnings")) : "0";
            String bookings = stats != null && stats.get("bookings") != null ? String.valueOf(stats.get("bookings")) : "0";
            String rating = stats != null && stats.get("rating") != null ? (String)stats.get("rating") : "-";
            
            if (session.getAttribute("profileStatus") == null) {
                session.setAttribute("profileStatus", status != null ? status : "complete");
            }
            session.setAttribute("vendorCategory", vendorCategory);
            session.setAttribute("userName", vendorName);
            
            req.setAttribute("vendorName", vendorName);
            req.setAttribute("vendorCategory", vendorCategory);
            req.setAttribute("vendorLocation", vendorLocation);
            req.setAttribute("vendorPhone", phone);
            req.setAttribute("vendorBusiness", business);
            req.setAttribute("vendorStatus", status);
            req.setAttribute("vendorEarnings", earnings);
            req.setAttribute("vendorBookingCount", bookings);
            req.setAttribute("vendorRating", rating);
            req.setAttribute("vendorJoined", created);
            
            // Fetch vendor services and bookings
            List<Map<String, Object>> vendorServices = UserRepository.getVendorServices(userEmail);
            List<Map<String, Object>> vendorBookings = UserRepository.getVendorBookings(userEmail);
            req.setAttribute("vendorServices", vendorServices);
            req.setAttribute("vendorBookings", vendorBookings);
            System.out.println("DEBUG Vendor: " + userEmail + ", category=" + vendorCategory + ", earnings=" + earnings + ", services=" + vendorServices.size() + ", bookings=" + vendorBookings.size());
            
            req.getRequestDispatcher("/WEB-INF/views/dashboard/vendor-rich.jsp").forward(req, res);
            return;
        }
        
if ("ADMIN".equals(role)) {
            System.out.println("DEBUG: Role is ADMIN - showing admin dashboard");
            List<Map<String, Object>> pendingVendors = UserRepository.getPendingVendors();
            List<Map<String, Object>> allVendors = UserRepository.getAllVendors();
            
            // Get admin stats
            int totalVendors = allVendors.size();
            int approvedVendors = 0;
            int rejectedVendors = 0;
            int pendingApproval = pendingVendors.size();
            for(Map<String, Object> v : allVendors) {
                String s = (String)v.get("status");
                if("complete".equals(s) || "approved".equals(s)) approvedVendors++;
                else if("rejected".equals(s)) rejectedVendors++;
            }
            
            System.out.println("DEBUG Admin: Found " + pendingVendors.size() + " pending, " + allVendors.size() + " total vendors");
            req.setAttribute("pendingVendors", pendingVendors);
            req.setAttribute("allVendors", allVendors);
            req.setAttribute("totalVendors", totalVendors);
            req.setAttribute("approvedVendors", approvedVendors);
            req.setAttribute("rejectedVendors", rejectedVendors);
            req.setAttribute("pendingApprovalCount", pendingApproval);
            req.setAttribute("professionals", PROFESSIONALS);
            req.getRequestDispatcher("/WEB-INF/views/dashboard/admin.jsp").forward(req, res);
            return;
        }
        
        res.sendRedirect(req.getContextPath() + "/login");
    }
}
