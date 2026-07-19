<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<title>ProQik — Book India's Best Creative Professionals</title>
<link href="https://fonts.googleapis.com/css2?family=Merriweather:ital,wght@0,300;0,400;0,700;0,900;1,300&family=DM+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
html{scroll-behavior:smooth}
body{font-family:'DM Sans',sans-serif;background:#fff;color:#0d1f3c;overflow-x:hidden;-webkit-font-smoothing:antialiased}
img{display:block;max-width:100%;object-fit:cover}
button{font-family:'DM Sans',sans-serif;cursor:pointer;border:none;background:none}
input,select,textarea{font-family:'DM Sans',sans-serif}
::selection{background:#1b376c;color:#fff}

/* === CINEMATIC ENTRANCE === */
.entrance{position:fixed;inset:0;z-index:1000;background:#0f1f3d;display:flex;align-items:center;justify-content:center;transition:opacity 1.5s cubic-bezier(.16,1,.3,1),visibility 1.5s}
.entrance.hidden{opacity:0;visibility:hidden;pointer-events:none}
.entrance-content{text-align:center;color:#fff}
.entrance-logo{font-family:'Merriweather',serif;font-size:11px;letter-spacing:14px;text-transform:uppercase;margin-bottom:48px;opacity:0;animation:fadeIn 1s .4s forwards;color:#c9a84c}
@keyframes fadeIn{to{opacity:1}}
@keyframes fadeUp{from{opacity:0;transform:translateY(36px)}to{opacity:1;transform:translateY(0)}}
@keyframes lineGrow{from{height:0}to{height:100px}}
.entrance-line{width:1px;height:0;background:linear-gradient(to bottom,transparent,#c9a84c,transparent);margin:0 auto 48px;animation:lineGrow 1.8s .8s forwards}
.entrance h1{font-family:'Merriweather',serif;font-size:clamp(32px,5vw,56px);font-weight:700;font-style:italic;line-height:1.12;opacity:0;animation:fadeUp 1.2s 1.2s forwards}
.entrance h1 em{color:#c9a84c;font-style:italic;font-weight:400}

/* ── NAV ─────────────────────────── */
.nav{position:fixed;top:0;left:0;right:0;z-index:600;height:68px;display:flex;align-items:center;padding:0 52px;background:#0f1f3d;border-bottom:1px solid rgba(255,255,255,.07);transition:all .3s}
.nav.stuck{background:rgba(15,31,61,.96);backdrop-filter:blur(18px);box-shadow:0 4px 28px rgba(0,0,0,.5)}
.logo{font-family:'Merriweather',serif;font-size:21px;font-weight:700;color:#fff;margin-right:48px;letter-spacing:-.2px;text-decoration:none;display:flex;align-items:baseline;gap:1px}
.logo-q{color:rgba(255,255,255,.32);font-style:italic}
.logo-ik{color:rgba(255,255,255,.58);font-weight:400}
.nav-links{display:flex;gap:2px;flex:1}
.nav-a{padding:7px 14px;font-size:13px;font-weight:500;color:rgba(255,255,255,.48);border-radius:8px;transition:all .18s;cursor:pointer}
.nav-a:hover{color:#fff;background:rgba(255,255,255,.07)}
.nav-end{display:flex;gap:10px;margin-left:auto;align-items:center}
.btn-ghost{padding:9px 20px;border-radius:9px;font-size:14px;font-weight:600;color:rgba(255,255,255,.78);border:1.5px solid rgba(255,255,255,.18);transition:all .18s;background:transparent}
.btn-ghost:hover{color:#fff;border-color:rgba(255,255,255,.38);background:rgba(255,255,255,.07)}
.btn-primary{padding:10px 22px;border-radius:9px;font-size:14px;font-weight:700;background:#c9a84c;color:#0f1f3d;box-shadow:0 2px 12px rgba(201,168,76,.32);transition:all .2s}
.btn-primary:hover{background:#ddb97a;transform:translateY(-1px);box-shadow:0 6px 20px rgba(201,168,76,.45)}

/* ── HERO ────────────────────────── */
.hero{min-height:100vh;padding-top:68px;display:grid;grid-template-columns:1fr 540px;background:#0f1f3d;position:relative;overflow:hidden;align-items:center}
.hero-bg-photo{position:absolute;inset:0;z-index:0}
.hero-bg-photo img{width:100%;height:100%;object-fit:cover;object-position:center 30%;opacity:.16}
.hero-bg-overlay{position:absolute;inset:0;z-index:1;background:linear-gradient(110deg,rgba(15,31,61,.97) 0%,rgba(15,31,61,.88) 40%,rgba(27,55,108,.55) 75%,rgba(27,55,108,.2) 100%)}
.hero-bg-grid{position:absolute;inset:0;z-index:1;background-image:repeating-linear-gradient(-45deg,rgba(255,255,255,.013) 0,rgba(255,255,255,.013) 1px,transparent 1px,transparent 20px)}
.hero-left{position:relative;z-index:2;padding:72px 32px 72px 60px;display:flex;flex-direction:column;justify-content:center}
.badge{display:inline-flex;align-items:center;gap:8px;background:rgba(255,255,255,.09);border:1px solid rgba(255,255,255,.15);border-radius:100px;padding:7px 18px;margin-bottom:28px;width:fit-content;font-size:12px;font-weight:600;color:rgba(255,255,255,.82);letter-spacing:.06em;text-transform:uppercase}
.dot-green{width:7px;height:7px;border-radius:50%;background:#4ade80;position:relative;flex-shrink:0}
.dot-green::after{content:'';position:absolute;inset:-3px;border-radius:50%;border:2px solid #4ade80;animation:dp 2s ease-out infinite}
@keyframes dp{0%{transform:scale(1);opacity:.8}100%{transform:scale(2.6);opacity:0}}
.hero-h1{font-family:'Merriweather',serif;font-size:clamp(52px,5.2vw,84px);font-weight:700;color:#fff;line-height:1.04;letter-spacing:-2px;margin-bottom:20px}
.hero-h1 em{font-style:italic;font-weight:400;color:rgba(255,255,255,.45);display:block;font-size:.7em;letter-spacing:-.5px;margin-bottom:6px}
.hero-h1 strong{position:relative;display:inline-block}
.hero-h1 strong::after{content:'';position:absolute;left:0;bottom:-5px;right:0;height:3px;background:linear-gradient(90deg,rgba(255,255,255,.58),transparent);border-radius:2px}
.hero-sub{font-size:18px;color:rgba(255,255,255,.52);line-height:1.82;max-width:480px;margin-bottom:40px;font-weight:300}
/* Search */
.search-box{display:flex;background:rgba(255,255,255,.97);border-radius:14px;overflow:hidden;box-shadow:0 18px 60px rgba(0,0,0,.45);max-width:560px;margin-bottom:18px;border:2px solid transparent;transition:border-color .2s,box-shadow .2s}
.search-box:focus-within{border-color:rgba(255,255,255,.4);box-shadow:0 18px 60px rgba(0,0,0,.5),0 0 0 4px rgba(255,255,255,.06)}
.search-input{flex:1;border:none;outline:none;padding:16px 20px;font-family:'DM Sans',sans-serif;font-size:15px;color:#0d1f3c;background:transparent;font-weight:400}
.search-input::placeholder{color:#7a8faa}
.search-sep{width:1px;background:#dce8f4;flex-shrink:0;margin:10px 0}
.search-sel{border:none;outline:none;padding:0 18px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:600;color:#3a4f6e;background:transparent;appearance:none;cursor:pointer;min-width:152px}
.search-go{background:#1b376c;color:#fff;border:none;padding:0 28px;font-size:14px;font-weight:700;font-family:'DM Sans',sans-serif;cursor:pointer;transition:background .18s;display:flex;align-items:center;gap:8px;flex-shrink:0}
.search-go:hover{background:#254e99}
.trending{display:flex;gap:8px;flex-wrap:wrap;align-items:center;max-width:560px}
.tr-lbl{font-size:13px;color:rgba(255,255,255,.32);font-weight:500}
.tr-tag{background:rgba(255,255,255,.07);border:1px solid rgba(255,255,255,.13);border-radius:100px;padding:5px 14px;font-size:13px;font-weight:500;color:rgba(255,255,255,.65);cursor:pointer;transition:all .18s}
.tr-tag:hover{background:rgba(255,255,255,.15);color:#fff;transform:translateY(-1px)}
/* Hero right — phone */
.hero-right{position:relative;z-index:2;display:flex;align-items:center;justify-content:center;padding:100px 30px}
.phone-wrap{position:relative;width:358px}
.phone{width:358px;height:720px;border-radius:44px;background:#0a0f1e;box-shadow:0 0 0 10px #161d32,0 0 0 12px #1e2540,0 56px 90px rgba(0,0,0,.75),inset 0 0 0 1px rgba(255,255,255,.06);overflow:hidden}
.pscreen{width:100%;height:100%;background:linear-gradient(160deg,#1b376c 0%,#0f1f3d 58%,#050a14 100%);overflow:hidden;position:relative;border-radius:44px}
.pnotch{position:absolute;top:0;left:50%;transform:translateX(-50%);width:96px;height:28px;background:#0a0f1e;border-radius:0 0 20px 20px;z-index:10}
.pstatus{display:flex;justify-content:space-between;padding:38px 18px 0;font-size:10.5px;color:rgba(255,255,255,.38);position:relative;z-index:1}
.pc{padding:12px 18px;position:relative;z-index:1}
.pbar{display:flex;justify-content:space-between;align-items:center;margin-bottom:14px}
.plogo{font-family:'Merriweather',serif;font-size:16px;font-weight:700;color:#fff}
.plogo em{color:rgba(255,255,255,.32);font-style:italic}
.pbellwrap{position:relative;width:30px;height:30px;border-radius:50%;background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.12);display:flex;align-items:center;justify-content:center;font-size:14px}
.preddot{position:absolute;top:1px;right:1px;width:8px;height:8px;border-radius:50%;background:#ef4444;border:1.5px solid #0f1f3d}
.pwelc{font-size:10.5px;color:rgba(255,255,255,.38);margin-bottom:2px;font-weight:300}
.pusername{font-family:'Merriweather',serif;font-size:17px;font-weight:700;color:#fff;margin-bottom:13px}
.psearch{display:flex;align-items:center;gap:7px;background:rgba(255,255,255,.09);border:1px solid rgba(255,255,255,.1);border-radius:11px;padding:9px 13px;margin-bottom:16px}
.psearch span{font-size:11.5px;color:rgba(255,255,255,.32)}
.psect{font-size:9.5px;font-weight:700;color:rgba(255,255,255,.38);letter-spacing:.1em;text-transform:uppercase;margin-bottom:9px}
.psvcrow{display:flex;gap:8px;margin-bottom:16px}
.psvc{flex:1;border-radius:12px;overflow:hidden;height:78px;position:relative;background:#1a2a45;border:1px solid rgba(255,255,255,.07)}
.psvc img{width:100%;height:100%;object-fit:cover;opacity:.52}
.psvcov{position:absolute;inset:0;background:linear-gradient(to top,rgba(9,18,38,.9),transparent)}
.psvcl{position:absolute;bottom:7px;left:9px;font-size:8.5px;font-weight:700;color:#fff;letter-spacing:.04em}
.ppro{display:flex;align-items:center;gap:9px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.08);border-radius:12px;padding:10px 11px;margin-bottom:7px}
.ppav{width:34px;height:34px;border-radius:50%;overflow:hidden;border:2px solid rgba(255,255,255,.16);flex-shrink:0}
.ppav img{width:100%;height:100%;object-fit:cover}
.ppn{font-size:11px;font-weight:600;color:#fff;margin-bottom:1px}
.ppr{font-size:9.5px;color:rgba(255,255,255,.38)}
.ppst{color:#f59e0b;font-size:8.5px;letter-spacing:1px}
.pprate{margin-left:auto;font-family:'Merriweather',serif;font-size:13px;font-weight:700;color:#fff}
.pnav{position:absolute;bottom:0;left:0;right:0;background:rgba(4,10,22,.96);backdrop-filter:blur(12px);border-top:1px solid rgba(255,255,255,.07);display:flex;justify-content:space-around;padding:8px 0 16px}
.pni{display:flex;flex-direction:column;align-items:center;gap:3px;font-size:8.5px;color:rgba(255,255,255,.3);font-weight:500}
.pni.on{color:rgba(255,255,255,.9)}
.pnic{width:30px;height:20px;display:flex;align-items:center;justify-content:center;font-size:14px}
/* Floating booking badge */
.booking-badge{position:absolute;bottom:120px;right:-68px;background:#fff;border-radius:14px;padding:12px 15px;box-shadow:0 10px 36px rgba(0,0,0,.4);display:flex;align-items:center;gap:10px;animation:bbf 6s ease-in-out infinite;white-space:nowrap;z-index:10}
@keyframes bbf{0%,100%{transform:translateY(0)}50%{transform:translateY(-9px)}}
.bbico{width:30px;height:30px;border-radius:9px;background:#eef4fb;display:flex;align-items:center;justify-content:center;font-size:15px;flex-shrink:0}
.bbtxt{font-size:11px;font-weight:600;color:#0d1f3c}
.bbsub{font-size:10px;color:#7a8faa;margin-top:1px}
.bbdot{width:7px;height:7px;border-radius:50%;background:#4ade80;flex-shrink:0}

/* ── TICKER ──���─���─────────────────── */
.ticker{background:#0a1425;border-top:1px solid rgba(255,255,255,.06);border-bottom:1px solid rgba(255,255,255,.06);padding:14px 0;overflow:hidden;position:relative}
.ticker::before,.ticker::after{content:'';position:absolute;top:0;bottom:0;width:120px;z-index:2;pointer-events:none}
.ticker::before{left:0;background:linear-gradient(to right,#0a1425,transparent)}
.ticker::after{right:0;background:linear-gradient(to left,#0a1425,transparent)}
.ttrack{display:flex;gap:72px;animation:tka 28s linear infinite;width:max-content}
@keyframes tka{from{transform:translateX(0)}to{transform:translateX(-50%)}}
.ticker:hover .ttrack{animation-play-state:paused}
.ti{display:flex;align-items:center;gap:10px;white-space:nowrap;font-size:10.5px;letter-spacing:2.5px;text-transform:uppercase;color:rgba(255,255,255,.25);font-weight:600}
.ti b{color:rgba(255,255,255,.52)}
.tidot{width:3px;height:3px;border-radius:50%;background:rgba(255,255,255,.18);flex-shrink:0}

/* ── SHARED ──────────────────────── */
.wrap{max-width:1280px;margin:0 auto;padding:0 80px}
.s-eye{font-size:12px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;color:#1b376c;display:inline-flex;align-items:center;gap:9px;margin-bottom:10px}
.s-eye::before{content:'';width:22px;height:2px;background:#1b376c;border-radius:2px}
.s-h2{font-family:'Merriweather',serif;font-size:clamp(36px,3.6vw,56px);font-weight:700;color:#0d1f3c;letter-spacing:-.8px;line-height:1.1}
.s-h2 .b{color:#1b376c}
.s-h2 em{font-style:italic;font-weight:400;color:#3a4f6e}
.s-sub{font-size:16px;color:#7a8faa;margin-top:12px;line-height:1.82;font-weight:300;max-width:520px}
.sec-row{display:flex;align-items:flex-end;justify-content:space-between;gap:16px;margin-bottom:52px;flex-wrap:wrap}
.btn-outline{display:inline-flex;align-items:center;gap:7px;padding:11px 22px;border-radius:10px;border:1.5px solid #dce8f4;font-size:13px;font-weight:600;color:#3a4f6e;transition:all .2s;cursor:pointer;background:#fff;flex-shrink:0}
.btn-outline:hover{border-color:#1b376c;color:#1b376c;background:#eef4fb}
.btn-cta{display:inline-flex;align-items:center;gap:8px;padding:13px 28px;border-radius:11px;background:#1b376c;color:#fff;font-size:14px;font-weight:700;cursor:pointer;transition:all .2s;border:none}
.btn-cta:hover{background:#254e99;transform:translateY(-1px);box-shadow:0 8px 24px rgba(27,55,108,.35)}

/* ── SERVICES ────────────────────── */
.svc-sec{padding:100px 0;background:#f5f8fc}
.svc-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:24px}
.svc-card{border-radius:22px;overflow:hidden;background:#fff;border:1.5px solid #dce8f4;cursor:pointer;transition:all .35s cubic-bezier(.22,1,.36,1)}
.svc-card:hover{border-color:#1b376c;transform:translateY(-8px);box-shadow:0 24px 64px rgba(27,55,108,.18)}
.svc-img{height:230px;overflow:hidden;position:relative}
.svc-img img{width:100%;height:100%;transition:transform .7s cubic-bezier(.22,1,.36,1)}
.svc-card:hover .svc-img img{transform:scale(1.07)}
.svc-ov{position:absolute;inset:0;background:linear-gradient(to top,rgba(9,18,38,.88) 0%,rgba(9,18,38,.06) 52%,transparent 100%)}
.svc-num{position:absolute;top:16px;left:18px;z-index:2;font-family:'Merriweather',serif;font-size:13px;font-style:italic;color:rgba(255,255,255,.52);letter-spacing:.04em}
.svc-cnt{position:absolute;bottom:15px;left:18px;z-index:2;font-size:11px;font-weight:600;color:rgba(255,255,255,.72)}
.svc-body{padding:24px 24px 28px}
.svc-ico{width:50px;height:50px;border-radius:14px;background:#eef4fb;border:1px solid #d6e4f7;display:flex;align-items:center;justify-content:center;font-size:24px;margin-bottom:14px;transition:all .3s}
.svc-card:hover .svc-ico{background:#1b376c;transform:scale(1.06)}
.svc-name{font-family:'Merriweather',serif;font-size:24px;font-weight:700;color:#0d1f3c;margin-bottom:8px;letter-spacing:-.2px}
.svc-desc{font-size:14.5px;color:#7a8faa;line-height:1.72;margin-bottom:18px;font-weight:300}
.svc-cta{display:inline-flex;align-items:center;gap:5px;font-size:14px;font-weight:700;color:#1b376c;transition:gap .18s}
.svc-card:hover .svc-cta{gap:10px}

/* ── STATS ───────────────────────── */
.stats-sec{background:#1b376c;padding:76px 0;position:relative;overflow:hidden}
.stats-sec::before{content:'';position:absolute;inset:0;background-image:url('https://img.freepik.com/free-photo/professional-photographer-taking-pictures_23-2151006478.jpg');background-size:cover;background-position:center;opacity:.07}
.stats-row{position:relative;z-index:1;display:grid;grid-template-columns:repeat(4,1fr)}
.stat{text-align:center;padding:0 28px;border-right:1px solid rgba(255,255,255,.12)}
.stat:last-child{border-right:none}
.stat-v{font-family:'Merriweather',serif;font-size:60px;font-weight:900;color:#fff;letter-spacing:-2px;line-height:1;margin-bottom:8px}
.stat-l{font-size:14px;color:rgba(255,255,255,.52);font-weight:300}
.stat-s{font-size:12px;color:rgba(255,255,255,.25);margin-top:4px}

/* ── HOW IT WORKS ────────────────── */
.hiw-sec{padding:100px 0;background:#0f1f3d}
.hiw-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:2px;border-radius:20px;overflow:hidden;background:rgba(255,255,255,.04);margin-top:52px}
.hiw-step{background:rgba(255,255,255,.04);padding:48px 36px;position:relative;overflow:hidden;transition:background .28s}
.hiw-step:hover{background:rgba(255,255,255,.09)}
.hiw-step::before{content:'';position:absolute;top:0;left:0;right:0;height:3px;background:linear-gradient(90deg,#d6e4f7,rgba(255,255,255,.28));transform:scaleX(0);transform-origin:left;transition:transform .4s cubic-bezier(.22,1,.36,1)}
.hiw-step:hover::before{transform:scaleX(1)}
.hiw-n{font-family:'Merriweather',serif;font-size:72px;font-weight:900;color:rgba(255,255,255,.04);line-height:1;margin-bottom:20px}
.hiw-ico{width:52px;height:52px;border-radius:14px;background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.1);display:flex;align-items:center;justify-content:center;font-size:26px;margin-bottom:18px;transition:background .28s}
.hiw-step:hover .hiw-ico{background:rgba(255,255,255,.14)}
.hiw-title{font-family:'Merriweather',serif;font-size:20px;font-weight:700;color:#fff;margin-bottom:10px}
.hiw-desc{font-size:13.5px;color:rgba(255,255,255,.42);line-height:1.78;font-weight:300}

/* ── PROFESSIONALS ───────────────── */
.pros-sec{padding:100px 0;background:#fff}
.pros-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:20px}
.pro-card{border-radius:20px;border:1.5px solid #dce8f4;background:#fff;overflow:hidden;transition:all .32s cubic-bezier(.22,1,.36,1);cursor:pointer}
.pro-card:hover{border-color:#1b376c;transform:translateY(-6px);box-shadow:0 20px 56px rgba(27,55,108,.18)}
.pro-ban{height:96px;overflow:hidden;position:relative}
.pro-ban img{width:100%;height:100%;transition:transform .6s}
.pro-card:hover .pro-ban img{transform:scale(1.06)}
.pro-ban-ov{position:absolute;inset:0;background:linear-gradient(135deg,#0f1f3d,#1b376c)}
.pro-avwrap{padding:0 18px;position:relative}
.pro-av{width:56px;height:56px;border-radius:50%;overflow:hidden;border:3px solid #fff;margin-top:-28px;position:relative;z-index:2;box-shadow:0 4px 14px rgba(27,55,108,.22)}
.pro-av img{width:100%;height:100%;object-fit:cover}
.pro-vf{position:absolute;bottom:0;right:-2px;width:19px;height:19px;border-radius:50%;background:#1b376c;border:2px solid #fff;display:flex;align-items:center;justify-content:center;font-size:9px;color:#fff;font-weight:800}
.pro-body{padding:9px 18px 18px}
.pro-name{font-family:'Merriweather',serif;font-size:16px;font-weight:700;color:#0d1f3c;margin-bottom:2px}
.pro-role{font-size:12px;color:#7a8faa;margin-bottom:10px}
.pro-pills{display:flex;gap:5px;flex-wrap:wrap;margin-bottom:11px}
.pro-pill{background:#eef4fb;color:#1b376c;font-size:10.5px;font-weight:700;padding:3px 10px;border-radius:6px;border:1px solid #d6e4f7}
.pro-rating{display:flex;align-items:center;gap:5px;margin-bottom:13px}
.pro-stars{color:#f59e0b;font-size:11.5px;letter-spacing:1.5px}
.pro-rv{font-size:13px;font-weight:700;color:#0d1f3c}
.pro-rc{font-size:11.5px;color:#7a8faa}
.pro-btn{width:100%;background:#1b376c;color:#fff;border-radius:10px;padding:11px;font-size:13px;font-weight:700;font-family:'DM Sans',sans-serif;transition:all .2s;cursor:pointer;border:none}
.pro-btn:hover{background:#254e99;transform:translateY(-1px)}

/* ── TESTIMONIALS ────────────────── */
.testi-sec{padding:100px 0;background:#0f1f3d;position:relative;overflow:hidden}
.testi-sec::after{content:'';position:absolute;top:-200px;right:-200px;width:500px;height:500px;border-radius:50%;background:rgba(255,255,255,.02);pointer-events:none}
.testi-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:22px;margin-top:52px}
.testi-card{background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.09);border-radius:20px;padding:36px;transition:all .28s;position:relative;overflow:hidden}
.testi-card:hover{background:rgba(255,255,255,.09);transform:translateY(-4px)}
.testi-card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:linear-gradient(90deg,rgba(214,228,247,.65),transparent);transform:scaleX(0);transform-origin:left;transition:transform .45s cubic-bezier(.22,1,.36,1)}
.testi-card:hover::before{transform:scaleX(1)}
.tq{font-family:'Merriweather',serif;font-size:64px;font-weight:900;color:rgba(255,255,255,.06);line-height:.8;margin-bottom:16px}
.tstars{color:#f59e0b;font-size:12.5px;letter-spacing:2px;margin-bottom:16px;display:block}
.ttxt{font-size:15px;color:rgba(255,255,255,.62);line-height:1.82;margin-bottom:28px;font-weight:300;font-style:italic}
.tfoot{display:flex;align-items:center;gap:14px;padding-top:22px;border-top:1px solid rgba(255,255,255,.08)}
.tav{width:46px;height:46px;border-radius:50%;overflow:hidden;flex-shrink:0;border:1.5px solid rgba(255,255,255,.14)}
.tav img{width:100%;height:100%;object-fit:cover}
.tname{font-size:13.5px;font-weight:600;color:#fff;margin-bottom:2px}
.trole{font-size:11px;color:rgba(255,255,255,.35)}

/* ── APP DOWNLOAD ────────────────── */
.app-sec{padding:100px 0;background:#f5f8fc}
.app-inner{display:grid;grid-template-columns:1fr 440px;gap:80px;align-items:center}
.app-feats{display:flex;gap:10px;flex-wrap:wrap;margin-bottom:32px}
.app-feat{display:flex;align-items:center;gap:7px;background:#fff;border:1.5px solid #dce8f4;border-radius:100px;padding:7px 16px;font-size:12.5px;font-weight:500;color:#3a4f6e}
.app-fdot{width:7px;height:7px;border-radius:50%;background:#1b376c;flex-shrink:0}
.store-row{display:flex;gap:14px;flex-wrap:wrap;margin-bottom:22px}
.store-btn{display:flex;align-items:center;gap:12px;padding:13px 22px;border-radius:13px;background:#1b376c;color:#fff;cursor:pointer;transition:all .2s;border:none;font-family:'DM Sans',sans-serif;box-shadow:0 4px 18px rgba(27,55,108,.32)}
.store-btn:hover{background:#254e99;transform:translateY(-2px);box-shadow:0 8px 28px rgba(27,55,108,.42)}
.store-btn svg{width:24px;height:24px;flex-shrink:0}
.store-btn-t small{display:block;font-size:9px;letter-spacing:.08em;text-transform:uppercase;opacity:.65;margin-bottom:2px}
.store-btn-t span{font-size:16px;font-weight:700;display:block}
.qr-row{display:flex;align-items:center;gap:14px}
.qr-box{width:68px;height:68px;border-radius:12px;background:#fff;border:1.5px solid #dce8f4;display:flex;align-items:center;justify-content:center;padding:7px}
.qr-box svg{width:100%;height:100%}
.qr-txt{font-size:12.5px;color:#7a8faa;line-height:1.55;max-width:200px}
/* Big phone */
.big-phone{width:268px;height:546px;border-radius:40px;background:#0a0f1e;box-shadow:0 0 0 9px #161d32,0 0 0 11px #1e2540,0 52px 88px rgba(0,0,0,.55);overflow:hidden;position:relative}
.bp-screen{width:100%;height:100%;background:linear-gradient(160deg,#1b376c 0%,#0f1f3d 55%,#030810 100%);border-radius:40px;overflow:hidden;position:relative}
.bp-notch{position:absolute;top:0;left:50%;transform:translateX(-50%);width:96px;height:28px;background:#0a0f1e;border-radius:0 0 20px 20px;z-index:10}
.bpc{padding:40px 17px 0;position:relative;z-index:1}
.bphdr{display:flex;justify-content:space-between;align-items:center;margin-bottom:16px}
.bplogo{font-family:'Merriweather',serif;font-size:16px;font-weight:700;color:#fff}
.bplogo em{color:rgba(255,255,255,.3);font-style:italic}
.bpav{width:28px;height:28px;border-radius:50%;overflow:hidden;border:2px solid rgba(255,255,255,.2)}
.bpav img{width:100%;height:100%;object-fit:cover}
.bpw{font-size:10px;color:rgba(255,255,255,.35);margin-bottom:2px;font-weight:300}
.bpname{font-family:'Merriweather',serif;font-size:16px;font-weight:700;color:#fff;margin-bottom:12px}
/* Booking card */
.bpbook{background:rgba(255,255,255,.09);border:1px solid rgba(255,255,255,.11);border-radius:15px;padding:13px;margin-bottom:13px}
.bpbt{display:flex;justify-content:space-between;align-items:flex-start;margin-bottom:9px}
.bpbtitle{font-size:11px;font-weight:600;color:#fff;margin-bottom:1px}
.bpbsub{font-size:9px;color:rgba(255,255,255,.35)}
.bpstatus{padding:3px 9px;border-radius:5px;font-size:8px;font-weight:700;text-transform:uppercase;background:rgba(74,222,128,.12);color:#4ade80}
.bpbpro{display:flex;align-items:center;gap:8px}
.bpbpav{width:24px;height:24px;border-radius:50%;overflow:hidden;border:1.5px solid rgba(255,255,255,.15)}
.bpbpav img{width:100%;height:100%;object-fit:cover}
.bpbpn{font-size:9.5px;font-weight:600;color:rgba(255,255,255,.75)}
.bpbpr{font-size:8.5px;color:rgba(255,255,255,.32)}
.bpamt{margin-left:auto;font-family:'Merriweather',serif;font-size:12px;font-weight:700;color:#fff}
/* Tabs */
.bptabs{display:flex;gap:5px;margin-bottom:10px}
.bptab{flex:1;padding:6px 0;text-align:center;font-size:9px;font-weight:600;border-radius:9px}
.bptab.on{background:rgba(255,255,255,.12);color:#fff}
.bptab.off{color:rgba(255,255,255,.28)}
/* Mini pros */
.bppros{display:flex;flex-direction:column;gap:7px}
.bppc{display:flex;align-items:center;gap:7px;background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.07);border-radius:11px;padding:9px 10px}
.bppcav{width:30px;height:30px;border-radius:50%;overflow:hidden;border:1.5px solid rgba(255,255,255,.14)}
.bppcav img{width:100%;height:100%;object-fit:cover}
.bppcn{font-size:10px;font-weight:600;color:#fff;margin-bottom:1px}
.bppcr{font-size:8.5px;color:rgba(255,255,255,.3)}
.bppcrate{margin-left:auto;font-family:'Merriweather',serif;font-size:11px;font-weight:700;color:#fff}
.bppcst{font-size:8px;color:#f59e0b;letter-spacing:1px}
.bp-nav{position:absolute;bottom:0;left:0;right:0;background:rgba(3,8,18,.96);backdrop-filter:blur(12px);border-top:1px solid rgba(255,255,255,.07);display:flex;justify-content:space-around;padding:8px 0 16px}
.bpni{display:flex;flex-direction:column;align-items:center;gap:3px;font-size:8px;color:rgba(255,255,255,.28);font-weight:500}
.bpni.on{color:rgba(255,255,255,.9)}
.bpnic{width:30px;height:20px;display:flex;align-items:center;justify-content:center;font-size:14px}

/* ── FOOTER ──────────────────────── */
.footer{background:#0f1f3d;padding:68px 0 0}
.ftop{display:grid;grid-template-columns:2.2fr 1fr 1fr 1fr;gap:48px;padding-bottom:48px;border-bottom:1px solid rgba(255,255,255,.07)}
.flogo{font-family:'Merriweather',serif;font-size:21px;margin-bottom:15px;display:flex;align-items:baseline;gap:1px}
.fl1{color:#fff;font-weight:700}.fl2{color:rgba(255,255,255,.32);font-style:italic}.fl3{color:rgba(255,255,255,.58);font-weight:400}
.fdesc{font-size:13px;color:rgba(255,255,255,.3);line-height:1.82;max-width:240px;margin-bottom:22px;font-weight:300}
.fsrow{display:flex;gap:8px}
.fsoc{width:36px;height:36px;border-radius:9px;background:rgba(255,255,255,.06);border:1px solid rgba(255,255,255,.09);display:flex;align-items:center;justify-content:center;font-size:14px;cursor:pointer;transition:all .18s}
.fsoc:hover{background:rgba(255,255,255,.12)}
.fcol h4{font-size:10px;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:rgba(255,255,255,.26);margin-bottom:17px}
.fl{font-size:13px;color:rgba(255,255,255,.38);margin-bottom:10px;cursor:pointer;transition:color .18s;font-weight:400;display:block}
.fl:hover{color:rgba(255,255,255,.78)}
.fbot{padding:20px 0;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:10px}
.fcopy{font-size:12px;color:rgba(255,255,255,.2)}
.fbdgs{display:flex;gap:12px}
.fbdg{font-size:11px;color:rgba(255,255,255,.2);display:flex;align-items:center;gap:4px}

/* ── MODAL ───────────────────────── */
.mov{position:fixed;inset:0;z-index:800;background:rgba(9,18,38,.88);backdrop-filter:blur(18px);display:none;align-items:flex-start;justify-content:center;padding:60px 20px;overflow-y:auto}
.mov.open{display:flex}
.modal{background:#fff;border-radius:24px;width:100%;max-width:460px;padding:48px;position:relative;box-shadow:0 40px 100px rgba(0,0,0,.5);animation:mia .35s cubic-bezier(.22,1,.36,1) both;flex-shrink:0}
@keyframes mia{from{opacity:0;transform:translateY(22px) scale(.97)}to{opacity:1;transform:none}}
.mclose{position:absolute;top:18px;right:18px;width:36px;height:36px;border-radius:50%;background:#f5f8fc;border:none;cursor:pointer;font-size:18px;color:#7a8faa;display:flex;align-items:center;justify-content:center;transition:all .18s}
.mclose:hover{background:#d6e4f7;color:#1b376c}
.mst{display:none}
.mst.show{display:block;animation:mia .28s cubic-bezier(.22,1,.36,1) both}
.meye{font-size:11.5px;font-weight:600;letter-spacing:.1em;text-transform:uppercase;color:#7a8faa;margin-bottom:6px}
.mtitle{font-family:'Merriweather',serif;font-size:26px;font-weight:700;color:#0d1f3c;margin-bottom:5px;letter-spacing:-.3px}
.msub{font-size:13.5px;color:#7a8faa;margin-bottom:26px;line-height:1.65;font-weight:300}
.gbtn{width:100%;padding:13px 20px;background:#fff;border:1.5px solid #dce8f4;border-radius:12px;cursor:pointer;display:flex;align-items:center;justify-content:center;gap:12px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:500;color:#0d1f3c;transition:all .2s;margin-bottom:10px}
.gbtn:hover{border-color:#4285f4;box-shadow:0 4px 18px rgba(66,133,244,.15);transform:translateY(-1px)}
.gdiv{display:flex;align-items:center;gap:14px;margin:15px 0}
.gdiv::before,.gdiv::after{content:'';flex:1;height:1px;background:#dce8f4}
.gdiv span{font-size:11px;color:#7a8faa;letter-spacing:.06em}
.mf{margin-bottom:13px}
.ml{display:block;font-size:10px;font-weight:700;color:#3a4f6e;letter-spacing:.1em;text-transform:uppercase;margin-bottom:6px}
.mi{width:100%;padding:12px 15px;font-family:'DM Sans',sans-serif;font-size:14px;color:#0d1f3c;background:#fff;border:1.5px solid #dce8f4;border-radius:11px;outline:none;transition:border-color .2s,box-shadow .2s;-webkit-appearance:none}
.mi:focus{border-color:#1b376c;box-shadow:0 0 0 3px rgba(27,55,108,.1)}
.mi::placeholder{color:#7a8faa;font-weight:300}
.mbtn{width:100%;padding:14px;background:#1b376c;color:#fff;border:none;border-radius:11px;font-family:'DM Sans',sans-serif;font-size:14px;font-weight:700;cursor:pointer;transition:all .2s;margin-top:5px}
.mbtn:hover{background:#254e99;transform:translateY(-1px);box-shadow:0 6px 20px rgba(27,55,108,.3)}
.mfooter{text-align:center;margin-top:15px;font-size:12.5px;color:#7a8faa}
.mfooter a{color:#1b376c;font-weight:600;cursor:pointer}
.modal-err{background:#fef2f2;border:1px solid #fecaca;color:#dc2626;padding:12px 16px;border-radius:8px;font-size:14px;margin-bottom:20px;display:none}
.modal-err.show{display:block}

/* ── REVEAL ──────────────────────── */
.reveal{opacity:0;transform:translateY(26px);transition:opacity .7s cubic-bezier(.22,1,.36,1),transform .7s cubic-bezier(.22,1,.36,1)}
.reveal.in{opacity:1;transform:none}
.d1{transition-delay:.07s}.d2{transition-delay:.14s}.d3{transition-delay:.21s}.d4{transition-delay:.28s}

/* ── RESPONSIVE ──────────────────── */
@media(max-width:1400px){
  .hero{grid-template-columns:1fr 500px}
  .hero-right{padding:90px 20px}
  .hero-left{padding:72px 28px 72px 48px}
  .phone{width:320px;height:640px}
  .phone-wrap{width:320px}
  .booking-badge{right:-50px}
}
@media(max-width:1200px){
  .hero{grid-template-columns:1fr 440px}
  .phone{width:280px;height:560px}
  .phone-wrap{width:280px}
}
@media(max-width:1100px){
  .hero{grid-template-columns:1fr}
}
@media(max-width:900px){
  .hero-right{display:none}
}
@media(max-width:900px){
  .nav{padding:0 24px}
  .nav-links{display:none}
  .wrap{padding:0 24px}
  .hero-left{padding:60px 24px}
  .hero-h1{font-size:clamp(36px,5vw,56px)}
  .search-box{flex-wrap:wrap}
  .search-sel{width:100%;padding:12px}
  .search-sep{display:none}
  .svc-grid{grid-template-columns:1fr}
  .hiw-grid{grid-template-columns:1fr}
  .testi-grid{grid-template-columns:1fr}
  .pros-grid{grid-template-columns:repeat(2,1fr)}
  .stats-row{grid-template-columns:repeat(2,1fr);gap:32px}.stat{border-right:none}
  .app-inner{grid-template-columns:1fr}.app-sec .big-phone{display:none}
  .ftop{grid-template-columns:1fr 1fr;gap:30px}
}
@media(max-width:600px){
  .nav{height:58px}
  .logo{font-size:18px;margin-right:16px}
  .nav-end{gap:6px}
  .btn-ghost,.btn-primary{padding:8px 14px;font-size:12px}
  .hero{min-height:auto;padding-top:58px;padding-bottom:40px}
  .hero-left{padding:40px 20px}
  .hero-h1{font-size:clamp(28px,6vw,42px)}
  .hero-sub{font-size:14px}
  .badge{padding:6px 12px;font-size:10px}
  .trending{gap:6px}
  .tr-tag{padding:4px 10px;font-size:11px}
  .sec-row{flex-direction:column;align-items:flex-start;gap:20px}
  .s-h2{font-size:clamp(24px,4vw,36px)}
  .svc-body{padding:16px}
  .stats-row{grid-template-columns:1fr 1fr;gap:20px}
  .stat{padding:16px 0}
  .stat-v{font-size:36px}
  .hiw-step{padding:24px 20px}
  .hiw-n{font-size:48px}
  .hiw-title{font-size:18px}
  .pro-card{border-radius:14px}
  .pro-body{padding:12px}
  .pro-name{font-size:14px}
  .pro-btn{padding:8px}
  .testi-card{padding:20px;border-radius:14px}
  .testi-grid{grid-template-columns:1fr}
  .app-inner{grid-template-columns:1fr}
  .app-sec .big-phone{display:none}
  .app-feats{flex-wrap:wrap}
  .store-row{flex-direction:column}
  .qr-row{flex-direction:column;gap:12px}
  .ftop{grid-template-columns:1fr;gap:24px}
  .fbot{flex-direction:column;gap:12px;text-align:center}
  .modal{padding:24px;margin:16px;max-width:100%}
  .meye{font-size:10px}
  .mtitle{font-size:22px}
  .msub{font-size:13px}
  .mi{padding:10px 12px;font-size:14px}
  .mbtn{padding:12px;font-size:14px}
}
@media(max-width:400px){
  .hero-h1{font-size:clamp(24px,6vw,36px)}
  .hero-sub{font-size:13px}
  .pros-grid{grid-template-columns:1fr}
  .stats-row{grid-template-columns:1fr}
  .stat-v{font-size:28px}
  .btn-cta,.btn-outline{width:100%;text-align:center;justify-content:center}
}
.app{opacity:0;transition:opacity 1s .8s}
.app.visible{opacity:1}
</style>
</head>
<body>

<!-- CINEMATIC ENTRANCE -->
<div class="entrance" id="entrance">
  <div class="entrance-content">
    <div class="entrance-logo">ProQik</div>
    <div class="entrance-line"></div>
    <h1>Your vision,<br/><em>perfectly captured.</em></h1>
  </div>
</div>

<!-- MAIN APP -->
<div class="app" id="app">

<!-- NAV -->
<nav class="nav" id="nav">
  <a class="logo" href="#"><span class="fl1">Pro</span><span class="logo-q">Q</span><span class="logo-ik">ik</span></a>
  <div class="nav-links">
    <span class="nav-a" onclick="smoothTo('services')">Services</span>
    <span class="nav-a" onclick="smoothTo('how')">How It Works</span>
    <span class="nav-a" onclick="smoothTo('pros')">Professionals</span>
    <span class="nav-a" onclick="smoothTo('app')">Get the App</span>
  </div>
  <div class="nav-end">
    <button class="btn-ghost" onclick="openModal('signin')">Sign In</button>
    <button class="btn-primary" onclick="openModal('signup')">Get Started Free</button>
  </div>
</nav>

<!-- HERO -->
<section class="hero">
  <div class="hero-bg-photo"><img src="https://img.freepik.com/free-photo/professional-photographer-taking-pictures-wedding-ceremony_23-2151006478.jpg" alt=""/></div>
  <div class="hero-bg-overlay"></div>
  <div class="hero-bg-grid"></div>
  <div class="hero-left">
    <div class="badge"><span class="dot-green"></span>152 Professionals Active Right Now · India</div>
    <h1 class="hero-h1">
      <em>Your vision, perfectly</em>
      <strong>captured on camera.</strong>
    </h1>
    <p class="hero-sub">ProQik connects clients with India's most talented photographers, videographers and album editors. Real professionals, instant bookings, exceptional results — guaranteed.</p>
    <div class="search-box">
      <input class="search-input" type="text" placeholder="Search by city, style or name…"/>
      <div class="search-sep"></div>
      <select class="search-sel">
        <option value="">All Services</option>
        <option>Photography</option>
        <option>Videography</option>
        <option>Album Editor</option>
      </select>
      <button class="search-go" onclick="openModal('signup')">
        <svg width="14" height="14" viewBox="0 0 20 20" fill="none"><circle cx="9" cy="9" r="5.5" stroke="white" stroke-width="1.6"/><path d="M13.5 13.5L17 17" stroke="white" stroke-width="1.8" stroke-linecap="round"/></svg>
        Search
      </button>
    </div>
    <div class="trending">
      <span class="tr-lbl">Trending:</span>
      <span class="tr-tag" onclick="openModal('signup')">Portrait sessions</span>
      <span class="tr-tag" onclick="openModal('signup')">Corporate events</span>
      <span class="tr-tag" onclick="openModal('signup')">Aerial drone</span>
      <span class="tr-tag" onclick="openModal('signup')">Album design</span>
      <span class="tr-tag" onclick="openModal('signup')">Fashion shoots</span>
    </div>
  </div>
  <div class="hero-right">
    <div class="phone-wrap">
      <div class="phone">
        <div class="pscreen">
          <div class="pnotch"></div>
          <div class="pstatus"><span>9:41</span><span>●●● 5G ▌</span></div>
          <div class="pc">
            <div class="pbar">
              <div class="plogo">Pro<em>Q</em>ik</div>
              <div class="pbellwrap">🔔<span class="preddot"></span></div>
            </div>
            <div class="pwelc">Good morning,</div>
            <div class="pusername">Arjun 👋</div>
            <div class="psearch"><span>🔍</span><span>Find your perfect pro…</span></div>
<div class="psect">Services</div>
              <div class="psvcrow">
              <div class="psvc"><img src="https://images.unsplash.com/photo-1554080353-a576cf803bda?w=900&q=85" alt=""/><div class="psvcov"></div><div class="psvcl">Photography</div></div>
              <div class="psvc"><img src="<%= request.getContextPath() %>/images/videography.jpg" alt=""/><div class="psvcov"></div><div class="psvcl">Videography</div></div>
              <div class="psvc"><img src="<%= request.getContextPath() %>/images/album-editor.jpg" alt=""/><div class="psvcov"></div><div class="psvcl">Album Editor</div></div>
            </div>
            <div class="psect">Top Rated Near You</div>
            <div class="ppro">
              <div class="ppav"><img src="https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=80" alt=""/></div>
              <div><div class="ppn">Ravi Kumar</div><div class="ppr">Photographer · Mumbai</div><div class="ppst">★★★★★</div></div>
              <div class="pprate">₹2,500</div>
            </div>
            <div class="ppro">
              <div class="ppav"><img src="https://img.freepik.com/free-photo/young-indian-woman-with-beautiful-smile_23-2148956428.jpg?w=80" alt=""/></div>
              <div><div class="ppn">Kavya Sharma</div><div class="ppr">Photographer · Delhi</div><div class="ppst">★★★★★</div></div>
              <div class="pprate">₹1,800</div>
            </div>
          </div>
          <div class="pnav">
            <div class="pni on"><div class="pnic">🏠</div>Home</div>
            <div class="pni"><div class="pnic">🔍</div>Explore</div>
            <div class="pni"><div class="pnic">📅</div>Book</div>
            <div class="pni"><div class="pnic">💬</div>Chat</div>
            <div class="pni"><div class="pnic">👤</div>Me</div>
          </div>
        </div>
      </div>
      <div class="booking-badge">
        <div class="bbico">📷</div>
        <div><div class="bbtxt">Kavya just accepted a booking</div><div class="bbsub">Portrait session · Delhi</div></div>
        <div class="bbdot"></div>
      </div>
    </div>
  </div>
</section>

<!-- TICKER -->
<div class="ticker">
  <div class="ttrack">
    <div class="ti"><span class="tidot"></span>India's <b>#1</b> Creative Platform</div>
    <div class="ti"><span class="tidot"></span><b>152+</b> Verified Professionals</div>
    <div class="ti"><span class="tidot"></span><b>1,284</b> Successful Bookings</div>
    <div class="ti"><span class="tidot"></span><b>4.91</b> Average Rating</div>
    <div class="ti"><span class="tidot"></span>Secure &amp; Instant Payments</div>
    <div class="ti"><span class="tidot"></span>Verified in <b>24 Hours</b></div>
    <div class="ti"><span class="tidot"></span>India's <b>#1</b> Creative Platform</div>
    <div class="ti"><span class="tidot"></span><b>152+</b> Verified Professionals</div>
    <div class="ti"><span class="tidot"></span><b>1,284</b> Successful Bookings</div>
    <div class="ti"><span class="tidot"></span><b>4.91</b> Average Rating</div>
    <div class="ti"><span class="tidot"></span>Secure &amp; Instant Payments</div>
    <div class="ti"><span class="tidot"></span>Verified in <b>24 Hours</b></div>
  </div>
</div>

<!-- SERVICES -->
<section class="svc-sec" id="services">
  <div class="wrap">
    <div class="sec-row">
      <div>
        <div class="s-eye reveal">What we offer</div>
        <h2 class="s-h2 reveal d1">Three services.<br><span class="b">Endless possibilities.</span></h2>
        <p class="s-sub reveal d2">Professional Photography, Videography and Album Editing — all in one platform. Hire in minutes, get stunning results every time.</p>
      </div>
      <button class="btn-cta reveal d3" onclick="openModal('signup')">Join for free →</button>
    </div>
    <div class="svc-grid">
      <div class="svc-card reveal d1" onclick="openModal('signup')">
        <div class="svc-img"><img src="https://images.unsplash.com/photo-1554080353-a576cf803bda?w=900&q=85" alt="Photography"/><div class="svc-ov"></div><div class="svc-num">01</div><div class="svc-cnt">68 active professionals</div></div>
        <div class="svc-body"><div class="svc-ico">📷</div><div class="svc-name">Photography</div><div class="svc-desc">Portrait, fashion, corporate, real estate, products and aerial. India's best photographers ready to book instantly.</div><div class="svc-cta">Browse photographers <svg width="13" height="13" viewBox="0 0 16 16" fill="none"><path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg></div></div>
      </div>
      <div class="svc-card reveal d2" onclick="openModal('signup')">
        <div class="svc-img"><img src="<%= request.getContextPath() %>/images/videography.jpg" alt="Videography"/><div class="svc-ov"></div><div class="svc-num">02</div><div class="svc-cnt">54 active professionals</div></div>
        <div class="svc-body"><div class="svc-ico">🎬</div><div class="svc-name">Videography</div><div class="svc-desc">Cinematic films, corporate reels, music videos, aerial drone, documentaries and social content creation.</div><div class="svc-cta">Browse videographers <svg width="13" height="13" viewBox="0 0 16 16" fill="none"><path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg></div></div>
      </div>
      <div class="svc-card reveal d3" onclick="openModal('signup')">
        <div class="svc-img"><img src="<%= request.getContextPath() %>/images/album-editor.jpg" alt="Album Editor"/><div class="svc-ov"></div><div class="svc-num">03</div><div class="svc-cnt">30 active professionals</div></div>
        <div class="svc-body"><div class="svc-ico">🎞</div><div class="svc-name">Album Editor</div><div class="svc-desc">Retouching, color grading, video editing, album design, motion graphics and complete post-production.</div><div class="svc-cta">Browse editors <svg width="13" height="13" viewBox="0 0 16 16" fill="none"><path d="M3 8h10M9 4l4 4-4 4" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg></div></div>
      </div>
    </div>
  </div>
</section>

<!-- STATS -->
<div class="stats-sec">
  <div class="wrap">
    <div class="stats-row">
      <div class="stat reveal d1"><div class="stat-v">152+</div><div class="stat-l">Verified Professionals</div><div class="stat-s">Across India</div></div>
      <div class="stat reveal d2"><div class="stat-v">1,284</div><div class="stat-l">Successful Bookings</div><div class="stat-s">This year alone</div></div>
      <div class="stat reveal d3"><div class="stat-v">4.91</div><div class="stat-l">Average Rating</div><div class="stat-s">Out of 5.0</div></div>
      <div class="stat reveal d4"><div class="stat-v">₹48K</div><div class="stat-l">Paid to Pros</div><div class="stat-s">This month</div></div>
    </div>
  </div>
</div>

<!-- HOW IT WORKS -->
<section class="hiw-sec" id="how">
  <div class="wrap">
    <div class="s-eye reveal" style="color:rgba(255,255,255,.38)">Simple process</div>
    <h2 class="s-h2 reveal d1" style="color:#fff">How <em style="color:rgba(255,255,255,.38)">ProQik</em> works</h2>
    <div class="hiw-grid">
      <div class="hiw-step reveal d1"><div class="hiw-n">01</div><div class="hiw-ico">🔍</div><div class="hiw-title">Discover Talent</div><div class="hiw-desc">Browse real portfolios from verified photographers, videographers and editors across India. Filter by city, style and budget — find your match in minutes.</div></div>
      <div class="hiw-step reveal d2"><div class="hiw-n">02</div><div class="hiw-ico">📲</div><div class="hiw-title">Book via the App</div><div class="hiw-desc">Download the ProQik app, message professionals directly, choose packages and confirm your booking with secure payment. Real-time notifications keep you in the loop.</div></div>
      <div class="hiw-step reveal d3"><div class="hiw-n">03</div><div class="hiw-ico">✅</div><div class="hiw-title">Receive &amp; Review</div><div class="hiw-desc">Your pro delivers work through the app. Review, request changes, approve and pay — all in one place. Rate your experience and help the community thrive.</div></div>
    </div>
  </div>
</section>

<!-- PROFESSIONALS -->
<section class="pros-sec" id="pros">
  <div class="wrap">
    <div class="sec-row">
      <div>
        <div class="s-eye reveal">Real people, real talent</div>
        <h2 class="s-h2 reveal d1">Meet our <span class="b">verified professionals</span></h2>
        <p class="s-sub reveal d2">Every pro on ProQik is verified, rated and trusted by real clients across India.</p>
      </div>
      <button class="btn-outline reveal d3" onclick="openModal('signup')">Browse all pros →</button>
    </div>
    <div class="pros-grid">
      <div class="pro-card reveal d1">
        <div class="pro-ban"><img src="https://img.freepik.com/free-photo/professional-photographer-portrait-session_23-2150935826.jpg" alt=""/><div class="pro-ban-ov"></div></div>
        <div class="pro-avwrap"><div class="pro-av"><img src="https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=120" alt="Ravi Kumar"/></div><div class="pro-vf">✓</div></div>
        <div class="pro-body"><div class="pro-name">Ravi Kumar</div><div class="pro-role">Photographer · Mumbai</div><div class="pro-pills"><span class="pro-pill">Portrait</span><span class="pro-pill">Events</span><span class="pro-pill">Fashion</span></div><div class="pro-rating"><span class="pro-stars">★★★★★</span><span class="pro-rv">4.9</span><span class="pro-rc">(128 reviews)</span></div><button class="pro-btn" onclick="openModal('signup')">View Profile</button></div>
      </div>
      <div class="pro-card reveal d2">
        <div class="pro-ban"><img src="https://img.freepik.com/free-photo/videographer-filming-outdoors_23-2149547654.jpg" alt=""/><div class="pro-ban-ov"></div></div>
        <div class="pro-avwrap"><div class="pro-av"><img src="https://img.freepik.com/free-photo/portrait-young-indian-man-traditional-clothing_23-2151183625.jpg?w=120" alt="Sky Vision"/></div><div class="pro-vf">✓</div></div>
        <div class="pro-body"><div class="pro-name">Sky Vision India</div><div class="pro-role">Videographer · Bangalore</div><div class="pro-pills"><span class="pro-pill">Aerial Drone</span><span class="pro-pill">Cinematic</span></div><div class="pro-rating"><span class="pro-stars">★★★★★</span><span class="pro-rv">5.0</span><span class="pro-rc">(74 reviews)</span></div><button class="pro-btn" onclick="openModal('signup')">View Profile</button></div>
      </div>
      <div class="pro-card reveal d3">
        <div class="pro-ban"><img src="https://img.freepik.com/free-photo/fashion-portrait-young-woman_23-2151283427.jpg" alt=""/><div class="pro-ban-ov"></div></div>
        <div class="pro-avwrap"><div class="pro-av"><img src="https://img.freepik.com/free-photo/young-indian-woman-with-beautiful-smile_23-2148956428.jpg?w=120" alt="Kavya Sharma"/></div><div class="pro-vf">✓</div></div>
        <div class="pro-body"><div class="pro-name">Kavya Sharma</div><div class="pro-role">Photographer · Delhi</div><div class="pro-pills"><span class="pro-pill">Portrait</span><span class="pro-pill">Fashion</span><span class="pro-pill">Editorial</span></div><div class="pro-rating"><span class="pro-stars">★★★★★</span><span class="pro-rv">4.8</span><span class="pro-rc">(52 reviews)</span></div><button class="pro-btn" onclick="openModal('signup')">View Profile</button></div>
      </div>
      <div class="pro-card reveal d4">
        <div class="pro-ban"><img src="https://img.freepik.com/free-photo/photographer-editing-photos-computer_23-2149547640.jpg" alt=""/><div class="pro-ban-ov"></div></div>
        <div class="pro-avwrap"><div class="pro-av"><img src="https://img.freepik.com/free-photo/indian-man-working-laptop_23-2148998889.jpg?w=120" alt="Arjun Mehta"/></div><div class="pro-vf">✓</div></div>
        <div class="pro-body"><div class="pro-name">Arjun Mehta</div><div class="pro-role">Album Editor · Pune</div><div class="pro-pills"><span class="pro-pill">Color Grade</span><span class="pro-pill">Album Design</span></div><div class="pro-rating"><span class="pro-stars">★★★★☆</span><span class="pro-rv">4.7</span><span class="pro-rc">(41 reviews)</span></div><button class="pro-btn" onclick="openModal('signup')">View Profile</button></div>
      </div>
    </div>
  </div>
</section>

<!-- TESTIMONIALS -->
<section class="testi-sec" id="testimonials">
  <div class="wrap">
    <div class="s-eye reveal" style="color:rgba(255,255,255,.36)">Real client stories</div>
    <h2 class="s-h2 reveal d1" style="color:#fff">People <em style="color:rgba(255,255,255,.36)">love</em> ProQik</h2>
    <div class="testi-grid">
      <div class="testi-card reveal d1"><div class="tq">"</div><span class="tstars">★★★★★</span><div class="ttxt">Found the perfect photographer in under 10 minutes. The app made everything seamless — from booking to receiving my final gallery. I tell everyone about ProQik.</div><div class="tfoot"><div class="tav"><img src="https://img.freepik.com/free-photo/smiling-woman-with-hijab-posing_23-2148765051.jpg?w=100" alt=""/></div><div><div class="tname">Priya Verma</div><div class="trole">Portrait client · Mumbai</div></div></div></div>
      <div class="testi-card reveal d2"><div class="tq">"</div><span class="tstars">★★★★★</span><div class="ttxt">The aerial drone footage Sky Vision captured for our product launch was genuinely breathtaking. ProQik connected us with talent we couldn't have found anywhere else in India.</div><div class="tfoot"><div class="tav"><img src="https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=100" alt=""/></div><div><div class="tname">Rahul Kapoor</div><div class="trole">Corporate client · Bangalore</div></div></div></div>
      <div class="testi-card reveal d3"><div class="tq">"</div><span class="tstars">★★★★★</span><div class="ttxt">As a photographer, my bookings tripled in my first month on ProQik. The platform is fast, the clients are quality, and the team genuinely cares about our success.</div><div class="tfoot"><div class="tav"><img src="https://img.freepik.com/free-photo/young-indian-woman-with-beautiful-smile_23-2148956428.jpg?w=100" alt=""/></div><div><div class="tname">Kavya Sharma</div><div class="trole">Photographer · ProQik Pro · Delhi</div></div></div></div>
    </div>
  </div>
</section>

<!-- APP DOWNLOAD -->
<section class="app-sec" id="app">
  <div class="wrap">
    <div class="app-inner">
      <div>
        <div class="s-eye reveal">The ProQik App</div>
        <h2 class="s-h2 reveal d1">Book professionals<br><em>from your phone</em></h2>
        <p class="s-sub reveal d2" style="margin-bottom:28px">The full ProQik experience is on mobile. Browse portfolios, message pros, book, track delivery and pay — all inside one beautifully designed app. No web booking — app only.</p>
        <div class="app-feats reveal d2">
          <div class="app-feat"><span class="app-fdot"></span>Real-time booking</div>
          <div class="app-feat"><span class="app-fdot"></span>In-app messaging</div>
          <div class="app-feat"><span class="app-fdot"></span>Secure payments</div>
          <div class="app-feat"><span class="app-fdot"></span>File delivery</div>
          <div class="app-feat"><span class="app-fdot"></span>Star ratings</div>
        </div>
        <div class="store-row reveal d3">
          <button class="store-btn"><svg viewBox="0 0 24 24" fill="white"><path d="M3 20.5v-17c0-.59.34-1.11.84-1.35L13.69 12l-9.85 9.85c-.5-.24-.84-.76-.84-1.35zm13.81-5.38L6.05 21.34l8.49-8.49 2.27 2.27zm3.35-4.31c.34.27.59.69.59 1.19s-.22.9-.57 1.18l-2.29 1.32-2.5-2.5 2.5-2.5 2.27 1.31zM6.05 2.66l11.76 6.22-2.27 2.27L6.05 2.66z"/></svg><div class="store-btn-t"><small>Get it on</small><span>Google Play</span></div></button>
          <button class="store-btn"><svg viewBox="0 0 24 24" fill="white"><path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98-.09.06-2.17 1.28-2.15 3.81.03 3.02 2.65 4.03 2.68 4.04-.03.07-.42 1.44-1.38 2.83M13 3.5c.73-.83 1.21-1.96 1.08-3.11-1.05.05-2.31.72-3.06 1.64-.67.81-1.26 2.11-1.1 3.22 1.17.09 2.36-.59 3.08-1.75z"/></svg><div class="store-btn-t"><small>Download on</small><span>App Store</span></div></button>
        </div>
        <div class="qr-row reveal d4">
          <div class="qr-box"><svg viewBox="0 0 100 100" fill="#1b376c"><rect x="10" y="10" width="30" height="30" rx="2"/><rect x="14" y="14" width="22" height="22" rx="1" fill="white"/><rect x="18" y="18" width="14" height="14" rx="1"/><rect x="60" y="10" width="30" height="30" rx="2"/><rect x="64" y="14" width="22" height="22" rx="1" fill="white"/><rect x="68" y="18" width="14" height="14" rx="1"/><rect x="10" y="60" width="30" height="30" rx="2"/><rect x="14" y="64" width="22" height="22" rx="1" fill="white"/><rect x="18" y="68" width="14" height="14" rx="1"/><rect x="60" y="60" width="8" height="8"/><rect x="72" y="60" width="8" height="8"/><rect x="60" y="72" width="8" height="8"/><rect x="72" y="72" width="18" height="18" rx="2"/><rect x="44" y="10" width="8" height="8"/><rect x="44" y="22" width="8" height="8"/><rect x="44" y="34" width="8" height="8"/><rect x="10" y="44" width="8" height="8"/><rect x="22" y="44" width="8" height="8"/><rect x="34" y="44" width="8" height="8"/></svg></div>
          <div class="qr-txt">Scan to download the ProQik app instantly on iOS or Android</div>
        </div>
      </div>
      <div style="display:flex;align-items:center;justify-content:center">
        <div class="big-phone">
          <div class="bp-screen">
            <div class="bp-notch"></div>
            <div class="bpc">
              <div class="bphdr"><div class="bplogo">Pro<em>Q</em>ik</div><div class="bpav"><img src="https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=60" alt=""/></div></div>
              <div class="bpw">Good afternoon,</div>
              <div class="bpname">Arjun 👋</div>
              <div class="bpbook">
                <div class="bpbt"><div><div class="bpbtitle">Corporate Event Shoot</div><div class="bpbsub">Tomorrow · 10:00 AM · Bandra, Mumbai</div></div><span class="bpstatus">Confirmed</span></div>
                <div class="bpbpro"><div class="bpbpav"><img src="https://img.freepik.com/free-photo/handsome-confident-smiling-man-with-hands-crossed-chest_176420-18743.jpg?w=60" alt="Ravi"/></div><div><div class="bpbpn">Ravi Kumar</div><div class="bpbpr">Photographer</div></div><div class="bpamt">₹2,500</div></div>
              </div>
              <div class="bptabs"><div class="bptab on">Photography</div><div class="bptab off">Videography</div><div class="bptab off">Album</div></div>
              <div class="bppros">
                <div class="bppc"><div class="bppcav"><img src="https://img.freepik.com/free-photo/young-indian-woman-with-beautiful-smile_23-2148956428.jpg?w=60" alt="Kavya"/></div><div><div class="bppcn">Kavya Sharma</div><div class="bppcr">Portrait · Delhi</div><div class="bppcst">★★★★★</div></div><div class="bppcrate">₹1,800</div></div>
                <div class="bppc"><div class="bppcav"><img src="https://img.freepik.com/free-photo/portrait-young-indian-man-traditional-clothing_23-2151183625.jpg?w=60" alt="Sky"/></div><div><div class="bppcn">Sky Vision India</div><div class="bppcr">Aerial · Bangalore</div><div class="bppcst">★★★★★</div></div><div class="bppcrate">₹3,200</div></div>
              </div>
            </div>
            <div class="bp-nav">
              <div class="bpni"><div class="bpnic">🏠</div>Home</div>
              <div class="bpni"><div class="bpnic">🔍</div>Explore</div>
              <div class="bpni on"><div class="bpnic">📅</div>Bookings</div>
              <div class="bpni"><div class="bpnic">💬</div>Chat</div>
              <div class="bpni"><div class="bpnic">👤</div>Profile</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- FOOTER -->
<footer class="footer">
  <div class="wrap">
    <div class="ftop">
      <div>
        <div class="flogo"><span class="fl1">Pro</span><span class="fl2">Q</span><span class="fl3">ik</span></div>
        <div class="fdesc">India's premier platform for Photography, Videography and Album Editing. Fast, verified and trusted by thousands.</div>
        <div class="fsrow"><div class="fsoc">📸</div><div class="fsoc">🎬</div><div class="fsoc">𝕏</div><div class="fsoc">▶</div></div>
      </div>
      <div class="fcol"><h4>Services</h4><span class="fl">Photography</span><span class="fl">Videography</span><span class="fl">Album Editor</span><span class="fl">Aerial Drone</span></div>
      <div class="fcol"><h4>Company</h4><span class="fl">About ProQik</span><span class="fl">Careers</span><span class="fl">Blog</span><span class="fl">Press</span></div>
      <div class="fcol"><h4>Support</h4><span class="fl">Help Centre</span><span class="fl">Privacy Policy</span><span class="fl">Terms of Service</span><span class="fl">Contact Us</span></div>
    </div>
    <div class="fbot">
      <div class="fcopy">© 2025 ProQik. All rights reserved. Made with love in India.</div>
      <div class="fbdgs"><span class="fbdg">🔒 Secure</span><span class="fbdg">✅ Verified</span><span class="fbdg">📍 India-based</span></div>
    </div>
  </div>
</footer>

</div> <!-- END MAIN APP -->

<!-- MODAL -->
<div class="mov" id="mov" onclick="ovClick(event)">
  <div class="modal" id="mbox">
    <button class="mclose" onclick="closeModal()">✕</button>

    <!-- SIGN UP -->
    <div class="mst show" id="stSignup">
      <div class="meye">Create your account</div>
      <div class="mtitle">Join ProQik</div>
      <div class="msub">Sign up free and discover India's best photographers, videographers and editors.</div>
      <div class="modal-err" id="signupErr"></div>
      <form id="signupForm" method="POST" action="<%= request.getContextPath() %>/signup">
        <input type="hidden" name="action" value="register"/>
        <div class="mf"><label class="ml">Full name</label><input class="mi" type="text" name="fullName" placeholder="Your full name" required/></div>
        <div class="mf"><label class="ml">Email address</label><input class="mi" type="email" name="email" placeholder="you@example.com" required/></div>
        <div class="mf"><label class="ml">Password</label><input class="mi" type="password" name="password" placeholder="Create a password" required minlength="6"/></div>
        <button type="submit" class="mbtn">Create free account →</button>
      </form>
      <div class="mfooter">Already a member? <a onclick="switchState('signin')">Sign in</a></div>
    </div>

    <!-- SIGN IN -->
    <div class="mst" id="stSignin">
      <div class="meye">Welcome back</div>
      <div class="mtitle">Sign in</div>
      <div class="msub">Good to see you again — let's get you back in.</div>
      <div class="modal-err" id="signinErr"></div>
      <form id="signinForm" method="POST" action="<%= request.getContextPath() %>/login">
        <div class="mf"><label class="ml">Email address</label><input class="mi" type="email" name="email" placeholder="you@example.com" required/></div>
        <div class="mf"><label class="ml">Password</label><input class="mi" type="password" name="password" placeholder="Your password" required/></div>
        <button type="submit" class="mbtn">Sign in →</button>
      </form>
      <div class="mfooter">New to ProQik? <a onclick="switchState('signup')">Create a free account</a></div>
    </div>

  </div>
</div>

<script>
// Entrance animation
document.addEventListener('DOMContentLoaded',function(){
  setTimeout(function(){
    document.getElementById('entrance').classList.add('hidden');
    document.getElementById('app').classList.add('visible');
  },2500);
});

// Nav sticky
window.addEventListener('scroll',function(){document.getElementById('nav').classList.toggle('stuck',window.scrollY>60)});
function smoothTo(id){var el=document.getElementById(id);if(el)el.scrollIntoView({behavior:'smooth',block:'start'})}

// Modal
function openModal(s){document.getElementById('mov').classList.add('open');switchState(s||'signup')}
function closeModal(){document.getElementById('mov').classList.remove('open')}
function ovClick(e){if(e.target===document.getElementById('mov'))closeModal()}
function switchState(s){
  document.querySelectorAll('.mst').forEach(function(el){el.classList.remove('show')});
  var m={signup:'stSignup',signin:'stSignin'};
  var el=document.getElementById(m[s]);
  if(el)el.classList.add('show');
}

// Reveal on scroll
var ro=new IntersectionObserver(function(es){es.forEach(function(e){if(e.isIntersecting)e.target.classList.add('in')})},{threshold:.07});
document.querySelectorAll('.reveal').forEach(function(el){ro.observe(el)});

// Check for error in URL and show modal
var urlParams=new URLSearchParams(window.location.search);
if(urlParams.get('error')==='invalid'){
  openModal('signin');
  document.getElementById('signinErr').textContent='Invalid email or password. Please try again.';
  document.getElementById('signinErr').classList.add('show');
}
if(urlParams.get('error')==='exists'){
  openModal('signup');
  document.getElementById('signupErr').textContent='An account with this email already exists.';
  document.getElementById('signupErr').classList.add('show');
}
if(urlParams.get('error')==='required'){
  openModal('signup');
  document.getElementById('signupErr').textContent='All fields are required.';
  document.getElementById('signupErr').classList.add('show');
}
</script>
</body>
</html>