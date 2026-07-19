package com.proqik.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import com.proqik.model.Professional;

public class VendorsServlet extends HttpServlet {

    private static final List<Professional> PROFESSIONALS = new ArrayList<>();

    static {
        PROFESSIONALS.add(new Professional(1L, "Ravi Kumar Photography", "Photography · Suva", 
            "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=600&h=400&fit=crop",
            "https://i.pravatar.cc/150?img=11", 4.9f, 128, true, true, false, 450, 
            List.of("Wedding", "Portrait"), "gold"));
        
        PROFESSIONALS.add(new Professional(2L, "Sky Vision India", "Videography · Nadi", 
            "https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?w=600&h=400&fit=crop",
            "https://i.pravatar.cc/150?img=26", 5.0f, 74, true, true, false, 600, 
            List.of("Wedding", "Corporate"), "elite"));
        
        PROFESSIONALS.add(new Professional(3L, "Kavya Sharma Studio", "Photography · Lautoka", 
            "https://images.unsplash.com/photo-1554048612-b6a482bc67e5?w=600&h=400&fit=crop",
            "https://i.pravatar.cc/150?img=41", 4.8f, 52, false, true, false, 350, 
            List.of("Portrait", "Fashion"), ""));
        
        PROFESSIONALS.add(new Professional(4L, "Aerial India", "Drone · Nadi", 
            "https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=600&h=400&fit=crop",
            "https://i.pravatar.cc/150?img=33", 4.7f, 38, true, true, false, 550, 
            List.of("Aerial", "Real Estate"), "gold"));
        
        PROFESSIONALS.add(new Professional(5L, "Niko Cama Editing", "Editing · Suva", 
            "https://images.unsplash.com/photo-1542038784456-1ea8e935640e?w=600&h=400&fit=crop",
            "https://i.pravatar.cc/150?img=44", 4.6f, 41, false, false, false, 200, 
            List.of("Album", "Color"), ""));
        
        PROFESSIONALS.add(new Professional(6L, "Pacific Events MC", "MC · Suva", 
            "https://images.unsplash.com/photo-1511578314322-379afb476865?w=600&h=400&fit=crop",
            "https://i.pravatar.cc/150?img=52", 4.9f, 67, true, true, false, 300, 
            List.of("Wedding", "Corporate"), ""));
        
        PROFESSIONALS.add(new Professional(7L, "Mere Cakobau Art", "Photography · Suva", 
            "https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=600&h=400&fit=crop",
            "https://i.pravatar.cc/150?img=5", 4.5f, 28, false, false, false, 400, 
            List.of("Portrait", "Family"), ""));
        
        PROFESSIONALS.add(new Professional(8L, "India Drone Pro", "Drone · Lautoka", 
            "https://images.unsplash.com/photo-1508614589041-895b88991e3e?w=600&h=400&fit=crop",
            "https://i.pravatar.cc/150?img=17", 4.8f, 45, true, true, false, 500, 
            List.of("Aerial", "Tourism"), "gold"));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String query = req.getParameter("q");
        String category = req.getParameter("category");
        String location = req.getParameter("location");
        String sort = req.getParameter("sort");

        List<Professional> filtered = new ArrayList<>(PROFESSIONALS);

        // Filter by search query
        if (query != null && !query.isEmpty()) {
            String q = query.toLowerCase();
            filtered = filtered.stream()
                .filter(p -> p.getDisplayName().toLowerCase().contains(q) 
                    || p.getSpecialty().toLowerCase().contains(q))
                .collect(Collectors.toList());
        }

        // Filter by category
        if (category != null && !category.isEmpty()) {
            filtered = filtered.stream()
                .filter(p -> p.getSpecialty().toLowerCase().contains(category.toLowerCase()))
                .collect(Collectors.toList());
        }

        // Filter by location
        if (location != null && !location.isEmpty()) {
            filtered = filtered.stream()
                .filter(p -> p.getLocation().equalsIgnoreCase(location))
                .collect(Collectors.toList());
        }

        // Sort
        if (sort != null) {
            switch (sort) {
                case "price-low":
                    filtered.sort((a, b) -> Integer.compare(a.getStartingRate(), b.getStartingRate()));
                    break;
                case "price-high":
                    filtered.sort((a, b) -> Integer.compare(b.getStartingRate(), a.getStartingRate()));
                    break;
                case "reviews":
                    filtered.sort((a, b) -> Integer.compare(b.getReviewCount(), a.getReviewCount()));
                    break;
                default: // rating
                    filtered.sort((a, b) -> Float.compare(b.getRating(), a.getRating()));
            }
        } else {
            filtered.sort((a, b) -> Float.compare(b.getRating(), a.getRating()));
        }

        req.setAttribute("vendors", filtered);
        req.setAttribute("searchQuery", query);
        req.setAttribute("category", category);
        req.setAttribute("location", location);
        
        req.getRequestDispatcher("/WEB-INF/views/vendors/listings.jsp").forward(req, res);
    }
}