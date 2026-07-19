// ProQik Dashboard JavaScript
// Template functions for admin and vendor dashboards

var proqik = proqik || {};

// Toast notifications
proqik.toast = function(msg, type) {
    var tw = document.getElementById('tw');
    if (!tw) {
        tw = document.createElement('div');
        tw.id = 'tw';
        tw.style.cssText = 'position:fixed;bottom:32px;left:50%;transform:translateX(-50%);z-index:9999;display:flex;flex-direction:column;gap:8px;align-items:center;pointer-events:none';
        document.body.appendChild(tw);
    }
    var t = document.createElement('div');
    var cls = 'tst ' + (type || 'b');
    t.className = cls;
    t.textContent = msg;
    t.style.cssText = 'padding:12px 22px;border-radius:4px;font-size:12px;font-weight:500;letter-spacing:.04em;color:#fff;box-shadow:0 12px 40px rgba(0,0,0,.25);pointer-events:none;animation:tIn 0.35s cubic-bezier(.16,1,.3,1) both';
    if (type === 'g') t.style.background = 'var(--success)';
    else if (type === 'r') t.style.background = 'var(--danger)';
    else if (type === 'o') { t.style.background = 'var(--gold)'; t.style.color = 'var(--navy)'; }
    else t.style.background = 'var(--navy)';
    tw.appendChild(t);
    setTimeout(function() {
        t.style.transition = 'opacity .3s,transform .3s';
        t.style.opacity = '0';
        t.style.transform = 'translateY(8px)';
        setTimeout(function() { t.remove(); }, 300);
    }, 3000);
};

// Toggle notifications panel
proqik.toggleNotifications = function() {
    var np = document.getElementById('np');
    var pd = document.getElementById('pd');
    if (pd) pd.style.display = 'none';
    if (np) np.style.display = np.style.display === 'none' ? 'block' : 'none';
};

// Toggle profile dropdown
proqik.toggleProfileDropdown = function() {
    var pd = document.getElementById('pd');
    var np = document.getElementById('np');
    if (np) np.style.display = 'none';
    if (pd) pd.style.display = pd.style.display === 'none' ? 'block' : 'none';
};

// Mark all notifications read
proqik.markAllNotifications = function() {
    var items = document.querySelectorAll('.np-item.unread');
    items.forEach(function(item) { item.classList.remove('unread'); });
    var dot = document.querySelector('.np-dot');
    if (dot) dot.style.display = 'none';
    var badge = document.getElementById('nb-badge');
    if (badge) badge.style.display = 'none';
    proqik.toast('All notifications read', 'g');
};

// Admin tab switching
proqik.showATab = function(tab, navEl) {
    var tabs = ['dash', 'pros', 'book'];
    tabs.forEach(function(t) {
        var el = document.getElementById('at-' + t);
        if (el) el.style.display = t === tab ? 'block' : 'none';
    });
    var navLinks = document.querySelectorAll('#adminDB .tb-nl');
    navLinks.forEach(function(n) { n.classList.remove('act'); });
    if (navEl) navEl.classList.add('act');
    else {
        var map = { dash: 'an-dash', pros: 'an-pros', book: 'an-book' };
        var el = document.getElementById(map[tab]);
        if (el) el.classList.add('act');
    }
    var sbItems = document.querySelectorAll('#adminDB .db-sb-item');
    sbItems.forEach(function(i) { i.classList.remove('act'); });
};

// Add professional modal
proqik.openAddPro = function() {
    var m = document.getElementById('add-pro-modal');
    if (m) m.style.display = 'flex';
};
proqik.closeAddPro = function() {
    var m = document.getElementById('add-pro-modal');
    if (m) m.style.display = 'none';
};
proqik.addProfessional = function() {
    proqik.closeAddPro();
    proqik.toast('Professional added and notified', 'g');
    var el = document.getElementById('k-pros');
    if (el) { el.style.color = 'var(--teal)'; el.textContent = '153'; }
};

// Export data
proqik.exportData = function() {
    proqik.toast('Preparing export... ready in moments', 'b');
};

