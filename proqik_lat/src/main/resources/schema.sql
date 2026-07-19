-- ProQik Oracle Database Schema
-- Run this script in Oracle Cloud SQL Worksheet

-- 1. USERS Table
CREATE TABLE users (
    user_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email VARCHAR2(100) UNIQUE NOT NULL,
    password VARCHAR2(255) NOT NULL,
    full_name VARCHAR2(100) NOT NULL,
    phone VARCHAR2(20) NOT NULL,
    role VARCHAR2(20) DEFAULT 'CUSTOMER' CHECK (role IN ('ADMIN', 'VENDOR', 'CUSTOMER')),
    google_id VARCHAR2(100),
    google_verified NUMBER DEFAULT 0,
    is_active NUMBER DEFAULT 1 CHECK (is_active IN (0, 1)),
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE DEFAULT SYSDATE
);

-- 2. CATEGORIES Table
CREATE TABLE categories (
    category_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name VARCHAR2(50) UNIQUE NOT NULL,
    category_key VARCHAR2(30) UNIQUE NOT NULL,
    parent_id NUMBER,
    base_rate NUMBER,
    is_active NUMBER DEFAULT 1 CHECK (is_active IN (0, 1)),
    display_order NUMBER DEFAULT 0,
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_categories_parent FOREIGN KEY (parent_id) REFERENCES categories(category_id)
);

-- 3. VENDORS Table
CREATE TABLE vendors (
    vendor_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id NUMBER UNIQUE NOT NULL,
    company_name VARCHAR2(150),
    service_type VARCHAR2(50),
    category_id NUMBER,
    description VARCHAR2(2000),
    daily_rate NUMBER,
    min_booking_amount NUMBER,
    experience_years NUMBER,
    is_verified NUMBER DEFAULT 0 CHECK (is_verified IN (0, 1)),
    is_featured NUMBER DEFAULT 0 CHECK (is_featured IN (0, 1)),
    rating_avg NUMBER(5,2) DEFAULT 0,
    review_count NUMBER DEFAULT 0,
    total_bookings NUMBER DEFAULT 0,
    response_time VARCHAR2(50),
    service_cities VARCHAR2(500),
    service_areas VARCHAR2(1000),
    terms_accepted NUMBER DEFAULT 0 CHECK (terms_accepted IN (0, 1)),
    profile_complete NUMBER DEFAULT 0 CHECK (profile_complete IN (0, 1)),
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_vendors_user FOREIGN KEY (user_id) REFERENCES users(user_id),
    CONSTRAINT fk_vendors_category FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 4. PORTFOLIO Table
CREATE TABLE portfolio (
    portfolio_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    vendor_id NUMBER NOT NULL,
    title VARCHAR2(100),
    description VARCHAR2(500),
    image_url VARCHAR2(500) NOT NULL,
    video_url VARCHAR2(500),
    category VARCHAR2(50),
    is_featured NUMBER DEFAULT 0 CHECK (is_featured IN (0, 1)),
    view_count NUMBER DEFAULT 0,
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_portfolio_vendor FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id)
);

-- 5. BOOKINGS Table
CREATE TABLE bookings (
    booking_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_no VARCHAR2(20) UNIQUE NOT NULL,
    customer_id NUMBER NOT NULL,
    vendor_id NUMBER NOT NULL,
    category_id NUMBER,
    event_date DATE NOT NULL,
    event_type VARCHAR2(50),
    event_place VARCHAR2(200),
    event_address VARCHAR2(500),
    guest_count NUMBER,
    event_description VARCHAR2(1000),
    status VARCHAR2(20) DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'in-progress', 'completed', 'cancelled')),
    payment_status VARCHAR2(20) DEFAULT 'unpaid' CHECK (payment_status IN ('unpaid', 'partial', 'paid', 'refunded')),
    total_amount NUMBER,
    advance_amount NUMBER,
    balance_amount NUMBER,
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_bookings_customer FOREIGN KEY (customer_id) REFERENCES users(user_id),
    CONSTRAINT fk_bookings_vendor FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id),
    CONSTRAINT fk_bookings_category FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 6. REVIEWS Table
