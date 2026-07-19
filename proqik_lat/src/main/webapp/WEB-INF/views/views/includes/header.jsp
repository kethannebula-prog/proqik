<%-- Header include --%>
<%
Object user = session.getAttribute("user");
if (user != null) {
    // User is logged in, redirect handled elsewhere
}
String ctx = request.getContextPath();
%>
<nav class="nav" id="navbar">
    <div class="nav-inner">
        <a href="<%= ctx %>/" class="nav-logo">
            <img src="<%= ctx %>/resources/img/logo-dark.svg" alt="ProQik" style="height:30px"/>
        </a>

        <div class="nav-search-bar">
            <svg class="nav-search-icon" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="11" cy="11" r="8"/>
                <path d="M21 21l-4.35-4.35"/>
            </svg>
            <input type="search" placeholder="Search creative professionals..." aria-label="Search professionals">
            <button class="nav-sb-btn" onclick="proqik.toast('Searching...', 'success')">
                Search
            </button>
        </div>

        <div class="nav-links">
            <a href="#categories" class="nav-link">Explore</a>
            <a href="#howItWorks" class="nav-link">How It Works</a>
            <a href="#professionals" class="nav-link">Professionals</a>
            <a href="<%= ctx %>/auth/vendor/apply" class="nav-link">Become a Pro</a>
        </div>

        <div class="nav-ctas">
            <a href="<%= ctx %>/auth/login" class="nbg">Sign In</a>
            <a href="<%= ctx %>/login?role=vendor&action=signup" class="nbs">
                Join Free
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M5 12h14M12 5l7 7-7 7"/>
                </svg>
            </a>
        </div>

        <button class="nav-mobile-toggle" aria-label="Toggle menu">
            <span></span><span></span><span></span>
        </button>
    </div>
</nav>