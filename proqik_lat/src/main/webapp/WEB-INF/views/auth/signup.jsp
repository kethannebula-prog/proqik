<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%
String signupError = request.getParameter("error");
String submitted = request.getParameter("submitted");
System.out.println("DEBUG: signup error param = " + signupError + ", submitted=" + submitted);
String errorMsg = "";
if ("exists".equals(signupError)) {
    errorMsg = "This email is already registered. Please login or use a different email.";
} else if ("pending".equals(signupError)) {
    errorMsg = "Your application is pending admin approval. You will receive a confirmation email once approved.";
} else if ("rejected".equals(signupError)) {
    errorMsg = "Your application has been rejected. Please contact support for more information.";
}
Boolean gvAttr = (Boolean) request.getAttribute("googleVerified");
String geAttr = (String) request.getAttribute("googleEmail");
Boolean jvAttr = (Boolean) request.getAttribute("justVerified");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>ProQik — Join as a Creative Professional</title>
<link href="https://fonts.googleapis.com/css2?family=Merriweather:ital,wght@0,300;0,400;0,700;0,900;1,300&family=DM+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<style>
:root{
  --P:#1b376c;   --PD:#0f1f3d;  --PM:#254e99;
  --PL:#d4e3f7;  --PX:#eef5fb;
  --W:#fff;   --OFF:#f7f9fc;
  --BORDER:#dce8f4;
  --TEXT:#0c1a30; --MID:#3d546e; --FAINT:#8a9fb5;
  --ERR:#dc2626;  --OK:#16a34a;
  --font:'DM Sans',sans-serif;
  --disp:'Merriweather',Georgia,serif;
  --ease:cubic-bezier(.22,1,.36,1);
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html,body{height:100%;font-family:var(--font);-webkit-font-smoothing:antialiased;overflow-x:hidden}

body{
  min-height:100vh;
  display:flex;align-items:center;justify-content:center;
  padding:24px 16px;
  position:relative;
  background:var(--PD);
}
.page-bg{
  position:fixed;inset:0;z-index:0;
  background:url('<%= request.getContextPath() %>/images/videography.jpg') center/cover no-repeat;
  filter:brightness(.35);
}
.page-glow{
  position:fixed;top:50%;left:50%;transform:translate(-50%,-50%);
  width:800px;height:800px;border-radius:50%;
  background:radial-gradient(circle,rgba(27,55,108,.55) 0%,transparent 70%);
  z-index:1;pointer-events:none;
}

.float-pro{
  position:fixed;z-index:2;pointer-events:none;
  display:flex;flex-direction:column;align-items:center;gap:6px;
  animation:fpFloat 7s ease-in-out infinite;
}
.float-pro img{
  width:52px;height:52px;border-radius:50%;object-fit:cover;
  border:2.5px solid rgba(255,255,255,.25);
  box-shadow:0 8px 24px rgba(0,0,0,.4);
}
.float-pro-name{
  font-size:10px;font-weight:600;color:rgba(255,255,255,.6);
  background:rgba(0,0,0,.35);backdrop-filter:blur(8px);
  padding:3px 9px;border-radius:100px;border:1px solid rgba(255,255,255,.12);
  white-space:nowrap;
}
.fp1{top:15%;left:4%;animation-delay:0s}
.fp2{top:55%;left:2%;animation-delay:2.5s}
.fp3{top:20%;right:4%;animation-delay:1.2s}
.fp4{top:62%;right:3%;animation-delay:3.8s}
@keyframes fpFloat{0%,100%{transform:translateY(0)}50%{transform:translateY(-12px)}}

.live-toast{
  position:fixed;bottom:32px;left:50%;transform:translateX(-50%);
  z-index:10;
  display:flex;align-items:center;gap:10px;
  background:rgba(11,24,50,.9);backdrop-filter:blur(12px);
  border:1px solid rgba(255,255,255,.1);border-radius:100px;
  padding:10px 18px 10px 14px;
  box-shadow:0 8px 32px rgba(0,0,0,.4);
  animation:toastIn .6s 3s var(--ease) both,toastOut .5s 7s var(--ease) forwards;
}
@keyframes toastIn{from{opacity:0;transform:translateX(-50%) translateY(20px)}to{opacity:1;transform:translateX(-50%) translateY(0)}}
@keyframes toastOut{to{opacity:0;transform:translateX(-50%) translateY(20px)}}
.live-dot{width:8px;height:8px;border-radius:50%;background:#4ade80;box-shadow:0 0 0 3px rgba(74,222,128,.2);flex-shrink:0}
.live-toast-txt{font-size:12.5px;font-weight:500;color:rgba(255,255,255,.8)}

.card{
  position:relative;z-index:5;
  width:100%;max-width:860px;
  display:grid;grid-template-columns:280px 1fr;
  border-radius:24px;overflow:hidden;
  box-shadow:0 40px 100px rgba(0,0,0,.55),0 0 0 1px rgba(255,255,255,.07);
  animation:cardIn .7s var(--ease) both;
}
@keyframes cardIn{from{opacity:0;transform:translateY(32px)}to{opacity:1;transform:none}}

.sidebar{
  background:var(--P);
  padding:36px 28px;display:flex;flex-direction:column;
  position:relative;overflow:hidden;
}
.sidebar-img{
  position:absolute;inset:0;
  background:url('<%= request.getContextPath() %>/images/album-editor.jpg') center/cover no-repeat;
  opacity:.25;mix-blend-mode:luminosity;
}
.sidebar-dots{
  position:absolute;inset:0;pointer-events:none;
  background-image:radial-gradient(rgba(255,255,255,.08) 1px,transparent 1px);
  background-size:18px 18px;
}
.sidebar-body{position:relative;z-index:1;flex:1;display:flex;flex-direction:column}
.s-logo{
  font-family:var(--disp);font-size:22px;color:var(--W);font-weight:700;
  margin-bottom:28px;display:flex;align-items:center;gap:6px;
}
.s-logo-q{color:rgba(255,255,255,.38);font-style:italic;font-weight:400}

.s-tagline{
  font-family:var(--disp);font-size:23px;font-weight:700;
  color:var(--W);line-height:1.25;margin-bottom:8px;
}
.s-tagline em{font-style:italic;color:rgba(255,255,255,.55);font-weight:400}
.s-desc{font-size:12.5px;color:rgba(255,255,255,.42);line-height:1.75;margin-bottom:32px;font-weight:300}

.s-steps{display:flex;flex-direction:column;gap:0;margin-bottom:auto}
.s-step{
  display:flex;align-items:flex-start;gap:13px;
  padding:14px 0;
  border-bottom:1px solid rgba(255,255,255,.07);
}
.s-step:last-child{border-bottom:none}
.s-step-num{
  width:28px;height:28px;border-radius:50%;flex-shrink:0;
  display:flex;align-items:center;justify-content:center;
  font-size:12px;font-weight:700;
  transition:all .35s var(--ease);
}
.s-step-num.done{background:var(--W);color:var(--P)}
.s-step-num.active{background:rgba(255,255,255,.15);color:var(--W);border:1.5px solid rgba(255,255,255,.4)}
.s-step-num.idle{background:rgba(255,255,255,.07);color:rgba(255,255,255,.3);border:1px solid rgba(255,255,255,.1)}
.s-step-info { }
.s-step-title { font-size: 13px; font-weight: 600; color: var(--W); margin-bottom: 2px; transition: color .3s; }
.s-step-title.idle{color:rgba(255,255,255,.3)}
.s-step-sub{font-size:11px;color:rgba(255,255,255,.32);line-height:1.5}

.s-perks{margin-top:28px;display:flex;flex-direction:column;gap:8px}
.s-perk{
  display:flex;align-items:center;gap:8px;
  font-size:11.5px;color:rgba(255,255,255,.38);font-weight:400;
}
.s-perk::before{
  content:'';width:5px;height:5px;border-radius:50%;
  background:rgba(255,255,255,.28);flex-shrink:0;
}

.s-trust{
  margin-top:24px;padding-top:20px;
  border-top:1px solid rgba(255,255,255,.08);
  display:flex;align-items:center;gap:10px;
}
.s-trust-avs{display:flex}
.s-trust-av{
  width:26px;height:26px;border-radius:50%;
  border:2px solid var(--P);margin-left:-6px;overflow:hidden;
}
.s-trust-av:first-child{margin-left:0}
.s-trust-av img{width:100%;height:100%;object-fit:cover}
.s-trust-txt{font-size:10.5px;color:rgba(255,255,255,.35);line-height:1.45}
.s-trust-txt strong{color:rgba(255,255,255,.65);display:block}

.form-panel{
  background:var(--W);
  padding:40px 40px 36px;
  display:flex;flex-direction:column;
}
.step-eye{font-size:11px;font-weight:700;letter-spacing:.1em;text-transform:uppercase;color:var(--FAINT);margin-bottom:8px}
.form-h{font-family:var(--disp);font-size:28px;font-weight:700;color:var(--TEXT);margin-bottom:4px;letter-spacing:-.3px}
.form-sub{font-size:13.5px;color:var(--FAINT);margin-bottom:28px;font-weight:300}

.err-banner{
  display:flex;align-items:center;gap:9px;
  background:#fef2f2;border:1px solid #fecaca;border-radius:10px;
  padding:11px 15px;margin-bottom:22px;
  font-size:13px;color:var(--ERR);font-weight:500;
}
.err-banner.hidden{display:none}
.err-ico{font-size:15px;flex-shrink:0}

.f-row{display:grid;grid-template-columns:1fr 1fr;gap:16px;margin-bottom:16px}
.f-row.one{grid-template-columns:1fr}
.field { }
.field label {
  display:block;font-size:11px;font-weight:700;
  letter-spacing:.07em;text-transform:uppercase;
  color:var(--MID);margin-bottom:7px;
}
.field input,.field select{
  width:100%;border:1.5px solid var(--BORDER);border-radius:11px;
  padding:12px 15px;font-size:14px;font-family:var(--font);
  color:var(--TEXT);outline:none;background:var(--W);
  transition:border-color .2s,box-shadow .2s;
}
.field input:focus,.field select:focus{
  border-color:var(--P);
  box-shadow:0 0 0 3px rgba(27,55,108,.1);
}
.field input::placeholder{color:var(--FAINT)}
.field input.has-prefix{padding-left:52px}
.input-wrap{position:relative}
.input-prefix{
  position:absolute;left:15px;top:50%;transform:translateY(-50%);
  font-size:13.5px;font-weight:600;color:var(--MID);pointer-events:none;
}
.pass-toggle{
  position:absolute;right:14px;top:50%;transform:translateY(-50%);
  background:none;border:none;cursor:pointer;color:var(--FAINT);
  font-size:16px;padding:4px;transition:color .2s;
}
.pass-toggle:hover{color:var(--P)}

.check-row{
  display:flex;align-items:flex-start;gap:10px;
  margin:18px 0 24px;
}
.check-row input[type=checkbox]{
  width:17px;height:17px;accent-color:var(--P);margin-top:2px;flex-shrink:0;cursor:pointer;
}
.check-row label{font-size:12.5px;color:var(--MID);line-height:1.55;cursor:pointer}
.check-row label a{color:var(--P);font-weight:600}

.spec-group{margin-bottom:20px}
.spec-group-label{
  font-size:10px;font-weight:700;letter-spacing:.12em;text-transform:uppercase;
  color:var(--FAINT);margin-bottom:10px;
  display:flex;align-items:center;gap:8px;
}
.spec-group-label::after{content:'';flex:1;height:1px;background:var(--BORDER)}
.spec-pills{display:flex;flex-wrap:wrap;gap:8px}
.spec-pill{
  padding:7px 16px;border-radius:100px;
  border:1.5px solid var(--BORDER);background:var(--W);
  font-size:13px;font-weight:500;color:var(--MID);
  cursor:pointer;transition:all .2s var(--ease);
  user-select:none;
}
.spec-pill:hover{border-color:var(--P);color:var(--P);background:var(--PX)}
.spec-pill.on{
  border-color:var(--P);background:var(--P);color:var(--W);
  box-shadow:0 4px 14px rgba(27,55,108,.25);
}
.sel-count{
  display:inline-flex;align-items:center;gap:7px;
  background:var(--PX);border:1px solid var(--PL);border-radius:8px;
  padding:7px 14px;margin-top:4px;
  font-size:12.5px;font-weight:600;color:var(--P);
}
.sel-count .count-num{
  width:22px;height:22px;border-radius:50%;background:var(--P);color:var(--W);
  display:flex;align-items:center;justify-content:center;font-size:12px;font-weight:700;
}

.svc-cards{display:grid;grid-template-columns:repeat(3,1fr);gap:10px;margin-bottom:22px}
.svc-card{
  border:1.5px solid var(--BORDER);border-radius:14px;
  padding:16px 10px 14px;text-align:center;
  cursor:pointer;transition:all .25s var(--ease);
  background:var(--W);position:relative;
}
.svc-card:hover{border-color:var(--P);background:var(--PX);transform:translateY(-2px)}
.svc-card.on{
  border-color:var(--P);background:var(--PX);
  box-shadow:0 4px 18px rgba(27,55,108,.14);
}
.svc-check{
  position:absolute;top:8px;right:8px;
  width:20px;height:20px;border-radius:50%;
  background:var(--P);display:none;
  align-items:center;justify-content:center;
  font-size:10px;color:var(--W);font-weight:700;
}
.svc-card.on .svc-check{display:flex}
.svc-card-img{
  width:52px;height:52px;border-radius:12px;
  margin:0 auto 10px;overflow:hidden;
  background:var(--P);display:flex;align-items:center;justify-content:center;font-size:26px;
}
.svc-card-name{font-size:12px;font-weight:700;color:var(--TEXT);margin-bottom:3px}
.svc-card-desc{font-size:10.5px;color:var(--FAINT);line-height:1.45}

.divider{
  display:flex;align-items:center;gap:12px;
  margin:18px 0 16px;
  font-size:11px;font-weight:600;color:var(--FAINT);letter-spacing:.06em;text-transform:uppercase;
}
.divider::before,.divider::after{content:'';flex:1;height:1px;background:var(--BORDER)}
.g-btn{
  width:100%;display:flex;align-items:center;justify-content:center;gap:12px;
  padding:13px;border-radius:12px;
  border:1.5px solid var(--BORDER);background:var(--W);
  font-size:14px;font-weight:600;color:var(--TEXT);
  cursor:pointer;transition:all .2s;
}
.g-btn:hover{border-color:var(--PL);background:var(--OFF);box-shadow:0 4px 16px rgba(27,55,108,.08)}
.g-verified{
  width:100%;display:flex;align-items:center;gap:12px;
  padding:13px 16px;border-radius:12px;
  border:1.5px solid #bbf7d0;background:#f0fdf4;
  font-size:13.5px;font-weight:600;color:#15803d;
}
.g-verified .g-tick{
  width:28px;height:28px;border-radius:50%;background:#16a34a;
  display:flex;align-items:center;justify-content:center;
  color:var(--W);font-size:14px;font-weight:700;flex-shrink:0;
}
.g-note{font-size:11px;color:var(--FAINT);margin-top:8px;line-height:1.55;text-align:center}

.btn-row{display:flex;gap:12px;margin-top:4px}
.btn-back{
  padding:13px 22px;border-radius:12px;
  border:1.5px solid var(--BORDER);background:var(--W);
  font-size:14px;font-weight:600;color:var(--MID);
  cursor:pointer;transition:all .2s;flex-shrink:0;
}
.btn-back:hover{border-color:var(--P);color:var(--P);background:var(--PX)}
.btn-main{
  flex:1;padding:14px;border-radius:12px;
  background:var(--P);color:var(--W);border:none;
  font-size:14.5px;font-weight:700;font-family:var(--font);
  cursor:pointer;transition:all .22s var(--ease);
  display:flex;align-items:center;justify-content:center;gap:8px;
}
.btn-main:hover:not(:disabled){background:var(--PM);transform:translateY(-1px);box-shadow:0 8px 24px rgba(27,55,108,.3)}
.btn-main:disabled{background:#a0b4cc;cursor:not-allowed;transform:none;box-shadow:none}

.sign-in-link{
  text-align:center;margin-top:18px;
  font-size:13px;color:var(--FAINT);
}
.sign-in-link a{color:var(--P);font-weight:600;cursor:pointer}
.sign-in-link a:hover{text-decoration:underline}

.step-panel{display:none}
.step-panel.active{display:block;animation:stepIn .4s var(--ease)}
@keyframes stepIn{from{opacity:0;transform:translateX(18px)}to{opacity:1;transform:none}}

.prog-bar{
  height:3px;background:var(--BORDER);border-radius:100px;
  margin-bottom:28px;overflow:hidden;
}
.prog-fill{
  height:100%;background:var(--P);border-radius:100px;
  transition:width .5s var(--ease);
}

.panel.success-panel{
  display:none;flex-direction:column;align-items:center;
  text-align:center;padding:48px 36px;
}
.panel.success-panel.show{display:flex}

.success-ring{
  width:72px;height:72px;border-radius:50%;
  background:var(--P);color:var(--W);
  display:flex;align-items:center;justify-content:center;
  font-size:32px;margin-bottom:20px;
  box-shadow:0 12px 36px rgba(27,55,108,.35);
}
.success-title{
  font-family:var(--disp);font-size:30px;font-weight:700;
  color:var(--TEXT);margin-bottom:12px;
}
.success-body{
  font-size:15px;color:var(--FAINT);max-width:380px;
  line-height:1.75;margin-bottom:20px;
}
.success-tags{display:flex;gap:10px;margin-bottom:24px}
.success-tag{
  background:var(--PX);border:1px solid var(--PL);
  padding:7px 14px;border-radius:8px;
  font-size:12px;font-weight:600;color:var(--P);
}

.bottom-link{text-align:center;margin-top:18px;font-size:13px;color:var(--FAINT)}
.bottom-link a{color:var(--P);font-weight:600;text-decoration:none}

@media(max-width:700px){
  .card{grid-template-columns:1fr}
  .sidebar{display:none}
  .float-pro{display:none}
  .svc-cards{grid-template-columns:repeat(2,1fr)}
  .form-panel{padding:28px 22px 24px}
}
@keyframes spin{to{transform:rotate(360deg)}}
</style>
</head>
<body>

<div class="page-bg"></div>
<div class="page-glow"></div>





<div class="card">

<div class="sidebar">
  <div class="sidebar-img"></div>
  <div class="sidebar-dots"></div>
  <div class="sidebar-body">

    <div class="s-logo">
      Pro<span class="s-logo-q">Q</span>ik
    </div>

    <div class="s-tagline">
      India's <em>premier</em><br>creative network
    </div>
    <div class="s-desc">Three simple steps to your verified profile. Start connecting with clients across India.</div>

    <div class="s-steps">
      <div class="s-step">
        <div class="s-step-num active" id="sn1">1</div>
        <div class="s-step-info">
          <div class="s-step-title" id="st1">Create account</div>
          <div class="s-step-sub">Your credentials &amp; details</div>
        </div>
      </div>
      <div class="s-step">
        <div class="s-step-num idle" id="sn2">2</div>
        <div class="s-step-info">
          <div class="s-step-title idle" id="st2">Choose service</div>
          <div class="s-step-sub">Select primary offering</div>
        </div>
      </div>
      <div class="s-step">
        <div class="s-step-num idle" id="sn3">3</div>
        <div class="s-step-info">
          <div class="s-step-title idle" id="st3">Verify &amp; submit</div>
          <div class="s-step-sub">Google auth + specialities</div>
        </div>
      </div>
    </div>

    <div class="s-perks">
      <div class="s-perk">Verified within 24 hours</div>
      <div class="s-perk">Secure &amp; private — India data protection</div>
      <div class="s-perk">Start earning immediately upon approval</div>
    </div>

    

  </div>
</div>

<div class="form-panel">

<% if ("true".equals(submitted)) { %>

<div style="display:flex;flex-direction:column;align-items:center;text-align:center;padding:48px 24px">
  <div style="width:72px;height:72px;border-radius:50%;background:var(--P);color:var(--W);display:flex;align-items:center;justify-content:center;font-size:32px;margin-bottom:20px;box-shadow:0 12px 36px rgba(27,55,108,.35)">✓</div>
  <div style="font-family:var(--disp);font-size:28px;font-weight:700;color:var(--TEXT);margin-bottom:8px">Application Submitted</div>
  <p style="font-size:15px;color:var(--FAINT);max-width:380px;line-height:1.75;margin-bottom:12px">Your profile has been submitted for admin review. You will receive a confirmation email once approved.</p>
  <div style="display:flex;gap:10px;margin-bottom:24px">
    <div style="background:var(--PX);border:1px solid var(--PL);padding:7px 14px;border-radius:8px;font-size:12px;font-weight:600;color:var(--P)">✓ Profile submitted</div>
    <div style="background:var(--PX);border:1px solid var(--PL);padding:7px 14px;border-radius:8px;font-size:12px;font-weight:600;color:var(--P)">✓ Google verified</div>
  </div>
  <a href="<%= request.getContextPath() %>/login" style="display:inline-flex;padding:14px 32px;border-radius:12px;background:var(--P);color:var(--W);text-decoration:none;font-size:14.5px;font-weight:700;font-family:var(--font);transition:all .22s">Go to sign in</a>
  <p style="font-size:12px;color:var(--FAINT);margin-top:16px">You'll be able to sign in once admin approves your account.</p>
</div>

<% } else { %>

<form method="POST" action="<%= request.getContextPath() %>/signup" id="signupForm" onsubmit="console.log('Form submitting to:', this.action); return prepSubmit()">
  <input type="hidden" name="fullName" id="h_name"/>
  <input type="hidden" name="phone" id="h_phone"/>
  <input type="hidden" name="categories" id="h_cats"/>
  <input type="hidden" name="service" id="h_svc" value="photography"/>


  <div class="prog-bar"><div class="prog-fill" id="progFill" style="width:33%"></div></div>

<% if (errorMsg != null && !errorMsg.equals("")) { %>
    <div class="err-banner" id="err_exists" style="margin: 16px 24px 0">
      <span class="err-ico">!</span>
      <span><%= errorMsg %></span>
    </div>
<% } %>

  <!-- STEP 1 -->
  <div class="step-panel active" id="step1">
    <div class="step-eye">Step one of three</div>
    <div class="form-h">Verify with Google</div>
    <div class="form-sub">Google authentication is required to create your ProQik profile</div>

    <div class="err-banner hidden" id="err1">
      <span class="err-ico">!</span>
      <span></span>
    </div>

    <% if (jvAttr != null && jvAttr && gvAttr != null && gvAttr) { %>
    <div class="g-verified" id="gVerifiedDisplay" style="margin-bottom:18px">
      <div class="g-tick">✓</div>
      <div>
        <div style="font-size:13.5px;font-weight:700">Google Verified</div>
        <div style="font-size:12px;color:#16a34a;font-weight:400"><%= geAttr != null ? geAttr : "" %></div>
      </div>
    </div>
    <% } else { %>
    <div id="gBtnWrapper" style="margin-bottom:18px">
      <button type="button" class="g-btn" onclick="doGoogleAuth()">
        <svg width="20" height="20" viewBox="0 0 48 48"><path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"/><path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"/><path fill="#FBBC05" d="M10.54 28.59A14.5 14.5 0 0 1 9.5 24c0-1.59.28-3.14.76-4.59l-7.98-6.19A23.99 23.99 0 0 0 0 24c0 3.77.87 7.35 2.56 10.56l7.98-5.97z"/><path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 5.97C6.51 42.62 14.62 48 24 48z"/></svg>
        Sign in with Google
      </button>
      <div class="g-note" style="margin-top:10px">Google authentication is mandatory. Your email is used for login and identity.</div>
    </div>
    <% } %>

    <div class="f-row">
      <div class="field">
        <label>Full Name</label>
        <input type="text" id="r_name" placeholder="Your full name"/>
      </div>
      <div class="field">
        <label>Phone Number</label>
        <div class="input-wrap">
          <span class="input-prefix">+91</span>
          <input type="tel" id="r_phone" class="has-prefix" placeholder="98765 43210" maxlength="10"/>
        </div>
      </div>
    </div>

    <div class="check-row">
      <input type="checkbox" id="chkTerms"/>
      <label for="chkTerms">
        I agree to ProQik's <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
      </label>
    </div>

    <div class="btn-row">
      <button type="button" class="btn-main" onclick="goStep(2)" id="btn_s1" disabled>
        Continue <span>→</span>
      </button>
    </div>
  </div>

  <!-- STEP 2 -->
  <div class="step-panel" id="step2">
    <div class="step-eye">Step two of three</div>
    <div class="form-h">Choose your service</div>
    <div class="form-sub">Select your primary offering</div>

    <div class="svc-cards">
      <div class="svc-card on" onclick="pickSvc('photography',this)">
        <div class="svc-check">✓</div>
        <div class="svc-card-img">📷</div>
        <div class="svc-card-name">Photography</div>
        <div class="svc-card-desc">Capture precious moments</div>
      </div>
      <div class="svc-card" onclick="pickSvc('videography',this)">
        <div class="svc-check">✓</div>
        <div class="svc-card-img">🎬</div>
        <div class="svc-card-name">Videography</div>
        <div class="svc-card-desc">Tell stories through film</div>
      </div>
      <div class="svc-card" onclick="pickSvc('album',this)">
        <div class="svc-check">✓</div>
        <div class="svc-card-img">🎞</div>
        <div class="svc-card-name">Album Editor</div>
        <div class="svc-card-desc">Craft the perfect edit</div>
      </div>
    </div>

    <div class="btn-row" style="margin-top:28px">
      <button type="button" class="btn-back" onclick="goStep(1)">← Back</button>
      <button type="button" class="btn-main" id="btn_s2" onclick="goStep(3)" disabled>Continue →</button>
    </div>
  </div>

  <!-- STEP 3 -->
  <div class="step-panel" id="step3">
    <div class="step-eye">Step three of three</div>
    <div class="form-h">Your specialities</div>
    <div class="form-sub">Select all categories that best describe your creative work</div>

    <div class="err-banner hidden" id="err2">
      <span class="err-ico">!</span>
      <span>Select at least one speciality</span>
    </div>

    <div class="spec-group">
      <div class="spec-group-label">Portrait &amp; Commercial</div>
      <div class="spec-pills">
        <div class="spec-pill" onclick="togPill(this)">Portrait</div>
        <div class="spec-pill" onclick="togPill(this)">Fashion &amp; editorial</div>
        <div class="spec-pill" onclick="togPill(this)">Corporate</div>
        <div class="spec-pill" onclick="togPill(this)">Product &amp; e-commerce</div>
      </div>
    </div>

    <div class="spec-group">
      <div class="spec-group-label">Events &amp; Occasions</div>
      <div class="spec-pills">
        <div class="spec-pill" onclick="togPill(this)">Engagement</div>
        <div class="spec-pill" onclick="togPill(this)">Reception</div>
        <div class="spec-pill" onclick="togPill(this)">Mehendi &amp; Sangeet</div>
        <div class="spec-pill" onclick="togPill(this)">Birthday &amp; Parties</div>
      </div>
    </div>

    <div class="spec-group">
      <div class="spec-group-label">Film &amp; Motion</div>
      <div class="spec-pills">
        <div class="spec-pill" onclick="togPill(this)">Cinematic films</div>
        <div class="spec-pill" onclick="togPill(this)">Aerial &amp; drone</div>
        <div class="spec-pill" onclick="togPill(this)">Music video</div>
        <div class="spec-pill" onclick="togPill(this)">Reels &amp; social</div>
      </div>
    </div>

    <div class="sel-count" id="selCount">
      <div class="count-num" id="countNum">0</div>
      <span id="selText">Select at least one speciality</span>
    </div>

    <div class="divider">Verification</div>
    <% if (gvAttr != null && gvAttr && geAttr != null) { %>
    <div class="g-verified">
      <div class="g-tick">✓</div>
      <div>
        <div style="font-size:13.5px;font-weight:700">Verified via Google</div>
        <div style="font-size:12px;color:#16a34a;font-weight:400"><%= geAttr %></div>
      </div>
    </div>
    <% } else { %>
    <div style="text-align:center;padding:8px 0;font-size:13px;color:var(--FAINT)">
      Please complete Step 1 and verify with Google first.
    </div>
    <% } %>



    <div class="btn-row" style="margin-top:18px">
      <button type="button" class="btn-back" onclick="goStep(2)">← Back</button>
      <button type="submit" class="btn-main" id="btn_sub" disabled>Create my profile →</button>
    </div>
  </div>
</form>

<div class="bottom-link">Already have an account? <a href="<%= request.getContextPath() %>/login">Sign in</a></div>

<% } %>

</div>
</div>

<script>
var cur=1, selCats=new Set(), selSvc='photography', gVerified=false;
var progW = {1:'33%', 2:'66%', 3:'100%'};

function updateSidebar(step){
  for(var i=1;i<=3;i++){
    var num=document.getElementById('sn'+i);
    var title=document.getElementById('st'+i);
    num.className='s-step-num '+(i<step?'done':i===step?'active':'idle');
    num.textContent = i<step ? '✓' : i;
    if(title) title.className='s-step-title'+(i>step?' idle':'');
  }
  document.getElementById('progFill').style.width = progW[step];
}

function showStep(n){
  document.querySelectorAll('.step-panel').forEach(function(p){p.classList.remove('active')});
  document.getElementById('step'+n).classList.add('active');
  cur=n;
  updateSidebar(n);
}

function goStep(s){
  if(s===2&&!val1())return;
  if(s===3&&cur===2){showStep(s);return;}
  if(s===3&&selCats.size===0){
    document.getElementById('err2').classList.remove('hidden');
    return;
  }
  hideErr('err1');hideErr('err2');
  showStep(s);
}

function val1(skipGv){
  var n=document.getElementById('r_name').value.trim();
  var p=document.getElementById('r_phone').value.trim();
  var t=document.getElementById('chkTerms').checked;
  if(!skipGv && !gVerified){showErr('err1','Please sign in with Google first.');return false;}
  if(!n){showErr('err1','Please enter your full name.');return false;}
  if(!p){showErr('err1','Please enter your phone number.');return false;}
  if(!t){showErr('err1','Please accept the Terms of Service.');return false;}
  return true;
}

function updateStep1Btn(){
  document.getElementById('btn_s1').disabled = !(gVerified && document.getElementById('r_name').value.trim() && document.getElementById('r_phone').value.trim() && document.getElementById('chkTerms').checked);
}

function showErr(id, msg){var el = document.getElementById(id); if(el) { el.querySelector('span:last-child').textContent = msg; el.classList.remove('hidden'); } }
function hideErr(id) { var el = document.getElementById(id); if(el) el.classList.add('hidden'); }



function togPill(el) {
  el.classList.toggle('on');
  var l = el.textContent.trim();
  el.classList.contains('on') ? selCats.add(l) : selCats.delete(l);
  var n = selCats.size;
  document.getElementById('countNum').textContent = n;
  document.getElementById('selText').textContent = n === 0 ? 'Select at least one speciality' : n + ' selected';
  chk3();
}

function pickSvc(k,el){
  document.querySelectorAll('.svc-card').forEach(function(c){c.classList.remove('on')});
  el.classList.add('on');selSvc=k;
  document.getElementById('h_svc').value=k;
  document.getElementById('btn_s2').disabled = false;
  chk3();
}

function chk3(){document.getElementById('btn_sub').disabled=!(selSvc&&selCats.size>0);}

function doGoogleAuth(){
  if(!val1(true))return;
  prepSubmit();
  var form = document.getElementById('signupForm');
  var input = document.createElement('input');
  input.type = 'hidden';
  input.name = 'google';
  input.value = '1';
  form.appendChild(input);
  form.submit();
}

document.getElementById('r_name').addEventListener('input',updateStep1Btn);
document.getElementById('r_phone').addEventListener('input',updateStep1Btn);
document.getElementById('chkTerms').addEventListener('change',updateStep1Btn);

<% if (gvAttr != null && gvAttr && geAttr != null) { %>
gVerified = true;
<% String savedName = (String) request.getAttribute("savedName"); %>
<% if (savedName != null && !savedName.isEmpty()) { %>
document.getElementById('r_name').value = '<%= savedName %>';
<% } %>
<% String savedPhone = (String) request.getAttribute("savedPhone"); %>
<% if (savedPhone != null && !savedPhone.isEmpty()) { %>
document.getElementById('r_phone').value = '<%= savedPhone %>';
<% } %>
updateStep1Btn();
<% } %>

function prepSubmit(){
  document.getElementById('h_name').value =document.getElementById('r_name').value;
  document.getElementById('h_phone').value=document.getElementById('r_phone').value;
  document.getElementById('h_cats').value =Array.from(selCats).join(',');
  document.getElementById('h_svc').value =selSvc;
}
</script>
</body>
</html>