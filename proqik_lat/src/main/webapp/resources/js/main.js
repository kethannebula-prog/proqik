/* ═══════════════════════════════════════════════════════════════════
   ProQik — Main JavaScript
   Java MVC Architecture
   ═══════════════════════════════════════════════════════════════════ */

const proqik = (function() {
    'use strict';

    // ─── Cursor Glow Effect ───
    function initCursorGlow() {
        const glow = document.getElementById('cursorGlow');
        if (!glow) return;

        let mouseX = 0, mouseY = 0;
        
        document.addEventListener('mousemove', (e) => {
            mouseX = e.clientX;
            mouseY = e.clientY;
            glow.style.left = mouseX + 'px';
            glow.style.top = mouseY + 'px';
            glow.style.opacity = '1';
        });

        document.addEventListener('mouseleave', () => {
            glow.style.opacity = '0';
        });
    }

    // ─── Particles Animation ───
    function initParticles() {
        const container = document.getElementById('particles');
        if (!container) return;

        for (let i = 0; i < 18; i++) {
            const particle = document.createElement('div');
            particle.className = 'particle';
            const size = Math.random() * 60 + 20;
            particle.style.cssText = `
                width: ${size}px;
                height: ${size}px;
                left: ${Math.random() * 100}%;
                top: ${Math.random() * 100}%;
                --dur: ${Math.random() * 10 + 6}s;
                --del: -${Math.random() * 8}s;
                --dy: -${Math.random() * 60 + 20}px;
            `;
            container.appendChild(particle);
        }
    }

    // ─── Navbar Scroll Effect ───
    function initNavbarScroll() {
        const navbar = document.getElementById('navbar');
        if (!navbar) return;

        window.addEventListener('scroll', () => {
            if (window.scrollY > 60) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
    }

    // ─── Hero Slideshow ───
    function initHeroSlideshow() {
        const slides = document.querySelectorAll('.hero-slide');
        const dots = document.querySelectorAll('.hero-dot');
        
        if (slides.length === 0) return;

        let currentSlide = 0;
        let interval;

        function goToSlide(index) {
            slides[currentSlide].classList.remove('active');
            dots[currentSlide]?.classList.remove('active');
            currentSlide = index;
            slides[currentSlide].classList.add('active');
            dots[currentSlide]?.classList.add('active');
        }

        function nextSlide() {
            goToSlide((currentSlide + 1) % slides.length);
        }

        // Auto-advance
        interval = setInterval(nextSlide, 5000);

        // Dot navigation
        dots.forEach((dot, index) => {
            dot.addEventListener('click', () => {
                clearInterval(interval);
                goToSlide(index);
                interval = setInterval(nextSlide, 5000);
            });
        });

        // Pause on hover
        const heroSection = document.querySelector('.hero');
        heroSection?.addEventListener('mouseenter', () => clearInterval(interval));
        heroSection?.addEventListener('mouseleave', () => {
            interval = setInterval(nextSlide, 5000);
        });
    }

    // ─── Toast Notifications ───
    function toast(message, type = '') {
        const wrapper = document.getElementById('toastContainer');
        if (!wrapper) return;

        const toastEl = document.createElement('div');
        toastEl.className = 'toast' + (type ? ' ' + type : '');
        
        const icons = {
            success: '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>',
            error: '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>',
            info: '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>',
            warning: '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>'
        };

        toastEl.innerHTML = '<div class="toast-icon">' + (icons[type] || '') + '</div><div class="toast-content"><div class="toast-title">' + message + '</div></div><button class="toast-close" onclick="this.parentElement.remove()">×</button>';
        wrapper.appendChild(toastEl);

        setTimeout(() => {
            toastEl.classList.add('exiting');
            setTimeout(() => toastEl.remove(), 300);
        }, 4000);
    }

    // ─── Modal Functions ───
    function openModal(id) {
        const modal = document.getElementById('modal-' + id);
        if (modal) {
            modal.classList.add('open');
            document.body.style.overflow = 'hidden';
        }
    }

    function closeModal(id) {
        const modal = document.getElementById('modal-' + id);
        if (modal) {
            modal.classList.remove('open');
            document.body.style.overflow = '';
        }
    }

    function closeOnOverlay(e, id) {
        if (e.target === document.getElementById('modal-' + id)) {
            closeModal(id);
        }
    }

    function switchModal(fromId, toId) {
        closeModal(fromId);
        setTimeout(() => openModal(toId), 100);
    }

    // ─── Filter Tabs ───
    function initFilterTabs() {
        document.querySelectorAll('.filter-tab').forEach(tab => {
            tab.addEventListener('click', () => {
                document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
                tab.classList.add('active');
                const category = tab.dataset.category;
                toast(category ? `Filtering by ${tab.textContent.trim()}` : 'Showing all categories', 'success');
            });
        });
    }

    // ─── Save Toggle ───
    function toggleSave(btn, serviceId) {
        btn.classList.toggle('saved');
        const isSaved = btn.classList.contains('saved');
        btn.textContent = isSaved ? '❤️' : '🤍';
        
        if (serviceId) {
            // Make API call to save/unsave
            fetch('/api/services/' + serviceId + '/save', {
                method: isSaved ? 'POST' : 'DELETE',
                headers: { 'Content-Type': 'application/json' }
            });
        }
        
        toast(isSaved ? 'Saved to wishlist ❤️' : 'Removed from wishlist', 'success');
    }

    // ─── How It Works Tabs ───
    const hiwContent = {
        client: [
            { n: '01', icon: '📱', title: 'Download the App', desc: 'Clients use the ProQik mobile app (iOS & Android) to browse local creative professionals by category, location and price.' },
            { n: '02', icon: '📅', title: 'Book Instantly', desc: 'Select your preferred professional, pick a date, add your requirements and pay securely through the app in seconds.' },
            { n: '03', icon: '✨', title: 'Receive Your Work', desc: 'Your pro delivers outstanding creative work. Review, approve and download your final files — all in-app.' }
        ],
        vendor: [
            { n: '01', icon: '📝', title: 'Apply as a Vendor', desc: 'Fill in the vendor application form above with your specialty, portfolio and location. Our admin team reviews within 24 hours.' },
            { n: '02', icon: '✅', title: 'Get Verified', desc: 'Once approved, your profile goes live on ProQik. Clients from across India can discover and book your services directly.' },
            { n: '03', icon: '💰', title: 'Earn & Grow', desc: 'Receive bookings, complete work, collect secure payments and grow your creative business with ProQik analytics.' }
        ],
        admin: [
            { n: '01', icon: '🔐', title: 'Admin Sign In', desc: 'Access the secure admin dashboard using your credentials. View real-time platform statistics and pending actions at a glance.' },
            { n: '02', icon: '👥', title: 'Manage Professionals', desc: 'Review vendor applications, approve or suspend profiles, adjust ratings and ensure quality across all categories.' },
            { n: '03', icon: '📊', title: 'Monitor & Optimise', desc: 'Track bookings, revenue, disputes and user feedback. Use built-in analytics to drive platform growth and satisfaction.' }
        ]
    };

    function initHiwTabs() {
        document.querySelectorAll('.hiw-tab').forEach(tab => {
            tab.addEventListener('click', () => {
                document.querySelectorAll('.hiw-tab').forEach(t => t.classList.remove('active'));
                tab.classList.add('active');
                
                const mode = tab.dataset.mode;
                const grid = document.getElementById('hiwGrid');
                if (!grid || !hiwContent[mode]) return;

                grid.innerHTML = hiwContent[mode].map((c, i) => `
                    <div class="hiw-card reveal in" style="transition-delay: ${i * 0.1}s">
                        <div class="hiw-number">${c.n}</div>
                        <div class="hiw-icon">${c.icon}</div>
                        <h3 class="hiw-title">${c.title}</h3>
                        <p class="hiw-description">${c.desc}</p>
                        <div class="hiw-arrow">→</div>
                    </div>
                `).join('');
            });
        });
    }

    // ─── Scroll Reveal ───
    function initScrollReveal() {
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('in');
                }
            });
        }, { threshold: 0.12 });

        document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
    }

    // ─── Stats Counter Animation ───
    function initStatsCounter() {
        const statsBand = document.querySelector('.stats-band');
        if (!statsBand) return;

        function animateCount(element, target, duration, decimals = 0) {
            const start = 0;
            const startTime = performance.now();
            
            function update(currentTime) {
                const elapsed = currentTime - startTime;
                const progress = Math.min(elapsed / duration, 1);
                const easeProgress = 1 - Math.pow(1 - progress, 3);
                const current = start + (target - start) * easeProgress;
                
                element.textContent = decimals > 0 
                    ? current.toFixed(decimals) 
                    : Math.floor(current).toLocaleString();
                
                if (progress < 1) {
                    requestAnimationFrame(update);
                }
            }
            
            requestAnimationFrame(update);
        }

        const statObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const statItems = entry.target.querySelectorAll('.stat-item');
                    statItems.forEach((item, index) => {
                        const valueEl = item.querySelector('.stat-value');
                        const barEl = item.querySelector('.stat-bar-fill');
                        
                        if (valueEl && !valueEl.dataset.done) {
                            valueEl.dataset.done = '1';
                            const target = parseInt(valueEl.parentElement.dataset.count) || 0;
                            const decimals = parseInt(valueEl.dataset.decimals) || 0;
                            
                            setTimeout(() => {
                                animateCount(valueEl, target, 1800, decimals);
                            }, index * 150);

                            if (barEl) {
                                const width = barEl.dataset.width;
                                setTimeout(() => {
                                    barEl.style.width = width + '%';
                                }, 200 + index * 150);
                            }
                        }
                    });
                    statObserver.unobserve(entry.target);
                }
            });
        }, { threshold: 0.3 });

        statObserver.observe(statsBand);
    }

    // ─── Dashboard Chart ───
    function initDashboardChart() {
        const container = document.getElementById('chartBars');
        if (!container) return;

        const chartData = [
            { label: 'Sep', height: 48, color: 'var(--g)' },
            { label: 'Oct', height: 62, color: 'var(--g)' },
            { label: 'Nov', height: 55, color: 'var(--g)' },
            { label: 'Dec', height: 88, color: 'var(--amber)' },
            { label: 'Jan', height: 70, color: 'var(--g)' },
            { label: 'Feb', height: 76, color: 'var(--g)' },
            { label: 'Mar', height: 90, color: 'var(--g)' },
            { label: 'Apr', height: 96, color: 'var(--g2)' }
        ];

        container.innerHTML = chartData.map(b => `
            <div class="db-bar-group">
                <div class="db-bar" style="height: 0; background: ${b.color}" data-height="${b.height}"></div>
                <span class="db-bar-label">${b.label}</span>
            </div>
        `).join('');

        setTimeout(() => {
            container.querySelectorAll('.db-bar').forEach(bar => {
                bar.style.height = bar.dataset.height + '%';
            });
        }, 400);
    }

    // ─── KPI Counter Animation ───
    function initKPICounters() {
        const kpiNumbers = document.querySelectorAll('.db-kpi-number');
        if (kpiNumbers.length === 0) return;

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const el = entry.target;
                    const target = parseInt(el.dataset.count) || 0;
                    const prefix = el.dataset.prefix || '';
                    const suffix = el.dataset.suffix || '';
                    const decimals = parseInt(el.dataset.decimals) || 0;
                    
                    let current = 0;
                    const duration = 1500;
                    const startTime = performance.now();

                    function update(currentTime) {
                        const elapsed = currentTime - startTime;
                        const progress = Math.min(elapsed / duration, 1);
                        const easeProgress = 1 - Math.pow(1 - progress, 3);
                        current = target * easeProgress;
                        
                        el.textContent = prefix + (decimals > 0 
                            ? current.toFixed(decimals) 
                            : Math.floor(current).toLocaleString()) + suffix;
                        
                        if (progress < 1) {
                            requestAnimationFrame(update);
                        }
                    }
                    
                    requestAnimationFrame(update);

                    // Animate bar
                    const bar = el.closest('.db-kpi').querySelector('.db-kpi-bar-fill');
                    if (bar) {
                        setTimeout(() => {
                            bar.style.width = bar.dataset.width + '%';
                        }, 200);
                    }

                    observer.unobserve(el);
                }
            });
        }, { threshold: 0.5 });

        kpiNumbers.forEach(el => observer.observe(el));
    }

    // ─── Live Booking Ticker ───
    const tickerData = [
        { name: 'Amit & Sneha', sub: 'Booked Wedding Photography · Just now', avatar: 'https://i.pravatar.cc/60?img=12' },
        { name: 'Coral Bay Resort', sub: 'Booked Aerial Drone · 2 min ago', avatar: 'https://i.pravatar.cc/60?img=26' },
        { name: 'Kavya S.', sub: 'Booked Portrait Session · 5 min ago', avatar: 'https://i.pravatar.cc/60?img=41' },
        { name: 'Ravi K.', sub: 'Booked Dance Reel · 8 min ago', avatar: 'https://i.pravatar.cc/60?img=33' },
        { name: 'Pacific Hotels', sub: 'Booked Events Coverage · 11 min ago', avatar: 'https://i.pravatar.cc/60?img=5' }
    ];

    let tickerIndex = 0;

    function showTicker() {
        const wrapper = document.getElementById('bookingTicker');
        if (!wrapper || wrapper.style.display === 'none') return;

        const data = tickerData[tickerIndex % tickerData.length];
        tickerIndex++;

        const tickEl = document.createElement('div');
        tickEl.className = 'ticker-item';
        tickEl.innerHTML = `
            <div class="pulse-dot"></div>
            <div class="tick-avatar"><img src="${data.avatar}" alt="${data.name}"></div>
            <div>
                <div class="tick-name">${data.name}</div>
                <div class="tick-sub">${data.sub}</div>
            </div>
        `;
        
        wrapper.appendChild(tickEl);
        
        setTimeout(() => {
            tickEl.style.animation = 'fadeOut 0.3s ease forwards';
            setTimeout(() => tickEl.remove(), 300);
        }, 5500);
    }

    function initTicker() {
        setTimeout(showTicker, 3500);
        setInterval(showTicker, 8500);
    }

    // ─── Password Toggle ───
    function togglePassword(inputId) {
        const input = document.getElementById(inputId);
        if (!input) return;

        const eyeOpen = input.parentElement.querySelector('.eye-open');
        const eyeClosed = input.parentElement.querySelector('.eye-closed');

        if (input.type === 'password') {
            input.type = 'text';
            if (eyeOpen) eyeOpen.style.display = 'none';
            if (eyeClosed) eyeClosed.style.display = 'block';
        } else {
            input.type = 'password';
            if (eyeOpen) eyeOpen.style.display = 'block';
            if (eyeClosed) eyeClosed.style.display = 'none';
        }
    }

    // ─── Password Strength ───
    function checkPasswordStrength(password) {
        const strengthEl = document.getElementById('passwordStrength');
        if (!strengthEl) return;

        const fill = strengthEl.querySelector('.password-strength-fill');
        const label = strengthEl.querySelector('.password-strength-label');
        
        let strength = 0;
        if (password.length >= 8) strength++;
        if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
        if (/\d/.test(password)) strength++;
        if (/[^a-zA-Z0-9]/.test(password)) strength++;

        strengthEl.classList.add('active');
        fill.dataset.strength = strength;

        const labels = ['Too weak', 'Weak', 'Fair', 'Strong', 'Very strong'];
        label.textContent = labels[strength] || '';
    }

    // ─── Social Login ───
    function socialLogin(provider, mode) {
        toast('Redirecting to ' + provider + '...', 'info');
        // Implement OAuth flow
        window.location.href = '/auth/oauth/' + provider + '?mode=' + mode;
    }

    // ─── Dashboard Notifications ───
    function toggleNotifications() {
        const panel = document.getElementById('notifPanel');
        const profile = document.getElementById('profileDrop');
        
        if (profile) profile.classList.remove('show');
        if (panel) panel.classList.toggle('show');
        
        // Add notification bell animation
        const notifBtn = document.getElementById('notifBtn');
        if (notifBtn) {
            notifBtn.style.transform = 'scale(1.2)';
            setTimeout(() => notifBtn.style.transform = '', 200);
        }
    }

    function toggleProfileDropdown() {
        const profile = document.getElementById('profileDrop');
        const panel = document.getElementById('notifPanel');
        
        if (panel) panel.classList.remove('show');
        if (profile) profile.classList.toggle('show');
        
        // Add user avatar animation
        const profileBtn = document.getElementById('profileBtn');
        if (profileBtn) {
            profileBtn.style.transform = 'scale(1.05)';
            setTimeout(() => profileBtn.style.transform = '', 200);
        }
    }

    function markAllNotifications() {
        const items = document.querySelectorAll('.db-notif-item.unread');
        items.forEach(item => item.classList.remove('unread'));
        toast('All notifications marked as read', 'success');
    }

    // ─── Dashboard Actions ───
    function exportChart() {
        toast('Exporting chart data...', 'info');
    }

    function viewAllActivity() {
        toast('Loading all activity...', 'info');
    }

    function viewAllPros() {
        window.location.href = '/admin/professionals';
    }

    // ─── Approve Professional ───
    function approveProfessional(btn, name) {
        const row = btn.closest('tr');
        const statusCell = row.querySelector('.db-table-status');
        const actionsCell = row.querySelector('.db-table-actions');
        
        toast('Approving ' + name + '...', 'info');
        
        setTimeout(() => {
            statusCell.innerHTML = 'ACTIVE';
            statusCell.style.background = '#DCFCE7';
            statusCell.style.color = '#166534';
            statusCell.style.boxShadow = '0 0 20px rgba(22,163,74,0.4)';
            actionsCell.innerHTML = '<button class="db-table-btn" onclick="proqik.toast(\'Opening ' + name + ' profile...\', \'info\')">View</button>';
            row.classList.remove('pending');
            toast(name + ' has been approved successfully!', 'success');
        }, 1000);
    }

    // ─── Activity Filter ───
    function filterActivity(type, btn) {
        document.querySelectorAll('.db-activity-filter').forEach(f => f.classList.remove('active'));
        btn.classList.add('active');
        
        const items = document.querySelectorAll('.db-activity-item');
        items.forEach(item => {
            if (type === 'all') {
                item.style.display = 'flex';
            } else {
                item.style.display = item.dataset.type === type ? 'flex' : 'none';
            }
        });
        
        toast('Filtering: ' + type, 'info');
    }

    // ─── Live Time ───
    function initLiveTime() {
        const timeEl = document.getElementById('liveTime');
        if (!timeEl) return;
        
        function updateTime() {
            const now = new Date();
            const options = { hour: '2-digit', minute: '2-digit', second: '2-digit' };
            timeEl.textContent = now.toLocaleTimeString('en-US', options);
        }
        
        updateTime();
        setInterval(updateTime, 1000);
    }

    // ─── Floating Particles ───
    function initParticles() {
        const container = document.getElementById('particles');
        if (!container) return;
        
        for (let i = 0; i < 15; i++) {
            const particle = document.createElement('div');
            particle.className = 'particle';
            particle.style.left = Math.random() * 100 + '%';
            particle.style.animationDelay = Math.random() * 15 + 's';
            particle.style.animationDuration = (15 + Math.random() * 10) + 's';
            container.appendChild(particle);
        }
    }

    // ─── Live Updates Simulation ───
    function initLiveUpdates() {
        setInterval(() => {
            const kpiValues = document.querySelectorAll('.db-kpi-value');
            if (kpiValues.length > 0) {
                const randomIndex = Math.floor(Math.random() * kpiValues.length);
                const kpi = kpiValues[randomIndex];
                const currentText = kpi.textContent;
                
                if (currentText.includes('K')) {
                    const num = parseFloat(currentText.replace(/[^\d.]/g, ''));
                    const newNum = (num + (Math.random() * 0.5 - 0.1)).toFixed(1);
                    kpi.textContent = '₹' + newNum + 'K';
                } else if (!currentText.includes('.')) {
                    const num = parseInt(currentText.replace(/,/g, ''));
                    if (!isNaN(num)) {
                        const newNum = num + Math.floor(Math.random() * 3);
                        kpi.textContent = newNum.toLocaleString();
                    }
                }
                
                kpi.style.transform = 'scale(1.05)';
                kpi.style.color = 'var(--gold)';
                setTimeout(() => {
                    kpi.style.transform = '';
                    kpi.style.color = '';
                }, 300);
            }
        }, 15000);
    }

    // ─── Outside Click Handler ───
    function initOutsideClick() {
        document.addEventListener('click', (e) => {
            const notifPanel = document.getElementById('notifPanel');
            const notifBtn = document.getElementById('notifBtn');
            const profileDrop = document.getElementById('profileDrop');
            const profileBtn = document.getElementById('profileBtn');
            
            if (notifPanel && notifBtn) {
                if (!notifPanel.contains(e.target) && !notifBtn.contains(e.target)) {
                    notifPanel.classList.remove('show');
                }
            }
            
            if (profileDrop && profileBtn) {
                if (!profileDrop.contains(e.target) && !profileBtn.contains(e.target)) {
                    profileDrop.classList.remove('show');
                }
            }
        });
    }

    // ─── Sidebar Navigation ───
    function initSidebarNav() {
        document.querySelectorAll('.db-sidebar-link').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const text = link.textContent.trim();
                
                document.querySelectorAll('.db-sidebar-link').forEach(l => l.classList.remove('active'));
                link.classList.add('active');
                
                toast('Navigating to ' + text + '...', 'info');
            });
        });
    }

    // ─── Nav Link Clicks ───
    function initNavLinkClicks() {
        document.querySelectorAll('.db-nav-link').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const text = link.textContent.trim();
                
                document.querySelectorAll('.db-nav-link').forEach(l => l.classList.remove('active'));
                link.classList.add('active');
                
                toast('Opening ' + text + ' section...', 'info');
            });
        });
    }

    // ─── Hero Search Placeholder Typing ───
    function initHeroTyping() {
        const input = document.getElementById('heroSearchInput');
        if (!input) return;

        const placeholders = [
            'Search for wedding photographers…',
            'Find aerial drone operators…',
            'Book a video editor…',
            'Hire a sketch artist…',
            'Find dance reel creators…'
        ];

        let placeholderIndex = 0;
        let charIndex = 0;
        let isDeleting = false;

        function type() {
            const current = placeholders[placeholderIndex];
            
            if (isDeleting) {
                input.placeholder = current.substring(0, charIndex - 1);
                charIndex--;
            } else {
                input.placeholder = current.substring(0, charIndex + 1);
                charIndex++;
            }

            let timeout = isDeleting ? 32 : 68;

            if (!isDeleting && charIndex === current.length) {
                timeout = 2000;
                isDeleting = true;
            } else if (isDeleting && charIndex === 0) {
                isDeleting = false;
                placeholderIndex = (placeholderIndex + 1) % placeholders.length;
                timeout = 400;
            }

            setTimeout(type, timeout);
        }

        setTimeout(type, 1200);
    }

    // ─── Card Tilt Effect ───
    function initCardTilt() {
        document.querySelectorAll('.category-card, .pro-card, .gig-card, .hiw-card').forEach(card => {
            card.addEventListener('mousemove', (e) => {
                const rect = card.getBoundingClientRect();
                const x = (e.clientX - rect.left) / rect.width - 0.5;
                const y = (e.clientY - rect.top) / rect.height - 0.5;
                
                card.style.transform = `translateY(-8px) scale(1.02) rotateX(${-y * 6}deg) rotateY(${x * 6}deg)`;
            });

            card.addEventListener('mouseleave', () => {
                card.style.transform = '';
            });
        });
    }

    // ─── Mobile Menu ───
    function initMobileMenu() {
        const toggle = document.getElementById('mobileToggle');
        const navLinks = document.querySelector('.nav-links');
        
        if (!toggle || !navLinks) return;

        toggle.addEventListener('click', () => {
            navLinks.classList.toggle('mobile-open');
            toggle.classList.toggle('active');
        });
    }

    // ─── Dashboard Init ───
    function initDashboard() {
        const dashboard = document.getElementById('dashboard');
        if (!dashboard) return;

        initDashboardChart();
        initKPICounters();

        // Notification panel
        const notifBtn = document.getElementById('notifBtn');
        const profileBtn = document.getElementById('profileBtn');
        
        if (notifBtn) notifBtn.addEventListener('click', toggleNotifications);
        if (profileBtn) profileBtn.addEventListener('click', toggleProfileDropdown);

        // Add professional button
        const addProBtn = document.getElementById('addProBtn');
        if (addProBtn) addProBtn.addEventListener('click', () => openModal('addPro'));

        // Close panels on outside click
        document.addEventListener('click', (e) => {
            const notifPanel = document.getElementById('notifPanel');
            const profileDrop = document.getElementById('profileDrop');
            
            if (notifPanel && !notifPanel.contains(e.target) && !e.target.closest('#notifBtn')) {
                notifPanel.classList.remove('open');
            }
            if (profileDrop && !profileDrop.contains(e.target) && !e.target.closest('#profileBtn')) {
                profileDrop.classList.remove('open');
            }
        });

        // Sidebar navigation
        document.querySelectorAll('.db-sb-item, .db-nav-link').forEach(link => {
            link.addEventListener('click', (e) => {
                if (link.tagName === 'A' && link.href.includes('#')) {
                    e.preventDefault();
                }
                
                const parent = link.closest('.db-sb-menu, .db-nav-links');
                if (parent) {
                    parent.querySelectorAll('.active').forEach(el => el.classList.remove('active'));
                    link.classList.add('active');
                }
            });
        });
    }

    // ─── Initialize Everything ───
    function init() {
        initCursorGlow();
        initParticles();
        initNavbarScroll();
        initHeroSlideshow();
        initFilterTabs();
        initHiwTabs();
        initScrollReveal();
        initStatsCounter();
        initTicker();
        initHeroTyping();
        initCardTilt();
        initMobileMenu();
        initDashboard();
        initLiveUpdates();
        initOutsideClick();
        initSidebarNav();
        initNavLinkClicks();
        initLiveTime();
        initParticles();

        // Modal event listeners
        document.querySelectorAll('.modal-overlay').forEach(overlay => {
            overlay.addEventListener('click', (e) => {
                if (e.target === overlay) {
                    const modalId = overlay.dataset.modal;
                    if (modalId) closeModal(modalId);
                }
            });
        });

        // Close modal buttons
        document.querySelectorAll('.modal-close').forEach(btn => {
            btn.addEventListener('click', () => {
                const modal = btn.closest('.modal-overlay');
                if (modal) {
                    modal.classList.remove('open');
                    document.body.style.overflow = '';
                }
            });
        });

        // ESC key to close modals
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                document.querySelectorAll('.modal-overlay.open').forEach(modal => {
                    modal.classList.remove('open');
                });
                document.body.style.overflow = '';
            }
        });

        // GSAP animations
        if (typeof gsap !== 'undefined') {
            gsap.registerPlugin(ScrollTrigger);
            
            // Smooth scroll animations
            gsap.utils.toArray('.reveal').forEach(element => {
                gsap.from(element, {
                    scrollTrigger: {
                        trigger: element,
                        start: 'top 80%',
                        toggleActions: 'play none none none'
                    },
                    y: 32,
                    opacity: 0,
                    duration: 0.75,
                    ease: 'power3.out'
                });
            });
        }

        console.log('ProQik initialized');
    }

    // ─── Public API ───
    return {
        init,
        toast,
        openModal,
        closeModal,
        switchModal,
        toggleSave,
        togglePassword,
        checkPasswordStrength,
        socialLogin,
        toggleNotifications,
        toggleProfileDropdown,
        markAllNotifications,
        exportChart,
        viewAllActivity,
        viewAllPros,
        approveProfessional,
        filterActivity
    };
})();

