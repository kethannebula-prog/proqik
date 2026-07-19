<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.proqik.model.Professional" %>

<%
List<Professional> vendors = (List<Professional>) request.getAttribute("vendors");
if (vendors == null) vendors = new ArrayList();
boolean adminView = request.getAttribute("adminView") != null && (Boolean)request.getAttribute("adminView");
String vName = (String) request.getAttribute("vendorName");
String vEmail = (String) request.getAttribute("vendorEmail");
String vCategory = (String) request.getAttribute("vendorCategory");
if (vName == null) vName = "Vendor";
if (vCategory == null) vCategory = "Photography";
String catLower = vCategory.toLowerCase();

// Category-based portfolio images
String[][] catImages = {
  {"https://images.unsplash.com/photo-1519741497674-611481863552","https://images.unsplash.com/photo-1520854221256-17451cc330e7","https://images.unsplash.com/photo-1511285560929-80b456fea0bc","https://images.unsplash.com/photo-1606216794074-735e91aa2c92","https://images.unsplash.com/photo-1469334031218-e382a71b716b","https://images.unsplash.com/photo-1504674900247-0877df9cc836","https://images.unsplash.com/photo-1511795409834-ef04bbd61622","https://images.unsplash.com/photo-1542038784456-1ea8e935640e"}
};
String[] cats = {"photography","videography","album","makeup","decoration","catering"};
String[][] catImageSets = {
  // photography
  {"photo-1519741497674-611481863552","photo-1520854221256-17451cc330e7","photo-1511285560929-80b456fea0bc","photo-1606216794074-735e91aa2c92","photo-1469334031218-e382a71b716b","photo-1504674900247-0877df9cc836","photo-1511795409834-ef04bbd61622","photo-1542038784456-1ea8e935640e"},
  // videography
  {"photo-1492691527719-9d1e07e534b4","photo-1536240478700-b869070f9279","photo-1574717024453-354056aaf998","photo-1598387993441-a364f854c3e1","photo-1492724724894-7464c27d0ceb","photo-1540575467063-178a50c2df87","photo-1504384308090-c894fdcc538d","photo-1557804506-669a67965ba0"},
  // album
  {"photo-1459749411175-04bf5292ceea","photo-1514525253161-7a46d19cd819","photo-1470229722913-7c0e2dbbafd3","photo-1493225457124-a3eb161ffa5f","photo-1516450360452-9312f5e86fc7","photo-1501386761578-eac5c94b800a","photo-1470225620780-dba8ba36b745","photo-1429962714451-bb934ecdc4ec"},
  // makeup
  {"photo-1487412912498-0447578fcca8","photo-1522337360788-8b13dee7a37e","photo-1596462502278-27bfdc403348","photo-1583241800698-edf714a1e8ec","photo-1567894340315-735d7c361db7","photo-1549236177-5c0c4d6e2a8c","photo-1570172619644-dfd03ed5d881","photo-1594035910387-fea47794261f"},
  // decoration
  {"photo-1519741497674-611481863552","photo-1520854221256-17451cc330e7","photo-1511285560929-80b456fea0bc","photo-1606216794074-735e91aa2c92","photo-1469334031218-e382a71b716b","photo-1504674900247-0877df9cc836","photo-1511795409834-ef04bbd61622","photo-1542038784456-1ea8e935640e"},
  // catering
  {"photo-1555244162-803834f70033","photo-1414235077428-338989a2e8c0","photo-1482049016688-2d3e1b3115bf","photo-1504674900247-0877df9cc836","photo-1476224203421-9ac39bcb3327","photo-1414235077428-338989a2e8c0","photo-1485182708500-8d1fecd4312a","photo-1540189549336-e6e99c3679fe"}
};
int catIdx = 0;
for (int i = 0; i < cats.length; i++) {
  if (catLower.contains(cats[i])) { catIdx = i; break; }
}
String[] pfImages = catImageSets[catIdx];
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= adminView ? vName + "'s Portfolio" : "My Portfolio" %> | ProQik</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/dashboard-unified.css"/>
<style>
:root{--navy:#0D2137;--teal:#0A8F76;--gold:#C9A84C;--cream:#F8F6F1;--ink:#0D1117;--muted:#6B7B8D;--muted2:#9AAAB8;--border:#E4E8EE;--white:#FFFFFF;--display:'Cormorant Garamond',Georgia,serif;--body:'Jost',system-ui,sans-serif}
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:var(--body);background:var(--cream);color:var(--ink)}
button,input,select{font-family:var(--body)}

