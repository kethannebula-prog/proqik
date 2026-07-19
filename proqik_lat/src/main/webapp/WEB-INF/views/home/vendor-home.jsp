<%-- This is the Vendor/Customer Portal Landing Page --%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>ProQik — Creative Professionals Network</title>
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Inter:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet"/>
<style>
:root{--navy:#1b376c;--navy-deep:#122855;--navy-darker:#0c1d40;--navy-mid:#2a4d8f;--navy-tint:#eef2f9;--navy-tint-2:#f5f7fb;--gold:#c9a84c;--gold-deep:#a78431;--gold-tint:#f5edd6;--ink:#15233f;--body:#4a5578;--muted:#8b96b0;--line:#e5e9f2;--line-soft:#eef1f6;--paper:#faf8f3;--paper-2:#f3eee2;--white:#ffffff;--green:#2e7d52;--display:'Cormorant Garamond','Times New Roman',serif;--sans:'Inter',system-ui,-apple-system,sans-serif;--mono:'JetBrains Mono',ui-monospace,monospace;--r6:6px;--r10:10px;--r14:14px;--r20:20px;--r28:28px;--ease:cubic-bezier(.16,1,.3,1);--ease2:cubic-bezier(.4,0,.2,1);--shadow-1:0 1px 2px rgba(20,40,80,.05),0 2px 8px rgba(20,40,80,.06);--shadow-2:0 8px 28px rgba(20,40,80,.10),0 2px 8px rgba(20,40,80,.06);--shadow-3:0 24px 64px rgba(12,29,64,.18),0 8px 24px rgba(12,29,64,.10);--shadow-gold:0 8px 28px rgba(201,164,76,.35)}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth;-webkit-text-size-adjust:100%}
body{font-family:var(--sans);color:var(--ink);background:var(--white);line-height:1.6;-webkit-font-smoothing:antialiased;overflow-x:hidden}
img{max-width:100%;display:block}
a{color:inherit;text-decoration:none}
button{font-family:inherit;cursor:pointer;border:none;background:none;color:inherit}
input,select,textarea{font-family:inherit}
::selection{background:var(--navy);color:#fff}
.display{font-family:var(--display);font-weight:500;letter-spacing:-.01em}
.eyebrow{font-family:var(--mono);font-size:11px;font-weight:500;color:var(--gold-deep);letter-spacing:.22em;text-transform:uppercase;display:inline-flex;align-items:center gap:10px}
.eyebrow::before{content:'';width:24px;height:1px;background:var(--gold-deep)}
.strip{background:var(--navy-darker);color:rgba(255,255,255,.78);font-size:12px;padding:9px 0;overflow:hidden;border-bottom:1px solid rgba(255,255,255,.06)}
.strip-inner{max-width:1320px;margin:0 auto;padding:0 32px;display:flex;align-items:center;justify-content:space-between;gap:24px}
.strip-left{display:flex;align-items:center;gap:14px}
.strip-loc{display:flex;align-items:center;gap:6px;font-weight:500}
.strip-divider{width:1px;height:12px;background:rgba(255,255,255,.18)}
.strip-right{display:flex;align-items:center;gap:18px;font-size:12px}
.nav{background:var(--navy);position:sticky;top:0;z-index:100;border-bottom:1px solid rgba(255,255,255,.08)}
.nav-inner{max-width:1320px;margin:0 auto;padding:0 32px;height:78px;display:flex;align-items:center;gap:32px}
.logo{font-family:var(--display);font-size:30px;font-weight:600;color:#fff;letter-spacing:-.02em}
.logo .q{color:var(--gold);font-style:italic}
.logo sup{font-family:var(--mono);font-size:9px;color:rgba(255,255,255,.45);letter-spacing:.18em;margin-left:6px}
.nav-links{display:flex;gap:2px;margin-left:24px}
@media(max-width:768px){.nav-links{display:none;position:absolute;top:64px;left:0;right:0;background:var(--navy);flex-direction:column;padding:16px;gap:0;z-index:200;box-shadow:0 4px 12px rgba(0,0,0,.3)}.nav-links.show{display:flex}}
.nav-link{padding:8px 14px;border-radius:8px;font-size:13px;font-weight:500;color:rgba(255,255,.72);transition:all .2s;cursor:pointer}
.nav-link:hover{color:#fff;background:rgba(255,255,255,.06)}
.nav-cta{margin-left:auto;display:flex;align-items:center;gap:10px}
@media(max-width:768px){.nav-cta{gap:8px;margin-left:0}}
.nav-toggle{display:none;width:32px;height:32px;border-radius:8px;background:none;align-items:center;justify-content:center;color:#fff;flex-shrink:0}
.nav-toggle svg{width:24px;height:24px}
@media(max-width:768px){.nav-toggle{display:flex}}
.btn-ghost{padding:9px 18px;border-radius:6px;font-size:13px;font-weight:600;color:rgba(255,255,255,.85);border:1px solid rgba(255,255,255,.18);transition:all .2s}
.btn-ghost:hover{background:rgba(255,255,255,.08);border-color:rgba(255,255,255,.32)}
.btn-gold{padding:10px 20px;border-radius:6px;font-size:13px;font-weight:600;background:var(--gold);color:var(--navy-darker);transition:all .25s var(--ease);box-shadow:0 2px 12px rgba(201,164,76,.32)}
.btn-gold:hover{background:#d8b35d;transform:translateY(-1px);box-shadow:0 6px 20px rgba(201,164,76,.45)}
.hero{background:var(--navy);color:#fff;position:relative;overflow:hidden;padding:90px 0 0}
.hero::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse 90% 70% at 78% 35%, rgba(201,164,76,.14), transparent 60%),radial-gradient(ellipse 80% 60% at 8% 90%, rgba(42,77,143,.55), transparent 70%);pointer-events:none}
.hero::after{content:'';position:absolute;inset:0;background:linear-gradient(rgba(255,255,255,.025) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,.025) 1px,transparent 1px);background-size:60px 60px;mask-image:radial-gradient(ellipse 70% 70% at 50% 50%, black 30%, transparent 80%);pointer-events:none}
.hero-inner{max-width:1320px;margin:0 auto;padding:0 32px;display:grid;grid-template-columns:1.05fr .95fr;gap:64px;align-items:center;position:relative;z-index:1;min-height:640px}
.hero-badge{display:inline-flex;align-items:center;gap:10px;padding:6px 14px 6px 8px;border-radius:30px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.14);font-size:11px;font-weight:500;color:rgba(255,255,255,.85);letter-spacing:.04em;backdrop-filter:blur(8px);margin-bottom:28px}
.hero-badge .pulse{width:18px;height:18px;border-radius:50%;background:rgba(95,195,124,.18);display:flex;align-items:center;justify-content:center;position:relative}
.hero-badge .pulse::after{content:'';width:7px;height:7px;border-radius:50%;background:#5fc37c;box-shadow:0 0 0 0 rgba(95,195,124,.7);animation:livePulse 2.4s ease-out infinite}
@keyframes livePulse{0%{box-shadow:0 0 0 0 rgba(95,195,124,.7)}70%{box-shadow:0 0 0 10px rgba(95,195,124,0)}100%{box-shadow:0 0 0 0 rgba(95,195,124,0)}}
.hero-h1{font-family:var(--display);font-weight:500;font-size:clamp(48px,6vw,84px);line-height:1.02;letter-spacing:-.025em;margin-bottom:24px}
.hero-h1 em{font-style:italic;color:var(--gold)}
.hero-h1 .light{color:rgba(255,255,255,.55);font-weight:400}
.hero-sub{font-size:17px;line-height:1.65;color:rgba(255,255,255,.7);max-width:520px;margin-bottom:40px}
.hero-search{background:#fff;border-radius:14px;padding:8px;display:flex;align-items:center;gap:0;box-shadow:0 24px 60px rgba(0,0,0,.32);max-width:600px}
.hs-field{flex:1;display:flex;flex-direction:column;padding:8px 16px;cursor:pointer;border-radius:10px;transition:background .2s}
.hs-field:hover{background:var(--navy-tint-2)}
.hs-label{font-size:10px;font-weight:600;color:var(--navy);letter-spacing:.12em;text-transform:uppercase;margin-bottom:3px}
.hs-value{font-size:13px;color:var(--ink);font-weight:500;display:flex;align-items:center;gap:6px}
.hs-btn{background:var(--navy);color:#fff;width:48px;height:48px;border-radius:10px;display:flex;align-items:center;justify-content:center;margin-left:8px;transition:all .25s var(--ease)}
.hs-btn:hover{background:var(--navy-darker);transform:scale(1.04)}
.hero-stats{display:flex;gap:36px;margin-top:48px;padding-top:28px;border-top:1px solid rgba(255,255,255,.1)}
.hs-num{font-family:var(--display);font-size:34px;font-weight:600;color:#fff;line-height:1}
.hs-num .gold{color:var(--gold)}
.hs-lbl{font-size:11px;color:rgba(255,255,255,.5);letter-spacing:.06em;margin-top:6px;text-transform:uppercase;font-weight:500}
.hero-right{position:relative;height:640px;display:flex;align-items:center;justify-content:center}
.hr-main{position:absolute;width:380px;height:520px;border-radius:18px;overflow:hidden;box-shadow:0 32px 80px rgba(0,0,0,.4),0 0 0 1px rgba(255,255,255,.08);transform:rotate(-2deg);z-index:2}
.hr-main img{width:100%;height:100%;object-fit:cover}
.hr-second{position:absolute;width:230px;height:300px;right:0;top:60px;border-radius:14px;overflow:hidden;transform:rotate(4deg);z-index:1}
.hr-second img{width:100%;height:100%;object-fit:cover}
.hr-third{position:absolute;width:220px;height:280px;left:0;bottom:30px;border-radius:14px;overflow:hidden;transform:rotate(-5deg);z-index:1}
.hr-third img{width:100%;height:100%;object-fit:cover}
.trust{background:var(--navy-darker);border-top:1px solid rgba(255,255,255,.06);padding:36px 0;margin-top:90px}
.trust-inner{max-width:1320px;margin:0 auto;padding:0 32px;display:grid;grid-template-columns:auto 1fr;gap:40px;align-items:center}
.trust-label{font-family:var(--mono);font-size:11px;color:rgba(255,255,255,.4);letter-spacing:.18em;text-transform:uppercase;line-height:1.5;border-right:1px solid rgba(255,255,255,.12);padding-right:40px}
.trust-marquee{display:flex;gap:48px;align-items:center;overflow:hidden;mask-image:linear-gradient(90deg,transparent,black 10%,black 90%,transparent)}
.trust-track{display:flex;gap:48px;align-items:center;animation:slide 40s linear infinite}
@keyframes slide{from{transform:translateX(0)}to{transform:translateX(-50%)}}
.trust-item{font-family:var(--display);font-size:22px;font-weight:600;color:rgba(255,255,255,.55);white-space:nowrap}
.section{padding:120px 0}
.section-inner{max-width:1320px;margin:0 auto;padding:0 32px}
.section-head{display:grid;grid-template-columns:1.4fr 1fr;gap:64px;align-items:end;margin-bottom:64px}
.section-h{font-family:var(--display);font-size:clamp(38px,4.5vw,64px);font-weight:500;line-height:1.04;letter-spacing:-.02em;color:var(--ink);margin-top:18px}
.section-h em{font-style:italic;color:var(--navy)}
.section-sub{font-size:16px;color:var(--body);line-height:1.65}
.cats{display:grid;grid-template-columns:repeat(4,1fr);gap:16px}
.cat{position:relative;border-radius:18px;overflow:hidden;aspect-ratio:3/4;cursor:pointer;border:1px solid var(--line);transition:transform .5s var(--ease),box-shadow .4s}
.cat:hover{transform:translateY(-6px);box-shadow:var(--shadow-3)}
.cat img{width:100%;height:100%;object-fit:cover;transition:transform .8s var(--ease);opacity:.85}
.cat:hover img{transform:scale(1.06);opacity:.95}
.cat-overlay{position:absolute;inset:0;background:linear-gradient(180deg,transparent 35%,rgba(12,29,64,.85) 100%)}
.cat-content{position:absolute;left:24px;right:24px;bottom:24px;color:#fff;z-index:2}
.cat-num{font-family:var(--mono);font-size:11px;color:var(--gold);letter-spacing:.18em;margin-bottom:8px}
.cat-name{font-family:var(--display);font-size:26px;font-weight:600;letter-spacing:-.01em;line-height:1.1;margin-bottom:6px}
.cat-meta{display:flex;align-items:center;justify-content:space-between;font-size:12px;color:rgba(255,255,255,.75);margin-top:14px;padding-top:14px;border-top:1px solid rgba(255,255,255,.16)}
.cat-arrow{width:32px;height:32px;border-radius:50%;background:rgba(255,255,255,.12);display:flex;align-items:center;justify-content:center;transition:all .25s}
.cat:hover .cat-arrow{background:var(--gold);color:var(--navy-darker)}
.pros-section{background:var(--paper);position:relative}
.pros-section::before{content:'';position:absolute;inset:0;background-image:radial-gradient(rgba(27,55,108,.06) 1px,transparent 1px);background-size:32px 32px}
.pros-tabs{display:flex;gap:4px;background:#fff;border:1px solid var(--line);padding:4px;border-radius:12px;width:fit-content;margin-bottom:40px}
.pros-tab{padding:10px 18px;border-radius:8px;font-size:13px;font-weight:600;color:var(--body);transition:all .2s}
.pros-tab.active{background:var(--navy);color:#fff}
.pros-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:20px}
.pro-card{background:#fff;border-radius:16px;overflow:hidden;border:1px solid var(--line);transition:all .35s var(--ease)}
.pro-card:hover{transform:translateY(-6px);box-shadow:var(--shadow-2);border-color:var(--navy-tint)}
.pro-img{aspect-ratio:1;overflow:hidden}
.pro-img img{width:100%;height:100%;object-fit:cover;transition:transform .6s}
.pro-card:hover .pro-img img{transform:scale(1.05)}
.pro-badge{position:absolute;top:12px;left:12px;background:rgba(255,255,255,.95);color:var(--navy);font-size:10px;font-weight:700;padding:5px 10px;border-radius:20px;text-transform:uppercase}
.pro-badge .star{color:var(--gold)}
.pro-body{padding:18px}
.pro-name{font-family:var(--display);font-size:20px;font-weight:600;color:var(--ink);letter-spacing:-.01em;margin-bottom:2px;display:flex;align-items:center;gap:6px}
.pro-verified{width:16px;height:16px;border-radius:50%;background:var(--navy);color:#fff;display:inline-flex;align-items:center;justify-content:center;font-size:9px}
.pro-craft{font-size:12px;color:var(--muted);text-transform:uppercase;margin-bottom:12px}
.pro-meta{display:flex;align-items:center;justify-content:space-between;padding-top:12px;border-top:1px solid var(--line-soft)}
.pro-rate{font-family:var(--display);font-size:18px;font-weight:600}
.pro-rate .from{font-size:10px;color:var(--muted);text-transform:uppercase}
.pro-rating-pill{display:flex;align-items:center;gap:5px;font-size:12px;font-weight:600}
.pro-rating-pill .stars{color:var(--gold)}
.editorial{background:var(--navy);color:#fff;padding:120px 0;position:relative;overflow:hidden}
.editorial::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse 60% 60% at 100% 0%,rgba(201,164,76,.18),transparent 60%)}
.ed-grid{display:grid;grid-template-columns:1fr 1fr;gap:80px;align-items:center;position:relative;z-index:1}
.ed-h{font-family:var(--display);font-size:clamp(40px,4.5vw,68px);font-weight:500;line-height:1.04;letter-spacing:-.02em;margin-top:18px;margin-bottom:24px}
.ed-h em{font-style:italic;color:var(--gold)}
.ed-sub{font-size:17px;color:rgba(255,255,255,.72);line-height:1.65;margin-bottom:32px;max-width:480px}
.ed-stats{display:grid;grid-template-columns:1fr 1fr 1fr;gap:0;margin-bottom:36px;border-top:1px solid rgba(255,255,255,.12);border-bottom:1px solid rgba(255,255,255,.12);padding:28px 0}
.ed-stat{padding-right:24px}
.ed-stat:not(:first-child){padding-left:24px;border-left:1px solid rgba(255,255,255,.12)}
.ed-stat-n{font-family:var(--display);font-size:42px;font-weight:600;line-height:1}
.ed-stat-n .gold{color:var(--gold)}
.ed-stat-l{font-size:11px;color:rgba(255,255,255,.5);margin-top:8px;text-transform:uppercase}
.ed-cta{display:flex;gap:12px}
.btn-lg-gold{background:var(--gold);color:var(--navy-darker);padding:16px 30px;border-radius:8px;font-size:14px;font-weight:600;box-shadow:var(--shadow-gold)}
.btn-lg-ghost{background:transparent;color:#fff;padding:16px 30px;border-radius:8px;font-size:14px;font-weight:600;border:1px solid rgba(255,255,255,.25)}
.testi-section{background:#fff;padding:120px 0}
.testi-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:24px;margin-top:56px}
.testi{border:1px solid var(--line);border-radius:18px;padding:32px;transition:all .35s}
.testi:hover{border-color:var(--navy-tint);box-shadow:var(--shadow-2);transform:translateY(-4px)}
.testi-mark{font-family:var(--display);font-size:64px;font-style:italic;color:var(--gold);line-height:.6;margin-bottom:0}
.testi-stars{color:var(--gold);margin-bottom:14px}
.testi-text{font-family:var(--display);font-size:20px;font-weight:500;line-height:1.4;margin-bottom:24px}
.testi-by{display:flex;align-items:center;gap:12px;padding-top:18px;border-top:1px solid var(--line-soft)}
.testi-av{width:42px;height:42px;border-radius:50%;overflow:hidden}
.testi-av img{width:100%;height:100%;object-fit:cover}
.testi-name{font-size:13px;font-weight:600}
.testi-role{font-size:11px;color:var(--muted);margin-top:1px}
.final-cta{background:var(--navy-darker);color:#fff;padding:120px 0;text-align:center;position:relative;overflow:hidden}
.final-cta::before{content:'';position:absolute;inset:0;background:radial-gradient(ellipse 50% 50% at 50% 100%,rgba(201,164,76,.2),transparent 70%)}
.final-inner{max-width:880px;margin:0 auto;padding:0 32px;position:relative;z-index:1}
.final-h{font-family:var(--display);font-size:clamp(44px,5.5vw,76px);font-weight:500;line-height:1.04;margin-top:20px;margin-bottom:20px}
.final-h em{font-style:italic;color:var(--gold)}
.final-sub{font-size:17px;color:rgba(255,255,255,.72);line-height:1.65;max-width:560px;margin:0 auto 36px}
.final-buttons{display:flex;gap:14px;justify-content:center}
.footer{background:var(--navy-darker);color:rgba(255,255,255,.6);padding:80px 0 32px;border-top:1px solid rgba(255,255,255,.06)}
.footer-inner{max-width:1320px;margin:0 auto;padding:0 32px}
.footer-top{display:grid;grid-template-columns:1.6fr 1fr 1fr 1fr;gap:48px;padding-bottom:48px;border-bottom:1px solid rgba(255,255,255,.08)}
.footer-col h4{font-size:11px;font-weight:600;color:#fff;letter-spacing:.16em;text-transform:uppercase;margin-bottom:18px}
.footer-col ul{list-style:none;display:flex;flex-direction:column;gap:12px}
.footer-col a{font-size:14px;color:rgba(255,255,255,.6);transition:color .2s}
.footer-col a:hover{color:var(--gold)}
.footer-bottom{padding-top:32px;display:flex;justify-content:space-between;font-size:12px;color:rgba(255,255,255,.4)}
.modal-backdrop{position:fixed;inset:0;z-index:500;background:rgba(12,29,64,.72);backdrop-filter:blur(8px);display:none;align-items:center;justify-content:center}
.modal-backdrop.open{display:flex}
.modal{background:#fff;border-radius:20px;width:100%;max-width:480px;overflow:hidden}
.modal-body{padding:28px}
.modal-title{font-family:var(--display);font-size:26px;font-weight:600;margin-bottom:6px}
.modal-sub{font-size:13px;color:var(--muted);margin-bottom:22px}
.modal-field{margin-bottom:14px}
.modal-field label{font-size:11px;font-weight:600;color:var(--navy);text-transform:uppercase;margin-bottom:6px;display:block}
.modal-field input,.modal-field select{width:100%;padding:12px 14px;border-radius:10px;border:1.5px solid var(--line);font-size:14px;outline:none}
.modal-field input:focus{border-color:var(--navy)}
.modal-btn{width:100%;background:var(--navy);color:#fff;padding:14px;border-radius:10px;font-size:14px;font-weight:600;margin-top:14px}
@media(max-width:1024px){.hero-inner,.ed-grid,.section-head{grid-template-columns:1fr}.hero-right{height:480px}.cats,.pros-grid{grid-template-columns:repeat(2,1fr)}.testi-grid{grid-template-columns:1fr}.footer-top{grid-template-columns:1fr 1fr}.nav-links,.strip-tick{display:none}}
@media(max-width:768px){.hero-inner{grid-template-columns:1fr;gap:40px;padding:60px 0;min-height:auto;display:flex;flex-direction:column-reverse}.hero-h1{font-size:clamp(36px,5vw,56px)}.hero-sub{font-size:15px}.hero-right{display:flex;position:relative;height:300px;width:100%}.hr-main{width:280px;height:360px;top:0;left:50%;transform:translateX(-50%) rotate(-3deg)}.hr-second,.hr-third{display:none}.section{padding:60px 0}.section-head{grid-template-columns:1fr;gap:32px;margin-bottom:40px}.section-h{font-size:clamp(28px,4vw,40px)}.cats{grid-template-columns:repeat(2,1fr);gap:12px}.cat{aspect-ratio:1/1}.cat-name{font-size:20px}.pros-section{background:var(--paper);padding:40px 0}.pros-grid{grid-template-columns:1fr}.strip-inner{padding:0 16px}.strip-left{display:none}.strip-right{gap:12px;font-size:11px}.nav-inner{padding:0 16px;height:64px}.logo{font-size:24px}.nav-links{display:none;position:absolute;top:64px;left:0;right:0;background:var(--navy);flex-direction:column;padding:16px;gap:0;z-index:200}.nav-links.show{display:flex}.nav-link{padding:12px;border-radius:8px}.nav-toggle{display:flex}.btn-ghost{display:inline-flex}.section-inner{padding:0 16px}.cats{grid-template-columns:1fr 1fr}.footer-top{grid-template-columns:1fr;gap:24px}.footer-bottom{flex-direction:column;gap:16px;text-align:center}}
@media(max-width:480px){.cats{grid-template-columns:1fr}.cat{aspect-ratio:3/4}.hero{padding:60px 0 40px}}
</style>
</head>
<body>

<script>
const CATEGORIES=[{num:'01',name:'Wedding Photography',count:'214 pros · from ₹480/day',img:'https://images.unsplash.com/photo-1519741497674-611481863552?w=800&q=85'},{num:'02',name:'Cinematography',count:'128 pros · from ₹720/day',img:'https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?w=800&q=85'},{num:'03',name:'Album Designing',count:'86 pros · from ₹280/album',img:'${pageContext.request.contextPath}/images/album-editor.jpg'}];
const PROS=[{tab:'photo',name:'Arjun Mehta',craft:'Wedding Photography',rating:4.98,reviews:312,rate:480,img:'https://images.unsplash.com/photo-1554080353-a576cf803bda?w=600&q=85',badge:'Top 1%'},{tab:'film',name:'Kabir Singh',craft:'Cinematography',rating:4.95,reviews:184,rate:720,img:'https://images.unsplash.com/photo-1492691527719-9d1e07e534b4?w=600&q=85',badge:'Featured'},{tab:'album',name:'Pixel Studio',craft:'Album Designing',rating:4.99,reviews:96,rate:540,img:'${pageContext.request.contextPath}/images/album-editor.jpg',badge:'Premium'}];
const TRUST_ITEMS=['Vogue India','Condé Nast Traveller','The Times of India','Bridal Asia','Forbes India','BRIDES'];
const TICKER_ITEMS=['Priya S. just booked Arjun Mehta for a wedding shoot','Kabir R. matched with Vikram S. — brand film','Anjali confirmed Pixel Studio for album design','A new vendor was just verified — Photo Art'];
</script>

<div class="strip">
<div class="strip-inner">
<div class="strip-left">
<div class="strip-loc"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" width="12" height="12"><path d="M12 22s-8-7.5-8-13a8 8 0 0 1 16 0c0 5.5-8 13-8 13z"/><circle cx="12" cy="9" r="3"/></svg>Mumbai, India</div>
<div class="strip-divider"></div>
<div class="strip-tick"><span style="width:6px;height:6px;border-radius:50%;background:#5fc37c"></span><span id="tickText">Priya S. just booked Arjun Mehta for a wedding shoot</span></div>
</div>
<div class="strip-right">
<a href="#">+91 98765 43210</a>
<span style="opacity:.3">|</span>
<a href="<%= request.getContextPath() %>/login">For Vendors →</a>
</div>
</div>
</div>

<nav class="nav">
<div class="nav-inner">
<a href="<%= request.getContextPath() %>/" class="logo">Pro<span class="q">Q</span>ik<sup>IND</sup></a>
<div class="nav-links">
<a href="#" class="nav-link">Discover</a>
<a href="#" class="nav-link">Categories</a>
<a href="#" class="nav-link">How It Works</a>
<a href="#" class="nav-link">Stories</a>
</div>
<div class="nav-cta">
<button class="nav-toggle" onclick="document.querySelector('.nav-links').classList.toggle('show')">
<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
</button>
<a href="<%= request.getContextPath() %>/login" class="btn-ghost">Sign In</a>
<a href="<%= request.getContextPath() %>/login" class="btn-gold">JOIN</a>
</div>
</div>
</nav>

<section class="hero">
<div class="hero-inner">
<div class="hero-left">
<div class="hero-badge"><span class="pulse"></span>Live · 248 professionals available</div>
<h1 class="hero-h1">India's finest<br/><em>Visual</em><br/><span class="light">Storytellers.</span></h1>
<p class="hero-sub">Curated network of premium photographers, cinematographers & album artists for discerning events.</p>

<div class="hero-search">
<div class="hs-field" onclick="location.href='<%= request.getContextPath() %>/vendors'">
<span class="hs-label">Service</span>
<span class="hs-value">Photography</span>
</div>
<div class="hs-field" onclick="location.href='<%= request.getContextPath() %>/vendors'">
<span class="hs-label">Where</span>
<span class="hs-value">All India</span>
</div>
<a href="<%= request.getContextPath() %>/vendors" class="hs-btn"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" width="18" height="18"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg></a>
</div>

<div class="hero-stats">
<div><div class="hs-num">2,400<span class="gold">+</span></div><div class="hs-lbl">Verified Pros</div></div>
<div><div class="hs-num">48<span class="gold">hr</span></div><div class="hs-lbl">Avg Booking</div></div>
<div><div class="hs-num">4.9<span class="gold">★</span></div><div class="hs-lbl">Reviews</div></div>
</div>
</div>

<div class="hero-right">
<div class="hr-second"><img src="https://images.unsplash.com/photo-1519741497674-611481863552?w=600&q=80" alt="Wedding"/></div>
<div class="hr-third"><img src="https://images.unsplash.com/photo-1556761175-5973dc0f32e7?w=600&q=80" alt="Event"/></div>
<div class="hr-main"><img src="https://images.unsplash.com/photo-1554080353-a576cf803bda?w=900&q=85" alt="Featured Pro"/></div>
</div>
</div>

<div class="trust">
<div class="trust-inner">
<div class="trust-label">Trusted by<br/>premium clients</div>
<div class="trust-marquee"><div class="trust-track" id="trustTrack"></div></div>
</div>
</div>
</section>

<section class="section">
<div class="section-inner">
<div class="section-head">
<div><span class="eyebrow">Our Specialties</span><h2 class="section-h">Visual crafts,<br/><em>perfected</em>.</h2></div>
<p class="section-sub">Three disciplines. Endless possibility.</p>
</div>
<div class="cats" id="catsGrid"></div>
</div>
</section>

<section class="section pros-section">
<div class="section-inner">
<div class="section-head">
<div><span class="eyebrow">Curated Pros</span><h2 class="section-h">Featured <em>visual artists</em>.</h2></div>
</div>
<div class="pros-tabs" id="prosTabs">
<button class="pros-tab active" data-tab="all">All</button>
<button class="pros-tab" data-tab="photo">Photo</button>
<button class="pros-tab" data-tab="film">Film</button>
<button class="pros-tab" data-tab="album">Album</button>
</div>
<div class="pros-grid" id="prosGrid"></div>
</div>
</section>

<section class="editorial">
<div class="section-inner">
<div class="ed-grid">
<div>
<span class="eyebrow">For Creators</span>
<h2 class="ed-h">Where India's finest <em>practice their craft</em>.</h2>
<p class="ed-sub">Join the network behind the country's most discerning events. Less searching. More creating.</p>
<div class="ed-stats">
<div class="ed-stat"><div class="ed-stat-n">₹3.2<span class="gold">L</span></div><div class="ed-stat-l">Avg monthly earnings</div></div>
<div class="ed-stat"><div class="ed-stat-n">12<span class="gold">×</span></div><div class="ed-stat-l">More qualified leads</div></div>
<div class="ed-stat"><div class="ed-stat-n">0<span class="gold">%</span></div><div class="ed-stat-l">Listing fee</div></div>
</div>
<div class="ed-cta">
<a href="<%= request.getContextPath() %>/login" class="btn-lg-gold">JOIN</a>
</div>
</div>
</div>
</div>
</section>

<section class="testi-section">
<div class="section-inner">
<div class="section-head">
<div><span class="eyebrow">Client Voices</span><h2 class="section-h">Held to the <em>highest</em> standard.</h2></div>
</div>
<div class="testi-grid">
<div class="testi"><div class="testi-mark">"</div><div class="testi-stars">★★★★★</div><p class="testi-text">ProQik made finding our wedding photographer effortless.</p><div class="testi-by"><div class="testi-av"><img src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80" alt=""/></div><div><div class="testi-name">Priya & Amit Sharma</div><div class="testi-role">Wedding · Mumbai</div></div></div></div>
<div class="testi"><div class="testi-mark">"</div><div class="testi-stars">★★★★★</div><p class="testi-text">The platform is elegant, fast and the team cares about our success.</p><div class="testi-by"><div class="testi-av"><img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80" alt=""/></div><div><div class="testi-name">Kabir Singh</div><div class="testi-role">Cinematographer</div></div></div></div>
<div class="testi"><div class="testi-mark">"</div><div class="testi-stars">★★★★★</div><p class="testi-text">Every guest asks about our photographer. Truly remarkable service.</p><div class="testi-by"><div class="testi-av"><img src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80" alt=""/></div><div><div class="testi-name">Anjali Mehta</div><div class="testi-role">Cultural Event</div></div></div>
</div>
</div>
</section>

<section class="final-cta">
<div class="final-inner">
<span class="eyebrow" style="color:var(--gold)">Begin</span>
<h1 class="final-h">Your story <em>deserves</em><br/>the right hands.</h1>
<p class="final-sub">Tell us about your event. Three matched professionals will be in your inbox.</p>
<div class="final-buttons">
<a href="<%= request.getContextPath() %>/login" class="btn-lg-gold">JOIN</a>
</div>
</div>
</section>

<footer class="footer">
<div class="footer-inner">
<div class="footer-top">
<div class="footer-brand"><div class="logo" style="color:#fff;margin-bottom:18px">Pro<span class="q">Q</span>ik<sup>IND</sup></div><p style="color:rgba(255,255,255,.5);font-size:13px;max-width:240px">India's premium network for visual artists — photographers, cinematographers & album designers.</p></div>
<div class="footer-col">
<h4>Discover</h4>
<ul><li><a href="<%= request.getContextPath() %>/vendors">Photographers</a></li><li><a href="<%= request.getContextPath() %>/vendors">Cinematographers</a></li><li><a href="<%= request.getContextPath() %>/vendors">Album Artists</a></li></ul>
</div>
<div class="footer-col">
<h4>For Creators</h4>
<ul><li><a href="<%= request.getContextPath() %>/login">Join Network</a></li><li><a href="#">How It Works</a></li><li><a href="#">Pricing</a></li></ul>
</div>
<div class="footer-col">
<h4>Company</h4>
<ul><li><a href="#">About</a></li><li><a href="<%= request.getContextPath() %>/login">Sign In</a></li></ul>
</div>
</div>
<div class="footer-bottom">
<div>© 2026 ProQik IN · Premier Visual Network</div>
</div>
</div>
</footer>

<script>
const catsGrid=document.getElementById('catsGrid');
CATEGORIES.forEach(c=>{const el=document.createElement('div');el.className='cat';el.innerHTML='<img src="'+c.img+'" alt="'+c.name+'"/><div class="cat-overlay"></div><div class="cat-content"><div class="cat-num">'+c.num+'</div><div class="cat-name">'+c.name+'</div><div class="cat-meta"><span>'+c.count+'</span><span class="cat-arrow">→</span></div></div>';el.onclick=function(){location.href='<%= request.getContextPath() %>/vendors'};catsGrid.appendChild(el)});

const prosGrid=document.getElementById('prosGrid');let activeTab='all';
function renderPros(){prosGrid.innerHTML='';const list=activeTab==='all'?PROS:PROS.filter(p=>p.tab===activeTab);list.forEach(p=>{const el=document.createElement('div');el.className='pro-card';el.innerHTML='<div class="pro-img"><img src="'+p.img+'" alt="'+p.name+'"/><div class="pro-badge"><span class="star">★</span> '+p.badge+'</div></div><div class="pro-body"><div class="pro-name">'+p.name+' <span class="pro-verified">✓</span></div><div class="pro-craft">'+p.craft+'</div><div class="pro-meta"><div class="pro-rate">₹'+p.rate+'<span class="from">/day</span></div><div class="pro-rating-pill"><span class="stars">★</span> '+p.rating+'</div></div></div>';el.onclick=function(){location.href='<%= request.getContextPath() %>/vendors'};prosGrid.appendChild(el)})}
document.querySelectorAll('.pros-tab').forEach(tab=>{tab.onclick=()=>{document.querySelectorAll('.pros-tab').forEach(t=>t.classList.remove('active'));tab.classList.add('active');activeTab=tab.dataset.tab;renderPros()}});

const trustTrack=document.getElementById('trustTrack');trustTrack.innerHTML=[...TRUST_ITEMS,...TRUST_ITEMS].map(t=>'<div class="trust-item">★ '+t+'</div>').join('');

let tickIdx=0;const tickEl=document.getElementById('tickText');
setInterval(()=>{tickIdx=(tickIdx+1)%TICKER_ITEMS.length;tickEl.style.opacity='0';setTimeout(()=>{tickEl.textContent=TICKER_ITEMS[tickIdx];tickEl.style.opacity='1';},250)},4000);

renderPros();
</script>
</body>
</html>