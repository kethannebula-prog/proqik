<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<title>Join ProQik — India's Creative Network</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400;1,600&family=DM+Sans:wght@300;400;500;600&family=Cormorant+Garamond:ital,wght@0,300;1,300&display=swap" rel="stylesheet"/>
<style>
:root{
  --navy:        #1b376c;
  --navy-deep:   #122550;
  --navy-mid:    #254e99;
  --navy-light:  #d6e4f7;
  --navy-xlight: #eef4fb;
  --navy-glow:   rgba(27,55,108,.10);
  --white:       #ffffff;
  --off-white:   #f6f8fc;
  --border:      #d0ddef;
  --text:        #0d1f3c;
  --text-mid:    #3a4f6e;
  --text-faint:  #7a8faa;
  --font-body:   'DM Sans', sans-serif;
  --font-disp:   'Merriweather', Georgia, serif;
  --font-serif:  'Cormorant Garamond', Georgia, serif;
  --ease:        cubic-bezier(.22,1,.36,1);
  --spring:      cubic-bezier(.34,1.4,.64,1);
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html,body{font-family:var(--font-body);min-height:100%}

body{
  background:var(--navy-deep);
  display:flex;align-items:center;justify-content:center;
  min-height:100vh;padding:24px;
  position:relative;overflow:hidden;
}
body::before{
  content:'';position:fixed;inset:0;pointer-events:none;
  background:
    radial-gradient(ellipse 60% 70% at -5% 50%, rgba(255,255,255,.055) 0%, transparent 60%),
    radial-gradient(ellipse 45% 45% at 110% 100%, rgba(27,55,108,.7) 0%, transparent 60%);
}
body::after{
  content:'';position:fixed;inset:0;pointer-events:none;
  background-image:repeating-linear-gradient(135deg,
    rgba(255,255,255,.013) 0px, rgba(255,255,255,.013) 1px,
    transparent 1px, transparent 14px);
}

.modal{
  position:relative;z-index:1;
  display:grid;grid-template-columns:300px 1fr;
  width:100%;max-width:900px;
  border-radius:24px;overflow:hidden;
  box-shadow:0 48px 130px rgba(0,0,0,.55),0 0 0 1px rgba(255,255,255,.09);
  animation:rise .55s var(--ease) both;
}
@keyframes rise{from{opacity:0;transform:translateY(22px) scale(.97)}to{opacity:1;transform:none}}

.left{
  background:var(--navy);
  padding:40px 30px;
  display:flex;flex-direction:column;
  position:relative;overflow:hidden;
}
.left::before{
  content:'';position:absolute;top:0;left:0;right:0;height:1px;
  background:linear-gradient(90deg,transparent,rgba(255,255,255,.22),transparent);
}
.arc1{position:absolute;top:-70px;right:-70px;width:190px;height:190px;border-radius:50%;border:1px solid rgba(255,255,255,.07);pointer-events:none}
.arc2{position:absolute;bottom:-90px;left:-90px;width:240px;height:240px;border-radius:50%;border:1px solid rgba(255,255,255,.04);pointer-events:none}

.logo{display:inline-flex;align-items:baseline;margin-bottom:38px;position:relative;z-index:1}
.logo-pro{font-family:var(--font-disp);font-size:24px;font-weight:700;color:#fff;letter-spacing:-.2px}
.logo-q  {font-family:var(--font-disp);font-size:24px;font-weight:700;color:rgba(255,255,255,.5);font-style:italic}
.logo-ik {font-family:var(--font-disp);font-size:24px;font-weight:400;color:rgba(255,255,255,.7)}

.left-headline{font-family:var(--font-disp);font-size:20px;font-weight:600;color:#fff;line-height:1.38;margin-bottom:8px;position:relative;z-index:1}
.left-headline em{font-style:italic;color:rgba(255,255,255,.6)}
.left-sub{font-size:12px;color:rgba(255,255,255,.38);line-height:1.85;font-weight:300;margin-bottom:34px;position:relative;z-index:1}

.steps{display:flex;flex-direction:column;position:relative;z-index:1;flex:1}
.step-item{display:flex;align-items:flex-start;gap:14px;padding:15px 0;border-bottom:1px solid rgba(255,255,255,.06)}
.step-item:last-child{border-bottom:none}
.step-num{width:28px;height:28px;border-radius:50%;flex-shrink:0;display:flex;align-items:center;justify-content:center;font-size:11px;font-weight:600;border:1.5px solid rgba(255,255,255,.15);color:rgba(255,255,255,.2);transition:all .35s var(--ease)}
.step-num.active{background:#fff;border-color:#fff;color:var(--navy);box-shadow:0 0 0 4px rgba(255,255,255,.13)}
.step-num.done{background:rgba(255,255,255,.12);border-color:rgba(255,255,255,.28);color:#fff}
.step-title{font-size:13px;font-weight:600;margin-bottom:2px;color:rgba(255,255,255,.28);transition:color .3s}
.step-item.s-active .step-title{color:#fff}
.step-item.s-done  .step-title{color:rgba(255,255,255,.55)}
.step-desc{font-size:11px;color:rgba(255,255,255,.2);line-height:1.5;font-weight:300}

.trust{margin-top:auto;padding-top:22px;border-top:1px solid rgba(255,255,255,.07);display:flex;flex-direction:column;gap:9px;position:relative;z-index:1}
.trust-item{display:flex;align-items:center;gap:10px;font-size:11px;color:rgba(255,255,255,.28);font-weight:300}
.trust-dot{width:4px;height:4px;flex-shrink:0;border-radius:50%;background:#fff;opacity:.3}

.right{background:var(--white);padding:44px 44px 36px;display:flex;flex-direction:column;position:relative}
.right::before{content:'';position:absolute;top:44px;bottom:44px;left:0;width:1px;background:linear-gradient(180deg,transparent,var(--border),transparent)}

.panel{display:none;flex-direction:column;flex:1;animation:slide .3s var(--ease) both}
.panel.show{display:flex}
@keyframes slide{from{opacity:0;transform:translateX(14px)}to{opacity:1;transform:none}}

.eyebrow{font-family:var(--font-serif);font-size:11px;font-style:italic;color:var(--text-faint);letter-spacing:.1em;margin-bottom:8px;font-weight:300}
.panel-title{font-family:var(--font-disp);font-size:25px;font-weight:700;color:var(--text);line-height:1.18;margin-bottom:5px;letter-spacing:-.3px}
.panel-sub{font-size:13px;color:var(--text-faint);line-height:1.65;margin-bottom:26px;font-weight:300}

.err{display:none;background:#fff0f0;border:1.5px solid #fca5a5;border-radius:10px;padding:11px 15px;margin-bottom:16px;font-size:13px;color:#b91c1c}
.err.show{display:block}

.field{margin-bottom:14px}
.field-row{display:grid;grid-template-columns:1fr 1fr;gap:13px}
.label{display:block;font-size:10px;font-weight:600;color:var(--text-mid);letter-spacing:.1em;text-transform:uppercase;margin-bottom:6px}
.input{width:100%;padding:12px 15px;font-family:var(--font-body);font-size:14px;color:var(--text);font-weight:400;background:#fff;border:1.5px solid var(--border);border-radius:11px;outline:none;-webkit-appearance:none;transition:border-color .2s,box-shadow .2s}
.input:focus{border-color:var(--navy);box-shadow:0 0 0 3px var(--navy-glow)}
.input::placeholder{color:var(--text-faint);font-weight:300}

.pw-wrap{position:relative}
.pw-eye{position:absolute;right:13px;top:50%;transform:translateY(-50%);background:none;border:none;cursor:pointer;color:var(--text-faint);font-size:16px;padding:3px;transition:color .2s}
.pw-eye:hover{color:var(--navy)}

.str-bar{display:flex;gap:3px;margin-top:7px}
.str-seg{height:3px;flex:1;border-radius:2px;background:var(--border);transition:background .3s}
.str-seg.w{background:#e05252}.str-seg.f{background:#e09052}.str-seg.g{background:var(--navy-mid)}.str-seg.s{background:#16a34a}
.str-lbl{font-size:10px;color:var(--text-faint);margin-top:5px}

.terms{display:flex;align-items:flex-start;gap:9px;margin-bottom:18px;font-size:12px;color:var(--text-faint);line-height:1.65}
.terms input[type=checkbox]{width:15px;height:15px;flex-shrink:0;margin-top:2px;accent-color:var(--navy);cursor:pointer}
.terms a{color:var(--navy);font-weight:500;text-decoration:none}
.terms a:hover{text-decoration:underline}

.cat-sec{margin-bottom:15px}
.cat-head{font-size:10px;font-weight:700;color:var(--text-faint);letter-spacing:.1em;text-transform:uppercase;margin-bottom:9px;display:flex;align-items:center;gap:9px}
.cat-head::after{content:'';flex:1;height:1px;background:var(--border)}
.pills{display:flex;gap:6px;flex-wrap:wrap}
.pill{padding:7px 14px;border-radius:100px;background:var(--off-white);border:1.5px solid var(--border);font-size:12px;font-weight:500;color:var(--text-mid);cursor:pointer;transition:all .18s;user-select:none}
.pill:hover{border-color:var(--navy-mid);color:var(--navy)}
.pill.on{background:var(--navy-xlight);border-color:var(--navy);color:var(--navy);font-weight:600}
.sel-row{display:flex;align-items:center;gap:8px;margin-top:13px;font-size:12px;color:var(--text-faint)}
.sel-badge{background:var(--navy);color:#fff;font-size:10px;font-weight:700;padding:2px 9px;border-radius:20px}

.svc-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:10px;margin-bottom:14px}
.svc-card{border:1.5px solid var(--border);border-radius:14px;padding:20px 12px 16px;text-align:center;cursor:pointer;background:#fff;transition:all .22s var(--ease);position:relative;overflow:hidden}
.svc-card::before{content:'';position:absolute;inset:0;background:var(--navy-xlight);opacity:0;transition:opacity .22s}
.svc-card:hover{border-color:var(--navy-mid);transform:translateY(-2px);box-shadow:0 8px 22px var(--navy-glow)}
.svc-card:hover::before{opacity:1}
.svc-card.on{border-color:var(--navy);box-shadow:0 0 0 3px var(--navy-glow)}
.svc-card.on::before{opacity:1}
.svc-chk{position:absolute;top:9px;right:9px;width:19px;height:19px;border-radius:50%;background:var(--navy);color:#fff;font-size:10px;font-weight:800;display:none;align-items:center;justify-content:center}
.svc-card.on .svc-chk{display:flex}
.svc-icon{width:46px;height:46px;border-radius:13px;background:var(--navy-xlight);display:flex;align-items:center;justify-content:center;font-size:22px;margin:0 auto 10px;transition:background .22s;position:relative}
.svc-card:hover .svc-icon,.svc-card.on .svc-icon{background:var(--navy-light)}
.svc-name{font-family:var(--font-disp);font-size:13px;font-weight:600;color:var(--text);margin-bottom:3px;position:relative}
.svc-desc{font-size:10px;color:var(--text-faint);line-height:1.4;position:relative}

.auth-divider{display:flex;align-items:center;gap:13px;margin:14px 0 12px}
.auth-divider::before,.auth-divider::after{content:'';flex:1;height:1px;background:var(--border)}
.auth-divider span{font-family:var(--font-serif);font-size:11px;font-style:italic;color:var(--text-faint);letter-spacing:.06em;white-space:nowrap}

.google-btn{width:100%;padding:13px 18px;background:#fff;border:1.5px solid var(--border);border-radius:11px;cursor:pointer;display:flex;align-items:center;justify-content:center;gap:11px;font-family:var(--font-body);font-size:14px;font-weight:500;color:var(--text);transition:all .22s var(--ease);margin-bottom:10px;position:relative;overflow:hidden}
.google-btn::before{content:'';position:absolute;inset:0;background:linear-gradient(135deg,rgba(66,133,244,.04),rgba(52,168,83,.03));opacity:0;transition:opacity .2s}
.google-btn:hover{border-color:#4285f4;box-shadow:0 4px 18px rgba(66,133,244,.14);transform:translateY(-1px)}
.google-btn:hover::before{opacity:1}
.google-btn:disabled{opacity:.45;cursor:not-allowed;transform:none;box-shadow:none}
.g-logo{width:20px;height:20px;flex-shrink:0}

.g-waiting{display:none;flex-direction:column;align-items:center;padding:20px;background:var(--off-white);border:1.5px solid var(--border);border-radius:13px;margin-bottom:10px}
.g-waiting.show{display:flex}
.spinner{width:32px;height:32px;border:2.5px solid var(--border);border-top-color:var(--navy);border-radius:50%;animation:spin .75s linear infinite;margin-bottom:11px}
@keyframes spin{to{transform:rotate(360deg)}}
.g-waiting p{font-size:12.5px;color:var(--text-mid);text-align:center;margin-bottom:3px}
.g-waiting small{font-size:11px;color:var(--text-faint)}

.g-verified{display:none;align-items:center;gap:13px;padding:14px 18px;background:#f0faf5;border:1.5px solid #86efac;border-radius:11px;margin-bottom:10px}
.g-verified.show{display:flex}
.gv-icon{width:34px;height:34px;border-radius:50%;background:#22c55e;color:#fff;display:flex;align-items:center;justify-content:center;font-size:15px;flex-shrink:0}
.gv-icon::after{content:'✓'}
.g-verified strong{display:block;font-size:13px;font-weight:600;color:#14532d}
.g-verified span{font-size:11px;color:#16a34a}
.g-note{text-align:center;font-size:11px;color:var(--text-faint);font-weight:300;line-height:1.65;margin-bottom:2px}

.btn-row{display:flex;gap:10px;margin-top:auto;padding-top:18px}
.btn-primary{flex:1;padding:14px 22px;background:var(--navy);color:#fff;border:none;border-radius:11px;font-family:var(--font-body);font-size:14px;font-weight:600;cursor:pointer;letter-spacing:.01em;display:flex;align-items:center;justify-content:center;gap:8px;transition:all .22s var(--ease);position:relative;overflow:hidden}
.btn-primary::after{content:'';position:absolute;inset:0;background:linear-gradient(135deg,rgba(255,255,255,.12),transparent 60%);opacity:0;transition:opacity .22s}
.btn-primary:hover{background:var(--navy-mid);transform:translateY(-2px);box-shadow:0 8px 26px rgba(27,55,108,.35)}
.btn-primary:hover::after{opacity:1}
.btn-primary:disabled{opacity:.3;cursor:not-allowed;transform:none;box-shadow:none}
.btn-primary span,.btn-primary svg{position:relative}
.btn-ghost{padding:14px 18px;background:transparent;border:1.5px solid var(--border);border-radius:11px;font-family:var(--font-body);font-size:14px;font-weight:500;color:var(--text-faint);cursor:pointer;transition:all .2s}
.btn-ghost:hover{border-color:var(--navy);color:var(--navy)}

.bottom-link{text-align:center;margin-top:16px;font-size:12.5px;color:var(--text-faint);font-weight:300}
.bottom-link a{color:var(--navy);font-weight:600;text-decoration:none}
.bottom-link a:hover{text-decoration:underline}

.success-panel{display:none;flex-direction:column;align-items:center;justify-content:center;text-align:center;flex:1;padding:16px 0}
.success-panel.show{display:flex}
.success-ring{width:78px;height:78px;border-radius:50%;background:var(--navy-xlight);border:2px solid var(--navy-light);display:flex;align-items:center;justify-content:center;font-size:30px;color:var(--navy);margin-bottom:20px;animation:pop .4s var(--spring) both}
@keyframes pop{from{transform:scale(.55);opacity:0}to{transform:scale(1);opacity:1}}
.success-title{font-family:var(--font-disp);font-size:25px;font-weight:700;color:var(--text);margin-bottom:7px;letter-spacing:-.3px}
.success-body{font-size:13.5px;color:var(--text-faint);line-height:1.7;max-width:290px;margin-bottom:22px}
.success-tags{display:flex;gap:7px;justify-content:center;flex-wrap:wrap;margin-bottom:26px}
.success-tag{display:flex;align-items:center;gap:6px;background:var(--navy-xlight);border:1px solid var(--navy-light);border-radius:100px;padding:6px 14px;font-size:11px;font-weight:600;color:var(--navy)}

@media(max-width:700px){
  .modal{grid-template-columns:1fr}
  .left{display:none}
  .right{padding:32px 24px}
  .svc-grid{grid-template-columns:1fr 1fr}
  .field-row{grid-template-columns:1fr}
  body{padding:14px}
}
</style>
</head>
<body>

<div class="modal">

  <!-- LEFT -->
  <div class="left">
    <div class="arc1"></div><div class="arc2"></div>
    <div class="logo">
      <span class="logo-pro">Pro</span><span class="logo-q">Q</span><span class="logo-ik">ik</span>
    </div>
    <div class="left-headline">India's <em>premier</em><br>creative network</div>
    <div class="left-sub">Three simple steps to your verified profile.<br>Start connecting with clients across India.</div>
    <div class="steps">
      <div class="step-item s-active" id="si1">
        <div class="step-num active" id="sn1">1</div>
        <div><div class="step-title">Create account</div><div class="step-desc">Your credentials &amp; details</div></div>
      </div>
      <div class="step-item" id="si2">
        <div class="step-num" id="sn2">2</div>
        <div><div class="step-title">Pick specialities</div><div class="step-desc">Choose your creative categories</div></div>
      </div>
      <div class="step-item" id="si3">
        <div class="step-num" id="sn3">3</div>
        <div><div class="step-title">Verify &amp; choose service</div><div class="step-desc">Google auth + primary offering</div></div>
      </div>
    </div>
    <div class="trust">
      <div class="trust-item"><span class="trust-dot"></span>Verified within 24 hours</div>
      <div class="trust-item"><span class="trust-dot"></span>Secure &amp; private — India data protection</div>
      <div class="trust-item"><span class="trust-dot"></span>Start earning immediately upon approval</div>
    </div>
  </div>

  <!-- RIGHT -->
  <div class="right">
    <form id="mainForm" action="<%= request.getContextPath() %>/login" method="POST" onsubmit="prepSubmit(); return true;">
      <input type="hidden" name="action"        value="register"/>
      <input type="hidden" name="fullName"       id="h_name"/>
      <input type="hidden" name="email"          id="h_email"/>
      <input type="hidden" name="phone"          id="h_phone"/>
      <input type="hidden" name="password"       id="h_pass"/>
      <input type="hidden" name="service"        id="h_svc"/>
      <input type="hidden" name="categories"     id="h_cats"/>
      <input type="hidden" name="googleVerified" id="h_gv" value="false"/>

      <!-- STEP 1 -->
      <div class="panel show" id="p1">
        <div class="eyebrow">Step one of three</div>
        <div class="panel-title">Create your account</div>
        <div class="panel-sub">Set up your login credentials to get started</div>
        <% if (request.getAttribute("error") != null) { %>
        <div class="err show"><%= request.getAttribute("error") %></div>
        <% } %>
        <div class="err" id="err1"></div>
        <div class="field-row field">
          <div>
            <label class="label">Full name</label>
            <input class="input" type="text" id="r_name" placeholder="Your full name" autocomplete="name"/>
          </div>
          <div>
            <label class="label">Phone number</label>
            <input class="input" type="tel" id="r_phone" placeholder="+91 98765 43210"/>
          </div>
        </div>
        <div class="field">
          <label class="label">Email address</label>
          <input class="input" type="email" id="r_email" placeholder="you@example.com" autocomplete="email"/>
        </div>
        <div class="field">
          <label class="label">Password</label>
          <div class="pw-wrap">
            <input class="input" type="password" id="r_pass" placeholder="Minimum 6 characters" oninput="chkStr(this.value)" autocomplete="new-password"/>
            <button type="button" class="pw-eye" onclick="togPw()">👁</button>
          </div>
          <div class="str-bar">
            <div class="str-seg" id="ss1"></div><div class="str-seg" id="ss2"></div>
            <div class="str-seg" id="ss3"></div><div class="str-seg" id="ss4"></div>
          </div>
          <div class="str-lbl" id="slbl"></div>
        </div>
        <div class="terms">
          <input type="checkbox" id="chkTerms"/>
          <label for="chkTerms">I agree to ProQik's <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a></label>
        </div>
        <div class="btn-row">
          <button type="button" class="btn-primary" onclick="goStep(2)">
            <span>Continue</span>
            <svg width="15" height="15" viewBox="0 0 16 16" fill="none"><path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>
          </button>
        </div>
      </div>

      <!-- STEP 2 -->
      <div class="panel" id="p2">
        <div class="eyebrow">Step two of three</div>
        <div class="panel-title">Your specialities</div>
        <div class="panel-sub">Select all categories that best describe your creative work</div>
        <div class="err" id="err2"></div>
        <div class="cat-sec">
          <div class="cat-head">Wedding &amp; events</div>
          <div class="pills">
            <div class="pill" onclick="togPill(this)">Wedding</div>
            <div class="pill" onclick="togPill(this)">Engagement</div>
            <div class="pill" onclick="togPill(this)">Reception</div>
            <div class="pill" onclick="togPill(this)">Mehendi &amp; Sangeet</div>
          </div>
        </div>
        <div class="cat-sec">
          <div class="cat-head">Portrait &amp; commercial</div>
          <div class="pills">
            <div class="pill" onclick="togPill(this)">Portrait</div>
            <div class="pill" onclick="togPill(this)">Fashion &amp; editorial</div>
            <div class="pill" onclick="togPill(this)">Corporate</div>
            <div class="pill" onclick="togPill(this)">Product &amp; e-commerce</div>
          </div>
        </div>
        <div class="cat-sec">
          <div class="cat-head">Film &amp; motion</div>
          <div class="pills">
            <div class="pill" onclick="togPill(this)">Cinematic films</div>
            <div class="pill" onclick="togPill(this)">Aerial &amp; drone</div>
            <div class="pill" onclick="togPill(this)">Music video</div>
            <div class="pill" onclick="togPill(this)">Reels &amp; social</div>
          </div>
        </div>
        <div class="sel-row">
          <span class="sel-badge" id="sel_n">0</span>
          <span id="sel_t" style="font-size:12px">Select at least one speciality</span>
        </div>
        <div class="btn-row">
          <button type="button" class="btn-ghost" onclick="goStep(1)">← Back</button>
          <button type="button" class="btn-primary" id="btn_s2" onclick="goStep(3)" disabled>
            <span>Continue</span>
            <svg width="15" height="15" viewBox="0 0 16 16" fill="none"><path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>
          </button>
        </div>
      </div>

      <!-- STEP 3 -->
      <div class="panel" id="p3">
        <div class="eyebrow">Step three of three</div>
        <div class="panel-title">Service &amp; identity</div>
        <div class="panel-sub">Choose your primary offering, then verify with Google to complete sign-up</div>
        <div class="svc-grid">
          <div class="svc-card" onclick="pickSvc('photography',this)">
            <div class="svc-chk">✓</div><div class="svc-icon">📷</div>
            <div class="svc-name">Photography</div><div class="svc-desc">Capture precious moments</div>
          </div>
          <div class="svc-card" onclick="pickSvc('videography',this)">
            <div class="svc-chk">✓</div><div class="svc-icon">🎬</div>
            <div class="svc-name">Videography</div><div class="svc-desc">Tell stories through film</div>
          </div>
          <div class="svc-card" onclick="pickSvc('editing',this)">
            <div class="svc-chk">✓</div><div class="svc-icon">🎞</div>
            <div class="svc-name">Post-production</div><div class="svc-desc">Craft the perfect edit</div>
          </div>
          <div class="svc-card" onclick="pickSvc('drone',this)">
            <div class="svc-chk">✓</div><div class="svc-icon">🚁</div>
            <div class="svc-name">Drone &amp; aerial</div><div class="svc-desc">Stunning bird's-eye shots</div>
          </div>
          <div class="svc-card" onclick="pickSvc('album',this)">
            <div class="svc-chk">✓</div><div class="svc-icon">📖</div>
            <div class="svc-name">Album design</div><div class="svc-desc">Craft visual memories</div>
          </div>
          <div class="svc-card" onclick="pickSvc('mc',this)">
            <div class="svc-chk">✓</div><div class="svc-icon">🎤</div>
            <div class="svc-name">MC &amp; anchor</div><div class="svc-desc">Command every event</div>
          </div>
        </div>

        <div class="auth-divider"><span>Verify your identity with Google</span></div>

        <button type="button" class="google-btn" id="gBtn" onclick="startGoogle()">
          <svg class="g-logo" viewBox="0 0 24 24">
            <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
            <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
            <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l3.66-2.84z" fill="#FBBC05"/>
            <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
          </svg>
          Continue with Google
        </button>

        <div class="g-waiting" id="gWaiting">
          <div class="spinner"></div>
          <p>Google authentication in progress…</p>
          <small>Please complete the sign-in in the popup window</small>
        </div>

        <div class="g-verified" id="gVerified">
          <div class="gv-icon"></div>
          <div>
            <strong id="gVName">Google account verified</strong>
            <span id="gVEmail"></span>
          </div>
        </div>

        <div class="g-note">Your Google account is used for identity verification only. We never post or share on your behalf.</div>

        <div class="btn-row">
          <button type="button" class="btn-ghost" onclick="goStep(2)">← Back</button>
          <button type="submit" class="btn-primary" id="btn_sub" disabled>
            <span>Create my profile</span>
            <svg width="15" height="15" viewBox="0 0 16 16" fill="none"><path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>
          </button>
        </div>
      </div>

      <!-- SUCCESS -->
      <div class="panel success-panel" id="p-success">
        <div class="success-ring">✦</div>
        <div class="success-title">Welcome to ProQik</div>
        <p class="success-body">Your profile has been submitted for review. Expect a verification email within 24 hours — then you're live across India.</p>
        <div class="success-tags">
          <div class="success-tag">✓ Profile submitted</div>
          <div class="success-tag">✓ Google verified</div>
          <div class="success-tag">✓ Email sent</div>
        </div>
        <a href="<%= request.getContextPath() %>/login" class="btn-primary" style="text-decoration:none;max-width:200px">
          <span>Go to sign in</span>
        </a>
      </div>
    </form>

    <div class="bottom-link">Already have an account? <a href="<%= request.getContextPath() %>/login">Sign in</a></div>
  </div>
</div>

<script>
var cur=1, selCats=new Set(), selSvc=null, gVerified=false;

function goStep(s){
  if(s===2&&!val1())return;
  if(s===3&&selCats.size===0){showErr('err2','Please select at least one speciality.');return;}
  hideErr('err1');hideErr('err2');
  var from=document.getElementById('p'+cur);if(from)from.classList.remove('show');
  cur=s;
  var to=document.getElementById('p'+cur);if(to)to.classList.add('show');
  updBar(s);
}

function val1(){
  var n=document.getElementById('r_name').value.trim();
  var e=document.getElementById('r_email').value.trim();
  var p=document.getElementById('r_phone').value.trim();
  var pw=document.getElementById('r_pass').value;
  var t=document.getElementById('chkTerms').checked;
  if(!n){showErr('err1','Please enter your full name.');return false;}
  if(!e||!e.includes('@')){showErr('err1','Please enter a valid email address.');return false;}
  if(!p){showErr('err1','Please enter your phone number.');return false;}
  if(pw.length<6){showErr('err1','Password must be at least 6 characters.');return false;}
  if(!t){showErr('err1','Please agree to the Terms of Service.');return false;}
  return true;
}

function showErr(id,msg){var el=document.getElementById(id);if(el){el.textContent=msg;el.classList.add('show');}}
function hideErr(id){var el=document.getElementById(id);if(el)el.classList.remove('show');}

function chkStr(v){
  var sc=0;
  if(v.length>=6)sc++;if(v.length>=10)sc++;
  if(/[A-Z]/.test(v)&&/[0-9]/.test(v))sc++;
  if(/[^A-Za-z0-9]/.test(v))sc++;
  var cls=['','w','f','g','s'],nms=['','Weak','Fair','Good','Strong'];
  for(var i=1;i<=4;i++){var el=document.getElementById('ss'+i);el.className='str-seg';if(i<=sc)el.classList.add(cls[sc]);}
  document.getElementById('slbl').textContent=v.length?nms[sc]:'';
}
function togPw(){var f=document.getElementById('r_pass');f.type=f.type==='password'?'text':'password';}

function togPill(el){
  el.classList.toggle('on');
  var l=el.textContent.trim();
  el.classList.contains('on')?selCats.add(l):selCats.delete(l);
  var n=selCats.size;
  document.getElementById('sel_n').textContent=n;
  document.getElementById('sel_t').textContent=n===0?'Select at least one speciality':n+' selected';
  document.getElementById('btn_s2').disabled=(n===0);
}

function pickSvc(k,el){
  document.querySelectorAll('.svc-card').forEach(function(c){c.classList.remove('on');});
  el.classList.add('on');selSvc=k;chk3();
}

function startGoogle(){
  document.getElementById('gBtn').style.display='none';
  document.getElementById('gWaiting').classList.add('show');
  simulateGoogle();
}
function simulateGoogle(){
  setTimeout(function(){
    onGoogleSuccess({
      name: document.getElementById('r_name').value||'Verified User',
      email:document.getElementById('r_email').value||'user@gmail.com'
    });
  },2400);
}
function onGoogleSuccess(user){
  gVerified=true;
  document.getElementById('gWaiting').classList.remove('show');
  document.getElementById('gVerified').classList.add('show');
  document.getElementById('gVName').textContent=user.name;
  document.getElementById('gVEmail').textContent=user.email;
  document.getElementById('h_gv').value='true';
  chk3();
}
function chk3(){document.getElementById('btn_sub').disabled=!(selSvc&&gVerified);}

function prepSubmit(){
  document.getElementById('h_name').value =document.getElementById('r_name').value;
  document.getElementById('h_email').value=document.getElementById('r_email').value;
  document.getElementById('h_phone').value=document.getElementById('r_phone').value;
  document.getElementById('h_pass').value =document.getElementById('r_pass').value;
  document.getElementById('h_cats').value =Array.from(selCats).join(',');
  document.getElementById('h_svc').value  =selSvc||'photography';
}

function updBar(s){
  for(var i=1;i<=3;i++){
    var sn=document.getElementById('sn'+i),si=document.getElementById('si'+i);
    sn.classList.remove('active','done');si.classList.remove('s-active','s-done');
    if(i<s){sn.classList.add('done');si.classList.add('s-done');}
    else if(i===s){sn.classList.add('active');si.classList.add('s-active');}
  }
}
</script>
</body>
</html>