#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== LearnEarnHub Homepage UI Upgrade ==="

cat >> public/assets/css/learn-earnhub-ui.css <<'CSS'

/* ===== LearnEarnHub Homepage Premium Layer ===== */

.hero,
.hero-section,
.banner,
.landing-hero {
  padding:70px 20px;
  text-align:center;
  background:
  linear-gradient(135deg,#2563eb,#16a34a);
  color:white;
  border-radius:24px;
  margin:20px auto;
}

.hero h1,
.hero-section h1,
.landing-hero h1 {
  color:white;
  font-size:clamp(32px,5vw,56px);
  font-weight:800;
}

.hero p,
.hero-section p {
  color:white;
  max-width:700px;
  margin:20px auto;
  font-size:18px;
}

.hero .btn,
.hero button {
  background:white;
  color:#2563eb!important;
  margin:8px;
}

.stats,
.statistics,
.counter-grid {
 display:grid;
 grid-template-columns:repeat(auto-fit,minmax(180px,1fr));
 gap:20px;
 margin:40px 0;
}

.stat-card {
 background:white;
 padding:25px;
 border-radius:18px;
 box-shadow:0 10px 30px rgba(0,0,0,.08);
 text-align:center;
}

.stat-card strong {
 display:block;
 font-size:36px;
 color:#2563eb;
}

.course-card img,
.feature-card img {
 border-radius:14px;
}

.course-card h3,
.feature-card h3 {
 margin-top:15px;
}

.section-title {
 text-align:center;
 margin:50px 0 25px;
}

.section-title h2 {
 font-size:34px;
}

.cta-box {
 padding:40px;
 border-radius:24px;
 background:#0f172a;
 color:white;
 text-align:center;
 margin:40px 0;
}

.cta-box h2 {
 color:white;
}

@media(max-width:600px){

.hero {
 padding:45px 15px;
 border-radius:18px;
}

.hero h1 {
 font-size:32px;
}

.cta-box {
 padding:25px 15px;
}

}

CSS


echo "=== Adding animation ==="

cat >> public/assets/css/learn-earnhub-ui.css <<'CSS'

.fade-up {
 animation:lehFade .6s ease;
}

@keyframes lehFade {
 from {
 opacity:0;
 transform:translateY(20px);
 }
 to {
 opacity:1;
 transform:translateY(0);
 }
}

CSS


echo "=== Done ==="

