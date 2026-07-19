package com.proqik.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.proqik.model.Professional;

public class BookingServlet extends HttpServlet {

    private static final List<Booking> BOOKINGS = new ArrayList<>();
    private static final List<Professional> PROFESSIONALS = new ArrayList<>();

    static {
        PROFESSIONALS.add(new Professional(1L, "Ravi Kumar Photography", "Photography · Suva", 
            "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=600&h=400&fit=crop",
            "https://i.pravatar.cc/150?img=11", 4.9f, 128, true, true, false, 450, null, "gold"));
        PROFESSIONALS.add(new Professional(2L, "Sky Vision India", "Videography · Nadi", 
            "https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?w=600&h=400&fit=crop",
            "https://i.pravatar.cc/150?img=26", 5.0f, 74, true, true, false, 600, null, "elite"));
        PROFESSIONALS.add(new Professional(3L, "Kavya Sharma Studio", "Photography · Lautoka", 
            "https://images.unsplash.com/photo-1554048612-b6a482bc67e5?w=600&h=400&fit=crop",
            "https://i.pravatar.cc/150?img=41", 4.8f, 52, false, true, false, 350, null, ""));
    }

    public static class Booking {
        private String id;
        private Long vendorId;
        private String clientEmail;
        private String eventType;
        private LocalDate eventDate;
        private String location;
        private String notes;
        private String status;
        private double amount;

        public Booking(String id, Long vendorId, String clientEmail, String eventType, 
                      LocalDate eventDate, String location, String notes, String status, double amount) {
            this.id = id;
            this.vendorId = vendorId;
            this.clientEmail = clientEmail;
            this.eventType = eventType;
            this.eventDate = eventDate;
            this.location = location;
            this.notes = notes;
            this.status = status;
            this.amount = amount;
        }

        public String getId() { return id; }
        public Long getVendorId() { return vendorId; }
        public String getClientEmail() { return clientEmail; }
        public String getEventType() { return eventType; }
        public LocalDate getEventDate() { return eventDate; }
        public String getLocation() { return location; }
        public String getNotes() { return notes; }
        public String getStatus() { return status; }
        public double getAmount() { return amount; }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            res.sendRedirect(req.getContextPath() + "/vendors");
            return;
        }

        String vendorIdStr = pathInfo.substring(1);
        try {
            Long vendorId = Long.parseLong(vendorIdStr);
            Professional vendor = PROFESSIONALS.stream()
                .filter(p -> p.getId().equals(vendorId))
                .findFirst()
                .orElse(null);
            
            if (vendor == null) {
                res.sendError(404);
                return;
            }
            
            req.setAttribute("vendor", vendor);
            req.getRequestDispatcher("/WEB-INF/views/bookings/book.jsp").forward(req, res);
        } catch (NumberFormatException e) {
            res.sendError(404);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        
        String vendorIdStr = req.getParameter("vendorId");
        String eventType = req.getParameter("eventType");
        String eventDate = req.getParameter("eventDate");
        String location = req.getParameter("location");
        String notes = req.getParameter("notes");
        String email = req.getParameter("email");
        
        if (vendorIdStr == null || eventType == null || eventDate == null || location == null) {
            res.sendError(400);
            return;
        }

        try {
            Long vendorId = Long.parseLong(vendorIdStr);
            Professional vendor = PROFESSIONALS.stream()
                .filter(p -> p.getId().equals(vendorId))
                .findFirst()
                .orElse(null);
            
            if (vendor == null) {
                res.sendError(404);
                return;
            }

            String bookingId = "BK-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            double amount = vendor.getStartingRate();
            
            Booking booking = new Booking(
                bookingId, vendorId, email, eventType,
                LocalDate.parse(eventDate), location, notes, "PENDING", amount
            );
            BOOKINGS.add(booking);

            req.setAttribute("booking", booking);
            req.setAttribute("vendor", vendor);
            req.getRequestDispatcher("/WEB-INF/views/bookings/confirmation.jsp").forward(req, res);
            
        } catch (Exception e) {
            res.sendError(400);
        }
    }
}