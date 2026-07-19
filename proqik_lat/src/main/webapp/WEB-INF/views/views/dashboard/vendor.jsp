<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%
String vendorName = (String) request.getAttribute("vendorName");
if (vendorName == null) vendorName = "Ravi Kumar";
String vendorCategory = (String) request.getAttribute("vendorCategory");
if (vendorCategory == null) vendorCategory = "Wedding Photographer";
String vendorLocation = (String) request.getAttribute("vendorLocation");
if (vendorLocation == null) vendorLocation = "Mumbai, India";
String vendorEarnings = (String) request.getAttribute("vendorEarnings");
if (vendorEarnings == null) vendorEarnings = "12400";
String vendorBookings = (String) request.getAttribute("vendorBookings");
if (vendorBookings == null) vendorBookings = "0";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Vendor Dashboard | ProQik</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400&family=DM+Sans:wght@300;400;500;600&family=Cormorant+Garamond:ital,wght@0,300;1,300&display=swap" rel="stylesheet"/>
<style>
:root{
  --navy:#1b376c; --navy-deep:#0f1f3d; --navy-mid:#254e99;
  --navy-light:#d6e4f7; --navy-xlight:#eef4fb;
  --navy-glow:rgba(27,55,108,.12);
  --white:#ffffff; --off:#f6f8fc; --cream:#fdfbf5;
  --border:#dce8f4; --border-light:#eef4fb;
  --text:#0d1f3c; --text-mid:#3a4f6e; --text-faint:#7a8faa;
  --success-bg:#f0faf5; --success:#16a34a; --success-border:#86efac;
  --warn-bg:#fffbeb; --warn:#d97706; --warn-border:#fcd34d;
  --danger-bg:#fff0f0; --danger:#dc2626; --danger-border:#fca5a5;
  --font-body:'DM Sans',sans-serif;
  --font-disp:'Merriweather',Georgia,serif;
  --font-serif:'Cormorant Garamond',Georgia,serif;
  --ease:cubic-bezier(.22,1,.36,1);
  --sh-soft:0 2px 16px rgba(27,55,108,.07);
  --sh-md:0 6px 28px rgba(27,55,108,.11);
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html,body{font-family:var(--font-body);background:var(--off);color:var(--text);min-height:100%}
button{font-family:var(--font-body);cursor:pointer;border:none;background:none}
img{display:block}

.hdr{
  position:sticky;top:0;z-index:200;
  background:var(--navy-deep);height:72px;padding:0 32px;
  display:flex;align-items:center;
  box-shadow:0 2px 24px rgba(0,0,0,.35);
}
.hdr::after{content:'';position:absolute;bottom:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent,rgba(255,255,255,.12),transparent)}
.hdr-logo{display:flex;align-items:baseline;gap:1px;margin-right:44px}
.hdr-logo-pro{font-family:var(--font-disp);font-size:22px;font-weight:700;color:#fff;letter-spacing:-.2px}
.hdr-logo-q{font-family:var(--font-disp);font-size:22px;font-weight:700;color:rgba(255,255,255,.45);font-style:italic}
.hdr-logo-ik{font-family:var(--font-disp);font-size:22px;font-weight:400;color:rgba(255,255,255,.65)}
.hdr-nav{display:flex;gap:2px;flex:1}
.hdr-nav a{padding:10px 18px;font-size:13px;font-weight:500;color:rgba(255,255,255,.5);border-radius:8px;transition:all .2s;text-decoration:none;position:relative}
.hdr-nav a:hover{color:rgba(255,255,255,.85);background:rgba(255,255,255,.06)}
.hdr-nav a.on{color:#fff;background:rgba(255,255,255,.09)}
.hdr-nav a.on::after{content:'';position:absolute;bottom:6px;left:50%;transform:translateX(-50%);width:18px;height:2px;border-radius:1px;background:var(--navy-light)}
.hdr-right{display:flex;align-items:center;gap:12px;margin-left:auto}
.hdr-btn{width:42px;height:42px;border-radius:50%;background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.1);display:flex;align-items:center;justify-content:center;font-size:17px;position:relative;transition:all .2s}
.hdr-btn:hover{background:rgba(255,255,255,.13)}
.hdr-badge{position:absolute;top:-2px;right:-2px;width:17px;height:17px;border-radius:50%;background:var(--danger);color:#fff;font-size:9px;font-weight:700;display:flex;align-items:center;justify-content:center;border:2px solid var(--navy-deep)}
.hdr-user{display:flex;align-items:center;gap:11px;padding:7px 14px 7px 7px;background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.1);border-radius:26px;cursor:pointer;transition:all .2s}
.hdr-user:hover{background:rgba(255,255,255,.12)}
.hdr-user img{width:34px;height:34px;border-radius:50%;object-fit:cover;border:2px solid rgba(255,255,255,.2)}
.hdr-user-name{font-size:13px;font-weight:600;color:#fff}
.hdr-user-role{font-size:10.5px;color:rgba(255,255,255,.45)}

.layout{display:grid;grid-template-columns:256px 1fr;min-height:calc(100vh - 72px)}

.sidebar{background:var(--white);border-right:1px solid var(--border);padding:28px 0;position:sticky;top:72px;height:calc(100vh - 72px);overflow-y:auto;display:flex;flex-direction:column}
.sb-profile{text-align:center;padding:0 24px 28px;border-bottom:1px solid var(--border-light);margin-bottom:20px}
.sb-cover{
  height:80px;border-radius:12px;margin-bottom:-36px;
  background:linear-gradient(135deg,var(--navy) 0%,var(--navy-mid) 100%);
  position:relative;overflow:hidden;
}
.sb-cover img{width:100%;height:100%;object-fit:cover;opacity:.3}
.sb-avatar-wrap{position:relative;display:inline-block;margin-bottom:10px;z-index:1}
.sb-avatar{width:80px;height:80px;border-radius:50%;object-fit:cover;border:4px solid var(--white);box-shadow:0 0 0 2px var(--navy-light),var(--sh-md)}
.sb-online{position:absolute;bottom:4px;right:4px;width:13px;height:13px;border-radius:50%;background:var(--success);border:2.5px solid var(--white)}
.sb-verified{
  display:inline-flex;align-items:center;gap:4px;
  background:var(--navy-xlight);border:1px solid var(--navy-light);
  border-radius:20px;padding:3px 10px;
  font-size:10.5px;font-weight:600;color:var(--navy);margin-bottom:6px;
}
.sb-name{font-family:var(--font-disp);font-size:17px;font-weight:600;color:var(--text);margin-bottom:2px}
.sb-cat{font-size:12px;color:var(--text-faint);margin-bottom:3px}
.sb-loc{font-size:11.5px;color:var(--text-faint);display:flex;align-items:center;justify-content:center;gap:4px;margin-bottom:14px}
.sb-stats{display:grid;grid-template-columns:1fr 1fr;gap:8px;margin-bottom:4px}
.sb-stat{background:var(--off);border-radius:10px;padding:10px 8px;text-align:center}
.sb-stat-val{font-family:var(--font-disp);font-size:16px;font-weight:700;color:var(--navy)}
.sb-stat-lbl{font-size:10px;color:var(--text-faint);margin-top:2px}

.sb-section{font-size:9.5px;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:var(--text-faint);padding:12px 24px 8px}
.sb-item{display:flex;align-items:center;gap:12px;padding:11px 24px;font-size:13px;font-weight:500;color:var(--text-mid);cursor:pointer;border-left:3px solid transparent;transition:all .2s}
.sb-item:hover{background:var(--navy-xlight);color:var(--navy)}
.sb-item.on{background:linear-gradient(90deg,var(--navy-xlight),transparent);color:var(--navy);border-left-color:var(--navy);font-weight:600}
.sb-item svg{opacity:.55;flex-shrink:0}
.sb-item.on svg{opacity:1}
.sb-count{margin-left:auto;padding:2px 8px;border-radius:10px;font-size:10px;font-weight:700}
.sb-count.red{background:var(--danger-bg);color:var(--danger)}
.sb-count.blue{background:var(--navy-xlight);color:var(--navy)}
.sb-divider{height:1px;background:var(--border-light);margin:10px 24px}
.sb-logout{color:var(--danger) !important}

.content{padding:34px 34px;background:var(--off)}

.pg-hero{
  position:relative;border-radius:20px;overflow:hidden;
  height:200px;margin-bottom:32px;
  background:var(--navy-deep);
}
.pg-hero-bg{
  position:absolute;inset:0;
  background-image:url('https://img.freepik.com/free-photo/professional-photographer-taking-pictures-wedding-ceremony_23-2151006478.jpg');
  background-size:cover;background-position:center 30%;
  opacity:.3;
}
.pg-hero-overlay{position:absolute;inset:0;background:linear-gradient(90deg,var(--navy-deep) 25%,rgba(15,31,61,.3) 100%)}
.pg-hero-body{position:relative;z-index:1;padding:36px 40px;height:100%;display:flex;flex-direction:column;justify-content:center}
.pg-hero-eyebrow{font-family:var(--font-serif);font-size:12px;font-style:italic;color:rgba(255,255,255,.45);letter-spacing:.1em;margin-bottom:8px}
.pg-hero-name{font-family:var(--font-disp);font-size:28px;font-weight:700;color:#fff;letter-spacing:-.3px;margin-bottom:4px}
.pg-hero-cat{font-size:14px;color:rgba(255,255,255,.55);font-weight:300}
.pg-hero-actions{position:absolute;right:40px;bottom:32px;display:flex;gap:10px}
.btn{padding:11px 20px;border-radius:10px;font-family:var(--font-body);font-size:13px;font-weight:600;display:flex;align-items:center;gap:7px;transition:all .22s var(--ease)}
.btn-primary{background:var(--navy-mid);color:#fff;box-shadow:0 4px 14px var(--navy-glow)}
.btn-primary:hover{background:var(--navy);transform:translateY(-1px)}
.btn-white{background:rgba(255,255,255,.12);color:#fff;border:1.5px solid rgba(255,255,255,.2);backdrop-filter:blur(8px)}
.btn-white:hover{background:rgba(255,255,255,.2)}

.kpi-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:18px;margin-bottom:28px}
.kpi{background:var(--white);border-radius:18px;padding:22px;border:1px solid var(--border);box-shadow:var(--sh-soft);transition:all .3s var(--ease);position:relative;overflow:hidden}
.kpi::before{content:'';position:absolute;top:0;left:0;right:0;height:3px;background:linear-gradient(90deg,var(--navy),var(--navy-mid));opacity:0;transition:opacity .3s}
.kpi:hover{transform:translateY(-3px);box-shadow:var(--sh-md)}
.kpi:hover::before{opacity:1}
.kpi-top{display:flex;align-items:flex-start;justify-content:space-between;margin-bottom:14px}
.kpi-lbl{font-size:11px;font-weight:600;color:var(--text-faint);letter-spacing:.04em;text-transform:uppercase}
.kpi-icon{width:38px;height:38px;border-radius:11px;background:var(--navy-xlight);display:flex;align-items:center;justify-content:center;font-size:18px}
.kpi-val{font-family:var(--font-disp);font-size:28px;font-weight:700;color:var(--text);letter-spacing:-.5px;margin-bottom:7px}
.kpi-chg{font-size:11.5px;font-weight:500;display:flex;align-items:center;gap:4px}
.kpi-chg.up{color:var(--success)}
.kpi-chg.neu{color:var(--text-faint)}
.kpi-chg span{color:var(--text-faint);font-weight:400}

.grid-2{display:grid;grid-template-columns:1fr 340px;gap:22px}

.card{background:var(--white);border-radius:18px;border:1px solid var(--border);box-shadow:var(--sh-soft);overflow:hidden}
.card-head{display:flex;align-items:center;justify-content:space-between;padding:20px 26px 16px;border-bottom:1px solid var(--border-light)}
.card-title{font-family:var(--font-disp);font-size:16px;font-weight:600;color:var(--text);letter-spacing:-.2px}
.card-sub{font-size:11.5px;color:var(--text-faint);margin-top:2px}
.card-link{font-size:12px;font-weight:600;color:var(--navy);cursor:pointer;display:flex;align-items:center;gap:3px}

.bk-list{padding:8px 0}
.bk-item{
  display:flex;align-items:center;gap:16px;
  padding:16px 26px;border-bottom:1px solid var(--border-light);
  transition:background .18s;cursor:pointer;
}
.bk-item:last-child{border-bottom:none}
.bk-item:hover{background:#fafcff}
.bk-photo{
  width:52px;height:52px;border-radius:12px;object-fit:cover;
  border:2px solid var(--border);flex-shrink:0;
}
.bk-info{flex:1}
.bk-client{font-size:14px;font-weight:600;color:var(--text);margin-bottom:3px}
.bk-detail{font-size:12px;color:var(--text-faint);display:flex;align-items:center;gap:10px}
.bk-amount{font-family:var(--font-disp);font-size:16px;font-weight:700;color:var(--navy)}
.bk-status{padding:4px 11px;border-radius:6px;font-size:10.5px;font-weight:700;letter-spacing:.03em;text-transform:uppercase}
.bk-status.confirmed{background:var(--success-bg);color:var(--success);border:1px solid var(--success-border)}
.bk-status.pending{background:var(--warn-bg);color:var(--warn);border:1px solid var(--warn-border)}
.bk-status.completed{background:var(--navy-xlight);color:var(--navy);border:1px solid var(--navy-light)}

.port-grid{display:grid;grid-template-columns:1fr 1fr;gap:2px;padding:2px}
.port-img{width:100%;aspect-ratio:1;object-fit:cover;cursor:pointer;transition:opacity .2s}
.port-img:hover{opacity:.85}
.port-add{
  width:100%;aspect-ratio:1;background:var(--off);
  display:flex;flex-direction:column;align-items:center;justify-content:center;
  gap:8px;cursor:pointer;border:2px dashed var(--border);
  font-size:12px;font-weight:500;color:var(--text-faint);
  transition:all .2s;
}
.port-add:hover{border-color:var(--navy);color:var(--navy);background:var(--navy-xlight)}

.upcoming{padding:16px 26px;display:flex;flex-direction:column;gap:0}
.up-item{display:flex;align-items:center;gap:14px;padding:13px 0;border-bottom:1px solid var(--border-light)}
.up-item:last-child{border-bottom:none}
.up-date{
  width:44px;height:44px;border-radius:12px;
  background:var(--navy-xlight);border:1.5px solid var(--navy-light);
  display:flex;flex-direction:column;align-items:center;justify-content:center;
  flex-shrink:0;
}
.up-day{font-size:16px;font-weight:700;color:var(--navy);line-height:1}
.up-mon{font-size:9px;font-weight:600;color:var(--navy-mid);text-transform:uppercase;letter-spacing:.05em}
.up-info{flex:1}
.up-title{font-size:13px;font-weight:600;color:var(--text);margin-bottom:2px}
.up-sub{font-size:11.5px;color:var(--text-faint)}
.up-type{padding:3px 10px;border-radius:6px;font-size:10px;font-weight:700;background:var(--navy-xlight);color:var(--navy)}

.msg-list{padding:8px 0}
.msg-item{display:flex;align-items:center;gap:13px;padding:13px 26px;border-bottom:1px solid var(--border-light);cursor:pointer;transition:background .18s}
.msg-item:last-child{border-bottom:none}
.msg-item:hover{background:#fafcff}
.msg-avatar{width:40px;height:40px;border-radius:50%;object-fit:cover;flex-shrink:0;border:2px solid var(--border)}
.msg-name{font-size:13px;font-weight:600;color:var(--text);margin-bottom:2px}
.msg-preview{font-size:12px;color:var(--text-faint);white-space:nowrap;overflow:hidden;text-overflow:ellipsis;max-width:180px}
.msg-time{font-size:10.5px;color:var(--text-faint);margin-left:auto;flex-shrink:0}
.msg-unread{width:8px;height:8px;border-radius:50%;background:var(--navy);flex-shrink:0}

.toast{position:fixed;bottom:28px;left:50%;transform:translateX(-50%) translateY(10px);background:var(--navy-deep);color:#fff;padding:14px 24px;border-radius:12px;font-size:13.5px;font-weight:500;box-shadow:0 10px 40px rgba(0,0,0,.35);z-index:9999;opacity:0;transition:all .3s var(--ease);pointer-events:none}
.toast.show{opacity:1;transform:translateX(-50%) translateY(0)}

@media(max-width:1100px){.kpi-grid{grid-template-columns:repeat(2,1fr)}}
@media(max-width:900px){.layout{grid-template-columns:1fr}.sidebar{display:none}.grid-2{grid-template-columns:1fr}}
</style>
</head>
<body>

<header class="hdr">
  <div class="hdr-logo">
    <span class="hdr-logo-pro">Pro</span><span class="hdr-logo-q">Q</span><span class="hdr-logo-ik">ik</span>
  </div>
  <nav class="hdr-nav">
    <a href="#" class="on">Dashboard</a>
    <a href="#">My Bookings</a>
    <a href="#">Portfolio</a>
    <a href="#">Messages</a>
    <a href="#">Earnings</a>
  </nav>
  <div class="hdr-right">
    <button class="hdr-btn">🔔<span class="hdr-badge">2</span></button>
    <button class="hdr-btn">💬<span class="hdr-badge" style="background:var(--navy-mid)">4</span></button>
    <div class="hdr-user">
      <img src="https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=80" alt="Vendor"/>
      <div>
        <div class="hdr-user-name"><%= vendorName %></div>
        <div class="hdr-user-role"><%= vendorCategory %></div>
      </div>
    </div>
  </div>
</header>

<div class="layout">
  <aside class="sidebar">
    <div class="sb-profile">
      <div class="sb-cover">
        <img src="https://img.freepik.com/free-photo/wedding-couple-posing-beautiful-nature_23-2151270553.jpg" alt="cover"/>
      </div>
      <div style="padding-top:40px">
        <div class="sb-avatar-wrap">
          <img class="sb-avatar" src="https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=150" alt="Vendor"/>
          <span class="sb-online"></span>
        </div>
        <div class="sb-verified">
          <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="var(--navy)" stroke-width="2"><path d="M9 12l2 2 4-4M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/></svg>
          Verified Pro
        </div>
        <div class="sb-name"><%= vendorName %></div>
        <div class="sb-cat"><%= vendorCategory %></div>
        <div class="sb-loc">📍 <%= vendorLocation %></div>
        <div class="sb-stats">
          <div class="sb-stat">
            <div class="sb-stat-val">4.9</div>
            <div class="sb-stat-lbl">Rating</div>
          </div>
          <div class="sb-stat">
            <div class="sb-stat-val">128</div>
            <div class="sb-stat-lbl">Reviews</div>
          </div>
        </div>
      </div>
    </div>

    <div class="sb-section">Menu</div>
    <div class="sb-item on">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/></svg>
      Dashboard
    </div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/></svg>
      My Bookings <span class="sb-count blue">8</span>
    </div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18M9 21V9"/></svg>
      Portfolio
    </div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/></svg>
      Messages <span class="sb-count red">4</span>
    </div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H6"/></svg>
      Earnings
    </div>
    <div class="sb-divider"></div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="8" r="4"/><path d="M6 20v-2a6 6 0 0112 0v2"/></svg>
      My Profile
    </div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93l-1.41 1.41M4.93 4.93l1.41 1.41M19.07 19.07l-1.41-1.41M4.93 19.07l1.41-1.41M12 2v2M12 20v2M2 12H4M20 12h2"/></svg>
      Settings
    </div>
    <div class="sb-divider"></div>
    <div class="sb-item sb-logout" onclick="location.href='<%= request.getContextPath() %>/logout'">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
      <span style="color:var(--danger)">Sign out</span>
    </div>
  </aside>

  <main class="content">
    <div class="pg-hero">
      <div class="pg-hero-bg"></div>
      <div class="pg-hero-overlay"></div>
      <div class="pg-hero-body">
        <div class="pg-hero-eyebrow">Welcome back</div>
        <div class="pg-hero-name"><%= vendorName %></div>
        <div class="pg-hero-cat"><%= vendorCategory %> · <%= vendorLocation %></div>
      </div>
      <div class="pg-hero-actions">
        <button class="btn btn-white">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
          View schedule
        </button>
        <button class="btn btn-primary">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
          New availability
        </button>
      </div>
    </div>

    <div class="kpi-grid">
      <div class="kpi">
        <div class="kpi-top"><div class="kpi-lbl">Total Earnings</div><div class="kpi-icon">💰</div></div>
        <div class="kpi-val">₹12,400</div>
        <div class="kpi-chg up">
          <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="18 15 12 9 6 15"/></svg>
          22% <span>vs last month</span>
        </div>
      </div>
      <div class="kpi">
        <div class="kpi-top"><div class="kpi-lbl">Total Bookings</div><div class="kpi-icon">📅</div></div>
        <div class="kpi-val">128</div>
        <div class="kpi-chg up">
          <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="18 15 12 9 6 15"/></svg>
          15% <span>vs last month</span>
        </div>
      </div>
      <div class="kpi">
        <div class="kpi-top"><div class="kpi-lbl">Avg Rating</div><div class="kpi-icon">⭐</div></div>
        <div class="kpi-val">4.9</div>
        <div class="kpi-chg neu">
          <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"/></svg>
          Stable <span>this month</span>
        </div>
      </div>
      <div class="kpi">
        <div class="kpi-top"><div class="kpi-lbl">Profile Views</div><div class="kpi-icon">👁</div></div>
        <div class="kpi-val">2,340</div>
        <div class="kpi-chg up">
          <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="18 15 12 9 6 15"/></svg>
          38% <span>this week</span>
        </div>
      </div>
    </div>

    <div class="grid-2">
      <div style="display:flex;flex-direction:column;gap:22px">
        <div class="card">
          <div class="card-head">
            <div>
              <div class="card-title">Recent Bookings</div>
              <div class="card-sub">8 active · 3 pending confirmation</div>
            </div>
            <span class="card-link">View all →</span>
          </div>
          <div class="bk-list">
            <div class="bk-item">
              <img class="bk-photo" src="https://img.freepik.com/free-photo/indian-wedding-couple-close-up_23-2151270563.jpg" alt="booking"/>
              <div class="bk-info">
                <div class="bk-client">Ananya & Vikram — Wedding</div>
                <div class="bk-detail">
                  <span>📅 18 May 2025</span>
                  <span>📍 The Taj, Mumbai</span>
                </div>
              </div>
              <div style="display:flex;flex-direction:column;align-items:flex-end;gap:6px">
                <div class="bk-amount">₹2,500</div>
                <span class="bk-status confirmed">Confirmed</span>
              </div>
            </div>
            <div class="bk-item">
              <img class="bk-photo" src="https://img.freepik.com/free-photo/beautiful-portrait-elegant-bride-groom_23-2151207155.jpg" alt="booking"/>
              <div class="bk-info">
                <div class="bk-client">Mehta Family — Engagement</div>
                <div class="bk-detail">
                  <span>📅 25 May 2025</span>
                  <span>📍 Leela Palace, Delhi</span>
                </div>
              </div>
              <div style="display:flex;flex-direction:column;align-items:flex-end;gap:6px">
                <div class="bk-amount">₹1,800</div>
                <span class="bk-status pending">Pending</span>
              </div>
            </div>
            <div class="bk-item">
              <img class="bk-photo" src="https://img.freepik.com/free-photo/young-couple-outdoor-engagement-session_23-2151282948.jpg" alt="booking"/>
              <div class="bk-info">
                <div class="bk-client">Sharma & Singh — Pre-Wedding</div>
                <div class="bk-detail">
                  <span>📅 2 Jun 2025</span>
                  <span>📍 Rajasthan, Jaipur</span>
                </div>
              </div>
              <div style="display:flex;flex-direction:column;align-items:flex-end;gap:6px">
                <div class="bk-amount">₹3,200</div>
                <span class="bk-status confirmed">Confirmed</span>
              </div>
            </div>
            <div class="bk-item">
              <img class="bk-photo" src="https://img.freepik.com/free-photo/corporate-event-business-conference_23-2149847316.jpg" alt="booking"/>
              <div class="bk-info">
                <div class="bk-client">TechCorp India — Corporate Event</div>
                <div class="bk-detail">
                  <span>📅 10 Jun 2025</span>
                  <span>📍 Hyderabad Convention</span>
                </div>
              </div>
              <div style="display:flex;flex-direction:column;align-items:flex-end;gap:6px">
                <div class="bk-amount">₹1,400</div>
                <span class="bk-status completed">Completed</span>
              </div>
            </div>
          </div>
        </div>

        <div class="card">
          <div class="card-head">
            <div>
              <div class="card-title">Upcoming Schedule</div>
              <div class="card-sub">Next 2 weeks</div>
            </div>
            <span class="card-link">Full calendar →</span>
          </div>
          <div class="upcoming">
            <div class="up-item">
              <div class="up-date"><div class="up-day">18</div><div class="up-mon">May</div></div>
              <div class="up-info">
                <div class="up-title">Ananya & Vikram Wedding</div>
                <div class="up-sub">The Taj, Mumbai · Full day shoot</div>
              </div>
              <span class="up-type">Wedding</span>
            </div>
            <div class="up-item">
              <div class="up-date"><div class="up-day">22</div><div class="up-mon">May</div></div>
              <div class="up-info">
                <div class="up-title">Kapoor Family Portrait Session</div>
                <div class="up-sub">Bandra, Mumbai · 2 hours</div>
              </div>
              <span class="up-type">Portrait</span>
            </div>
            <div class="up-item">
              <div class="up-date"><div class="up-day">25</div><div class="up-mon">May</div></div>
              <div class="up-info">
                <div class="up-title">Mehta Engagement Ceremony</div>
                <div class="up-sub">Leela Palace, Delhi · Evening</div>
              </div>
              <span class="up-type">Engagement</span>
            </div>
          </div>
        </div>
      </div>

      <div style="display:flex;flex-direction:column;gap:22px">
        <div class="card">
          <div class="card-head">
            <div>
              <div class="card-title">Portfolio</div>
              <div class="card-sub">24 photos · 6 videos</div>
            </div>
            <span class="card-link">Manage →</span>
          </div>
          <div class="port-grid">
            <img class="port-img" src="https://img.freepik.com/free-photo/wedding-couple-posing-beautiful-nature_23-2151270553.jpg" alt="portfolio"/>
            <img class="port-img" src="https://img.freepik.com/free-photo/indian-wedding-couple-close-up_23-2151270563.jpg" alt="portfolio"/>
            <img class="port-img" src="https://img.freepik.com/free-photo/beautiful-portrait-elegant-bride-groom_23-2151207155.jpg" alt="portfolio"/>
            <div class="port-add" onclick="toast('Upload feature coming soon')">
              <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
              Add photo
            </div>
          </div>
        </div>

        <div class="card">
          <div class="card-head">
            <div>
              <div class="card-title">Messages</div>
              <div class="card-sub">4 unread conversations</div>
            </div>
            <span class="card-link">Open →</span>
          </div>
          <div class="msg-list">
            <div class="msg-item">
              <img class="msg-avatar" src="https://img.freepik.com/free-photo/young-indian-woman-with-beautiful-smile_23-2148956428.jpg?w=80" alt=""/>
              <div style="flex:1;overflow:hidden">
                <div class="msg-name">Ananya Mehta</div>
                <div class="msg-preview">Hi! Are you available on May 18th for our wedding?</div>
              </div>
              <div style="display:flex;flex-direction:column;align-items:flex-end;gap:5px">
                <div class="msg-time">2m ago</div>
                <div class="msg-unread"></div>
              </div>
            </div>
            <div class="msg-item">
              <img class="msg-avatar" src="https://img.freepik.com/free-photo/portrait-young-indian-man-traditional-clothing_23-2151183625.jpg?w=80" alt=""/>
              <div style="flex:1;overflow:hidden">
                <div class="msg-name">Vikram Singh</div>
                <div class="msg-preview">Can we discuss the package options?</div>
              </div>
              <div style="display:flex;flex-direction:column;align-items:flex-end;gap:5px">
                <div class="msg-time">1h ago</div>
                <div class="msg-unread"></div>
              </div>
            </div>
            <div class="msg-item">
              <img class="msg-avatar" src="https://img.freepik.com/free-photo/smiling-woman-with-hijab-posing_23-2148765051.jpg?w=80" alt=""/>
              <div style="flex:1;overflow:hidden">
                <div class="msg-name">Priya Sharma</div>
                <div class="msg-preview">Thank you so much for the beautiful photos!</div>
              </div>
              <div style="display:flex;flex-direction:column;align-items:flex-end;gap:5px">
                <div class="msg-time">3h ago</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </main>
</div>

<div class="toast" id="toast"></div>

<script>
function toast(msg){
  var t=document.getElementById('toast');
  t.textContent=msg;t.classList.add('show');
  setTimeout(function(){t.classList.remove('show');},3000);
}
</script>
</body>
</html>