.pf-header{background:var(--navy);padding:20px 32px;display:flex;align-items:center;justify-content:space-between}
.pf-logo{font-family:var(--display);font-size:20px;color:#fff;display:flex;align-items:center;gap:10px}
.pf-logo span{color:var(--teal)}
.pf-back{color:#fff;font-size:13px;text-decoration:none;display:flex;align-items:center;gap:6px}
.pf-back:hover{text-decoration:underline}

.pf-main{max-width:1200px;margin:0 auto;padding:32px 20px}
.pf-title{font-family:var(--display);font-size:32px;margin-bottom:8px}
.pf-sub{font-size:14px;color:var(--muted);margin-bottom:32px}

.pf-upload{background:#fff;border:2px dashed var(--border);border-radius:12px;padding:40px;text-align:center;cursor:pointer;transition:all .2s;margin-bottom:32px}
.pf-upload:hover{border-color:var(--teal);background:rgba(10,143,118,.02)}
.pf-upload-icon{font-size:36px;margin-bottom:12px}
.pf-upload-text{font-size:14px;color:var(--muted)}
.pf-upload-text strong{color:var(--navy)}

.pf-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:16px}
.pf-item{aspect-ratio:1;border-radius:8px;overflow:hidden;position:relative;cursor:pointer;background:var(--border)}
.pf-item img{width:100%;height:100%;object-fit:cover;transition:transform .3s}
.pf-item:hover img{transform:scale(1.05)}
.pf-item-overlay{position:absolute;inset:0;background:rgba(0,0,0,.4);opacity:0;transition:opacity .2s;display:flex;align-items:center;justify-content:center;gap:12px}
.pf-item:hover .pf-item-overlay{opacity:1}
.pf-item-btn{width:36px;height:36px;border-radius:50%;background:#fff;border:none;cursor:pointer;font-size:14px;display:flex;align-items:center;justify-content:center}
.pf-item-delete{background:#ff4444;color:#fff}

.pf-empty{grid-column:1/-1;text-align:center;padding:60px 20px;color:var(--muted2)}
.pf-empty-icon{font-size:48px;margin-bottom:12px}

.pf-nav{display:flex;justify-content:center;gap:8px;margin-top:40px}
.pf-nav button{padding:10px 16px;border:1px solid var(--border);background:#fff;border-radius:6px;font-size:13px;cursor:pointer}
.pf-nav button.active{background:var(--navy);color:#fff;border-color:var(--navy)}

/* Lightbox */
.lightbox{display:none;position:fixed;inset:0;background:rgba(0,0,0,.92);z-index:9999;align-items:center;justify-content:center;padding:40px}
.lightbox.active{display:flex}
.lightbox-close{position:absolute;top:24px;right:32px;width:48px;height:48px;border:1px solid rgba(255,255,255,.2);border-radius:50%;background:transparent;color:#fff;font-size:24px;cursor:pointer;transition:all .2s;display:flex;align-items:center;justify-content:center}
.lightbox-close:hover{background:rgba(255,255,255,.1);border-color:rgba(255,255,255,.4)}
.lightbox-img{max-width:90vw;max-height:85vh;border-radius:4px;box-shadow:0 20px 60px rgba(0,0,0,.5);object-fit:contain}
.lightbox-prev,.lightbox-next{position:absolute;top:50%;transform:translateY(-50%);width:56px;height:56px;border:none;background:rgba(255,255,255,.08);border-radius:50%;color:#fff;font-size:28px;cursor:pointer;transition:all .2s;display:flex;align-items:center;justify-content:center}
.lightbox-prev:hover,.lightbox-next:hover{background:rgba(255,255,255,.16)}
.lightbox-prev{left:24px}
.lightbox-next{right:24px}
.lightbox-counter{position:absolute;bottom:24px;left:50%;transform:translateX(-50%);color:rgba(255,255,255,.5);font-size:14px;letter-spacing:1px}

@media(max-width:768px){.pf-grid{grid-template-columns:repeat(2,1fr)}.lightbox{padding:16px}.lightbox-prev,.lightbox-next{width:40px;height:40px;font-size:20px}.lightbox-prev{left:8px}.lightbox-next{right:8px}}
</style>
</head>
<body>

<div class="pf-header">
  <div class="pf-logo">Pro<span>Qik</span></div>
  <% if (adminView) { %>
  <a href="<%= request.getContextPath() %>/admin" class="pf-back">← Back to Admin Panel</a>
  <% } else { %>
  <a href="<%= request.getContextPath() %>/dashboard" class="pf-back">← Back to Dashboard</a>
  <% } %>
</div>

<div class="pf-main">
  <h1 class="pf-title"><%= adminView ? vName + "'s Portfolio" : "My Portfolio" %></h1>
  <p class="pf-sub"><%= adminView ? "Viewing portfolio of " + vName : "Showcase your best work to attract more clients" %></p>
  
  <% if (!adminView) { %>
  <div class="pf-upload" onclick="document.getElementById('pfInput').click()">
    <div class="pf-upload-icon">📤</div>
    <div class="pf-upload-text"><strong>Click to upload</strong> or drag and drop<br/>JPG, PNG up to 10MB</div>
    <input type="file" id="pfInput" style="display:none" accept="image/*" multiple onchange="handleUpload(this)"/>
  </div>
  <% } %>
  
  <div class="pf-grid" id="pfGrid">
    <% for (int i = 0; i < pfImages.length; i++) { %>
    <div class="pf-item" onclick="viewImage(<%= i %>)">
      <img src="https://images.unsplash.com/<%= pfImages[i] %>?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(<%= i %>)">👁</button>
        <% if (!adminView) { %><button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(<%= i %>)">🗑</button><% } %>
      </div>
    </div>
    <% } %>
  </div>
    </div>
    <div class="pf-item" onclick="viewImage(1)">
      <img src="https://images.unsplash.com/photo-1520854221256-17451cc330e7?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(1)">👁</button>
        <% if (!adminView) { %><button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(1)">🗑</button><% } %>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(2)">
      <img src="https://images.unsplash.com/photo-1511285560929-80b456fea0bc?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(2)">👁</button>
        <% if (!adminView) { %><button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(2)">🗑</button><% } %>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(3)">
      <img src="https://images.unsplash.com/photo-1606216794074-735e91aa2c92?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(3)">👁</button>
        <% if (!adminView) { %><button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(3)">🗑</button><% } %>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(4)">
      <img src="https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(4)">👁</button>
        <% if (!adminView) { %><button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(4)">🗑</button><% } %>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(5)">
      <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(5)">👁</button>
        <% if (!adminView) { %><button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(5)">🗑</button><% } %>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(6)">
      <img src="https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(6)">👁</button>
        <% if (!adminView) { %><button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(6)">🗑</button><% } %>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(7)">
      <img src="https://images.unsplash.com/photo-1542038784456-1ea8e935640e?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(7)">👁</button>
        <% if (!adminView) { %><button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(7)">🗑</button><% } %>
      </div>
    </div>
  </div>
  
  <div class="pf-nav">
    <button>←</button>
    <button class="active">1</button>
    <button>2</button>
    <button>3</button>
    <button>→</button>
  </div>
</div>

<div class="lightbox" id="lightbox">
  <button class="lightbox-close" onclick="closeLightbox()">&times;</button>
  <button class="lightbox-prev" onclick="prevImage()">&#8249;</button>
  <img class="lightbox-img" id="lightboxImg" src="" alt="Portfolio"/>
  <button class="lightbox-next" onclick="nextImage()">&#8250;</button>
  <div class="lightbox-counter" id="lightboxCounter"></div>
</div>

<script>
var currentIdx = 0;
var totalImages = <%= pfImages.length %>;
var imageUrls = [
  <% for (int i = 0; i < pfImages.length; i++) { %>"https://images.unsplash.com/<%= pfImages[i] %>?w=1200&h=900&fit=crop"<%= i < pfImages.length - 1 ? "," : "" %>
  <% } %>
];

function viewImage(idx) {
  currentIdx = idx;
  updateLightbox();
  document.getElementById('lightbox').classList.add('active');
  document.body.style.overflow = 'hidden';
}

function closeLightbox() {
  document.getElementById('lightbox').classList.remove('active');
  document.body.style.overflow = '';
}

function nextImage() {
  currentIdx = (currentIdx + 1) % totalImages;
  updateLightbox();
}

function prevImage() {
  currentIdx = (currentIdx - 1 + totalImages) % totalImages;
  updateLightbox();
}

function updateLightbox() {
  document.getElementById('lightboxImg').src = imageUrls[currentIdx];
  document.getElementById('lightboxCounter').textContent = (currentIdx + 1) + ' / ' + totalImages;
}

document.addEventListener('keydown', function(e) {
  if (!document.getElementById('lightbox').classList.contains('active')) return;
  if (e.key === 'Escape') closeLightbox();
  if (e.key === 'ArrowRight') nextImage();
  if (e.key === 'ArrowLeft') prevImage();
});

<% if (!adminView) { %>
function handleUpload(input) {
  if (input.files && input.files.length > 0) {
    alert('Upload functionality would upload ' + input.files.length + ' file(s). In production, this would save to server.');
  }
}
<% } %>

<% if (!adminView) { %>
function deleteImage(idx) {
  if (confirm('Delete this image?')) {
    alert('Image ' + (idx + 1) + ' deleted');
  }
}
<% } %>
</script>

</body>
</html>
