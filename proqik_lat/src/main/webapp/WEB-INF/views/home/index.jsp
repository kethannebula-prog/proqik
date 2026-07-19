<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<title>ProQik — Join as a Creative Professional in India</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<style>
:root{
  --navy:#122f66;
  --navy-deep:#122f66;
  --navy-mid:#1e55b0;
  --navy-light:#e8f0fc;
  --navy-xlight:#f0f5ff;
  --blue-glow:rgba(27,74,151,.12);
  --white:#ffffff;
  --off-white:#fafbff;
  --gray-50:#f6f8fc;
  --gray-100:#eef1f8;
  --gray-200:#dce2f0;
  --gray-400:#8b96b0;
  --gray-600:#4a5578;
  --gray-800:#1a2140;
  --gold:#c9a84c;
  --gold-light:#f5edd6;
  --success:#16a34a;
  --font:'Plus Jakarta Sans',system-ui,sans-serif;
  --disp:'Syne',system-ui,sans-serif;
  --ease:cubic-bezier(.16,1,.3,1);
  --ease2:cubic-bezier(.4,0,.2,1);
  --r8:8px; --r12:12px; --r16:16px; --r20:20px; --r24:24px;
  --shadow-sm:0 1px 4px rgba(27,74,151,.08),0 1px 2px rgba(0,0,0,.04);
  --shadow-md:0 4px 20px rgba(27,74,151,.1),0 2px 8px rgba(0,0,0,.06);
  --shadow-lg:0 12px 48px rgba(27,74,151,.14),0 4px 16px rgba(0,0,0,.08);
  --shadow-xl:0 24px 80px rgba(27,74,151,.18),0 8px 32px rgba(0,0,0,.1);
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth;-webkit-text-size-adjust:100%}
body{font-family:var(--font);background:var(--white);color:var(--gray-800);min-height:100vh;-webkit-font-smoothing:antialiased;overflow-x:hidden}
a{text-decoration:none;color:inherit}
button{cursor:pointer;font-family:var(--font);border:none;background:none}
img{max-width:100%;display:block}
input,select,textarea{font-family:var(--font)}
.nav{background:var(--navy);border-bottom:1px solid rgba(255,255,255,.08);position:sticky;top:0;z-index:200;box-shadow:0 2px 20px rgba(0,0,0,.2)}
.nav-inner{max-width:1280px;margin:0 auto;padding:0 32px;height:68px;display:flex;align-items:center;gap:20px}
.nav-logo{flex-shrink:0}
.nav-logo img{height:38px;width:auto}
.nav-divider{width:1px;height:28px;background:rgba(255,255,255,.15);flex-shrink:0}
.nav-links{display:flex;gap:4px;flex:1}
.nav-link{padding:8px 14px;border-radius:var(--r8);font-size:13px;font-weight:600;color:rgba(255,255,255,.7);transition:all .2s;white-space:nowrap}
.nav-link:hover{color:#fff;background:rgba(255,255,255,.1)}
.nav-ctas{display:flex;align-items:center;gap:10px;margin-left:auto}
.btn-ghost{padding:8px 18px;border-radius:var(--r8);font-size:13px;font-weight:600;color:rgba(255,255,255,.85);border:1.5px solid rgba(255,255,255,.22);transition:all .2s}
.btn-ghost:hover{background:rgba(255,255,255,.1);color:#fff;border-color:rgba(255,255,255,.4)}
.btn-white{padding:9px 22px;border-radius:var(--r8);font-size:13px;font-weight:700;background:#fff;color:var(--navy);transition:all .25s var(--ease);box-shadow:0 2px 12px rgba(0,0,0,.2)}
.btn-white:hover{background:var(--navy-light);transform:translateY(-1px);box-shadow:0 4px 20px rgba(0,0,0,.25)}
.hero{background:var(--navy);position:relative;overflow:hidden;padding:80px 0 0}
.hero-bg-art{position:absolute;inset:0;pointer-events:none;overflow:hidden}
.hero-beam{position:absolute;border-radius:50%;background:rgba(255,255,255,.04);transform-origin:center}
.hb1{width:700px;height:700px;right:-200px;top:-200px}
.hb2{width:500px;height:500px;left:-100px;bottom:-150px;background:rgba(255,255,255,.02)}
.hb3{position:absolute;width:100%;height:1px;top:50%;left:0;background:linear-gradient(90deg,transparent,rgba(255,255,255,.06),transparent)}
.hero-grid{position:absolute;inset:0;background-image:radial-gradient(circle,rgba(255,255,255,.07) 1px,transparent 1px);background-size:36px 36px;mask-image:radial-gradient(ellipse 80% 80% at 50% 50%,black 40%,transparent 100%)}
.hero-inner{max-width:1280px;margin:0 auto;padding:0 32px;display:grid;grid-template-columns:1fr 500px;gap:64px;align-items:end;position:relative;z-index:2}
.hero-left{padding-bottom:64px}
.hero-badge{display:inline-flex;align-items:center;gap:8px;background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.18);border-radius:24px;padding:6px 16px;font-size:11px;font-weight:700;color:rgba(255,255,255,.9);letter-spacing:.12em;text-transform:uppercase;margin-bottom:24px;backdrop-filter:blur(8px)}
.live-dot{width:7px;height:7px;border-radius:50%;background:#4ade80;position:relative;flex-shrink:0}
.live-dot::after{content:'';position:absolute;inset:-3px;border-radius:50%;border:2px solid #4ade80;animation:livePulse 2s ease-out infinite}
@keyframes livePulse{0%{transform:scale(1);opacity:.8}100%{transform:scale(2.5);opacity:0}}
.hero-h1{font-family:var(--disp);font-size:clamp(36px,4.2vw,62px);font-weight:800;color:#fff;line-height:1.06;letter-spacing:-2px;margin-bottom:20px}
.hero-h1 .accent{position:relative;display:inline-block;color:var(--gold)}
.hero-h1 .accent::after{content:'';position:absolute;bottom:-4px;left:0;right:0;height:3px;background:var(--gold);border-radius:2px;opacity:.5}
.hero-h1 .dim{color:rgba(255,255,255,.5);font-weight:600}
.hero-sub{font-size:16px;color:rgba(255,255,255,.65);line-height:1.78;max-width:520px;margin-bottom:40px;font-weight:400}
.hero-search{display:flex;background:#fff;border-radius:var(--r12);overflow:hidden;max-width:580px;box-shadow:0 8px 40px rgba(0,0,0,.28);border:2px solid transparent;transition:border-color .25s,box-shadow .25s}
.hero-search:focus-within{border-color:var(--gold);box-shadow:0 8px 40px rgba(0,0,0,.28),0 0 0 4px rgba(201,168,76,.15)}
.hs-inp{flex:1;border:none;outline:none;padding:15px 20px;font-size:14px;font-family:var(--font);color:var(--gray-800);font-weight:500}
.hs-inp::placeholder{color:var(--gray-400)}
.hs-sep{width:1px;background:var(--gray-200);flex-shrink:0;margin:10px 0}
.hs-select{border:none;outline:none;padding:0 16px;font-size:13px;font-family:var(--font);color:var(--gray-600);background:transparent;cursor:pointer;font-weight:600;appearance:none;min-width:148px}
.hs-btn{background:var(--navy);color:#fff;border:none;padding:0 24px;font-size:14px;font-weight:700;font-family:var(--font);cursor:pointer;transition:all .2s;display:flex;align-items:center;gap:8px;flex-shrink:0}
.hs-btn:hover{background:var(--navy-deep)}
.hero-tags{display:flex;gap:8px;margin-top:16px;flex-wrap:wrap;align-items:center}
.hero-tag-label{font-size:11px;color:rgba(255,255,45,.45);font-weight:600}
.hero-tag{background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.16);border-radius:24px;padding:5px 14px;font-size:12px;font-weight:600;color:rgba(255,255,255,.8);cursor:pointer;transition:all .2s}
.hero-tag:hover{background:rgba(255,255,255,.15);color:#fff;transform:translateY(-1px)}
.hero-right{position:relative;padding-bottom:0;display:flex;align-items:flex-end}
.hero-card-stack{position:relative;width:100%;padding-bottom:40px}
.showcase-card{background:#fff;border-radius:var(--r20);padding:24px;box-shadow:var(--shadow-xl);border:1px solid var(--gray-100);margin-bottom:0;position:relative;z-index:2;transform:translateY(40px)}
.sc-top{display:flex;align-items:center;gap:12px;margin-bottom:18px}
.sc-badge{background:var(--navy-light);color:var(--navy);font-size:10px;font-weight:800;padding:3px 10px;border-radius:var(--r8);letter-spacing:.07em;text-transform:uppercase}
.sc-title{font-size:13px;font-weight:600;color:var(--gray-800)}
.sc-pros{display:grid;grid-template-columns:repeat(3,1fr);gap:12px;margin-bottom:18px}
.sc-pro{background:var(--gray-50);border-radius:var(--r12);padding:13px 10px;text-align:center;border:1px solid var(--gray-100);transition:all .25s var(--ease);cursor:default}
.sc-pro:hover{border-color:var(--navy-light);background:#fff;box-shadow:var(--shadow-sm);transform:translateY(-2px)}
.sc-pro-av{width:44px;height:44px;border-radius:50%;overflow:hidden;margin:0 auto 8px;border:2.5px solid var(--navy-light)}
.sc-pro-av img{width:100%;height:100%;object-fit:cover}
.sc-pro-name{font-size:11px;font-weight:700;color:var(--gray-800);margin-bottom:2px}
.sc-pro-role{font-size:10px;color:var(--gray-400)}
.sc-pro-rate{font-size:12px;font-weight:700;color:var(--navy);margin-top:5px}
.sc-stats{display:flex;gap:0;border:1px solid var(--gray-100);border-radius:var(--r12);overflow:hidden}
.sc-stat{flex:1;padding:12px 10px;text-align:center;border-right:1px solid var(--gray-100)}
.sc-stat:last-child{border-right:none}
.sc-stat-n{font-family:var(--disp);font-size:17px;font-weight:800;color:var(--navy)}
.sc-stat-l{font-size:10px;color:var(--gray-400);font-weight:500;margin-top:2px}
.float-pill{position:absolute;bottom:20px;left:-24px;background:#fff;border-radius:40px;padding:12px 16px;display:flex;align-items:center;gap:10px;box-shadow:var(--shadow-md);border:1px solid var(--gray-100);z-index:3;animation:floatUp 6s ease-in-out infinite}
@keyframes floatUp{0%,100%{transform:translateY(0)}50%{transform:translateY(-8px)}}
.fp-ico{width:36px;height:36px;border-radius:50%;background:var(--navy-light);display:flex;align-items:center;justify-content:center;font-size:16px;flex-shrink:0}
.fp-name{font-size:12px;font-weight:700;color:var(--gray-800)}
.fp-sub{font-size:10px;color:var(--gray-400);margin-top:1px}
.fp-dot{width:8px;height:8px;border-radius:50%;background:#4ade80;flex-shrink:0;margin-left:auto}
.trust-bar{background:var(--gray-50);border-bottom:1px solid var(--gray-200);padding:16px 0;overflow:hidden;position:relative}
.trust-bar::before,.trust-bar::after{content:'';position:absolute;top:0;bottom:0;width:80px;z-index:2;pointer-events:none}
.trust-bar::before{left:0;background:linear-gradient(to right,var(--gray-50),transparent)}
.trust-bar::after{right:0;background:linear-gradient(to left,var(--gray-50),transparent)}
.marquee{display:flex;gap:48px;animation:marqueeRun 30s linear infinite;width:max-content}
@keyframes marqueeRun{from{transform:translateX(0)}to{transform:translateX(-50%)}}
.trust-bar:hover .marquee{animation-play-state:paused}
.mq-item{display:flex;align-items:center;gap:9px;white-space:nowrap;font-size:12px;font-weight:700;color:var(--gray-400)}
.mq-item span.icon{font-size:16px}
.mq-sep{width:4px;height:4px;border-radius:50%;background:var(--gray-200);flex-shrink:0}
.section{padding:80px 0}
.section-inner{max-width:1280px;margin:0 auto;padding:0 32px}
.section-eyebrow{display:inline-flex;align-items:center;gap:8px;font-size:11px;font-weight:800;color:var(--navy);letter-spacing:.16em;text-transform:uppercase;margin-bottom:10px}
.section-eyebrow::before{content:'';width:24px;height:2px;background:var(--navy);border-radius:1px}
.section-h{font-family:var(--disp);font-size:clamp(26px,3vw,40px);font-weight:800;color:var(--gray-800);letter-spacing:-.8px;line-height:1.12}
.section-h .hl{color:var(--navy)}
.section-sub{font-size:15px;color:var(--gray-600);margin-top:10px;line-height:1.75;max-width:500px}
.section-row{display:flex;align-items:flex-end;justify-content:space-between;gap:16px;margin-bottom:44px;flex-wrap:wrap}
.see-all{display:flex;align-items:center;gap:6px;padding:10px 20px;border-radius:var(--r8);border:1.5px solid var(--gray-200);font-size:13px;font-weight:700;color:var(--gray-600);transition:all .22s;flex-shrink:0}
.see-all:hover{border-color:var(--navy);color:var(--navy);background:var(--navy-xlight)}
.see-all svg{transition:transform .2s}
.see-all:hover svg{transform:translateX(4px)}
.svc-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:20px}
.svc-card{border-radius:var(--r20);overflow:hidden;border:1.5px solid var(--gray-200);background:#fff;cursor:pointer;transition:all .35s var(--ease);position:relative}
.svc-card:hover{border-color:var(--navy);transform:translateY(-8px);box-shadow:var(--shadow-lg)}
.svc-card-img{height:200px;overflow:hidden;position:relative}
.svc-card-img img{width:100%;height:100%;object-fit:cover;transition:transform .6s var(--ease)}
.svc-card:hover .svc-card-img img{transform:scale(1.07)}
.svc-card-overlay{position:absolute;inset:0;background:linear-gradient(to top,rgba(27,74,151,.85) 0%,rgba(27,74,151,.1) 60%,transparent 100%)}
.svc-card-badge{position:absolute;top:12px;left:12px;background:var(--gold);color:var(--navy-deep);font-size:9px;font-weight:800;padding:3px 10px;border-radius:20px;letter-spacing:.06em;text-transform:uppercase;z-index:2}
.svc-card-count{position:absolute;bottom:14px;left:14px;z-index:2;font-size:11px;font-weight:700;color:rgba(255,255,255,.9)}
.svc-body{padding:20px}
.svc-icon{width:48px;height:48px;border-radius:var(--r12);background:var(--navy-xlight);border:1px solid var(--navy-light);display:flex;align-items:center;justify-content:center;font-size:22px;margin-bottom:14px;transition:all .3s var(--ease)}
.svc-card:hover .svc-icon{background:var(--navy);transform:scale(1.08)}
.svc-name{font-family:var(--disp);font-size:18px;font-weight:700;color:var(--gray-800);margin-bottom:5px}
.svc-desc{font-size:13px;color:var(--gray-600);line-height:1.65}
.svc-arrow{display:flex;align-items:center;gap:6px;margin-top:14px;font-size:12px;font-weight:700;color:var(--navy);transition:gap .2s}
.svc-card:hover .svc-arrow{gap:10px}
.hiw{background:var(--navy-xlight);padding:80px 0}
.hiw-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:2px;background:var(--gray-200);border-radius:var(--r20);overflow:hidden;margin-top:48px}
.hiw-step{background:#fff;padding:40px 32px;position:relative;overflow:hidden;transition:background .25s}
.hiw-step:hover{background:var(--navy-xlight)}
.hiw-step::before{content:'';position:absolute;top:0;left:0;right:0;height:3px;background:var(--navy);transform:scaleX(0);transform-origin:left;transition:transform .35s var(--ease)}
.hiw-step:hover::before{transform:scaleX(1)}
.step-num{font-family:var(--disp);font-size:64px;font-weight:800;color:var(--navy-light);line-height:1;margin-bottom:20px}
.step-icon{width:52px;height:52px;border-radius:var(--r12);background:var(--navy);display:flex;align-items:center;justify-content:center;font-size:24px;margin-bottom:16px}
.step-title{font-family:var(--disp);font-size:18px;font-weight:700;color:var(--gray-800);margin-bottom:8px}
.step-desc{font-size:13px;color:var(--gray-600);line-height:1.72}
.pros-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:18px}
.pro-card{border-radius:var(--r16);border:1.5px solid var(--gray-200);background:#fff;overflow:hidden;transition:all .32s var(--ease);cursor:pointer}
.pro-card:hover{border-color:var(--navy);transform:translateY(-6px);box-shadow:var(--shadow-lg)}
.pro-banner{height:88px;overflow:hidden;position:relative}
.pro-banner img{width:100%;height:100%;object-fit:cover}
.pro-banner-overlay{position:absolute;inset:0;background:linear-gradient(135deg,var(--navy),var(--navy-mid))}
.pro-av-wrap{padding:0 16px;position:relative}
.pro-av{width:54px;height:54px;border-radius:50%;border:3px solid #fff;overflow:hidden;margin-top:-27px;position:relative;z-index:2;box-shadow:var(--shadow-sm)}
.pro-av img{width:100%;height:100%;object-fit:cover}
.pro-verified{position:absolute;bottom:0;right:-1px;width:18px;height:18px;border-radius:50%;background:var(--navy);border:2px solid #fff;display:flex;align-items:center;justify-content:center;font-size:8px;color:#fff;font-weight:800}
.pro-body{padding:10px 16px 16px}
.pro-name{font-family:var(--disp);font-size:15px;font-weight:700;color:var(--gray-800);margin-bottom:2px}
.pro-role{font-size:12px;color:var(--gray-400);margin-bottom:10px}
.pro-pills{display:flex;gap:5px;flex-wrap:wrap;margin-bottom:12px}
.pro-pill{background:var(--navy-xlight);color:var(--navy);font-size:10px;font-weight:700;padding:3px 9px;border-radius:6px;border:1px solid var(--navy-light)}
.pro-rating{display:flex;align-items:center;gap:5px;margin-bottom:12px}
.pro-stars{color:var(--gold);font-size:11px;letter-spacing:1px}
.pro-rv{font-size:12px;font-weight:700;color:var(--gray-800)}
.pro-rc{font-size:11px;color:var(--gray-400)}
.pro-book{width:100%;background:var(--navy);color:#fff;border-radius:var(--r8);padding:10px;font-size:12px;font-weight:700;font-family:var(--font);transition:all .22s}
.pro-book:hover{background:var(--navy-deep);transform:translateY(-1px)}
.testi{background:var(--navy);padding:80px 0}
.testi-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:20px;margin-top:44px}
.testi-card{background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.1);border-radius:var(--r20);padding:28px;transition:all .3s var(--ease);position:relative}
.testi-card:hover{background:rgba(255,255,255,.1);transform:translateY(-4px)}
.testi-quote{font-family:var(--disp);font-size:56px;font-weight:800;color:var(--gold);opacity:.35;line-height:.8;margin-bottom:12px}
.testi-stars{color:var(--gold);font-size:13px;letter-spacing:2px;margin-bottom:14px}
.testi-text{font-size:14px;color:rgba(255,255,255,.7);line-height:1.78;margin-bottom:22px}
.testi-av-row{display:flex;align-items:center;gap:11px;padding-top:18px;border-top:1px solid rgba(255,255,255,.08)}
.testi-av{width:42px;height:42px;border-radius:50%;overflow:hidden;border:2px solid rgba(201,168,76,.4)}
.testi-av img{width:100%;height:100%;object-fit:cover}
.testi-name{font-size:13px;font-weight:700;color:#fff}
.testi-role{font-size:11px;color:rgba(255,255,255,.4);margin-top:2px}
.cta-split{padding:72px 0;background:var(--gray-50)}
.cta-grid{display:grid;grid-template-columns:1fr 1fr;gap:20px}
.cta-card{border-radius:var(--r24);padding:48px 44px;position:relative;overflow:hidden}
.cta-card.dark{background:var(--navy)}
.cta-card.light{background:#fff;border:1.5px solid var(--gray-200)}
.cta-circle{position:absolute;border-radius:50%;opacity:.08}
.cta-eye{font-size:11px;font-weight:800;letter-spacing:.14em;text-transform:uppercase;margin-bottom:12px}
.cta-card.dark .cta-eye{color:rgba(255,255,255,.5)}
.cta-card.light .cta-eye{color:var(--navy)}
.cta-h{font-family:var(--disp);font-size:clamp(20px,2.5vw,30px);font-weight:800;line-height:1.2;letter-spacing:-.3px;margin-bottom:14px}
.cta-card.dark .cta-h{color:#fff}
.cta-card.light .cta-h{color:var(--gray-800)}
.cta-p{font-size:14px;line-height:1.75;margin-bottom:28px;max-width:360px}
.cta-card.dark .cta-p{color:rgba(255,255,255,.6)}
.cta-card.light .cta-p{color:var(--gray-600)}
.cta-btn{display:inline-flex;align-items:center;gap:8px;padding:14px 28px;border-radius:var(--r12);font-size:14px;font-weight:700;font-family:var(--font);transition:all .25s var(--ease);border:none;cursor:pointer}
.cta-btn.gold{background:var(--gold);color:var(--navy-deep)}
.cta-btn.gold:hover{background:#d4a94d;transform:translateY(-2px);box-shadow:0 6px 20px rgba(201,168,76,.35)}
.cta-btn.navy{background:var(--navy);color:#fff}
.cta-btn.navy:hover{background:var(--navy-deep);transform:translateY(-2px);box-shadow:0 6px 20px rgba(27,74,151,.3)}
.footer{background:var(--navy-deep);padding:64px 0 0}
.footer-inner{max-width:1280px;margin:0 auto;padding:0 32px}
.footer-top{display:grid;grid-template-columns:2fr 1fr 1fr 1fr;gap:48px;padding-bottom:48px}
.footer-logo img{height:34px;margin-bottom:14px}
.footer-desc{font-size:13px;color:rgba(255,255,255,.4);line-height:1.75;max-width:240px;margin-bottom:18px}
.footer-social{display:flex;gap:8px}
.fsoc{width:36px;height:36px;border-radius:var(--r8);background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.1);display:flex;align-items:center;justify-content:center;font-size:14px;cursor:pointer;transition:all .2s}
.fsoc:hover{background:var(--navy);border-color:var(--navy-mid)}
.footer-col h4{font-size:11px;font-weight:800;color:rgba(255,255,255,.35);letter-spacing:.12em;text-transform:uppercase;margin-bottom:16px}
.footer-link{font-size:13px;color:rgba(255,255,255,.5);margin-bottom:9px;cursor:pointer;transition:color .2s;font-weight:500;display:block}
.footer-link:hover{color:rgba(255,255,255,.85)}
.footer-bottom{border-top:1px solid rgba(255,255,255,.07);padding:20px 0;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:12px}
.footer-copy{font-size:12px;color:rgba(255,255,255,.28)}
.footer-badges{display:flex;gap:10px}
.fb{display:flex;align-items:center;gap:5px;font-size:11px;color:rgba(255,255,255,.28);font-weight:600}
#tw{position:fixed;bottom:28px;left:50%;transform:translateX(-50%);z-index:9999;display:flex;flex-direction:column;gap:8px;align-items:center;pointer-events:none}
.toast{background:var(--gray-800);color:#fff;padding:12px 20px;border-radius:var(--r12);font-size:13px;font-weight:600;box-shadow:var(--shadow-lg);animation:tIn .38s var(--ease) both;display:flex;align-items:center;gap:8px}
.toast.g{background:var(--success)}
.toast.r{background:#dc2626}
.toast.b{background:var(--navy)}
@keyframes tIn{from{opacity:0;transform:translateY(12px) scale(.95)}to{opacity:1;transform:none}}
.reveal{opacity:0;transform:translateY(24px);transition:opacity .65s var(--ease),transform .65s var(--ease)}
.reveal.in{opacity:1;transform:none}
.reveal.from-left{transform:translateX(-28px)}
.reveal.from-right{transform:translateX(28px)}
.reveal.from-left.in,.reveal.from-right.in{transform:none}
.d1{transition-delay:.06s}.d2{transition-delay:.12s}.d3{transition-delay:.18s}.d4{transition-delay:.24s}.d5{transition-delay:.3s}
@media(max-width:1024px){
  .hero-inner{grid-template-columns:1fr}
  .hero-right{display:none}
  .svc-grid{grid-template-columns:repeat(3,1fr)}
  .pros-grid{grid-template-columns:repeat(2,1fr)}
  .testi-grid{grid-template-columns:1fr 1fr}
  .footer-top{grid-template-columns:1fr 1fr;gap:28px}
}
@media(max-width:640px){
  .svc-grid,.hiw-grid,.testi-grid,.cta-grid{grid-template-columns:1fr}
  .pros-grid{grid-template-columns:1fr 1fr}
  .nav-links{display:none}
  .section-inner,.hero-inner,.nav-inner,.footer-inner{padding:0 16px}
  .hero{padding:60px 0 0}
  #tkr{display:none}
}
</style>
</head>
<body>

<nav class="nav">
  <div class="nav-inner">
    <a href="<%= request.getContextPath() %>/" class="nav-logo"><img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMDAgNDgiIGZpbGw9Im5vbmUiPgogIDxjaXJjbGUgY3g9IjIyIiBjeT0iMjQiIHI9IjE5IiBzdHJva2U9IndoaXRlIiBzdHJva2Utd2lkdGg9IjEuNiIgZmlsbD0ibm9uZSIgb3BhY2l0eT0iMC4zIi8+CiAgPGNpcmNsZSBjeD0iMjIiIGN5PSIyNCIgcj0iMTMiIHN0cm9rZT0id2hpdGUiIHN0cm9rZS13aWR0aD0iMiIgZmlsbD0ibm9uZSIvPgogIDxwYXRoIGQ9Ik0yMiAxMSBDMjkgMTEgMzUgMTYuOCAzNSAyNCIgc3Ryb2tlPSJ3aGl0ZSIgc3Ryb2tlLXdpZHRoPSIyLjQiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIvPgogIDxwYXRoIGQ9Ik0zNSAyNCBDMzUgMzEuMiAyOSAzNyAyMiAzNyIgc3Ryb2tlPSJ3aGl0ZSIgc3Ryb2tlLXdpZHRoPSIyLjQiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgb3BhY2l0eT0iMC41NSIvPgogIDxjaXJjbGUgY3g9IjIyIiBjeT0iMjQiIHI9IjQiIGZpbGw9IndoaXRlIi8+CiAgPHBhdGggZD0iTTI1LjUgMjcuNSBMMzIgMzQiIHN0cm9rZT0id2hpdGUiIHN0cm9rZS13aWR0aD0iMi42IiBzdHJva2UtbGluZWNhcD0icm91bmQiLz4KICA8dGV4dCB4PSI1MiIgeT0iMzIiIGZvbnQtZmFtaWx5PSInU3luZScsc3lzdGVtLXVpLHNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iMjMiIGZvbnQtd2VpZ2h0PSI4MDAiIGxldHRlci1zcGFjaW5nPSItMC44IiBmaWxsPSJ3aGl0ZSI+UHJvPC90ZXh0PgogIDx0ZXh0IHg9Ijk2IiB5PSIzMiIgZm9udC1mYW1pbHk9IidTeW5lJyxzeXN0ZW0tdWksc2Fucy1zZXJpZiIgZm9udC1zaXplPSIyMyIgZm9udC13ZWlnaHQ9IjgwMCIgbGV0dGVyLXNwYWNpbmc9Ii0wLjgiIGZpbGw9InJnYmEoMjU1LDI1NSwyNTUsMC44NSkiPlFpazwvdGV4dD4KPC9zdmc+" alt="ProQik"/></a>
    <div class="nav-divider"></div>
    <div class="nav-links">
      <a href="#services" class="nav-link">Services</a>
      <a href="#how-it-works" class="nav-link">How It Works</a>
      <a href="#professionals" class="nav-link">Professionals</a>
      <a href="#testimonials" class="nav-link">Reviews</a>
    </div>
    <div class="nav-ctas">
      <a href="<%= request.getContextPath() %>/auth/login.jsp" class="btn-ghost">Sign In</a>
      <button class="btn-white">Join as a Pro</button>
    </div>
  </div>
</nav>

<section class="hero" id="hero">
  <div class="hero-bg-art">
    <div class="hero-grid"></div>
    <div class="hero-beam hb1"></div>
    <div class="hero-beam hb2"></div>
    <div class="hero-beam hb3"></div>
  </div>
  <div class="hero-inner">
    <div class="hero-left">
      <div class="hero-badge"><div class="live-dot"></div> 152 Professionals Active &middot; India 2025</div>
      <h1 class="hero-h1">
        Find the perfect<br>
        <span class="accent">creative pro</span><br>
        <span class="dim">for every moment.</span>
      </h1>
      <p class="hero-sub">ProQik connects clients with India's finest photographers, videographers and album editors. Verified talent, instant bookings, guaranteed quality.</p>
      <form class="hero-search" action="<%= request.getContextPath() %>/vendors" method="GET">
        <input class="hs-inp" name="q" id="heroInput" placeholder="Try 'wedding photographer in Suva'..."/>
        <div class="hs-sep"></div>
        <select class="hs-select" name="category">
          <option value="">All Services</option>
          <option value="photography">Photography</option>
          <option value="videography">Videography</option>
          <option value="drone">Drone / Aerial</option>
          <option value="editing">Album Editing</option>
        </select>
        <button type="submit" class="hs-btn">
          Search
        </button>
      </form>
      <div class="hero-tags">
        <span class="hero-tag-label">Popular:</span>
        <span class="hero-tag">Wedding</span>
        <span class="hero-tag">Portrait</span>
        <span class="hero-tag">Aerial Drone</span>
        <span class="hero-tag">Video Editing</span>
        <span class="hero-tag">Events</span>
      </div>
    </div>
    <div class="hero-right">
      <div class="hero-card-stack">
        <div class="showcase-card">
          <div class="sc-top">
            <div class="sc-badge">Top Rated This Week</div>
          </div>
          <div class="sc-pros">
            <div class="sc-pro">
              <div class="sc-pro-av"><img src="https://i.pravatar.cc/80?img=11" alt=""/></div>
              <div class="sc-pro-name">Ravi K.</div>
              <div class="sc-pro-role">Photography</div>
              <div class="sc-pro-rate">$480</div>
            </div>
            <div class="sc-pro">
              <div class="sc-pro-av"><img src="https://i.pravatar.cc/80?img=41" alt=""/></div>
              <div class="sc-pro-name">Kavya S.</div>
              <div class="sc-pro-role">Videography</div>
              <div class="sc-pro-rate">$320</div>
            </div>
            <div class="sc-pro">
              <div class="sc-pro-av"><img src="https://i.pravatar.cc/80?img=33" alt=""/></div>
              <div class="sc-pro-name">Niko C.</div>
              <div class="sc-pro-role">Album Edit</div>
              <div class="sc-pro-rate">$180</div>
            </div>
          </div>
          <div class="sc-stats">
            <div class="sc-stat"><div class="sc-stat-n">152+</div><div class="sc-stat-l">Verified Pros</div></div>
            <div class="sc-stat"><div class="sc-stat-n">1,284</div><div class="sc-stat-l">Jobs Done</div></div>
            <div class="sc-stat"><div class="sc-stat-n">4.91</div><div class="sc-stat-l">Avg. Rating</div></div>
          </div>
        </div>
        <div class="float-pill">
          <div class="fp-ico">&#128248;</div>
          <div>
            <div class="fp-name">Sione just registered</div>
            <div class="fp-sub">Wedding Photographer &middot; Suva</div>
          </div>
          <div class="fp-dot"></div>
        </div>
      </div>
    </div>
  </div>
</section>

<div class="trust-bar">
  <div class="marquee">
    <div class="mq-item"><span class="icon">&#127942;</span> India's #1 Creative Platform</div>
    <div class="mq-sep"></div>
    <div class="mq-item"><span class="icon">&#9989;</span> 100% Verified Professionals</div>
    <div class="mq-sep"></div>
    <div class="mq-item"><span class="icon">&#128274;</span> Secure Payments</div>
    <div class="mq-sep"></div>
    <div class="mq-item"><span class="icon">&#9889;</span> Instant Booking</div>
    <div class="mq-sep"></div>
    <div class="mq-item"><span class="icon">&#127796;</span> Local India Talent</div>
    <div class="mq-sep"></div>
    <div class="mq-item"><span class="icon">&#127942;</span> India's #1 Creative Platform</div>
    <div class="mq-sep"></div>
    <div class="mq-item"><span class="icon">&#9989;</span> 100% Verified Professionals</div>
    <div class="mq-sep"></div>
    <div class="mq-item"><span class="icon">&#128274;</span> Secure Payments</div>
    <div class="mq-sep"></div>
    <div class="mq-item"><span class="icon">&#9889;</span> Instant Booking</div>
    <div class="mq-sep"></div>
    <div class="mq-item"><span class="icon">&#127796;</span> Local India Talent</div>
  </div>
</div>

<section class="section" id="services">
  <div class="section-inner">
    <div class="section-row">
      <div>
        <div class="section-eyebrow reveal">Our Services</div>
        <h2 class="section-h reveal d1">Three disciplines.<br><span class="hl">One trusted platform.</span></h2>
        <p class="section-sub reveal d2">Register as a professional in photography, videography or album editing and start receiving bookings from clients across India.</p>
      </div>
      <a href="<%= request.getContextPath() %>/login?role=vendor&action=signup" class="see-all reveal d3">
        Join as a Pro
      </a>
    </div>
    <div class="svc-grid">
      <a href="<%= request.getContextPath() %>/login?role=vendor&action=signup&category=photography" class="svc-card reveal d1">
        <div class="svc-card-img">
          <img src="https://images.unsplash.com/photo-1519741497674-611481863552?w=600&q=85" alt="Photography"/>
          <div class="svc-card-overlay"></div>
          <div class="svc-card-badge">Most Popular</div>
          <div class="svc-card-count">68 active professionals</div>
        </div>
        <div class="svc-body">
          <div class="svc-icon">&#128248;</div>
          <div class="svc-name">Photography</div>
          <div class="svc-desc">Wedding, portrait, events, fashion, commercial and real estate photography. Capture every moment beautifully.</div>
          <div class="svc-arrow">
            Register as Photographer
          </div>
        </div>
      </a>
      <a href="<%= request.getContextPath() %>/login?role=vendor&action=signup&category=videography" class="svc-card reveal d2">
        <div class="svc-card-img">
          <img src="https://images.unsplash.com/photo-1492684223066-81342ee5ff30?w=600&q=85" alt="Videography"/>
          <div class="svc-card-overlay"></div>
          <div class="svc-card-count">54 active professionals</div>
        </div>
        <div class="svc-body">
          <div class="svc-icon">&#127916;</div>
          <div class="svc-name">Videography</div>
          <div class="svc-desc">Wedding films, music videos, commercials, aerial drone, documentaries and resort content creation.</div>
          <div class="svc-arrow">
            Register as Videographer
          </div>
        </div>
      </a>
      <a href="<%= request.getContextPath() %>/login?role=vendor&action=signup&category=album" class="svc-card reveal d3">
        <div class="svc-card-img">
          <img src="https://images.unsplash.com/photo-1574717024453-354056aada64?w=600&q=85" alt="Album Editing"/>
          <div class="svc-card-overlay"></div>
          <div class="svc-card-badge" style="background:var(--navy-light);color:var(--navy)">Premium</div>
          <div class="svc-card-count">30 active professionals</div>
        </div>
        <div class="svc-body">
          <div class="svc-icon">&#127902;</div>
          <div class="svc-name">Album Editing</div>
          <div class="svc-desc">Photo retouching, color grading, album design, video editing, motion graphics and visual effects.</div>
          <div class="svc-arrow">
            Register as Editor
          </div>
        </div>
      </a>
    </div>
  </div>
</section>

<div class="hiw" id="how-it-works">
  <div class="section-inner">
    <div class="section-eyebrow reveal">Simple Process</div>
    <h2 class="section-h reveal d1">How <span class="hl">ProQik</span> works</h2>
    <div class="hiw-grid">
      <div class="hiw-step reveal d2">
        <div class="step-num">01</div>
        <div class="step-icon">&#128270;</div>
        <div class="step-title">Choose Your Service</div>
        <div class="step-desc">Select Photography, Videography or Album Editing as your primary discipline, then pick your specialities.</div>
      </div>
      <div class="hiw-step reveal d3">
        <div class="step-num">02</div>
        <div class="step-icon">&#128203;</div>
        <div class="step-title">Build Your Profile</div>
        <div class="step-desc">Fill in your details, upload your portfolio and set your rates. Our team reviews and verifies your profile within 24 hours.</div>
      </div>
      <div class="hiw-step reveal d4">
        <div class="step-num">03</div>
        <div class="step-icon">&#128176;</div>
        <div class="step-title">Get Booked &amp; Paid</div>
        <div class="step-desc">Clients find you through ProQik, book your services, and payment is released securely after each job is complete.</div>
      </div>
    </div>
  </div>
</div>

<section class="section" id="professionals">
  <div class="section-inner">
    <div class="section-row">
      <div>
        <div class="section-eyebrow reveal">Top Talent</div>
        <h2 class="section-h reveal d1">Meet our <span class="hl">professionals</span></h2>
        <p class="section-sub reveal d2">Verified, rated and trusted by clients across India's islands.</p>
      </div>
      <a href="#" class="see-all reveal d3">Browse All</a>
    </div>
    <div class="pros-grid">
      <div class="pro-card reveal d1">
        <div class="pro-banner"><div class="pro-banner-overlay"></div><img src="https://images.unsplash.com/photo-1519741497674-611481863552?w=400&q=75" alt=""/></div>
        <div class="pro-av-wrap"><div class="pro-av"><img src="https://i.pravatar.cc/80?img=11" alt=""/></div><div class="pro-verified">&#10003;</div></div>
        <div class="pro-body">
          <div class="pro-name">Ravi Kumar</div>
          <div class="pro-role">Wedding Photographer &middot; Suva</div>
          <div class="pro-pills"><span class="pro-pill">Wedding</span><span class="pro-pill">Events</span><span class="pro-pill">Portrait</span></div>
          <div class="pro-rating"><span class="pro-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</span><span class="pro-rv">4.9</span><span class="pro-rc">(128)</span></div>
          <button class="pro-book">View Profile</button>
        </div>
      </div>
      <div class="pro-card reveal d2">
        <div class="pro-banner"><div class="pro-banner-overlay"></div><img src="https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=400&q=75" alt=""/></div>
        <div class="pro-av-wrap"><div class="pro-av"><img src="https://i.pravatar.cc/80?img=26" alt=""/></div><div class="pro-verified">&#10003;</div></div>
        <div class="pro-body">
          <div class="pro-name">Sky Vision India</div>
          <div class="pro-role">Aerial Videographer &middot; Nadi</div>
          <div class="pro-pills"><span class="pro-pill">Aerial Drone</span><span class="pro-pill">Resort</span></div>
          <div class="pro-rating"><span class="pro-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</span><span class="pro-rv">5.0</span><span class="pro-rc">(74)</span></div>
          <button class="pro-book">View Profile</button>
        </div>
      </div>
      <div class="pro-card reveal d3">
        <div class="pro-banner"><div class="pro-banner-overlay"></div><img src="https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=400&q=75" alt=""/></div>
        <div class="pro-av-wrap"><div class="pro-av"><img src="https://i.pravatar.cc/80?img=41" alt=""/></div><div class="pro-verified">&#10003;</div></div>
        <div class="pro-body">
          <div class="pro-name">Kavya Sharma</div>
          <div class="pro-role">Portrait Photographer &middot; Lautoka</div>
          <div class="pro-pills"><span class="pro-pill">Portrait</span><span class="pro-pill">Fashion</span></div>
          <div class="pro-rating"><span class="pro-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</span><span class="pro-rv">4.8</span><span class="pro-rc">(52)</span></div>
          <button class="pro-book">View Profile</button>
        </div>
      </div>
      <div class="pro-card reveal d4">
        <div class="pro-banner"><div class="pro-banner-overlay"></div><img src="https://images.unsplash.com/photo-1574717024453-354056aada64?w=400&q=75" alt=""/></div>
        <div class="pro-av-wrap"><div class="pro-av"><img src="https://i.pravatar.cc/80?img=33" alt=""/></div><div class="pro-verified">&#10003;</div></div>
        <div class="pro-body">
          <div class="pro-name">Niko Cama</div>
          <div class="pro-role">Album Editor &middot; Suva</div>
          <div class="pro-pills"><span class="pro-pill">Color Grade</span><span class="pro-pill">Album Design</span></div>
          <div class="pro-rating"><span class="pro-stars">&#9733;&#9733;&#9733;&#9733;</span><span class="pro-rv">4.7</span><span class="pro-rc">(41)</span></div>
          <button class="pro-book">View Profile</button>
        </div>
      </div>
    </div>
  </div>
</section>

<section class="testi" id="testimonials">
  <div class="section-inner">
    <div class="section-eyebrow reveal" style="color:var(--gold)">Client Stories</div>
    <h2 class="section-h reveal d1" style="color:#fff">Loved by <span style="color:var(--gold)">clients</span> across India</h2>
    <div class="testi-grid">
      <div class="testi-card reveal d2">
        <div class="testi-quote">&ldquo;</div>
        <div class="testi-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
        <div class="testi-text">ProQik made finding our wedding photographer effortless. Ravi was professional, creative and delivered stunning cinematic shots. Worth every cent.</div>
        <div class="testi-av-row"><div class="testi-av"><img src="https://i.pravatar.cc/60?img=12" alt=""/></div><div><div class="testi-name">Priya &amp; Amit Sharma</div><div class="testi-role">Wedding Clients &middot; Suva</div></div></div>
      </div>
      <div class="testi-card reveal d3">
        <div class="testi-quote">&ldquo;</div>
        <div class="testi-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
        <div class="testi-text">The aerial drone footage of our resort is breathtaking. Every guest asks about it. ProQik connected us with real world-class talent in minutes.</div>
        <div class="testi-av-row"><div class="testi-av"><img src="https://i.pravatar.cc/60?img=26" alt=""/></div><div><div class="testi-name">Coral Bay Resorts</div><div class="testi-role">Commercial Client &middot; Nadi</div></div></div>
      </div>
      <div class="testi-card reveal d4">
        <div class="testi-quote">&ldquo;</div>
        <div class="testi-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div>
        <div class="testi-text">As a professional on ProQik, my bookings tripled in the first month. The platform is elegant, fast and the team genuinely cares about our success.</div>
        <div class="testi-av-row"><div class="testi-av"><img src="https://i.pravatar.cc/60?img=41" alt=""/></div><div><div class="testi-name">Kavya Sharma</div><div class="testi-role">Photographer &middot; ProQik Pro</div></div></div>
      </div>
    </div>
  </div>
</section>

<div class="cta-split">
  <div class="section-inner">
    <div class="cta-grid" style="max-width:1280px;margin:0 auto">
      <div class="cta-card dark reveal from-left">
        <div class="cta-circle" style="width:280px;height:280px;background:#fff;top:-100px;right:-100px"></div>
        <div class="cta-circle" style="width:180px;height:180px;background:#fff;bottom:-80px;left:-60px"></div>
        <div class="cta-eye">For Professionals</div>
        <div class="cta-h">Grow your creative<br>business with ProQik</div>
        <div class="cta-p">Register your profile, list your services and start receiving bookings from clients across India's islands &mdash; all managed from your dashboard.</div>
        <a href="<%= request.getContextPath() %>/login?role=vendor&action=signup" class="cta-btn gold">
          Become a Pro &rarr;
        </a>
      </div>
      <div class="cta-card light reveal from-right">
        <div class="cta-eye">For Administrators</div>
        <div class="cta-h">Manage the entire platform in one place</div>
        <div class="cta-p">Full admin control &mdash; approve vendors, manage bookings, view analytics and resolve disputes. Built for platform excellence.</div>
        <a href="<%= request.getContextPath() %>/login" class="cta-btn navy">
          Admin Sign In &rarr;
        </a>
      </div>
    </div>
  </div>
</div>

<footer class="footer">
  <div class="footer-inner">
    <div class="footer-top">
      <div>
        <img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyMDAgNDgiIGZpbGw9Im5vbmUiPgogIDxjaXJjbGUgY3g9IjIyIiBjeT0iMjQiIHI9IjE5IiBzdHJva2U9IndoaXRlIiBzdHJva2Utd2lkdGg9IjEuNiIgZmlsbD0ibm9uZSIgb3BhY2l0eT0iMC4zIi8+CiAgPGNpcmNsZSBjeD0iMjIiIGN5PSIyNCIgcj0iMTMiIHN0cm9rZT0id2hpdGUiIHN0cm9rZS13aWR0aD0iMiIgZmlsbD0ibm9uZSIvPgogIDxwYXRoIGQ9Ik0yMiAxMSBDMjkgMTEgMzUgMTYuOCAzNSAyNCIgc3Ryb2tlPSJ3aGl0ZSIgc3Ryb2tlLXdpZHRoPSIyLjQiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIvPgogIDxwYXRoIGQ9Ik0zNSAyNCBDMzUgMzEuMiAyOSAzNyAyMiAzNyIgc3Ryb2tlPSJ3aGl0ZSIgc3Ryb2tlLXdpZHRoPSIyLjQiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgb3BhY2l0eT0iMC41NSIvPgogIDxjaXJjbGUgY3g9IjIyIiBjeT0iMjQiIHI9IjQiIGZpbGw9IndoaXRlIi8+CiAgPHBhdGggZD0iTTI1LjUgMjcuNSBMMzIgMzQiIHN0cm9rZT0id2hpdGUiIHN0cm9rZS13aWR0aD0iMi42IiBzdHJva2UtbGluZWNhcD0icm91bmQiLz4KICA8dGV4dCB4PSI1MiIgeT0iMzIiIGZvbnQtZmFtaWx5PSInU3luZScsc3lzdGVtLXVpLHNhbnMtc2VyaWYiIGZvbnQtc2l6ZT0iMjMiIGZvbnQtd2VpZ2h0PSI4MDAiIGxldHRlci1zcGFjaW5nPSItMC44IiBmaWxsPSJ3aGl0ZSI+UHJvPC90ZXh0PgogIDx0ZXh0IHg9Ijk2IiB5PSIzMiIgZm9udC1mYW1pbHk9IidTeW5lJyxzeXN0ZW0tdWksc2Fucy1zZXJpZiIgZm9udC1zaXplPSIyMyIgZm9udC13ZWlnaHQ9IjgwMCIgbGV0dGVyLXNwYWNpbmc9Ii0wLjgiIGZpbGw9InJnYmEoMjU1LDI1NSwyNTUsMC44NSkiPlFpazwvdGV4dD4KPC9zdmc+" alt="ProQik" style="height:32px;margin-bottom:14px"/>
        <div class="footer-desc">India's premier platform for connecting clients with creative professionals. Fast, verified, and trusted.</div>
        <div class="footer-social">
          <div class="fsoc">&#128248;</div>
          <div class="fsoc">&#127916;</div>
          <div class="fsoc">&#128247;</div>
          <div class="fsoc">&#9654;</div>
        </div>
      </div>
      <div class="footer-col">
        <h4>Platform</h4>
        <a href="#services" class="footer-link">Our Services</a>
        <a href="#how-it-works" class="footer-link">How It Works</a>
        <a href="#professionals" class="footer-link">Professionals</a>
        <a href="#" class="footer-link">Pricing</a>
      </div>
      <div class="footer-col">
        <h4>Professionals</h4>
        <a href="#" class="footer-link">Become a Vendor</a>
        <a href="<%= request.getContextPath() %>/auth/login.jsp" class="footer-link">Vendor Login</a>
        <a href="#" class="footer-link">Success Stories</a>
        <a href="#" class="footer-link">Support</a>
      </div>
      <div class="footer-col">
        <h4>Company</h4>
        <a href="#" class="footer-link">About ProQik</a>
        <a href="#" class="footer-link">Blog</a>
        <a href="#" class="footer-link">Privacy Policy</a>
        <a href="#" class="footer-link">Terms of Service</a>
      </div>
    </div>
    <div class="footer-bottom">
      <div class="footer-copy">&copy; 2025 ProQik. All rights reserved. Made with love in India.</div>
      <div class="footer-badges">
        <div class="fb">&#128274; Secure</div>
        <div class="fb">&#9989; Verified</div>
        <div class="fb">&#127796; India-based</div>
      </div>
    </div>
  </div>
</footer>

<div id="tw"></div>

<script>
var ro=new IntersectionObserver(function(es){es.forEach(function(e){if(e.isIntersecting)e.target.classList.add('in');});},{threshold:.1});
document.querySelectorAll('.reveal').forEach(function(el){ro.observe(el);});
</script>
</body>
</html>