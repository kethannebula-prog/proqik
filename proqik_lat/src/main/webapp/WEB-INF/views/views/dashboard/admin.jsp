<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
List<Map<String, Object>> professionals = (List<Map<String, Object>>) request.getAttribute("professionals");
if (professionals == null) professionals = new ArrayList();
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Admin Dashboard | ProQik</title>
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
  --font-disp:'Playfair Display',Georgia,serif;
  --font-serif:'Cormorant Garamond',Georgia,serif;
  --ease:cubic-bezier(.22,1,.36,1);
  --sh-soft:0 2px 16px rgba(27,55,108,.07);
  --sh-md:0 6px 28px rgba(27,55,108,.11);
  --sh-lg:0 16px 48px rgba(27,55,108,.16);
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html,body{font-family:var(--font-body);background:var(--off);color:var(--text);min-height:100%}
a{text-decoration:none;color:inherit}
button{font-family:var(--font-body);cursor:pointer;border:none;background:none}
img{display:block}

.hdr{
  position:sticky;top:0;z-index:200;
  background:var(--navy-deep);
  height:72px;padding:0 32px;
  display:flex;align-items:center;gap:0;
  box-shadow:0 2px 24px rgba(0,0,0,.35);
}
.hdr::after{
  content:'';position:absolute;bottom:0;left:0;right:0;height:1px;
  background:linear-gradient(90deg,transparent,rgba(255,255,255,.12),transparent);
}
.hdr-logo{display:flex;align-items:baseline;gap:1px;margin-right:44px}
.hdr-logo-pro{font-family:var(--font-disp);font-size:22px;font-weight:700;color:#fff;letter-spacing:-.2px}
.hdr-logo-q{font-family:var(--font-disp);font-size:22px;font-weight:700;color:rgba(255,255,255,.45);font-style:italic}
.hdr-logo-ik{font-family:var(--font-disp);font-size:22px;font-weight:400;color:rgba(255,255,255,.65)}

.hdr-nav{display:flex;gap:2px;flex:1}
.hdr-nav a{
  padding:10px 18px;font-size:13px;font-weight:500;
  color:rgba(255,255,255,.5);border-radius:8px;
  transition:all .2s;position:relative;
}
.hdr-nav a:hover{color:rgba(255,255,255,.85);background:rgba(255,255,255,.06)}
.hdr-nav a.on{color:#fff;background:rgba(255,255,255,.09)}
.hdr-nav a.on::after{
  content:'';position:absolute;bottom:6px;left:50%;transform:translateX(-50%);
  width:18px;height:2px;border-radius:1px;background:var(--navy-light);
}

.hdr-right{display:flex;align-items:center;gap:12px;margin-left:auto}
.hdr-search{
  display:flex;align-items:center;gap:9px;
  background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.1);
  border-radius:22px;padding:8px 16px;transition:all .2s;
}
.hdr-search:focus-within{background:rgba(255,255,255,.1);border-color:rgba(255,255,255,.2)}
.hdr-search input{background:none;border:none;outline:none;width:150px;font-size:13px;color:#fff;font-family:var(--font-body)}
.hdr-search input::placeholder{color:rgba(255,255,255,.35)}
.hdr-search svg{opacity:.4;flex-shrink:0}

.hdr-btn{
  width:42px;height:42px;border-radius:50%;
  background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.1);
  display:flex;align-items:center;justify-content:center;
  font-size:17px;position:relative;transition:all .2s;
}
.hdr-btn:hover{background:rgba(255,255,255,.13)}
.hdr-badge{
  position:absolute;top:-2px;right:-2px;
  width:17px;height:17px;border-radius:50%;
  background:var(--danger);color:#fff;
  font-size:9px;font-weight:700;
  display:flex;align-items:center;justify-content:center;
  border:2px solid var(--navy-deep);
}

.hdr-user{
  display:flex;align-items:center;gap:11px;
  padding:7px 14px 7px 7px;
  background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.1);
  border-radius:26px;cursor:pointer;transition:all .2s;
}
.hdr-user:hover{background:rgba(255,255,255,.12)}
.hdr-user img{
  width:34px;height:34px;border-radius:50%;object-fit:cover;
  border:2px solid rgba(255,255,255,.2);
}
.hdr-user-name{font-size:13px;font-weight:600;color:#fff}
.hdr-user-role{font-size:10.5px;color:rgba(255,255,255,.45)}

.layout{display:grid;grid-template-columns:256px 1fr;min-height:calc(100vh - 72px)}

.sidebar{
  background:var(--white);
  border-right:1px solid var(--border);
  padding:28px 0 28px;
  position:sticky;top:72px;
  height:calc(100vh - 72px);
  overflow-y:auto;
  display:flex;flex-direction:column;
}

.sb-profile{
  text-align:center;padding:0 24px 28px;
  border-bottom:1px solid var(--border-light);margin-bottom:20px;
}
.sb-avatar-wrap{
  position:relative;display:inline-block;margin-bottom:14px;
}
.sb-avatar{
  width:88px;height:88px;border-radius:50%;object-fit:cover;
  border:3px solid var(--white);
  box-shadow:0 0 0 3px var(--navy-light),var(--sh-md);
}
.sb-online{
  position:absolute;bottom:4px;right:4px;
  width:14px;height:14px;border-radius:50%;
  background:var(--success);border:2.5px solid var(--white);
}
.sb-name{font-family:var(--font-disp);font-size:18px;font-weight:600;color:var(--text);margin-bottom:3px}
.sb-email{font-size:11.5px;color:var(--text-faint);margin-bottom:12px}
.sb-pill{
  display:inline-flex;align-items:center;gap:5px;
  background:var(--navy);color:#fff;
  font-size:10px;font-weight:700;letter-spacing:.08em;text-transform:uppercase;
  padding:5px 14px;border-radius:20px;
}

.sb-section{
  font-size:9.5px;font-weight:700;letter-spacing:.12em;text-transform:uppercase;
  color:var(--text-faint);padding:12px 24px 8px;
}
.sb-item{
  display:flex;align-items:center;gap:12px;
  padding:12px 24px;font-size:13px;font-weight:500;
  color:var(--text-mid);cursor:pointer;
  border-left:3px solid transparent;
  transition:all .2s;
}
.sb-item:hover{background:var(--navy-xlight);color:var(--navy)}
.sb-item.on{
  background:linear-gradient(90deg,var(--navy-xlight),transparent);
  color:var(--navy);border-left-color:var(--navy);font-weight:600;
}
.sb-item svg{opacity:.6;flex-shrink:0}
.sb-item.on svg{opacity:1}
.sb-count{
  margin-left:auto;padding:3px 9px;border-radius:12px;
  font-size:10px;font-weight:700;
}
.sb-count.red{background:var(--danger-bg);color:var(--danger)}
.sb-count.green{background:var(--success-bg);color:var(--success)}
.sb-count.blue{background:var(--navy-xlight);color:var(--navy)}
.sb-divider{height:1px;background:var(--border-light);margin:12px 24px}
.sb-logout{color:var(--danger) !important}
.sb-logout svg{opacity:.7 !important}

.content{padding:36px 36px;background:var(--off)}

.pg-hdr{
  display:flex;align-items:flex-end;justify-content:space-between;
  margin-bottom:32px;
}
.pg-title{
  font-family:var(--font-disp);font-size:32px;font-weight:700;
  color:var(--text);letter-spacing:-.3px;margin-bottom:5px;
}
.pg-sub{font-size:13.5px;color:var(--text-faint);font-weight:300}
.pg-sub span{color:var(--navy);font-weight:500}
.pg-actions{display:flex;gap:10px}

.btn{
  padding:12px 22px;border-radius:10px;
  font-family:var(--font-body);font-size:13px;font-weight:600;
  display:flex;align-items:center;gap:7px;
  transition:all .22s var(--ease);
}
.btn-primary{
  background:var(--navy);color:#fff;
  box-shadow:0 4px 16px var(--navy-glow);
}
.btn-primary:hover{background:var(--navy-mid);transform:translateY(-1px);box-shadow:0 8px 24px var(--navy-glow)}
.btn-outline{
  background:var(--white);color:var(--text-mid);
  border:1.5px solid var(--border);
}
.btn-outline:hover{border-color:var(--navy);color:var(--navy)}

.hero-banner{
  position:relative;border-radius:20px;overflow:hidden;
  height:180px;margin-bottom:32px;
  background:var(--navy-deep);
}
.hero-bg{
  position:absolute;inset:0;
  background-image:url('https://img.freepik.com/free-photo/photography-equipment-studio_23-2149547615.jpg');
  background-size:cover;background-position:center 40%;
  opacity:.25;
}
.hero-overlay{
  position:absolute;inset:0;
  background:linear-gradient(90deg, var(--navy-deep) 30%, rgba(15,31,61,.4) 100%);
}
.hero-content{position:relative;z-index:1;padding:36px 40px;height:100%;display:flex;flex-direction:column;justify-content:center}
.hero-eyebrow{
  font-family:var(--font-serif);font-size:12px;font-style:italic;
  color:rgba(255,255,255,.5);letter-spacing:.1em;margin-bottom:8px;
}
.hero-title{font-family:var(--font-disp);font-size:26px;font-weight:700;color:#fff;margin-bottom:6px;letter-spacing:-.2px}
.hero-sub{font-size:13px;color:rgba(255,255,255,.5);font-weight:300}
.hero-badge{
  position:absolute;right:40px;top:50%;transform:translateY(-50%);
  background:rgba(255,255,255,.07);backdrop-filter:blur(10px);
  border:1px solid rgba(255,255,255,.12);border-radius:16px;
  padding:20px 28px;text-align:center;
}
.hero-badge-val{font-family:var(--font-disp);font-size:30px;font-weight:700;color:#fff}
.hero-badge-lbl{font-size:11px;color:rgba(255,255,255,.45);margin-top:2px}

.kpi-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:20px;margin-bottom:32px}
.kpi{
  background:var(--white);border-radius:18px;
  padding:24px;border:1px solid var(--border);
  box-shadow:var(--sh-soft);
  transition:all .3s var(--ease);position:relative;overflow:hidden;
}
.kpi::before{
  content:'';position:absolute;top:0;left:0;right:0;height:3px;
  background:linear-gradient(90deg,var(--navy),var(--navy-mid));
  opacity:0;transition:opacity .3s;
}
.kpi:hover{transform:translateY(-3px);box-shadow:var(--sh-md)}
.kpi:hover::before{opacity:1}
.kpi-top{display:flex;align-items:flex-start;justify-content:space-between;margin-bottom:16px}
.kpi-label{font-size:11.5px;font-weight:600;color:var(--text-faint);letter-spacing:.04em;text-transform:uppercase}
.kpi-icon{
  width:40px;height:40px;border-radius:12px;
  background:var(--navy-xlight);
  display:flex;align-items:center;justify-content:center;font-size:19px;
}
.kpi-val{font-family:var(--font-disp);font-size:30px;font-weight:700;color:var(--text);letter-spacing:-.5px;margin-bottom:8px}
.kpi-change{font-size:12px;font-weight:500;display:flex;align-items:center;gap:5px}
.kpi-change.up{color:var(--success)}
.kpi-change.down{color:var(--danger)}
.kpi-change span{color:var(--text-faint);font-weight:400}

.grid-2{display:grid;grid-template-columns:1fr 360px;gap:24px;margin-bottom:24px}

.card{
  background:var(--white);border-radius:18px;
  border:1px solid var(--border);box-shadow:var(--sh-soft);
  overflow:hidden;
}
.card-head{
  display:flex;align-items:center;justify-content:space-between;
  padding:22px 28px 18px;border-bottom:1px solid var(--border-light);
}
.card-title{font-family:var(--font-disp);font-size:17px;font-weight:600;color:var(--text);letter-spacing:-.2px}
.card-sub{font-size:12px;color:var(--text-faint);margin-top:2px}
.card-link{font-size:12.5px;font-weight:600;color:var(--navy);display:flex;align-items:center;gap:4px;cursor:pointer;transition:gap .2s}
.card-link:hover{gap:7px}

.tbl{width:100%;border-collapse:collapse}
.tbl th{
  padding:13px 24px;font-size:10.5px;font-weight:700;
  letter-spacing:.08em;text-transform:uppercase;
  color:var(--text-faint);text-align:left;
  background:var(--off);border-bottom:1px solid var(--border);
}
.tbl td{padding:16px 24px;font-size:13px;color:var(--text-mid);border-bottom:1px solid var(--border-light)}
.tbl tr:last-child td{border-bottom:none}
.tbl tr:hover td{background:#fafcff}

.tbl-user{display:flex;align-items:center;gap:13px}
.tbl-avatar{
  width:40px;height:40px;border-radius:50%;object-fit:cover;
  border:2px solid var(--navy-light);flex-shrink:0;
}
.tbl-name{font-size:13.5px;font-weight:600;color:var(--text);margin-bottom:2px}
.tbl-loc{font-size:11px;color:var(--text-faint)}

.tbl-stars{color:#f59e0b;font-size:12px;letter-spacing:1px}
.tbl-rating{display:flex;align-items:center;gap:6px}
.tbl-rating strong{font-weight:700;color:var(--text)}
.tbl-rating span{font-size:11.5px;color:var(--text-faint)}

.status{
  display:inline-flex;align-items:center;gap:5px;
  padding:4px 12px;border-radius:6px;
  font-size:10.5px;font-weight:700;letter-spacing:.04em;text-transform:uppercase;
}
.status::before{content:'';width:6px;height:6px;border-radius:50%;flex-shrink:0}
.status.active{background:var(--success-bg);color:var(--success)}
.status.active::before{background:var(--success)}
.status.pending{background:var(--warn-bg);color:var(--warn)}
.status.pending::before{background:var(--warn)}

.tbl-actions{display:flex;gap:7px}
.tbl-btn{
  padding:7px 14px;border-radius:8px;
  font-family:var(--font-body);font-size:11.5px;font-weight:600;
  transition:all .18s;
}
.tbl-btn.view{background:var(--navy-xlight);color:var(--navy);border:1.5px solid var(--navy-light)}
.tbl-btn.view:hover{background:var(--navy-light)}
.tbl-btn.approve{background:var(--success-bg);color:var(--success);border:1.5px solid var(--success-border)}
.tbl-btn.approve:hover{background:#dcfce7}
.tbl-btn.reject{background:var(--danger-bg);color:var(--danger);border:1.5px solid var(--danger-border)}
.tbl-btn.reject:hover{background:#fee2e2}

.feed{padding:20px 28px;display:flex;flex-direction:column;gap:0}
.feed-item{
  display:flex;align-items:flex-start;gap:14px;
  padding:14px 0;border-bottom:1px solid var(--border-light);
}
.feed-item:last-child{border-bottom:none}
.feed-avatar{
  width:38px;height:38px;border-radius:50%;object-fit:cover;flex-shrink:0;
  border:2px solid var(--navy-light);
}
.feed-text{flex:1}
.feed-msg{font-size:12.5px;color:var(--text-mid);line-height:1.5;margin-bottom:3px}
.feed-msg strong{color:var(--text);font-weight:600}
.feed-time{font-size:11px;color:var(--text-faint)}
.feed-dot{
  width:8px;height:8px;border-radius:50%;
  flex-shrink:0;margin-top:6px;
}
.feed-dot.green{background:var(--success)}
.feed-dot.blue{background:var(--navy)}
.feed-dot.warn{background:var(--warn)}

.chart-wrap{padding:20px 28px}
.chart-bars{display:flex;align-items:flex-end;gap:6px;height:80px}
.bar{
  flex:1;border-radius:4px 4px 0 0;
  background:var(--navy-xlight);
  transition:background .2s;cursor:pointer;
}
.bar:hover{background:var(--navy-light)}
.bar.hi{background:var(--navy);opacity:.8}
.bar.hi:hover{opacity:1}
.chart-labels{display:flex;gap:6px;margin-top:8px}
.chart-labels span{flex:1;text-align:center;font-size:9.5px;color:var(--text-faint)}

.toast{
  position:fixed;bottom:28px;left:50%;transform:translateX(-50%) translateY(10px);
  background:var(--navy-deep);color:#fff;
  padding:14px 24px;border-radius:12px;font-size:13.5px;font-weight:500;
  box-shadow:0 10px 40px rgba(0,0,0,.35);z-index:9999;
  opacity:0;transition:all .3s var(--ease);pointer-events:none;
}
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
    <a href="#">Professionals</a>
    <a href="#">Bookings</a>
    <a href="#">Analytics</a>
    <a href="#">Finance</a>
  </nav>
  <div class="hdr-right">
    <div class="hdr-search">
      <svg width="14" height="14" viewBox="0 0 20 20" fill="none"><circle cx="9" cy="9" r="6" stroke="white" stroke-width="1.5"/><path d="M13.5 13.5L17 17" stroke="white" stroke-width="1.5" stroke-linecap="round"/></svg>
      <input type="text" placeholder="Search platform…"/>
    </div>
    <button class="hdr-btn">🔔<span class="hdr-badge">3</span></button>
    <button class="hdr-btn">✉<span class="hdr-badge" style="background:var(--success)">7</span></button>
    <div class="hdr-user">
      <img src="https://img.freepik.com/free-photo/smiling-businessman-face-portrait-wearing-suit_53876-148138.jpg?w=100" alt="Admin"/>
      <div>
        <div class="hdr-user-name">Super Admin</div>
        <div class="hdr-user-role">Administrator</div>
      </div>
    </div>
  </div>
</header>

<div class="layout">
  <aside class="sidebar">
    <div class="sb-profile">
      <div class="sb-avatar-wrap">
        <img class="sb-avatar" src="https://img.freepik.com/free-photo/smiling-businessman-face-portrait-wearing-suit_53876-148138.jpg?w=150" alt="Admin"/>
        <span class="sb-online"></span>
      </div>
      <div class="sb-name">Super Admin</div>
      <div class="sb-email">admin@proqik.in</div>
      <div class="sb-pill">
        <svg width="10" height="10" viewBox="0 0 12 12" fill="currentColor"><path d="M6 1l1.5 3 3.5.5-2.5 2.5.6 3.5L6 9l-3.1 1.5.6-3.5L1 4.5l3.5-.5z"/></svg>
        ADMIN
      </div>
    </div>

    <div class="sb-section">Main</div>
    <div class="sb-item on">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="3" width="7" height="7" rx="1"/><rect x="14" y="3" width="7" height="7" rx="1"/><rect x="3" y="14" width="7" height="7" rx="1"/><rect x="14" y="14" width="7" height="7" rx="1"/></svg>
      Dashboard
    </div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="9" cy="7" r="4"/><path d="M3 21v-2a4 4 0 014-4h4a4 4 0 014 4v2"/><path d="M16 11a4 4 0 010 8"/><path d="M21 21v-2a4 4 0 00-3-3.87"/></svg>
      Professionals <span class="sb-count blue">152</span>
    </div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="4" width="18" height="18" rx="2"/><path d="M16 2v4M8 2v4M3 10h18"/></svg>
      Bookings <span class="sb-count red">12</span>
    </div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/><polyline points="14 2 14 8 20 8"/><line x1="9" y1="13" x2="15" y2="13"/><line x1="9" y1="17" x2="15" y2="17"/></svg>
      Applications <span class="sb-count red">5</span>
    </div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>
      Analytics
    </div>
    <div class="sb-divider"></div>
    <div class="sb-section">System</div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 000 7h5a3.5 3.5 0 010 7H6"/></svg>
      Finance
    </div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
      Reviews
    </div>
    <div class="sb-item">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><circle cx="12" cy="12" r="3"/><path d="M19.07 4.93l-1.41 1.41M4.93 4.93l1.41 1.41M19.07 19.07l-1.41-1.41M4.93 19.07l1.41-1.41M12 2v2M12 20v2M2 12H4M20 12h2"/></svg>
      Settings
    </div>
    <div class="sb-divider"></div>
    <div class="sb-item sb-logout" onclick="location.href='<%= request.getContextPath() %>/logout'">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><path d="M9 21H5a2 2 0 01-2-2V5a2 2 0 012-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
      Sign out
    </div>
  </aside>

  <main class="content">
    <div class="pg-hdr">
      <div>
        <div class="pg-title">Good morning, Admin</div>
        <div class="pg-sub">Today is <span id="todayDate">Monday</span> — <span>1,284 bookings</span> on the platform</div>
      </div>
      <div class="pg-actions">
        <button class="btn btn-outline">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
          Export
        </button>
        <button class="btn btn-primary">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
          Add Professional
        </button>
      </div>
    </div>

    <div class="hero-banner">
      <div class="hero-bg"></div>
      <div class="hero-overlay"></div>
      <div class="hero-content">
        <div class="hero-eyebrow">Platform overview</div>
        <div class="hero-title">India's Premier Creative Network</div>
        <div class="hero-sub">Connecting talented professionals with clients across every city</div>
      </div>
      <div class="hero-badge">
        <div class="hero-badge-val">₹48.2K</div>
        <div class="hero-badge-lbl">Revenue this month</div>
      </div>
    </div>

    <div class="kpi-grid">
      <div class="kpi">
        <div class="kpi-top">
          <div class="kpi-label">Total Bookings</div>
          <div class="kpi-icon">📅</div>
        </div>
        <div class="kpi-val">1,284</div>
        <div class="kpi-change up">
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="18 15 12 9 6 15"/></svg>
          18.4% <span>vs last month</span>
        </div>
      </div>
      <div class="kpi">
        <div class="kpi-top">
          <div class="kpi-label">Active Pros</div>
          <div class="kpi-icon">👥</div>
        </div>
        <div class="kpi-val">152</div>
        <div class="kpi-change up">
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="18 15 12 9 6 15"/></svg>
          12.1% <span>vs last month</span>
        </div>
      </div>
      <div class="kpi">
        <div class="kpi-top">
          <div class="kpi-label">Platform Revenue</div>
          <div class="kpi-icon">💰</div>
        </div>
        <div class="kpi-val">₹48.2K</div>
        <div class="kpi-change up">
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="18 15 12 9 6 15"/></svg>
          23.7% <span>vs last month</span>
        </div>
      </div>
      <div class="kpi">
        <div class="kpi-top">
          <div class="kpi-label">Avg Rating</div>
          <div class="kpi-icon">⭐</div>
        </div>
        <div class="kpi-val">4.91</div>
        <div class="kpi-change up">
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="18 15 12 9 6 15"/></svg>
          +0.02 <span>vs last month</span>
        </div>
      </div>
    </div>

    <div class="grid-2">
      <div class="card">
        <div class="card-head">
          <div>
            <div class="card-title">Professional Management</div>
            <div class="card-sub">5 pending review · 147 active</div>
          </div>
          <span class="card-link">View all →</span>
        </div>
        <table class="tbl">
          <thead>
            <tr>
              <th>Professional</th>
              <th>Category</th>
              <th>Rating</th>
              <th>Earnings</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>
                <div class="tbl-user">
                  <img class="tbl-avatar" src="https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=80" alt="Ravi"/>
                  <div>
                    <div class="tbl-name">Ravi Kumar</div>
                    <div class="tbl-loc">📍 Mumbai, India</div>
                  </div>
                </div>
              </td>
              <td>Wedding Photography</td>
              <td>
                <div class="tbl-rating">
                  <span class="tbl-stars">★★★★★</span>
                  <strong>4.9</strong><span>(128)</span>
                </div>
              </td>
              <td><strong>₹12,400</strong></td>
              <td><span class="status active">Active</span></td>
              <td>
                <div class="tbl-actions">
                  <button class="tbl-btn view" onclick="toast('Viewing Ravi Kumar')">View</button>
                </div>
              </td>
            </tr>
            <tr>
              <td>
                <div class="tbl-user">
                  <img class="tbl-avatar" src="https://img.freepik.com/free-photo/portrait-young-indian-man-traditional-clothing_23-2151183625.jpg?w=80" alt="Sky Vision"/>
                  <div>
                    <div class="tbl-name">Sky Vision India</div>
                    <div class="tbl-loc">📍 Bangalore, India</div>
                  </div>
                </div>
              </td>
              <td>Aerial Videography</td>
              <td>
                <div class="tbl-rating">
                  <span class="tbl-stars">★★★★★</span>
                  <strong>5.0</strong><span>(74)</span>
                </div>
              </td>
              <td><strong>₹9,840</strong></td>
              <td><span class="status active">Active</span></td>
              <td>
                <div class="tbl-actions">
                  <button class="tbl-btn view" onclick="toast('Viewing Sky Vision India')">View</button>
                </div>
              </td>
            </tr>
            <tr>
              <td>
                <div class="tbl-user">
                  <img class="tbl-avatar" src="https://img.freepik.com/free-photo/young-indian-woman-with-beautiful-smile_23-2148956428.jpg?w=80" alt="Kavya"/>
                  <div>
                    <div class="tbl-name">Kavya Sharma</div>
                    <div class="tbl-loc">📍 Delhi, India</div>
                  </div>
                </div>
              </td>
              <td>Portrait Photography</td>
              <td>
                <div class="tbl-rating">
                  <span class="tbl-stars">★★★★☆</span>
                  <strong>4.8</strong><span>(52)</span>
                </div>
              </td>
              <td><strong>₹5,280</strong></td>
              <td><span class="status pending">Pending</span></td>
              <td>
                <div class="tbl-actions">
                  <button class="tbl-btn approve" onclick="toast('✓ Kavya Sharma approved')">Approve</button>
                  <button class="tbl-btn reject" onclick="toast('✗ Rejected')">Reject</button>
                </div>
              </td>
            </tr>
            <tr>
              <td>
                <div class="tbl-user">
                  <img class="tbl-avatar" src="https://img.freepik.com/free-photo/indian-man-working-laptop_23-2148998889.jpg?w=80" alt="Arjun"/>
                  <div>
                    <div class="tbl-name">Arjun Mehta</div>
                    <div class="tbl-loc">📍 Pune, India</div>
                  </div>
                </div>
              </td>
              <td>Album Design</td>
              <td>
                <div class="tbl-rating">
                  <span class="tbl-stars">★★★★☆</span>
                  <strong>4.7</strong><span>(36)</span>
                </div>
              </td>
              <td><strong>₹4,200</strong></td>
              <td><span class="status active">Active</span></td>
              <td>
                <div class="tbl-actions">
                  <button class="tbl-btn view" onclick="toast('Viewing Arjun Mehta')">View</button>
                </div>
              </td>
            </tr>
            <tr>
              <td>
                <div class="tbl-user">
                  <img class="tbl-avatar" src="https://img.freepik.com/free-photo/smiling-woman-with-hijab-posing_23-2148765051.jpg?w=80" alt="Priya"/>
                  <div>
                    <div class="tbl-name">Priya Nair</div>
                    <div class="tbl-loc">📍 Chennai, India</div>
                  </div>
                </div>
              </td>
              <td>Cinematic Videography</td>
              <td>
                <div class="tbl-rating">
                  <span class="tbl-stars">★★★★★</span>
                  <strong>4.9</strong><span>(61)</span>
                </div>
              </td>
              <td><strong>₹8,100</strong></td>
              <td><span class="status pending">Pending</span></td>
              <td>
                <div class="tbl-actions">
                  <button class="tbl-btn approve" onclick="toast('✓ Priya Nair approved')">Approve</button>
                  <button class="tbl-btn reject" onclick="toast('✗ Rejected')">Reject</button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div style="display:flex;flex-direction:column;gap:24px">
        <div class="card">
          <div class="card-head">
            <div>
              <div class="card-title">Bookings</div>
              <div class="card-sub">Last 7 days</div>
            </div>
            <span style="font-family:var(--font-disp);font-size:22px;font-weight:700;color:var(--navy)">214</span>
          </div>
          <div class="chart-wrap">
            <div class="chart-bars">
              <div class="bar" style="height:45%"></div>
              <div class="bar" style="height:60%"></div>
              <div class="bar" style="height:38%"></div>
              <div class="bar hi" style="height:85%"></div>
              <div class="bar" style="height:72%"></div>
              <div class="bar" style="height:55%"></div>
              <div class="bar hi" style="height:90%"></div>
            </div>
            <div class="chart-labels">
              <span>Mon</span><span>Tue</span><span>Wed</span><span>Thu</span><span>Fri</span><span>Sat</span><span>Sun</span>
            </div>
          </div>
        </div>

        <div class="card" style="flex:1">
          <div class="card-head">
            <div>
              <div class="card-title">Activity</div>
              <div class="card-sub">Real-time updates</div>
            </div>
            <span class="card-link">See all →</span>
          </div>
          <div class="feed">
            <div class="feed-item">
              <span class="feed-dot green"></span>
              <img class="feed-avatar" src="https://img.freepik.com/free-photo/young-indian-woman-with-beautiful-smile_23-2148956428.jpg?w=60" alt=""/>
              <div class="feed-text">
                <div class="feed-msg"><strong>Kavya Sharma</strong> submitted a new application</div>
                <div class="feed-time">2 minutes ago</div>
              </div>
            </div>
            <div class="feed-item">
              <span class="feed-dot blue"></span>
              <img class="feed-avatar" src="https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=60" alt=""/>
              <div class="feed-text">
                <div class="feed-msg"><strong>Ravi Kumar</strong> completed a wedding booking in Mumbai</div>
                <div class="feed-time">18 minutes ago</div>
              </div>
            </div>
            <div class="feed-item">
              <span class="feed-dot warn"></span>
              <img class="feed-avatar" src="https://img.freepik.com/free-photo/smiling-woman-with-hijab-posing_23-2148765051.jpg?w=60" alt=""/>
              <div class="feed-text">
                <div class="feed-msg"><strong>Priya Nair</strong> requested a payout of ₹8,100</div>
                <div class="feed-time">1 hour ago</div>
              </div>
            </div>
            <div class="feed-item">
              <span class="feed-dot green"></span>
              <img class="feed-avatar" src="https://img.freepik.com/free-photo/portrait-young-indian-man-traditional-clothing_23-2151183625.jpg?w=60" alt=""/>
              <div class="feed-text">
                <div class="feed-msg"><strong>Sky Vision India</strong> received a 5-star review</div>
                <div class="feed-time">3 hours ago</div>
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
document.getElementById('todayDate').textContent = new Date().toLocaleDateString('en-IN',{weekday:'long',day:'numeric',month:'long'});
function toast(msg){
  var t=document.getElementById('toast');
  t.textContent=msg;t.classList.add('show');
  setTimeout(function(){t.classList.remove('show');},3000);
}
</script>
</body>
</html>