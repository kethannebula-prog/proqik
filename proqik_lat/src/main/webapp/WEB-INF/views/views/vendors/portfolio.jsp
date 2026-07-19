<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.proqik.model.Professional" %>

<%
List<Professional> vendors = (List<Professional>) request.getAttribute("vendors");
if (vendors == null) vendors = new ArrayList();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Portfolio | ProQik</title>
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

@media(max-width:768px){.pf-grid{grid-template-columns:repeat(2,1fr)}}
</style>
</head>
<body>

<div class="pf-header">
  <div class="pf-logo">Pro<span>Qik</span></div>
  <a href="<%= request.getContextPath() %>/dashboard" class="pf-back">← Back to Dashboard</a>
</div>

<div class="pf-main">
  <h1 class="pf-title">My Portfolio</h1>
  <p class="pf-sub">Showcase your best work to attract more clients</p>
  
  <div class="pf-upload" onclick="document.getElementById('pfInput').click()">
    <div class="pf-upload-icon">📤</div>
    <div class="pf-upload-text"><strong>Click to upload</strong> or drag and drop<br/>JPG, PNG up to 10MB</div>
    <input type="file" id="pfInput" style="display:none" accept="image/*" multiple onchange="handleUpload(this)"/>
  </div>
  
  <div class="pf-grid" id="pfGrid">
    <div class="pf-item" onclick="viewImage(0)">
      <img src="https://images.unsplash.com/photo-1519741497674-611481863552?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(0)">👁</button>
        <button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(0)">🗑</button>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(1)">
      <img src="https://images.unsplash.com/photo-1520854221256-17451cc330e7?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(1)">👁</button>
        <button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(1)">🗑</button>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(2)">
      <img src="https://images.unsplash.com/photo-1511285560929-80b456fea0bc?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(2)">👁</button>
        <button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(2)">🗑</button>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(3)">
      <img src="https://images.unsplash.com/photo-1606216794074-735e91aa2c92?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(3)">👁</button>
        <button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(3)">🗑</button>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(4)">
      <img src="https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(4)">👁</button>
        <button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(4)">🗑</button>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(5)">
      <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(5)">👁</button>
        <button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(5)">🗑</button>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(6)">
      <img src="https://images.unsplash.com/photo-1511795409834-ef04bbd61622?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(6)">👁</button>
        <button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(6)">🗑</button>
      </div>
    </div>
    <div class="pf-item" onclick="viewImage(7)">
      <img src="https://images.unsplash.com/photo-1542038784456-1ea8e935640e?w=400&h=400&fit=crop" alt="Portfolio"/>
      <div class="pf-item-overlay">
        <button class="pf-item-btn" onclick="event.stopPropagation();viewImage(7)">👁</button>
        <button class="pf-item-btn pf-item-delete" onclick="event.stopPropagation();deleteImage(7)">🗑</button>
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

<script>
function handleUpload(input) {
  if (input.files && input.files.length > 0) {
    alert('Upload functionality would upload ' + input.files.length + ' file(s). In production, this would save to server.');
  }
}

function viewImage(idx) {
  alert('Opening image ' + (idx + 1) + ' in full view');
}

function deleteImage(idx) {
  if (confirm('Delete this image?')) {
    alert('Image ' + (idx + 1) + ' deleted');
  }
}
</script>

</body>
</html>