// Professionals table
proqik.renderPros = function(data) {
    var tbody = document.getElementById('pros-tbody');
    if (!tbody) return;
    if (!data.length) {
        tbody.innerHTML = '<tr><td colspan="8" style="text-align:center;padding:32px;color:var(--muted2);font-size:12px">No professionals found</td></tr>';
        return;
    }
    var statusClass = { 'ACTIVE': 'chip-green', 'PENDING': 'chip-gold', 'SUSPENDED': 'chip-red' };
    tbody.innerHTML = data.map(function(p) {
        var sc = statusClass[p.status] || 'chip-gold';
        var actions = p.status === 'PENDING'
            ? '<button class="tbl-btn approve" onclick="proqik.approvePro(this,\'' + p.name + '\')">Approve</button><button class="tbl-btn" onclick="proqik.toast(\'Rejected\',\'r\')" style="margin-left:4px">Reject</button>'
            : '<button class="tbl-btn" onclick="proqik.toast(\'Viewing ' + p.name + '…\',\'b\')">View</button><button class="tbl-btn" onclick="proqik.toast(\'Suspended\',\'b\')" style="margin-left:4px">Suspend</button>';
        return '<tr onclick="proqik.toast(\'Opening ' + p.name + '…\',\'b\')">'
            + '<td><div class="tbl-av"><img src="' + p.av + '"/><div><div class="tbl-name">' + p.name + '</div></div></div></td>'
            + '<td style="font-size:12px">' + p.cat + '</td>'
            + '<td style="font-size:12px">' + p.loc + '</td>'
            + '<td style="font-size:12px">&#9733; ' + p.rating + ' <span style="color:var(--muted2)">(' + p.rv + ')</span></td>'
            + '<td style="font-size:12px;font-weight:500;color:var(--ink)">' + p.bookings + '</td>'
            + '<td style="font-size:12px;font-weight:500;color:var(--navy)">₹' + p.earnings + '</td>'
            + '<td><span class="db-sb-chip ' + sc + '" style="font-size:9px">' + p.status + '</span></td>'
            + '<td onclick="event.stopPropagation()"><div class="tbl-btns">' + actions + '</div></td></tr>';
    }).join('');
};

proqik.filterPros = function(v) {
    if (typeof prosFilter === 'undefined') var prosFilter = { text: '', status: '' };
    prosFilter.text = v.toLowerCase();
    proqik.applyFilter();
};

proqik.filterProsStatus = function(v) {
    if (typeof prosFilter === 'undefined') var prosFilter = { text: '', status: '' };
    prosFilter.status = v;
    proqik.applyFilter();
};

proqik.applyFilter = function() {
    if (typeof prosData === 'undefined' || typeof prosFilter === 'undefined') return;
    var f = prosData.filter(function(p) {
        return (!prosFilter.text || p.name.toLowerCase().includes(prosFilter.text) || p.cat.toLowerCase().includes(prosFilter.text))
            && (!prosFilter.status || p.status === prosFilter.status);
    });
    proqik.renderPros(f);
};

proqik.approvePro = function(btn, name) {
    var row = btn.closest('tr');
    var chip = row.querySelector('.db-sb-chip');
    if (chip) { chip.className = 'db-sb-chip chip-green'; chip.style.fontSize = '9px'; chip.textContent = 'ACTIVE'; }
    btn.closest('td').innerHTML = '<div class="tbl-btns"><button class="tbl-btn" onclick="proqik.toast(\'Viewing…\',\'b\')">View</button></div>';
    proqik.toast(name + ' is now live on ProQik', 'g');
};

