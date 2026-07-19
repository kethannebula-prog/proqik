<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProQik — India's Finest Visual Storytellers</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400;1,500&family=Inter:wght@200;300;400;500&display=swap" rel="stylesheet"/>
    <style>
        :root {
            --navy: #0a1628;
            --navy-mid: #1b376c;
            --navy-light: #234a8c;
            --white: #ffffff;
            --ivory: #f8f7f4;
            --cream: #f0ede8;
            --gold: #c9a84c;
            --gold-bright: #ddb97a;
            --text: #1a1a1a;
            --text-muted: #8a8a8a;
            --border: rgba(201,169,110,0.15);
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        html { scroll-behavior: smooth; }
        body {
            font-family: 'Inter', sans-serif;
            font-weight: 300;
            color: var(--text);
            background: var(--navy);
            line-height: 1.6;
            min-height: 100vh;
            -webkit-font-smoothing: antialiased;
        }
        .serif { font-family: 'Cormorant Garamond', serif; font-weight: 300; }

        /* Login Container */
        .login-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }
        
        .login-card {
            background: var(--white);
            border-radius: 16px;
            padding: 48px;
            width: 100%;
            max-width: 440px;
            box-shadow: 0 25px 80px rgba(0,0,0,.4);
        }
        
        .login-logo {
            font-family: 'Cormorant Garamond', serif;
            font-size: 32px;
            color: var(--navy);
            text-align: center;
            letter-spacing: 4px;
            margin-bottom: 8px;
        }
        .login-logo span { color: var(--gold); }
        
        .login-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 28px;
            font-weight: 300;
            color: var(--text);
            text-align: center;
            margin-bottom: 8px;
        }
        .login-subtitle {
            font-size: 14px;
            color: var(--text-muted);
            text-align: center;
            margin-bottom: 32px;
        }
        
        /* Form */
        .login-error {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #dc2626;
            padding: 12px 16px;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 20px;
            display: none;
        }
        .login-error.show { display: block; }
        
        .form-group { margin-bottom: 20px; }
        .form-label {
            display: block;
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: var(--text-muted);
            margin-bottom: 10px;
            font-weight: 400;
        }
        .form-input {
            width: 100%;
            padding: 16px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 15px;
            font-family: 'Inter', sans-serif;
            transition: border-color 0.3s;
        }
        .form-input:focus {
            outline: none;
            border-color: var(--gold);
        }
        
        .login-btn {
            width: 100%;
            padding: 18px;
            background: var(--gold);
            color: var(--navy);
            border: none;
            border-radius: 8px;
            font-size: 13px;
            letter-spacing: 2px;
            text-transform: uppercase;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 8px;
        }
        .login-btn:hover {
            background: var(--gold-bright);
            box-shadow: 0 8px 24px rgba(201,169,110,0.3);
        }
        
        .login-divider {
            display: flex;
            align-items: center;
            gap: 20px;
            margin: 28px 0;
            color: var(--text-muted);
            font-size: 12px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        .login-divider::before,
        .login-divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: var(--border);
        }
        
        /* Google Button */
        .google-btn {
            width: 100%;
            padding: 16px;
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: 8px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            font-size: 14px;
            color: var(--text);
            transition: all 0.3s;
        }
        .google-btn:hover {
            border-color: var(--gold);
            box-shadow: 0 4px 12px rgba(0,0,0,.08);
        }
        
        /* Links */
        .login-links {
            text-align: center;
            margin-top: 32px;
            padding-top: 28px;
            border-top: 1px solid var(--border);
        }
        .login-links p {
            font-size: 14px;
            color: var(--text-muted);
            margin-bottom: 16px;
        }
        
        /* Modal Overlay */
        .modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(10,22,40,0.92);
            backdrop-filter: blur(12px);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 500;
            padding: 20px;
        }
        .modal-overlay.active { display: flex; }
        
        .modal {
            background: var(--white);
            border-radius: 16px;
            width: 100%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
            padding: 48px;
            position: relative;
        }
        .modal-close {
            position: absolute;
            top: 24px;
            right: 24px;
            width: 40px;
            height: 40px;
            border: 1px solid var(--border);
            background: transparent;
            border-radius: 50%;
            cursor: pointer;
            font-size: 18px;
            color: var(--text-muted);
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .modal-close:hover {
            border-color: var(--gold);
            color: var(--gold);
        }
        
        /* Pro Steps */
        .pro-steps {
            display: flex;
            gap: 8px;
            margin-bottom: 40px;
        }
        .pro-step {
            flex: 1;
            height: 2px;
            background: var(--border);
            transition: all 0.4s;
        }
        .pro-step.active { background: var(--gold); }
        
        .form-step { display: none; }
        .form-step.active { display: block; animation: fadeUp 0.5s; }
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: none; }
        }
        
        .step-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 26px;
            font-weight: 300;
            color: var(--text);
            margin-bottom: 8px;
        }
        .step-desc {
            font-size: 14px;
            color: var(--text-muted);
            margin-bottom: 28px;
        }
        
        /* Category Cards */
        .cat-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
            margin-bottom: 32px;
        }
        .cat-card {
            aspect-ratio: 1;
            background: var(--cream);
            border: 2px solid var(--border);
            border-radius: 12px;
            cursor: pointer;
            position: relative;
            transition: all 0.4s;
            overflow: hidden;
        }
        .cat-card::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(to top, rgba(10,22,40,0.9), transparent);
            opacity: 0.8;
            transition: opacity 0.3s;
        }
        .cat-card:hover::before { opacity: 0.9; }
        .cat-card.selected {
            border-color: var(--gold);
        }
        .cat-card-content {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 16px;
            color: var(--white);
            text-align: center;
        }
        .cat-num {
            font-size: 11px;
            color: var(--gold);
            letter-spacing: 2px;
            margin-bottom: 4px;
        }
        .cat-name {
            font-family: 'Cormorant Garamond', serif;
            font-size: 18px;
            font-weight: 400;
        }
        
        .cat-check {
            position: absolute;
            top: 12px;
            right: 12px;
            width: 24px;
            height: 24px;
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 50%;
            opacity: 0;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            color: var(--navy);
        }
        .cat-card:hover .cat-check,
        .cat-card.selected .cat-check { opacity: 1; }
        .cat-card.selected .cat-check {
            background: var(--gold);
            border-color: var(--gold);
        }
        
        /* Success */
        .modal-success {
            display: none;
            text-align: center;
            padding: 40px 0;
        }
        .modal-success.active {
            display: block;
            animation: fadeUp 0.6s;
        }
        .success-icon {
            width: 64px;
            height: 64px;
            border: 2px solid var(--gold);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 24px;
            font-size: 24px;
            color: var(--gold);
        }
        
        /* Join Customer Section */
        .join-section {
            display: none;
            text-align: center;
            padding: 40px 20px;
        }
        .join-section.active { display: block; }
        .join-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 36px;
            font-weight: 300;
            color: var(--white);
            margin-bottom: 16px;
        }
        .join-subtitle {
            font-size: 16px;
            color: rgba(255,255,255,0.5);
            margin-bottom: 40px;
        }
        
        .store-grid {
            display: flex;
            gap: 16px;
            justify-content: center;
            margin-bottom: 40px;
        }
        .store-btn {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px 24px;
            background: var(--white);
            color: var(--navy);
            border-radius: 8px;
            text-decoration: none;
            transition: all 0.3s;
        }
        .store-btn:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 32px rgba(0,0,0,0.3);
        }
        
        .join-or {
            color: rgba(255,255,255,0.3);
            font-size: 13px;
            margin-bottom: 16px;
        }
        
        @media (max-width: 480px) {
            .login-card { padding: 32px 24px; }
            .cat-grid { grid-template-columns: 1fr; }
            .store-grid { flex-direction: column; }
        }
    </style>
