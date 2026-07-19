<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProQik — Download App</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=DM+Serif+Display&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --navy: #1b376c;
            --navy-deep: #122855;
            --navy-darker: #0a162e;
            --navy-light: #2a4d8f;
            --gold: #c9a84c;
            --gold-light: #d4b47a;
            --gold-glow: #e8c97a;
            --gold-pale: #f5edd6;
            --ink: #15233f;
            --text: #4a5578;
            --muted: #8b96b0;
            --white: #ffffff;
            --ivory: #faf8f3;
            --font-display: 'DM Serif Display', serif;
            --font-body: 'Inter', sans-serif;
            --font-alt: 'DM Sans', sans-serif;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        html { scroll-behavior: smooth; }

        body {
            font-family: var(--font-body);
            background: linear-gradient(180deg, var(--navy) 0%, var(--navy-deep) 100%);
            color: var(--white);
            line-height: 1.5;
            overflow-x: hidden;
            min-height: 100vh;
        }

        a { text-decoration: none; color: inherit; }
        img { max-width: 100%; height: auto; display: block; }
        
        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* Header */
        header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 100;
            padding: 16px 0;
            background: rgba(27,55,108,0.95);
            backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(201,168,76,0.15);
        }

        .header-inner {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            font-family: var(--font-display);
            font-size: 24px;
            color: var(--white);
        }
        .logo span { color: var(--gold); }

        .nav-links {
            display: flex;
            gap: 24px;
            align-items: center;
        }

        .nav-link {
            font-size: 13px;
            font-weight: 500;
            color: rgba(255,255,255,0.7);
            transition: color 0.2s;
        }
        .nav-link:hover { color: var(--gold); }

        .btn-app {
            padding: 10px 20px;
            background: var(--gold);
            color: var(--navy-deep);
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .btn-app:hover {
            background: var(--gold-light);
            transform: translateY(-2px);
        }

        /* Hero */
        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            padding: 100px 0 60px;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: 
                radial-gradient(ellipse 100% 60% at 30% -20%, rgba(201,168,76,0.15) 0%, transparent 50%),
                radial-gradient(ellipse 60% 50% at 80% 120%, rgba(18,40,85,0.8) 0%, transparent 50%);
            z-index: 0;
        }

        .hero::after {
            content: '';
            position: absolute;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg width='80' height='80' viewBox='0 0 80 80' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M40 0l40 40-40 40L0 40z' fill='none' stroke='rgba(201,168,76,0.03)' stroke-width='1'/%3E%3C/svg%3E");
            opacity: 0.5;
            z-index: 0;
        }

        .hero-content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
            position: relative;
            z-index: 1;
        }

        .hero-text h1 {
            font-family: var(--font-display);
            font-size: clamp(36px, 5vw, 56px);
            line-height: 1.15;
            margin-bottom: 20px;
        }
        .hero-text h1 span { color: var(--gold); }

        .hero-text p {
            font-size: 16px;
            color: rgba(255,255,255,0.7);
            margin-bottom: 32px;
            max-width: 420px;
        }

        .hero-stats {
            display: flex;
            gap: 40px;
            margin-bottom: 36px;
            padding-bottom: 32px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .stat-num {
            font-family: var(--font-display);
            font-size: 36px;
            color: var(--gold);
        }
        .stat-label {
            font-size: 12px;
            color: rgba(255,255,255,0.5);
            letter-spacing: 0.05em;
        }

        .store-btns {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .store-btn {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 24px;
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.12);
            border-radius: 10px;
            transition: all 0.3s;
        }
        .store-btn:hover {
            background: var(--gold);
            border-color: var(--gold);
            color: var(--navy-deep);
            transform: translateY(-3px);
        }
        .store-btn svg { width: 28px; height: 28px; }
        .store-btn .txt { text-align: left; }
        .store-btn .txt-l { font-size: 10px; opacity: 0.7; text-transform: uppercase; letter-spacing: 0.1em; }
        .store-btn .txt-n { font-size: 16px; font-weight: 600; }

.hero-img {
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .phone-mockup {
            width: 260px;
            height: 520px;
            background: linear-gradient(180deg, #1a2d4a 0%, #0d1a2e 100%);
            border: 3px solid rgba(201,168,76,0.4);
            border-radius: 40px;
            padding: 12px;
            position: relative;
            box-shadow: 
                0 0 0 1px rgba(201,168,76,0.2),
                0 40px 80px rgba(0,0,0,0.5),
                0 0 60px rgba(201,168,76,0.08),
                inset 0 0 40px rgba(201,168,76,0.04);
            display: flex;
            flex-direction: column;
        }

        .phone-side-buttons {
            position: absolute;
            left: -14px;
            top: 100px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .phone-side-btn {
            width: 4px;
            height: 24px;
            background: rgba(201,168,76,0.3);
            border-radius: 2px;
        }

        .phone-side-btn.small {
            height: 16px;
            top: 60px;
        }

        .phone-notch {
            width: 90px;
            height: 22px;
            background: #0d1a2e;
            border-radius: 20px;
            margin: 0 auto 12px;
        }

        .phone-screen {
            flex: 1;
            border-radius: 28px;
            overflow: hidden;
            background: linear-gradient(180deg, #1b376c 0%, #0a1528 100%);
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .phone-screen::before {
            content: '';
            position: absolute;
            inset: 0;
            background: 
                radial-gradient(circle at 20% 20%, rgba(201,168,76,0.06) 0%, transparent 30%),
                radial-gradient(circle at 80% 80%, rgba(201,168,76,0.04) 0%, transparent 30%);
            pointer-events: none;
        }

        .app-header {
            padding: 16px;
            text-align: center;
            background: linear-gradient(180deg, rgba(201,168,76,0.12) 0%, transparent 100%);
            border-bottom: 1px solid rgba(201,168,76,0.08);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .app-logo {
            font-family: var(--font-display);
            font-size: 22px;
            color: var(--gold);
        }

        .app-rating-badge {
            background: var(--gold);
            color: var(--navy-deep);
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
        }

        .app-nav {
            display: flex;
            justify-content: center;
            gap: 10px;
            padding: 12px;
        }

        .app-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: rgba(255,255,255,0.15);
            transition: all 0.3s;
        }
        .app-dot.active { 
            background: var(--gold); 
            box-shadow: 0 0 10px rgba(201,168,76,0.5);
        }

        .app-content {
            padding: 12px;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 10px;
            overflow: hidden;
        }

        .app-card {
            background: rgba(255,255,255,0.04);
            border: 1px solid rgba(201,168,76,0.12);
            border-radius: 12px;
            padding: 12px;
            display: flex;
            align-items: center;
            gap: 12px;
            flex-shrink: 0;
            transition: all 0.3s;
        }

        .app-card:hover {
            background: rgba(201,168,76,0.06);
            border-color: rgba(201,168,76,0.25);
        }

        .app-card-img {
            width: 44px;
            height: 44px;
            border-radius: 10px;
            background: linear-gradient(135deg, rgba(201,168,76,0.15) 0%, rgba(201,168,76,0.03) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            border: 1px solid rgba(201,168,76,0.12);
        }

        .app-card-img svg { 
            width: 20px; 
            height: 20px; 
            stroke: var(--gold); 
        }

        .app-card-info { flex: 1; }
        .app-card-title { font-size: 12px; font-weight: 600; margin-bottom: 2px; }
        .app-card-meta { font-size: 10px; color: var(--gold); }

        /* Services */
        .services {
            padding: 80px 0;
            background: var(--ivory);
            color: var(--navy);
        }

        .section-header {
            text-align: center;
            margin-bottom: 48px;
        }
        .section-header h2 {
            font-family: var(--font-display);
            font-size: clamp(28px, 4vw, 40px);
            margin-bottom: 12px;
        }
        .section-header h2 span { color: var(--gold); }
        .section-header p {
            color: var(--text);
            max-width: 480px;
            margin: 0 auto;
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .service-card {
            border-radius: 16px;
            overflow: hidden;
            background: var(--white);
            box-shadow: 0 8px 32px rgba(27,55,108,0.08);
            transition: transform 0.3s;
        }
        .service-card:hover { transform: translateY(-8px); }

        .service-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }

        .service-card-content {
            padding: 24px;
        }

        .service-card h3 {
            font-family: var(--font-display);
            font-size: 20px;
            margin-bottom: 8px;
        }

        .service-card p {
            font-size: 13px;
            color: var(--muted);
            margin-bottom: 16px;
        }

        .service-card .meta {
            font-size: 12px;
            color: var(--gold);
            font-weight: 500;
        }

        /* Testimonials */
        .testimonials {
            padding: 80px 0;
            background: var(--navy-deep);
        }

        .testimonials-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .testimonial-card {
            background: rgba(255,255,255,0.04);
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 16px;
            padding: 28px;
        }

        .testimonial-card .stars {
            color: var(--gold);
            font-size: 14px;
            letter-spacing: 3px;
            margin-bottom: 16px;
        }

        .testimonial-card .quote {
            font-family: var(--font-display);
            font-size: 18px;
            font-style: italic;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .testimonial-card .author {
            font-size: 13px;
            color: rgba(255,255,255,0.6);
        }

        /* CTA */
        .cta {
            padding: 100px 0;
            text-align: center;
            background: linear-gradient(180deg, var(--navy) 0%, var(--navy-deep) 100%);
            position: relative;
            overflow: hidden;
        }

        .cta::before {
            content: '';
            position: absolute;
            inset: 0;
            background: 
                radial-gradient(ellipse 80% 60% at 50% 0%, rgba(201,168,76,0.12) 0%, transparent 50%),
                radial-gradient(circle at 50% 100%, rgba(201,168,76,0.08) 0%, transparent 40%);
        }

        .cta::after {
            content: '';
            position: absolute;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M30 0l30 30-30 30L0 30z' fill='none' stroke='rgba(201,168,76,0.02)'/%3E%3C/svg%3E");
            opacity: 0.4;
        }

        .cta-content { position: relative; z-index: 1; }

        .cta h2 {
            font-family: var(--font-display);
            font-size: clamp(32px, 5vw, 48px);
            margin-bottom: 16px;
        }
        .cta h2 span { color: var(--gold); }

        .cta p {
            color: rgba(255,255,255,0.6);
            margin-bottom: 36px;
        }

        /* Footer */
        footer {
            padding: 32px 0;
            text-align: center;
            border-top: 1px solid rgba(255,255,255,0.06);
        }
        footer p { font-size: 13px; color: rgba(255,255,255,0.4); }
        footer span { color: var(--gold); }

        /* Responsive */
        @media (max-width: 900px) {
            .hero-content { grid-template-columns: 1fr; text-align: center; }
            .hero-text p { margin: 0 auto 32px; }
            .hero-stats { justify-content: center; }
            .store-btns { justify-content: center; }
            .hero-img { display: none; }
            .services-grid { grid-template-columns: 1fr; max-width: 400px; margin: 0 auto; }
            .testimonials-grid { grid-template-columns: 1fr; max-width: 500px; margin: 0 auto; }
        }

        @media (max-width: 600px) {
            .nav-links { display: none; }
            .hero { padding: 100px 0 60px; }
            .hero-stats { gap: 24px; flex-wrap: wrap; justify-content: center; }
            .stat-num { font-size: 28px; }
            .store-btns { flex-direction: column; }
            .store-btn { width: 100%; justify-content: center; }
            .container { padding: 0 16px; }
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="header-inner">
                <a href="#" class="logo">Pro<span>Qik</span></a>
                <nav class="nav-links">
                    <a href="#services" class="nav-link">Services</a>
                    <a href="#stories" class="nav-link">Stories</a>
                    <a href="https://play.google.com/store" target="_blank" class="btn-app">Download App</a>
                </nav>
            </div>
        </div>
    </header>

    <section class="hero">
        <div class="container">
            <div class="hero-content">
                <div class="hero-text">
                    <h1>Every <span>precious moment</span> deserves to last forever.</h1>
                    <p>Book verified photographers, videographers, and album designers across India — handpicked for excellence, trusted by thousands of families.</p>
                    
                    <div class="hero-stats">
                        <div>
                            <div class="stat-num">428+</div>
                            <div class="stat-label">PROFESSIONALS</div>
                        </div>
                        <div>
                            <div class="stat-num">50K+</div>
                            <div class="stat-label">HAPPY FAMILIES</div>
                        </div>
                        <div>
                            <div class="stat-num">4.9</div>
                            <div class="stat-label">APP RATING</div>
                        </div>
                    </div>

                    <div class="store-btns">
                        <a href="https://play.google.com/store" target="_blank" class="store-btn">
                            <svg viewBox="0 0 24 24" fill="currentColor">
                                <path d="M3.18 23.76c.37.2.8.2 1.2-.02l12.93-7.47-2.73-2.73-11.4 10.22zm-1.02-20.6C2.06 3.47 2 3.76 2 4.07v15.86c0 .31.06.6.16.87l.09.08 8.89-8.89v-.21L2.25 3.07l-.09.09zm18.52 8.46l-2.65-1.53-2.99 2.99 2.99 2.99 2.66-1.54c.76-.44.76-1.47-.01-1.91zM4.38.24L17.31 7.7l-2.73 2.73L3.18.21c.37-.22.8-.23 1.2.03z"/>
                            </svg>
                            <div class="txt">
                                <div class="txt-l">Get it on</div>
                                <div class="txt-n">Google Play</div>
                            </div>
                        </a>
                        <a href="https://apps.apple.com" target="_blank" class="store-btn">
                            <svg viewBox="0 0 24 24" fill="currentColor">
                                <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98l-.09.06c-.22.14-2.14 1.25-2.11 3.73.02 2.96 2.59 3.95 2.62 3.96l-.06.19c-.24.87-.61 1.68-1.2 2.64M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/>
                            </svg>
                            <div class="txt">
                                <div class="txt-l">Download on</div>
                                <div class="txt-n">App Store</div>
                            </div>
                        </a>
                    </div>
                </div>

                <div class="hero-img">
                    <div class="phone-mockup">
                        <div class="phone-side-buttons">
                            <div class="phone-side-btn"></div>
                            <div class="phone-side-btn small"></div>
                        </div>
                        <div class="phone-notch"></div>
                        <div class="phone-screen">
                            <div class="app-header">
                                <div class="app-logo">ProQik</div>
                                <div class="app-rating-badge">4.9★</div>
                            </div>
                            <div class="app-nav">
                                <div class="app-dot active"></div>
                                <div class="app-dot"></div>
                                <div class="app-dot"></div>
                            </div>
                            <div class="app-content">
                                <div class="app-card">
                                    <div class="app-card-img">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M4 4l16 8-16 8V4z"/></svg>
                                    </div>
                                    <div class="app-card-info">
                                        <div class="app-card-title">Photography</div>
                                        <div class="app-card-meta">214 professionals</div>
                                    </div>
                                </div>
                                <div class="app-card">
                                    <div class="app-card-img">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z"/></svg>
                                    </div>
                                    <div class="app-card-info">
                                        <div class="app-card-title">Videography</div>
                                        <div class="app-card-meta">128 professionals</div>
                                    </div>
                                </div>
                                <div class="app-card">
                                    <div class="app-card-img">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14"/></svg>
                                    </div>
                                    <div class="app-card-info">
                                        <div class="app-card-title">Album Design</div>
                                        <div class="app-card-meta">86 professionals</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="services" id="services">
        <div class="container">
            <div class="section-header">
                <h2>Services that <span>honour your moments</span></h2>
                <p>Three specializations. Hundreds of artists. One platform to find the perfect match.</p>
            </div>

            <div class="services-grid">
                <div class="service-card">
                    <img src="https://images.unsplash.com/photo-1519741497674-611481863552?w=600&q=80" alt="Photography"/>
                    <div class="service-card-content">
                        <h3>Photography</h3>
                        <p>India's finest photographers for all your precious occasions.</p>
                        <div class="meta">214 professionals available</div>
                    </div>
                </div>
                <div class="service-card">
                    <img src="https://images.unsplash.com/photo-1574717432749-9cf81e4c9d69?w=600&q=80" alt="Videography"/>
                    <div class="service-card-content">
                        <h3>Videography</h3>
                        <p>Films that move you every time you watch.</p>
                        <div class="meta">128 professionals available</div>
                    </div>
                </div>
                <div class="service-card">
                    <img src="${pageContext.request.contextPath}/images/album-editor.jpg" alt="Album Designing" style="width:100%;height:180px;object-fit:cover;border-radius:12px;"/>
                    <div class="service-card-content">
                        <h3>Album Designing</h3>
                        <p>Premium albums crafted to last generations.</p>
                        <div class="meta">86 professionals available</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="testimonials" id="stories">
        <div class="container">
            <div class="section-header">
                <h2>What our <span>customers say</span></h2>
            </div>

            <div class="testimonials-grid">
                <div class="testimonial-card">
                    <div class="stars">★★★★★</div>
                    <p class="quote">"We were nervous about finding the right person. ProQik delivered beyond our expectations. Every frame is a treasure."</p>
                    <p class="author">— Ananya & Prakash, Bangalore</p>
                </div>
                <div class="testimonial-card">
                    <div class="stars">★★★★★</div>
                    <p class="quote">"The album designer matched our celebration perfectly. Guests keep asking which studio made it."</p>
                    <p class="author">— Meera & Arjun, Jaipur</p>
                </div>
                <div class="testimonial-card">
                    <div class="stars">★★★★★</div>
                    <p class="quote">"Booked everything through ProQik. The whole team coordinated perfectly without me lifting a finger."</p>
                    <p class="author">— Sunita & Rohit, Hyderabad</p>
                </div>
                <div class="testimonial-card">
                    <div class="stars">★★★★★</div>
                    <p class="quote">"The videographer understood our vision completely. The film is the most precious thing we own."</p>
                    <p class="author">— Pooja & Suresh, Mumbai</p>
                </div>
            </div>
        </div>
    </section>

    <section class="cta">
        <div class="container">
            <div class="cta-content">
                <h2>Your special day deserves<br><span>nothing less than perfect</span></h2>
                <p>Join thousands of families who trusted ProQik.</p>
                <div class="store-btns">
                    <a href="https://play.google.com/store" target="_blank" class="store-btn">
                        <svg viewBox="0 0 24 24" fill="currentColor">
                            <path d="M3.18 23.76c.37.2.8.2 1.2-.02l12.93-7.47-2.73-2.73-11.4 10.22zm-1.02-20.6C2.06 3.47 2 3.76 2 4.07v15.86c0 .31.06.6.16.87l.09.08 8.89-8.89v-.21L2.25 3.07l-.09.09zm18.52 8.46l-2.65-1.53-2.99 2.99 2.99 2.99 2.66-1.54c.76-.44.76-1.47-.01-1.91zM4.38.24L17.31 7.7l-2.73 2.73L3.18.21c.37-.22.8-.23 1.2.03z"/>
                        </svg>
                        <div class="txt">
                            <div class="txt-l">Get it on</div>
                            <div class="txt-n">Google Play</div>
                        </div>
                    </a>
                    <a href="https://apps.apple.com" target="_blank" class="store-btn">
                        <svg viewBox="0 0 24 24" fill="currentColor">
                            <path d="M18.71 19.5c-.83 1.24-1.71 2.45-3.05 2.47-1.34.03-1.77-.79-3.29-.79-1.53 0-2 .77-3.27.82-1.31.05-2.3-1.32-3.14-2.53C4.25 17 2.94 12.45 4.7 9.39c.87-1.52 2.43-2.48 4.12-2.51 1.28-.02 2.5.87 3.29.87.78 0 2.26-1.07 3.8-.91.65.03 2.47.26 3.64 1.98l-.09.06c-.22.14-2.14 1.25-2.11 3.73.02 2.96 2.59 3.95 2.62 3.96l-.06.19c-.24.87-.61 1.68-1.2 2.64M13 3.5c.73-.83 1.94-1.46 2.94-1.5.13 1.17-.34 2.35-1.04 3.19-.69.85-1.83 1.51-2.95 1.42-.15-1.15.41-2.35 1.05-3.11z"/>
                        </svg>
                        <div class="txt">
                            <div class="txt-l">Download on</div>
                            <div class="txt-n">App Store</div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <footer>
        <div class="container">
            <p>&copy; 2026 ProQik <span>●</span> India's Premier Platform</p>
        </div>
    </footer>
</body>
</html>