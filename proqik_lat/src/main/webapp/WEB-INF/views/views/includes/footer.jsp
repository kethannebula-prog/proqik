<%-- Footer include --%>
<footer class="footer">
    <div class="footer-inner">
        <div class="footer-top">
            <div class="footer-brand">
                <a href="${pageContext.request.contextPath}/" class="footer-logo">
                    <img src="${pageContext.request.contextPath}/resources/img/logo-dark.svg" alt="ProQik" style="height:28px"/>
                </a>
                <p class="footer-desc">
                    India's premier platform for connecting clients with creative professionals. 
                    Fast, verified, and trusted by thousands across the country.
                </p>
                <div class="footer-social">
                    <a href="#" class="fsoc" aria-label="Facebook">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"/>
                        </svg>
                    </a>
                    <a href="#" class="fsoc" aria-label="Instagram">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <rect x="2" y="2" width="20" height="20" rx="5"/>
                            <circle cx="12" cy="12" r="4"/>
                            <circle cx="18" cy="6" r="1" fill="currentColor"/>
                        </svg>
                    </a>
                    <a href="#" class="fsoc" aria-label="Twitter">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M23 3a10.9 10.9 0 0 1-3.14 1.53 4.48 4.48 0 0 0-7.86 3v1A10.66 10.66 0 0 1 3 4s-4 9 5 13a11.64 11.64 0 0 1-7 2c9 5 20 0 20-11.5a4.5 4.5 0 0 0-.08-.83A7.72 7.72 0 0 0 23 3z"/>
                        </svg>
                    </a>
                    <a href="#" class="fsoc" aria-label="YouTube">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M22.54 6.42a2.78 2.78 0 0 0-1.94-2C18.88 4 12 4 12 4s-6.88 0-8.6.46a2.78 2.78 0 0 0-1.94 2A29 29 0 0 0 1 11.75a29 29 0 0 0 .46 5.33A2.78 2.78 0 0 0 3.4 19c1.72.46 8.6.46 8.6.46s6.88 0 8.6-.46a2.78 2.78 0 0 0 1.94-2 29 29 0 0 0 .46-5.25 29 29 0 0 0-.46-5.33z"/>
                            <polygon fill="white" points="9.75 15.02 15.5 11.75 9.75 8.48 9.75 15.02"/>
                        </svg>
                    </a>
                </div>
            </div>

            <div class="footer-col">
                <h4>Platform</h4>
                <a href="${pageContext.request.contextPath}/" class="footer-link">Browse Professionals</a>
                <a href="#categories" class="footer-link">Categories</a>
                <a href="#howItWorks" class="footer-link">How It Works</a>
                <a href="#" class="footer-link">Pricing</a>
                <a href="#" class="footer-link">Mobile App</a>
            </div>

            <div class="footer-col">
                <h4>Professionals</h4>
                <a href="${pageContext.request.contextPath}/auth/vendor/apply" class="footer-link">Become a Vendor</a>
                <a href="${pageContext.request.contextPath}/dashboard" class="footer-link">Vendor Dashboard</a>
                <a href="#" class="footer-link">Success Stories</a>
                <a href="#" class="footer-link">Resources</a>
                <a href="#" class="footer-link">Support</a>
            </div>

            <div class="footer-col">
                <h4>Company</h4>
                <a href="#" class="footer-link">About ProQik</a>
                <a href="#" class="footer-link">Careers</a>
                <a href="#" class="footer-link">Blog</a>
                <a href="#" class="footer-link">Privacy Policy</a>
                <a href="#" class="footer-link">Terms of Service</a>
            </div>
        </div>

        <div class="footer-bottom">
            <div class="footer-copy">
                &copy; <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy" /> ProQik. All rights reserved. Made with 
                <span class="footer-heart">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="#EF4444" stroke="none">
                        <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/>
                    </svg>
                </span> in India.
            </div>
            <div class="footer-badges">
                <div class="fbadge">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="11" width="18" height="11" rx="2"/>
                        <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                    </svg>
                    Secure
                </div>
                <div class="fbadge">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
                        <polyline points="22 4 12 14.01 9 11.01"/>
                    </svg>
                    Verified
                </div>
                <div class="fbadge">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                        <circle cx="12" cy="10" r="3"/>
                    </svg>
                    India-based
                </div>
            </div>
        </div>
    </div>
</footer>