</head>
<body>

    <!-- Login Form -->
    <div class="login-wrapper">
        <div class="login-card">
            <div class="login-logo">PRO<span>QIK</span></div>
            
            <div class="login-title">Welcome Back</div>
            <div class="login-subtitle">Sign in to continue</div>
            
            <div class="login-error<%= request.getAttribute("error") != null ? " show" : "" %>">
                <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
            </div>
            
            <form action="<%= request.getContextPath() %>/login" method="POST">
                <input type="hidden" name="action" value="login"/>
                
                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-input" placeholder="your@email.com" required/>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-input" placeholder="Enter password" required/>
                </div>
                
                <button type="submit" class="login-btn">Sign In</button>
            </form>
            
            <div class="login-divider">or</div>
            
            <button class="google-btn">
                <svg width="20" height="20" viewBox="0 0 24 24">
                    <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92a5.06 5.06 0 0 1-2.2 3.32v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.1z"/>
                    <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.15-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                    <path fill="#FBBC05" d="M5.85 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
                    <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.86-2.6 3.3-4.53 6.16-4.53z"/>
                </svg>
                Continue with Google
            </button>
            
            <div class="login-links">
                <p>New to ProQik?</p>
                <a href="#" class="login-btn" onclick="openModal('proModal')" style="display:inline-block;text-decoration:none;width:auto;padding:14px 32px;">Join as Pro</a>
            </div>
        </div>
    </div>

    <!-- Pro Application Modal -->
    <div class="modal-overlay" id="proModal">
        <div class="modal">
            <button class="modal-close" onclick="closeModal()">&times;</button>
            
            <div class="pro-steps">
                <div class="pro-step active" id="pstep1"></div>
                <div class="pro-step" id="pstep2"></div>
                <div class="pro-step" id="pstep3"></div>
            </div>
            
            <!-- Step 1: Personal -->
            <div class="form-step active" id="step1">
                <div class="step-title">Personal Information</div>
                <div class="step-desc">Tell us about yourself.</div>
                
                <form id="proStep1Form">
                    <div class="form-group">
                        <label class="form-label">Full Name</label>
                        <input type="text" id="proFullName" class="form-input" placeholder="Your full name" required/>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Display Name</label>
                        <input type="text" id="proDisplayName" class="form-input" placeholder="How clients will see you" required/>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Professional Title</label>
                        <input type="text" id="proTitle" class="form-input" placeholder="e.g. Wedding Photographer" required/>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Description</label>
                        <input type="text" id="proDesc" class="form-input" placeholder="Describe your craft" required/>
                    </div>
                    <button type="button" class="login-btn" onclick="nextStep(2)">Continue</button>
                </form>
            </div>
            
            <!-- Step 2: Category -->
            <div class="form-step" id="step2">
                <div class="step-title">Professional Information</div>
                <div class="step-desc">Select your primary discipline.</div>
                
                <div class="cat-grid">
                    <div class="cat-card selected" data-cat="photography" onclick="selectCat(this)">
                        <div class="cat-check">&#10003;</div>
                        <div class="cat-card-content">
                            <div class="cat-num">01</div>
                            <div class="cat-name">Photography</div>
                        </div>
                    </div>
                    <div class="cat-card" data-cat="videography" onclick="selectCat(this)">
                        <div class="cat-check">&#10003;</div>
                        <div class="cat-card-content">
                            <div class="cat-num">02</div>
                            <div class="cat-name">Videography</div>
                        </div>
                    </div>
                    <div class="cat-card" data-cat="album" onclick="selectCat(this)">
                        <div class="cat-check">&#10003;</div>
                        <div class="cat-card-content">
                            <div class="cat-num">03</div>
                            <div class="cat-name">Album Editor</div>
                        </div>
                    </div>
                </div>
                
                <button type="button" class="login-btn" onclick="nextStep(3)">Continue</button>
            </div>
            
            <!-- Step 3: Verify -->
            <div class="form-step" id="step3">
                <div class="step-title">Verify Your Identity</div>
                <div class="step-desc">Complete verification to submit.</div>
                
                <form action="<%= request.getContextPath() %>/signup" method="POST" id="proFinalForm">
                    <input type="hidden" name="fullName" id="finalFullName"/>
                    <input type="hidden" name="email" id="finalEmail"/>
                    <input type="hidden" name="phone" id="finalPhone"/>
                    <input type="hidden" name="password" id="finalPassword"/>
                    <input type="hidden" name="service" id="finalService"/>
                    
                    <div class="form-group">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" id="proPhone" class="form-input" placeholder="+91" required/>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Years of Experience</label>
                        <input type="number" id="proExp" class="form-input" placeholder="e.g. 5" required/>
                    </div>
                    
                    <button type="submit" class="login-btn" onclick="submitPro(event)">Submit Application</button>
                </form>
            </div>
            
            <!-- Success -->
            <div class="modal-success" id="proSuccess">
                <div class="success-icon">&#10003;</div>
                <div class="step-title">Application Submitted</div>
                <div class="step-desc">Your profile is under review. We'll verify within 24-48 hours.</div>
                <div style="display:inline-block;padding:16px 32px;background:var(--cream);border-radius:8px;font-size:14px;letter-spacing:1.5px;color:var(--navy);margin:24px 0;">
                    Application ID: #PQ-PRO-<%= (int)(Math.random()*9000+1000) %>
                </div>
                <br/>
                <button type="button" class="login-btn" style="width:auto;padding:16px 40px;" onclick="closeModal()">Done</button>
            </div>
        </div>
    </div>

    <script>
        var currentStep = 1;
        
        function openModal(id) {
            document.getElementById(id).classList.add('active');
        }
        
        function closeModal() {
            document.querySelectorAll('.modal-overlay').forEach(function(m) {
                m.classList.remove('active');
            });
            currentStep = 1;
            resetSteps();
        }
        
        function resetSteps() {
            for (var i = 1; i <= 3; i++) {
                var dot = document.getElementById('pstep' + i);
                if (dot) dot.classList.remove('active');
                var step = document.getElementById('step' + i);
                if (step) step.classList.remove('active');
            }
            document.getElementById('pstep1').classList.add('active');
            document.getElementById('step1').classList.add('active');
            document.getElementById('proSuccess').classList.remove('active');
        }
        
        function nextStep(n) {
            document.getElementById('step' + currentStep).classList.remove('active');
            currentStep = n;
            document.getElementById('step' + currentStep).classList.add('active');
            
            for (var i = 1; i <= 3; i++) {
                var dot = document.getElementById('pstep' + i);
                if (dot) {
                    dot.classList.remove('active');
                    if (i <= currentStep) dot.classList.add('active');
                }
            }
        }
        
        function selectCat(el) {
            document.querySelectorAll('.cat-card').forEach(function(c) {
                c.classList.remove('selected');
            });
            el.classList.add('selected');
        }
        
        function submitPro(e) {
            e.preventDefault();
            
            document.getElementById('finalFullName').value = document.getElementById('proFullName').value;
            document.getElementById('finalEmail').value = document.getElementById('proDisplayName').value + '@gmail.com';
            document.getElementById('finalPhone').value = document.getElementById('proPhone').value;
            document.getElementById('finalPassword').value = 'welcome123';
            
            var selected = document.querySelector('.cat-card.selected');
            document.getElementById('finalService').value = selected ? selected.dataset.cat : 'photography';
            
            document.getElementById('step3').classList.remove('active');
            document.getElementById('proSuccess').classList.add('active');
        }
        
        document.querySelectorAll('.modal-overlay').forEach(function(overlay) {
            overlay.addEventListener('click', function(e) {
                if (e.target === overlay) closeModal();
            });
        });
    </script>
</body>
</html>