CREATE TABLE reviews (
    review_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id NUMBER NOT NULL,
    vendor_id NUMBER NOT NULL,
    customer_id NUMBER NOT NULL,
    rating NUMBER(2,1) NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_title VARCHAR2(100),
    review_text VARCHAR2(1000),
    is_approved NUMBER DEFAULT 0 CHECK (is_approved IN (0, 1)),
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_reviews_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    CONSTRAINT fk_reviews_vendor FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id),
    CONSTRAINT fk_reviews_customer FOREIGN KEY (customer_id) REFERENCES users(user_id)
);

-- 7. MESSAGES Table
CREATE TABLE messages (
    message_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sender_id NUMBER NOT NULL,
    receiver_id NUMBER NOT NULL,
    booking_id NUMBER,
    message_type VARCHAR2(20) DEFAULT 'text' CHECK (message_type IN ('text', 'image', 'document')),
    message_text VARCHAR2(2000) NOT NULL,
    is_read NUMBER DEFAULT 0 CHECK (is_read IN (0, 1)),
    read_at DATE,
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_messages_sender FOREIGN KEY (sender_id) REFERENCES users(user_id),
    CONSTRAINT fk_messages_receiver FOREIGN KEY (receiver_id) REFERENCES users(user_id),
    CONSTRAINT fk_messages_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

-- 8. PAYMENTS Table
CREATE TABLE payments (
    payment_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id NUMBER NOT NULL,
    user_id NUMBER NOT NULL,
    amount NUMBER NOT NULL,
    payment_mode VARCHAR2(20) CHECK (payment_mode IN ('cash', 'online', 'upi', 'card')),
    transaction_id VARCHAR2(100),
    status VARCHAR2(20) DEFAULT 'pending' CHECK (status IN ('success', 'failed', 'pending')),
    payment_proof_url VARCHAR2(500),
    created_at DATE DEFAULT SYSDATE,
    updated_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_payments_booking FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    CONSTRAINT fk_payments_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 9. NOTIFICATIONS Table
CREATE TABLE notifications (
    notif_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id NUMBER NOT NULL,
    title VARCHAR2(100) NOT NULL,
    message VARCHAR2(500) NOT NULL,
    notif_type VARCHAR2(20) CHECK (notif_type IN ('booking', 'review', 'payment', 'message', 'system')),
    is_read NUMBER DEFAULT 0 CHECK (is_read IN (0, 1)),
    link_url VARCHAR2(200),
    created_at DATE DEFAULT SYSDATE,
    read_at DATE,
    CONSTRAINT fk_notif_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 10. SETTINGS Table
CREATE TABLE settings (
    setting_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    setting_key VARCHAR2(50) UNIQUE NOT NULL,
    setting_value VARCHAR2(1000),
    description VARCHAR2(200),
    updated_at DATE DEFAULT SYSDATE
);

-- Insert default categories
INSERT INTO categories (category_name, category_key, base_rate, display_order) VALUES 
('Wedding Photography', 'photo', 480, 1),
('Cinematography', 'video', 720, 2),
('Album Designing', 'album', 280, 3);

-- Insert admin user (change password before use)
INSERT INTO users (email, password, full_name, phone, role) VALUES 
('admin@proqik.in', 'CHANGE_ME', 'Admin', '9999999999', 'ADMIN');

COMMIT;

-- Create indexes for better performance
CREATE INDEX idx_vendors_user ON vendors(user_id);
CREATE INDEX idx_vendors_category ON vendors(category_id);
CREATE INDEX idx_bookings_customer ON bookings(customer_id);
CREATE INDEX idx_bookings_vendor ON bookings(vendor_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_messages_sender ON messages(sender_id);
CREATE INDEX idx_messages_receiver ON messages(receiver_id);
CREATE INDEX idx_portfolio_vendor ON portfolio(vendor_id);
CREATE INDEX idx_reviews_vendor ON reviews(vendor_id);

COMMIT;

-- Enable primary key sequence for ID generation (if needed)
-- This is handled automatically with GENERATED ALWAYS AS IDENTITY