// Bookings table
proqik.renderBookings = function() {
    var tbody = document.getElementById('book-tbody');
    if (!tbody || typeof bookingsData === 'undefined') return;
    var sc = { CONFIRMED: 'chip-green', PENDING: 'chip-gold', COMPLETED: 'chip-teal', DISPUTE: 'chip-red' };
    tbody.innerHTML = bookingsData.map(function(b) {
        return '<tr onclick="proqik.toast(\'Opening ' + b.id + '…\',\'b\')">'
            + '<td style="font-weight:500;color:var(--navy);font-size:12px">' + b.id + '</td>'
            + '<td style="font-size:12px">' + b.client + '</td>'
            + '<td style="font-size:12px">' + b.pro + '</td>'
            + '<td style="font-size:12px">' + b.svc + '</td>'
            + '<td style="font-size:12px;color:var(--muted2)">' + b.date + '</td>'
            + '<td style="font-size:12px;font-weight:500;color:var(--navy)">' + b.amt + '</td>'
            + '<td><span class="db-sb-chip ' + (sc[b.status] || 'chip-gold') + '" style="font-size:9px">' + b.status + '</span></td>'
            + '<td onclick="event.stopPropagation()"><button class="tbl-btn" onclick="proqik.toast(\'Opening ' + b.id + '…\',\'b\')">View</button></td></tr>';
    }).join('');
};

// Notifications
proqik.renderNotifs = function() {
    var nl = document.getElementById('np-list');
    if (!nl || typeof notifData === 'undefined') return;
    nl.innerHTML = notifData.map(function(n) {
        return '<div class="np-item' + (n.unread ? ' unread' : '') + '">'
            + '<div class="np-ico" style="background:' + n.bg + '">' + n.ico + '</div>'
            + '<div style="flex:1"><div class="np-msg">' + n.msg + '</div><div class="np-time">' + n.time + '</div></div>'
            + (n.unread ? '<div class="np-dot"></div>' : '') + '</div>';
    }).join('');
};

proqik.clearNotifs = function() {
    if (typeof notifData === 'undefined') return;
    notifData.forEach(function(n) { n.unread = false; });
    proqik.renderNotifs();
    var b = document.getElementById('nb-badge');
    if (b) b.style.display = 'none';
    var np = document.getElementById('np');
    if (np) np.style.display = 'none';
    proqik.toast('All notifications read', 'g');
};

// Live feed
proqik.renderFeed = function() {
    var feed = document.getElementById('a-feed');
    if (!feed || typeof feedData === 'undefined') return;
    feed.innerHTML = feedData.map(function(e) {
        return '<div class="feed-item">'
            + '<div class="feed-ico" style="background:' + e.bg + '">' + e.ico + '</div>'
            + '<div style="flex:1"><div class="feed-text">' + e.msg + '</div><div class="feed-time">' + e.time + '</div></div>'
            + '</div>';
    }).join('');
};

// Bar chart
proqik.renderChart = function() {
    var wrap = document.getElementById('a-chart'), lbl = document.getElementById('a-chart-lbl');
    if (!wrap || !lbl || typeof chartData === 'undefined') return;
    var max = Math.max.apply(null, chartData.map(function(d) { return d.v; }));
    wrap.innerHTML = chartData.map(function(d, i) {
        var pct = Math.round(d.v / max * 100);
        var isLast = i === chartData.length - 1;
        return '<div class="chart-bar-wrap"><div style="flex:1;display:flex;align-items:flex-end;width:100%">'
            + '<div class="chart-bar' + (isLast ? ' hi' : '') + '" data-h="' + pct + '%" style="height:0;' + (isLast ? 'opacity:1' : 'opacity:.18') + '"></div></div></div>';
    }).join('');
    lbl.innerHTML = chartData.map(function(d) {
        return '<div class="chart-bar-lbl" style="flex:1;text-align:center">' + d.l + '</div>';
    }).join('');
    setTimeout(function() {
        wrap.querySelectorAll('[data-h]').forEach(function(b) { b.style.height = b.getAttribute('data-h'); });
    }, 120);
};

// Category bars
proqik.renderCatBars = function() {
    var el = document.getElementById('a-cat-bars');
    if (!el || typeof catData === 'undefined') return;
    el.innerHTML = catData.map(function(c) {
        return '<div class="cat-bar-row"><div class="cat-bar-meta"><span class="cat-bar-name">' + c.n + '</span><span class="cat-bar-pct">' + c.p + '%</span></div>'
            + '<div class="cat-bar-track"><div class="cat-bar-fill" data-w="' + c.p + '%" style="background:' + c.c + '"></div></div></div>';
    }).join('');
    setTimeout(function() {
        el.querySelectorAll('[data-w]').forEach(function(b) { b.style.width = b.getAttribute('data-w'); });
    }, 120);
};

