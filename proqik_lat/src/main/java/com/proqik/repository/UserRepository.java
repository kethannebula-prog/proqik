package com.proqik.repository;

import com.proqik.util.DBConnection;
import java.sql.*;
import java.util.*;

public class UserRepository {
    
    public static boolean initTable() {
        Connection conn = null;
        Statement stmt = null;
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            try { stmt.execute("ALTER TABLE users ADD phone VARCHAR2(20)"); System.out.println("Added phone column"); } catch (SQLException e) { if(e.getErrorCode()!=1430) System.out.println("Phone column: " + e.getMessage()); }
            try { stmt.execute("ALTER TABLE users ADD status VARCHAR2(50)"); System.out.println("Added status column"); } catch (SQLException e) { if(e.getErrorCode()!=1430) System.out.println("Status column: " + e.getMessage()); }
            try { stmt.execute("ALTER TABLE users ADD full_name VARCHAR2(255)"); System.out.println("Added full_name column"); } catch (SQLException e) { if(e.getErrorCode()!=1430) System.out.println("Full_name column: " + e.getMessage()); }
            try { stmt.execute("ALTER TABLE users ADD vendor_category VARCHAR2(100)"); System.out.println("Added vendor_category column"); } catch (SQLException e) { if(e.getErrorCode()!=1430) System.out.println("Vendor_category column: " + e.getMessage()); }
            try { stmt.execute("ALTER TABLE users ADD business_name VARCHAR2(255)"); System.out.println("Added business_name column"); } catch (SQLException e) { if(e.getErrorCode()!=1430) System.out.println("Business_name column: " + e.getMessage()); }
            try { stmt.execute("ALTER TABLE users ADD location VARCHAR2(100)"); System.out.println("Added location column"); } catch (SQLException e) { if(e.getErrorCode()!=1430) System.out.println("Location column: " + e.getMessage()); }
            try { stmt.execute("ALTER TABLE users ADD experience VARCHAR2(50)"); System.out.println("Added experience column"); } catch (SQLException e) { if(e.getErrorCode()!=1430) System.out.println("Experience column: " + e.getMessage()); }
            try { stmt.execute("ALTER TABLE users ADD description CLOB"); System.out.println("Added description column"); } catch (SQLException e) { if(e.getErrorCode()!=1430) System.out.println("Description column: " + e.getMessage()); }
            try { stmt.execute("ALTER TABLE users ADD service_name VARCHAR2(255)"); System.out.println("Added service_name column"); } catch (SQLException e) { if(e.getErrorCode()!=1430) System.out.println("Service_name column: " + e.getMessage()); }
            try { stmt.execute("ALTER TABLE users ADD price_start NUMBER"); System.out.println("Added price_start column"); } catch (SQLException e) { if(e.getErrorCode()!=1430) System.out.println("Price_start column: " + e.getMessage()); }
            try { stmt.execute("ALTER TABLE users ADD duration VARCHAR2(50)"); System.out.println("Added duration column"); } catch (SQLException e) { if(e.getErrorCode()!=1430) System.out.println("Duration column: " + e.getMessage()); }
            try { stmt.execute("ALTER TABLE users ADD service_includes CLOB"); System.out.println("Added service_includes column"); } catch (SQLException e) { if(e.getErrorCode()!=1430) System.out.println("Service_includes column: " + e.getMessage()); }
            return true;
        } catch (SQLException e) { System.out.println("Error initializing table: " + e.getMessage()); return false; }
        finally { try { if(stmt!=null) stmt.close(); if(conn!=null) conn.close(); } catch (Exception e) {} }
    }
    
    public static boolean createUser(String email, String password, String fullName, String role, String status, String phone, String vendorCategory) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBConnection.getConnection();
            
            // Check and add vendor_category column if needed
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet col = meta.getColumns(null, null, "USERS", "VENDOR_CATEGORY");
            if (!col.next()) {
                try {
                    conn.createStatement().execute("ALTER TABLE users ADD vendor_category VARCHAR2(100)");
                    System.out.println("Added vendor_category column");
                } catch (SQLException e) { /* ignore if exists */ }
            }
            col.close();
            
            String sql = "INSERT INTO users (email, password, full_name, role, status, phone, vendor_category, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, SYSTIMESTAMP)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, fullName);
            ps.setString(4, role);
            ps.setString(5, status);
            ps.setString(6, phone);
            ps.setString(7, vendorCategory);
            
            int rows = ps.executeUpdate();
            System.out.println("User created: " + email + ", category: " + vendorCategory);
            return rows > 0;
            
        } catch (SQLException e) {
            System.out.println("Error creating user: " + e.getMessage());
            return false;
        } finally {
            close(conn, ps);
        }
    }
    
    public static String[] getUser(String email) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "SELECT password, full_name, role, status FROM users WHERE email = ?";
            System.out.println("DEBUG getUser SQL: " + sql + " [email=" + email + "]");
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                String pwd = rs.getString("password");
                String name = rs.getString("full_name");
                String role = rs.getString("role");
                String status = rs.getString("status");
                System.out.println("DEBUG getUser FOUND: pwd=" + pwd + ", name=" + name + ", role=" + role + ", status=" + status);
                return new String[]{
                    pwd,
                    name,
                    role,
                    status
                };
            } else {
                System.out.println("DEBUG getUser: No row found for email=" + email);
            }
        } catch (SQLException e) {
            System.out.println("Error getting user: " + e.getMessage());
        } finally {
            close(conn, ps, rs);
        }
        return null;
    }
    
    public static List<Map<String, Object>> getPendingVendors() {
        List<Map<String, Object>> vendors = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            
            // First check if status column exists
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet columns = meta.getColumns(null, null, "USERS", "STATUS");
            boolean hasStatusColumn = columns.next();
            columns.close();
            System.out.println("DEBUG: Status column exists: " + hasStatusColumn);
            
            String sql = hasStatusColumn 
                ? "SELECT email, full_name, role, status, phone, vendor_category, business_name, location, created_at FROM users WHERE role = 'VENDOR' AND status IN ('incomplete', 'pending_verify') ORDER BY created_at DESC"
                : "SELECT email, full_name, role, phone, vendor_category, business_name, location, created_at FROM users WHERE role = 'VENDOR' ORDER BY created_at DESC";
            System.out.println("DEBUG: getPendingVendors SQL: " + sql);
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> vendor = new HashMap<>();
                vendor.put("email", rs.getString("email"));
                vendor.put("name", rs.getString("full_name"));
                vendor.put("role", rs.getString("role"));
                vendor.put("status", rs.getString("status"));
                vendor.put("phone", rs.getString("phone"));
                vendor.put("category", rs.getString("vendor_category"));
                vendor.put("business", rs.getString("business_name"));
                vendor.put("location", rs.getString("location"));
                vendor.put("created", rs.getTimestamp("created_at"));
                vendors.add(vendor);
                System.out.println("DEBUG: Found pending vendor: " + rs.getString("email") + " status: " + rs.getString("status"));
            }
            System.out.println("DEBUG: Total pending vendors: " + vendors.size());
        } catch (SQLException e) {
            System.out.println("Error getting pending vendors: " + e.getMessage());
        } finally {
            close(conn, ps, rs);
        }
        return vendors;
    }
    
    public static List<Map<String, Object>> getAllVendors() {
        List<Map<String, Object>> vendors = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet columns = meta.getColumns(null, null, "USERS", "STATUS");
            boolean hasStatusColumn = columns.next();
            columns.close();
            
            String sql = "SELECT email, full_name, role, status, phone, vendor_category, business_name, location, created_at FROM users WHERE role = 'VENDOR' ORDER BY created_at DESC";
            System.out.println("DEBUG: getAllVendors SQL: " + sql);
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> vendor = new HashMap<>();
                vendor.put("email", rs.getString("email"));
                vendor.put("name", rs.getString("full_name"));
                vendor.put("role", rs.getString("role"));
                String status = null;
                try { status = rs.getString("status"); } catch (Exception e) {}
                if (status == null || status.isEmpty()) status = "incomplete";
                vendor.put("status", status);
                vendor.put("phone", rs.getString("phone"));
                vendor.put("category", rs.getString("vendor_category"));
                vendor.put("business", rs.getString("business_name"));
                vendor.put("location", rs.getString("location"));
                vendor.put("created", rs.getTimestamp("created_at"));
                vendors.add(vendor);
                System.out.println("DEBUG: Found vendor: " + rs.getString("email") + " status: " + status);
            }
            System.out.println("DEBUG: Total vendors: " + vendors.size());
        } catch (SQLException e) {
            System.out.println("Error getting all vendors: " + e.getMessage());
        } finally {
            close(conn, ps, rs);
        }
        return vendors;
    }
    
    public static boolean updateStatus(String email, String status) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "UPDATE users SET status = ? WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, email);
            
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Error updating status: " + e.getMessage());
            return false;
        } finally {
            close(conn, ps);
        }
    }
    
    public static boolean updateVendorProfile(String email, String fullName, String phone, String vendorCategory, String businessName, String location, String status) {
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "UPDATE users SET full_name = ?, phone = ?, vendor_category = ?, business_name = ?, location = ?, status = ? WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, vendorCategory);
            ps.setString(4, businessName);
            ps.setString(5, location);
            ps.setString(6, status);
            ps.setString(7, email);
            
            int rows = ps.executeUpdate();
            System.out.println("DEBUG updateVendorProfile: updated " + email + " rows=" + rows);
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Error updating profile: " + e.getMessage());
            return false;
        } finally {
            close(conn, ps);
        }
    }
    
    public static boolean initVendorStatsTable() {
        Connection conn = null;
        Statement stmt = null;
        try {
            conn = DBConnection.getConnection();
            stmt = conn.createStatement();
            try { stmt.execute("CREATE TABLE vendor_stats (email VARCHAR2(255) PRIMARY KEY, earnings NUMBER default 0, bookings NUMBER default 0, rating VARCHAR2(10))"); System.out.println("Created vendor_stats table"); } catch (SQLException e) { if(e.getErrorCode()!=955) System.out.println("Vendor stats table: " + e.getMessage()); }
            return true;
        } catch (SQLException e) { System.out.println("Error initializing stats table: " + e.getMessage()); return false; }
        finally { try { if(stmt!=null) stmt.close(); if(conn!=null) conn.close(); } catch (Exception e) {} }
    }
    
    public static boolean updateVendorStats(String email, int earnings, int bookings, String rating) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            initVendorStatsTable();
            String sql = "MERGE INTO vendor_stats USING DUAL ON (email = ?) WHEN MATCHED THEN UPDATE SET earnings = ?, bookings = ?, rating = ? WHEN NOT MATCHED THEN INSERT (email, earnings, bookings, rating) VALUES (?, ?, ?, ?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, earnings); ps.setInt(2, bookings); ps.setString(3, rating);
            ps.setString(4, email); ps.setInt(5, earnings); ps.setInt(6, bookings); ps.setString(7, rating);
            ps.executeUpdate();
            System.out.println("DEBUG updateVendorStats: " + email + " earnings=" + earnings + " bookings=" + bookings + " rating=" + rating);
            return true;
        } catch (SQLException e) { System.out.println("Error updating stats: " + e.getMessage()); return false; }
        finally { try { if(ps!=null) ps.close(); if(conn!=null) conn.close(); } catch (Exception e) {} }
    }
    
    public static Map<String, Object> getVendorStats(String email) {
        Map<String, Object> stats = new HashMap<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT earnings, bookings, rating FROM vendor_stats WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                stats.put("earnings", rs.getInt("earnings"));
                stats.put("bookings", rs.getInt("bookings"));
                stats.put("rating", rs.getString("rating"));
            } else {
                stats.put("earnings", 0);
                stats.put("bookings", 0);
                stats.put("rating", "-");
            }
        } catch (SQLException e) { System.out.println("Error getting stats: " + e.getMessage()); }
        finally { try { if(rs!=null) rs.close(); if(ps!=null) ps.close(); if(conn!=null) conn.close(); } catch (Exception e) {} }
        return stats;
    }
    
    private static final Map<String, List<Map<String, Object>>> VENDOR_SERVICES = new LinkedHashMap<>();
    private static final Map<String, List<Map<String, Object>>> VENDOR_BOOKINGS = new LinkedHashMap<>();

    static {
        List<Map<String, Object>> services = new ArrayList<>();
        services.add(createService("Premium Wedding Package", 15000, "Full day coverage with 2 photographers", "https://images.unsplash.com/photo-1511285560929-80b456fea0bc?w=400&h=300&fit=crop&q=80"));
        services.add(createService("Standard Package", 8000, "Half day coverage with 1 photographer", "https://images.unsplash.com/photo-1554080353-a576cf803bda?w=400&h=300&fit=crop&q=80"));
        services.add(createService("Basic Session", 5000, "Quick portrait session (2 hours)", "https://images.unsplash.com/photo-1519741497674-611481863552?w=400&h=300&fit=crop&q=80"));
        VENDOR_SERVICES.put("nanda@gmail.com", services);

        List<Map<String, Object>> bookings = new ArrayList<>();
        bookings.add(createBooking("BK-001", "Priya Sharma", "Wedding", "2026-06-15", "Chennai", "Confirmed", 15000));
        bookings.add(createBooking("BK-002", "Ananya Reddy", "Engagement", "2026-07-20", "Bangalore", "Completed", 8000));
        bookings.add(createBooking("BK-003", "Vikram Patel", "Pre-wedding", "2026-08-10", "Pondicherry", "Pending", 5000));
        VENDOR_BOOKINGS.put("nanda@gmail.com", bookings);
    }

    private static Map<String, Object> createService(String name, int price, String desc, String image) {
        Map<String, Object> s = new HashMap<>();
        s.put("name", name);
        s.put("price", price);
        s.put("description", desc);
        s.put("image", image);
        return s;
    }

    private static Map<String, Object> createBooking(String id, String client, String event, String date, String location, String status, int amount) {
        Map<String, Object> b = new HashMap<>();
        b.put("id", id);
        b.put("client", client);
        b.put("event", event);
        b.put("date", date);
        b.put("location", location);
        b.put("status", status);
        b.put("amount", amount);
        return b;
    }

    public static List<Map<String, Object>> getVendorServices(String email) {
        List<Map<String, Object>> services = VENDOR_SERVICES.get(email);
        return services != null ? services : new ArrayList<>();
    }

    public static List<Map<String, Object>> getVendorBookings(String email) {
        List<Map<String, Object>> bookings = VENDOR_BOOKINGS.get(email);
        return bookings != null ? bookings : new ArrayList<>();
    }

    private static void close(Connection conn, PreparedStatement ps) {
        try { if (ps != null) ps.close(); } catch (SQLException e) {}
        try { if (conn != null) conn.close(); } catch (SQLException e) {}
    }
    
    public static Map<String, Object> getVendorByEmail(String email) {
        Map<String, Object> vendor = null;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT full_name, phone, vendor_category, business_name, location, status, created_at FROM users WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                vendor = new HashMap<>();
                vendor.put("name", rs.getString("full_name"));
                vendor.put("phone", rs.getString("phone"));
                vendor.put("category", rs.getString("vendor_category"));
                vendor.put("business", rs.getString("business_name"));
                vendor.put("location", rs.getString("location"));
                vendor.put("status", rs.getString("status"));
                vendor.put("created", rs.getTimestamp("created_at"));
                System.out.println("DEBUG getVendorByEmail: fetched status=" + rs.getString("status") + ", category=" + rs.getString("vendor_category"));
            }
        } catch (SQLException e) {
            System.out.println("Error getting vendor: " + e.getMessage());
        } finally {
            close(conn, ps, rs);
        }
        return vendor;
    }
    
    public static void initTestData() {
        System.out.println("=== Initializing test data for nanda@gmail.com ===");
        initVendorStatsTable();
        updateVendorProfile("nanda@gmail.com", "Nanda Kishore", "9876543210", "Photography", "Nanda Studios", "Chennai, Tamil Nadu", "complete");
        updateVendorStats("nanda@gmail.com", 25000, 12, "4.5");
        System.out.println("=== Test data inserted: nanda@gmail.com ===");
    }
    
    public static List<Map<String, Object>> getAllUsers() {
        List<Map<String, Object>> users = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT email, full_name, role, status, created_at FROM users ORDER BY created_at DESC";
            System.out.println("DEBUG: getAllUsers SQL: " + sql);
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> user = new HashMap<>();
                user.put("email", rs.getString("email"));
                user.put("name", rs.getString("full_name"));
                user.put("role", rs.getString("role"));
                user.put("status", rs.getString("status"));
                user.put("created", rs.getTimestamp("created_at"));
                users.add(user);
            }
            System.out.println("DEBUG: Total users: " + users.size());
        } catch (SQLException e) {
            System.out.println("Error getting all users: " + e.getMessage());
        } finally {
            close(conn, ps, rs);
        }
        return users;
    }
    
    public static String getVendorName(String email) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT full_name FROM users WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) return rs.getString("full_name");
        } catch (SQLException e) {
            System.out.println("Error getting vendor name: " + e.getMessage());
        } finally {
            close(conn, ps, rs);
        }
        return null;
    }

    private static void close(Connection conn, PreparedStatement ps, ResultSet rs) {
        try { if (rs != null) rs.close(); } catch (SQLException e) {}
        close(conn, ps);
    }
}