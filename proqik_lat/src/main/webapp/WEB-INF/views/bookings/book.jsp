<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.proqik.model.Professional" %>
<%@ page import="com.proqik.controller.BookingServlet.Booking" %>

<%
Professional vendor = (Professional) request.getAttribute("vendor");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book <%= vendor.getDisplayName() %> | ProQik</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&family=Cormorant+Garamond:wght@400;500;600;700&display=swap" rel="stylesheet"/>
<style>
:root{
  --navy:#122f66;
  --navy-light:#e8f0fc;
  --white:#ffffff;
  --gray-50:#f6f8fc;
  --gray-100:#eef1f8;
  --gray-200:#dce2f0;
  --gray-400:#8b96b0;
  --gray-600:#4a5578;
  --gray-800:#1a2140;
  --gold:#c9a84c;
  --success:#16a34a;
  --font:'Plus Jakarta Sans',system-ui,sans-serif;
  --disp:'Syne',system-ui,sans-serif;
  --ease:cubic-bezier(.16,1,.3,1);
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
body{font-family:var(--font);background:var(--gray-50);color:var(--gray-800)}

.bk-header{background:var(--navy);padding:24px 40px;display:flex;align-items:center;justify-content:space-between}
.bk-logo{display:flex;align-items:center;gap:12px}
.bk-logo img{height:32px}
.bk-logo span{font-family:var(--disp);font-size:20px;font-weight:800;color:#fff}
.bk-step{font-size:13px;color:rgba(255,255,255,.6)}
.bk-step strong{color:#fff}

.bk-container{max-width:1000px;margin:40px auto;padding:0 20px;display:grid;grid-template-columns:1fr 380px;gap:32px}
.bk-main{background:#fff;border-radius:16px;padding:32px;box-shadow:0 4px 20px rgba(27,74,151,.08)}
.bk-section{margin-bottom:32px}
.bk-section-title{font-family:var(--disp);font-size:18px;font-weight:700;color:var(--gray-800);margin-bottom:20px;display:flex;align-items:center;gap:10px}
.bk-section-title .num{width:28px;height:28px;background:var(--navy);color:#fff;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:700}

.bk-vendor-card{display:flex;gap:16px;padding:16px;background:var(--gray-50);border-radius:12px;margin-bottom:24px}
.bk-vendor-img{width:80px;height:80px;border-radius:10px;object-fit:cover}
.bk-vendor-info{flex:1}
.bk-vendor-name{font-family:var(--disp);font-size:16px;font-weight:700;color:var(--gray-800)}
.bk-vendor-cat{font-size:12px;color:var(--gray-600);margin-top:2px}
.bk-vendor-rating{font-size:12px;color:var(--gold);margin-top:6px}
.bk-vendor-price{font-size:14px;color:var(--gray-600);margin-top:4px}
.bk-vendor-price strong{font-size:18px;color:var(--navy)}

.form-group{margin-bottom:20px}
.form-label{display:block;font-size:12px;font-weight:600;color:var(--gray-600);letter-spacing:.04em;margin-bottom:8px}
.form-input{width:100%;padding:14px 16px;border:1.5px solid var(--gray-200);border-radius:10px;font-size:14px;font-family:var(--font);transition:all .2s}
.form-input:focus{outline:none;border-color:var(--navy);box-shadow:0 0 0 4px rgba(27,74,151,.08)}
.form-select{width:100%;padding:14px 16px;border:1.5px solid var(--gray-200);border-radius:10px;font-size:14px;font-family:var(--font);background:#fff;cursor:pointer}
.form-textarea{width:100%;padding:14px 16px;border:1.5px solid var(--gray-200);border-radius:10px;font-size:14px;font-family:var(--font);resize:vertical;min-height:100px}
.form-row{display:grid;grid-template-columns:1fr 1fr;gap:16px}

.bk-summary{background:#fff;border-radius:16px;padding:24px;box-shadow:0 4px 20px rgba(27,74,151,.08);position:sticky;top:40px;height:fit-content}
.bk-summary-title{font-family:var(--disp);font-size:16px;font-weight:700;margin-bottom:20px}
.bk-summary-row{display:flex;justify-content:space-between;margin-bottom:12px;font-size:14px}
.bk-summary-row span:first-child{color:var(--gray-600)}
.bk-summary-divider{height:1px;background:var(--gray-200);margin:16px 0}
.bk-summary-total{display:flex;justify-content:space-between;font-size:16px;font-weight:700}
.bk-summary-total span:last-child{color:var(--navy);font-size:22px;font-family:var(--disp)}

.bk-submit{width:100%;padding:16px;background:var(--navy);color:#fff;border:none;border-radius:10px;font-size:15px;font-weight:700;cursor:pointer;transition:all .25s;margin-top:20px}
.bk-submit:hover{background:#1e55b0;transform:translateY(-2px)}
.bk-note{font-size:12px;color:var(--gray-400);margin-top:16px;text-align:center}

@media(max-width:768px){.bk-container{grid-template-columns:1fr}.bk-summary{position:static}.form-row{grid-template-columns:1fr}}
</style>
</head>
<body>

<div class="bk-header">
  <div class="bk-logo">
    <img src="<%= request.getContextPath() %>/resources/img/logo.svg" alt="ProQik"/>
    <span>ProQik</span>
  </div>
  <div class="bk-step">Step 1 of 2 — <strong>Booking Details</strong></div>
</div>

<div class="bk-container">
  <div class="bk-main">
    <div class="bk-section">
      <div class="bk-section-title"><span class="num">1</span> Select Service</div>
      
      <div class="bk-vendor-card">
        <img class="bk-vendor-img" src="<%= vendor.getCoverImage() %>" alt="<%= vendor.getDisplayName() %>"/>
        <div class="bk-vendor-info">
          <div class="bk-vendor-name"><%= vendor.getDisplayName() %></div>
          <div class="bk-vendor-cat"><%= vendor.getSpecialty() %></div>
          <div class="bk-vendor-rating">★ <%= vendor.getRating() %> (<%= vendor.getReviewCount() %> reviews)</div>
          <div class="bk-vendor-price">From <strong>₹ <%= vendor.getStartingRate() %></strong></div>
        </div>
      </div>
      
      <form action="<%= request.getContextPath() %>/book/<%= vendor.getId() %>" method="POST">
        <input type="hidden" name="vendorId" value="<%= vendor.getId() %>"/>
        
        <div class="form-group">
          <label class="form-label">Event Type</label>
          <select name="eventType" class="form-select" required>
            <option value="">Select event type</option>
            <option value="Wedding">Wedding</option>
            <option value="Engagement">Engagement</option>
            <option value="Corporate Event">Corporate Event</option>
            <option value="Portrait Session">Portrait Session</option>
            <option value="Product Photography">Product Photography</option>
            <option value="Real Estate">Real Estate / Property</option>
            <option value="Other">Other</option>
          </select>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Event Date</label>
            <input type="date" name="eventDate" class="form-input" required min="<%= java.time.LocalDate.now() %>"/>
          </div>
          <div class="form-group">
            <label class="form-label">Preferred Time</label>
            <select name="time" class="form-select">
              <option value="morning">Morning (8am - 12pm)</option>
              <option value="afternoon">Afternoon (12pm - 5pm)</option>
              <option value="evening">Evening (5pm - 8pm)</option>
              <option value="full-day">Full Day</option>
            </select>
          </div>
        </div>
        
        <div class="form-group">
          <label class="form-label">Event Location</label>
          <input type="text" name="location" class="form-input" placeholder="e.g., Grand Pacific Hotel, Suva" required/>
        </div>
        
        <div class="form-row">
          <div class="form-group">
            <label class="form-label">Your Name</label>
            <input type="text" name="name" class="form-input" placeholder="Full name" required/>
          </div>
          <div class="form-group">
            <label class="form-label">Email Address</label>
            <input type="email" name="email" class="form-input" placeholder="your@email.com" required/>
          </div>
        </div>
        
        <div class="form-group">
          <label class="form-label">Phone Number</label>
          <input type="tel" name="phone" class="form-input" placeholder="+679..." required/>
        </div>
        
        <div class="form-group">
          <label class="form-label">Additional Notes (Optional)</label>
          <textarea name="notes" class="form-textarea" placeholder="Any specific requirements, ideas, or questions..."></textarea>
        </div>
        
        <div class="bk-section">
          <div class="bk-section-title"><span class="num">2</span> Payment Method</div>
          
          <div class="form-group">
            <label class="form-label">Payment Option</label>
            <select name="payment" class="form-select">
              <option value="cash">Pay on Completion (Cash)</option>
              <option value="card">Credit/Debit Card</option>
              <option value="bank">Bank Transfer</option>
            </select>
          </div>
        </div>
        
        <button type="submit" class="bk-submit">Confirm Booking Request</button>
        <p class="bk-note">You'll receive a confirmation email after the vendor accepts your booking.</p>
      </form>
    </div>
  </div>
  
  <div class="bk-summary">
    <div class="bk-summary-title">Booking Summary</div>
    <div class="bk-summary-row">
      <span>Service</span>
      <span><%= vendor.getCategoryName() %></span>
    </div>
    <div class="bk-summary-row">
      <span>Professional</span>
      <span><%= vendor.getDisplayName() %></span>
    </div>
    <div class="bk-summary-row">
      <span>Starting Rate</span>
      <span>₹ <%= vendor.getStartingRate() %></span>
    </div>
    <div class="bk-summary-divider"></div>
    <div class="bk-summary-row">
      <span>Platform Fee</span>
      <span>₹ 0</span>
    </div>
    <div class="bk-summary-total">
      <span>Total</span>
      <span>₹ <%= vendor.getStartingRate() %></span>
    </div>
  </div>
</div>

</body>
</html>