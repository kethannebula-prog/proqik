<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Your Profile | ProQik</title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
:root{
  --navy:#122f66;
  --navy-deep:#122f66;
  --navy-mid:#1e55b0;
  --navy-light:#e8f0fc;
  --navy-xlight:#f0f5ff;
  --white:#ffffff;
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
}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
body{font-family:var(--font);background:linear-gradient(135deg,rgba(8,18,36,.95)0%,rgba(18,47,102,.9)100%);min-height:100vh;display:flex;align-items:center;justify-content:center;padding:20px}
a{text-decoration:none;color:inherit}
button{cursor:pointer;font-family:var(--font);border:none;background:none}
input,select,textarea{font-family:var(--font)}

.setup-container{
  max-width:720px;width:100%;background:#fff;border-radius:24px;overflow:hidden;box-shadow:0 40px 120px rgba(0,0,0,.5)
}
.setup-header{
  background:var(--navy);padding:32px 40px;text-align:center
}
.setup-logo{margin-bottom:20px}
.setup-logo svg{width:120px}
.setup-title{font-family:var(--disp);font-size:24px;font-weight:800;color:#fff;margin-bottom:8px}
.setup-subtitle{font-size:14px;color:rgba(255,255,255,.6)}

.setup-progress{
  display:flex;justify-content:center;padding:24px 40px;gap:8px;background:var(--gray-50)
}
.setup-step{
  display:flex;align-items:center;gap:8px
}
.setup-step-num{
  width:28px;height:28px;border-radius:50%;background:var(--gray-200);color:var(--gray-600);font-size:12px;font-weight:700;display:flex;align-items:center;justify-content:center
}
.setup-step.active .setup-step-num{background:var(--navy);color:#fff}
.setup-step.completed .setup-step-num{background:var(--success);color:#fff}
.setup-step-label{font-size:12px;color:var(--gray-400);font-weight:600}
.setup-step.active .setup-step-label,.setup-step.completed .setup-step-label{color:var(--gray-800)}
.setup-step-line{width:40px;height:2px;background:var(--gray-200)}
.setup-step.completed+.setup-step-line{background:var(--success)}

.setup-body{padding:40px}
.setup-panel{display:none}
.setup-panel.active{display:block}

.setup-input-group{margin-bottom:20px}
.setup-label{display:block;font-size:12px;font-weight:700;color:var(--gray-600);letter-spacing:.05em;text-transform:uppercase;margin-bottom:8px}
.setup-input,.setup-select,.setup-textarea{
  width:100%;padding:14px 16px;border:1.5px solid var(--gray-200);border-radius:12px;font-size:14px;color:var(--gray-800);outline:none;transition:all .2s;background:#fff
}
.setup-input:focus,.setup-select:focus,.setup-textarea:focus{border-color:var(--navy);box-shadow:0 0 0 4px rgba(27,74,151,.08)}
.setup-textarea{resize:vertical;min-height:100px}

.setup-row{display:grid;grid-template-columns:1fr 1fr;gap:16px}
@media(max-width:600px){.setup-row{grid-template-columns:1fr}}

.setup-category-grid{
  display:grid;grid-template-columns:repeat(3,1fr);gap:12px;margin-top:8px
}
@media(max-width:600px){.setup-category-grid{grid-template-columns:repeat(2,1fr)}}
.setup-category-card{
  border:2px solid var(--gray-200);border-radius:14px;padding:20px;text-align:center;cursor:pointer;transition:all .2s
}
.setup-category-card:hover{border-color:var(--navy-light);background:var(--navy-xlight)}
.setup-category-card.selected{border-color:var(--navy);background:var(--navy-xlight)}
.setup-category-icon{font-size:32px;margin-bottom:8px}
.setup-category-name{font-size:13px;font-weight:700;color:var(--gray-800)}
.setup-category-desc{font-size:11px;color:var(--gray-400);margin-top:4px}

.setup-nav{display:flex;justify-content:space-between;margin-top:32px;gap:16px}
.setup-btn{
  padding:14px 28px;border-radius:12px;font-size:14px;font-weight:700;transition:all .2s;display:flex;align-items:center;gap:8px
}
.setup-btn-secondary{background:var(--gray-100);color:var(--gray-600)}
.setup-btn-secondary:hover{background:var(--gray-200)}
.setup-btn-primary{background:var(--navy);color:#fff;box-shadow:0 4px 16px rgba(27,74,151,.3)}
.setup-btn-primary:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(27,74,151,.4)}
.setup-btn-gold{background:var(--gold);color:var(--navy);box-shadow:0 4px 16px rgba(201,168,76,.4)}
.setup-btn-gold:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(201,168,76,.5)}

.setup-success{
  text-align:center;padding:40px
}
.setup-success-icon{
  width:80px;height:80px;border-radius:50%;background:var(--gold-light);display:flex;align-items:center;justify-content:center;margin:0 auto 24px;font-size:40px
}
.setup-success-title{font-family:var(--disp);font-size:22px;font-weight:800;color:var(--gray-800);margin-bottom:8px}
.setup-success-msg{font-size:14px;color:var(--gray-400);margin-bottom:32px}

.setup-features{
  background:var(--gray-50);border-radius:14px;padding:20px;margin-top:20px
}
.setup-features-title{font-size:12px;font-weight:700;color:var(--gray-600);letter-spacing:.05em;text-transform:uppercase;margin-bottom:12px}
.setup-feature-item{display:flex;align-items:center;gap:10px;margin-bottom:10px;font-size:13px;color:var(--gray-600)}
.setup-feature-item:last-child{margin-bottom:0}
.setup-feature-item svg{width:16px;height:16px;color:var(--success)}
    </style>
</head>
<body>

<div class="setup-container">
  <div class="setup-header">
    <div class="setup-logo">
      <img src="<%= request.getContextPath() %>/resources/img/logo.svg" alt="ProQik" style="height:36px"/>
    </div>
    <div class="setup-title">Complete Your Profile</div>
    <div class="setup-subtitle">Set up your professional profile to start receiving bookings</div>
  </div>
  
  <div class="setup-progress">
    <div class="setup-step active" id="step1-indicator">
      <span class="setup-step-num">1</span>
      <span class="setup-step-label">Category</span>
    </div>
    <div class="setup-step-line" id="line1"></div>
    <div class="setup-step" id="step2-indicator">
      <span class="setup-step-num">2</span>
      <span class="setup-step-label">Details</span>
    </div>
    <div class="setup-step-line" id="line2"></div>
    <div class="setup-step" id="step3-indicator">
      <span class="setup-step-num">3</span>
      <span class="setup-step-label">Ready</span>
    </div>
  </div>
  
  <form action="<%= request.getContextPath() %>/vendor/setup" method="POST" id="setupForm">
    <input type="hidden" name="step" id="currentStep" value="1"/>
    <input type="hidden" name="category" id="selectedCategory" value=""/>
    <input type="hidden" name="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>"/>
    
    <!-- Step 1: Category Selection -->
    <div class="setup-body setup-panel active" id="panel1">
      <div class="setup-title" style="font-size:20px;margin-bottom:8px">What type of professional are you?</div>
      <div class="setup-subtitle" style="margin-bottom:24px">Select the category that best describes your services</div>
      
      <div class="setup-category-grid">
        <div class="setup-category-card" onclick="selectCategory('photography', this)">
          <div class="setup-category-icon">&#128247;</div>
          <div class="setup-category-name">Photography</div>
          <div class="setup-category-desc">Weddings, portraits, events</div>
        </div>
        <div class="setup-category-card" onclick="selectCategory('videography', this)">
          <div class="setup-category-icon">&#127909;</div>
          <div class="setup-category-name">Videography</div>
          <div class="setup-category-desc">Films, events, commercials</div>
        </div>
        <div class="setup-category-card" onclick="selectCategory('album-editing', this)">
          <div class="setup-category-icon">&#128190;</div>
          <div class="setup-category-name">Album Editing</div>
          <div class="setup-category-desc">Photo editing, retouching</div>
        </div>
        <div class="setup-category-card" onclick="selectCategory('makeup', this)">
          <div class="setup-category-icon">&#10024;</div>
          <div class="setup-category-name">Makeup Artist</div>
          <div class="setup-category-desc">Bridal, events, editorial</div>
        </div>
        <div class="setup-category-card" onclick="selectCategory(' decoration', this)">
          <div class="setup-category-icon">&#127917;</div>
          <div class="setup-category-name">Decoration</div>
          <div class="setup-category-desc">Events, weddings, venues</div>
        </div>
        <div class="setup-category-card" onclick="selectCategory('catering', this)">
          <div class="setup-category-icon">&#127869;</div>
          <div class="setup-category-name">Catering</div>
          <div class="setup-category-desc">Events, weddings, parties</div>
        </div>
      </div>
      
      <div class="setup-nav">
        <button type="button" class="setup-btn setup-btn-secondary" onclick="skipSetup()">Skip for Now</button>
        <button type="button" class="setup-btn setup-btn-primary" onclick="nextStep()">Continue</button>
      </div>
    </div>
    
    <!-- Step 2: Business Details -->
    <div class="setup-body setup-panel" id="panel2">
      <div class="setup-title" style="font-size:20px;margin-bottom:8px">Tell us about your business</div>
      <div class="setup-subtitle" style="margin-bottom:24px">This information will be visible to clients</div>
      
      <div class="setup-input-group">
        <label class="setup-label">Business Name</label>
        <input type="text" name="businessName" class="setup-input" placeholder="Your business name"/>
      </div>
      
      <div class="setup-row">
        <div class="setup-input-group">
          <label class="setup-label">Years of Experience</label>
          <select name="experience" class="setup-select">
            <option value="">Select...</option>
            <option value="0-1">Less than 1 year</option>
            <option value="1-3">1-3 years</option>
            <option value="3-5">3-5 years</option>
            <option value="5-10">5-10 years</option>
            <option value="10+">10+ years</option>
          </select>
        </div>
        <div class="setup-input-group">
          <label class="setup-label">Location</label>
          <select name="location" class="setup-select">
            <option value="">Select location...</option>
            <option value="suva">Suva</option>
            <option value="nadi">Nadi</option>
            <option value="lautoka">Lautoka</option>
            <option value="labasa">Labasa</option>
            <option value="other">Other</option>
          </select>
        </div>
      </div>
      
      <div class="setup-input-group">
        <label class="setup-label">Description</label>
        <textarea name="description" class="setup-textarea" placeholder="Tell clients about your services, style, and what makes you unique..."></textarea>
      </div>
      
      <div class="setup-nav">
        <button type="button" class="setup-btn setup-btn-secondary" onclick="prevStep()">&#8592; Back</button>
        <button type="button" class="setup-btn setup-btn-primary" onclick="nextStep()">Continue</button>
      </div>
    </div>
    
    <!-- Step 3: Services & Pricing -->
    <div class="setup-body setup-panel" id="panel3">
      <div class="setup-title" style="font-size:20px;margin-bottom:8px">What services do you offer?</div>
      <div class="setup-subtitle" style="margin-bottom:24px">Add your service packages and pricing</div>
      
      <div class="setup-input-group">
        <label class="setup-label">Service Name</label>
        <input type="text" name="serviceName" class="setup-input" placeholder="e.g., Wedding Photography Package"/>
      </div>
      
      <div class="setup-row">
        <div class="setup-input-group">
          <label class="setup-label">Starting Price (FJD)</label>
          <input type="number" name="priceStart" class="setup-input" placeholder="500"/>
        </div>
        <div class="setup-input-group">
          <label class="setup-label">Service Duration</label>
          <select name="duration" class="setup-select">
            <option value="">Select...</option>
            <option value="2h">2 hours</option>
            <option value="4h">4 hours</option>
            <option value="6h">6 hours</option>
            <option value="8h">8 hours</option>
            <option value="full-day">Full day</option>
          </select>
        </div>
      </div>
      
      <div class="setup-input-group">
        <label class="setup-label">What's included?</label>
        <textarea name="serviceIncludes" class="setup-textarea" placeholder="e.g., 200 edited photos, 1 hour consultation, online gallery..." style="min-height:80px"></textarea>
      </div>
      
      <div class="setup-nav">
        <button type="button" class="setup-btn setup-btn-secondary" onclick="prevStep()">&#8592; Back</button>
        <button type="button" class="setup-btn setup-btn-primary" onclick="nextStep()">Review & Complete</button>
      </div>
    </div>
    
    <!-- Step 3: Complete -->
    <div class="setup-body setup-panel" id="panel3">
      <div class="setup-success">
        <div class="setup-success-icon">&#127881;</div>
        <div class="setup-success-title">Almost there!</div>
        <div class="setup-success-msg">Review your information and complete your profile setup.</div>
        
        <div class="setup-features">
          <div class="setup-features-title">What happens next?</div>
          <div class="setup-feature-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
            Your profile will be visible to potential clients
          </div>
          <div class="setup-feature-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
            You'll receive booking notifications
          </div>
          <div class="setup-feature-item">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="20 6 9 17 4 12"/></svg>
            You can update your portfolio anytime
          </div>
        </div>
      </div>
      
      <div class="setup-nav" style="justify-content:center">
        <button type="button" class="setup-btn setup-btn-secondary" onclick="prevStep()">&#8592; Back</button>
        <button type="submit" class="setup-btn setup-btn-gold">Complete Setup</button>
      </div>
    </div>
  </form>
</div>

<script>
var currentStep = 1;
var selectedCategory = '';

function selectCategory(cat, elem){
  selectedCategory = cat;
  document.getElementById('selectedCategory').value = cat;
  document.querySelectorAll('.setup-category-card').forEach(function(c){
    c.classList.remove('selected');
  });
  elem.classList.add('selected');
}

function updateProgress(step){
  for(var i=1; i<=4; i++){
    var stepEl = document.getElementById('step'+i+'-indicator');
    var lineEl = document.getElementById('line'+i);
    if(i < step){
      stepEl.classList.add('completed');
      stepEl.classList.remove('active');
      if(lineEl) lineEl.classList.add('completed');
    } else if(i === step){
      stepEl.classList.add('active');
      stepEl.classList.remove('completed');
      if(lineEl) lineEl.classList.remove('completed');
    } else {
      stepEl.classList.remove('active','completed');
      if(lineEl) lineEl.classList.remove('completed');
    }
  }
}

function showPanel(step){
  document.querySelectorAll('.setup-panel').forEach(function(p){
    p.classList.remove('active');
  });
  document.getElementById('panel'+step).classList.add('active');
  updateProgress(step);
  document.getElementById('currentStep').value = step;
}

function nextStep(){
  if(currentStep === 1 && !selectedCategory){
    alert('Please select a category');
    return;
  }
  if(currentStep < 3){
    currentStep++;
    showPanel(currentStep);
  }
}

function prevStep(){
  if(currentStep > 1){
    currentStep--;
    showPanel(currentStep);
  }
}

function skipSetup(){
  window.location.href = '<%= request.getContextPath() %>/dashboard';
}

// Enter key navigation
document.addEventListener('keydown',function(e){
  if(e.key === 'Enter' && e.target.tagName !== 'BUTTON'){
    e.preventDefault();
    nextStep();
  }
});
</script>

</body>
</html>