// Count up animation
proqik.countUp = function(id, target, prefix, suffix, dur) {
    var el = document.getElementById(id);
    if (!el) return;
    var start = 0, step = target / (dur / 16);
    var t = setInterval(function() {
        start = Math.min(start + step, target);
        el.textContent = (prefix || '') + Math.floor(start).toLocaleString() + (suffix || '');
        if (start >= target) clearInterval(t);
    }, 16);
};

// Update datetime
proqik.updateDT = function() {
    var el = document.getElementById('a-datetime');
    if (!el) return;
    el.textContent = new Date().toLocaleDateString('en-FJ', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' });
};

// Initialize admin
proqik.initAdmin = function() {
    proqik.updateDT();
    proqik.renderFeed();
    proqik.renderNotifs();
    proqik.renderPros(prosData);
    proqik.renderBookings();
    proqik.renderChart();
    proqik.renderCatBars();
    
    setTimeout(function() {
        var bars = [['kf-1', 78], ['kf-2', 65], ['kf-3', 82], ['kf-4', 98]];
        bars.forEach(function(b) {
            var el = document.getElementById(b[0]);
            if (el) el.style.width = b[1] + '%';
        });
    }, 300);
    
    setTimeout(function() {
        proqik.countUp('sn-reg', 7, '', '', 1200);
        proqik.countUp('sn-bk', 23, '', '', 1400);
        proqik.countUp('sn-rv', 3840, '₹', '', 1600);
        proqik.countUp('sn-ac', 38, '', '', 1000);
    }, 400);
};

// Close panels on escape
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        var np = document.getElementById('np');
        var pd = document.getElementById('pd');
        var modal = document.getElementById('add-pro-modal');
        if (np) np.style.display = 'none';
        if (pd) pd.style.display = 'none';
        if (modal) modal.style.display = 'none';
    }
});

// Close panels on outside click
document.addEventListener('click', function(e) {
    var np = document.getElementById('np');
    var pd = document.getElementById('pd');
    var nBtn = document.querySelector('.tb-icon[onclick*="toggleNP"]');
    var pBtn = document.querySelector('.tb-avatar[onclick*="togglePD"]');
    if (np && np.style.display !== 'none' && !np.contains(e.target) && !(nBtn && nBtn.contains(e.target))) {
        np.style.display = 'none';
    }
    if (pd && pd.style.display !== 'none' && !pd.contains(e.target) && !(pBtn && pBtn.contains(e.target))) {
        pd.style.display = 'none';
    }
});

// Toast function for global use
function toast(msg, type) {
    if (typeof proqik.toast === 'function') {
        proqik.toast(msg, type);
    } else {
        var tw = document.getElementById('tw');
        if (!tw) {
            tw = document.createElement('div');
            tw.id = 'tw';
            tw.style.cssText = 'position:fixed;bottom:32px;left:50%;transform:translateX(-50%);z-index:9999;display:flex;flex-direction:column;gap:8px;align-items:center;pointer-events:none';
            document.body.appendChild(tw);
        }
        var t = document.createElement('div');
        t.className = 'tst ' + (type || 'b');
        t.textContent = msg;
        t.style.cssText = 'padding:12px 22px;border-radius:4px;font-size:12px;font-weight:500;letter-spacing:.04em;color:#fff;box-shadow:0 12px 40px rgba(0,0,0,.25)';
        if (type === 'g') t.style.background = '#16875A';
        else if (type === 'r') t.style.background = '#B91C1C';
        else if (type === 'o') { t.style.background = '#C9A84C'; t.style.color = '#0D2137'; }
        else t.style.background = '#0D2137';
        tw.appendChild(t);
        setTimeout(function() { t.remove(); }, 3000);
    }
}

// Global selectRole for login
function selectRole(role) {
    if (typeof window.selectRoleLogin === 'function') {
        window.selectRoleLogin(role);
    }
}