// ─── Initialize on DOM Ready ───
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', proqik.init);
} else {
    proqik.init();
}

// ─── Add CSS for ticker and animations ───
const style = document.createElement('style');
style.textContent = `
    .ticker-item {
        display: flex;
        align-items: center;
        gap: 10px;
        background: rgba(255, 255, 255, 0.97);
        border-radius: 14px;
        padding: 11px 15px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.14);
        border: 1px solid var(--border);
        margin-bottom: 10px;
        animation: tickIn 0.45s var(--ease) both;
        max-width: 260px;
    }
    
    @keyframes tickIn {
        from { opacity: 0; transform: translateX(-24px) scale(0.95); }
        to { opacity: 1; transform: translateX(0) scale(1); }
    }
    
    @keyframes fadeOut {
        to { opacity: 0; transform: translateX(24px); }
    }
    
    .tick-avatar {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        overflow: hidden;
        flex-shrink: 0;
        border: 2px solid var(--gl);
    }
    
    .tick-avatar img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
	    
    .tick-name {
        font-size: 12px;
        font-weight: 700;
        color: var(--ink);
    }
    
    .tick-sub {
        font-size: 10px;
        color: var(--muted);
        font-weight: 500;
        margin-top: 1px;
    }
    
    .nav-links.mobile-open {
        display: flex !important;
        flex-direction: column;
        position: absolute;
        top: 72px;
        left: 0;
        right: 0;
        background: var(--white);
        padding: 16px;
        border-bottom: 1px solid var(--border);
        box-shadow: var(--shadow-md);
    }
    
    .nav-mobile-toggle.active span:nth-child(1) {
        transform: rotate(45deg) translate(5px, 5px);
    }
    
    .nav-mobile-toggle.active span:nth-child(2) {
        opacity: 0;
    }
    
    .nav-mobile-toggle.active span:nth-child(3) {
        transform: rotate(-45deg) translate(5px, -5px);
    }
`;
document.head.appendChild(style);
