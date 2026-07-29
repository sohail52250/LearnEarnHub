#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== LearnEarnHub Marketplace UI Upgrade ==="

cat >> public/assets/css/learn-earnhub-ui.css <<'CSS'

/* ===== Marketplace Professional UI ===== */

.marketplace,
.market-container,
.business-marketplace,
.opportunity-list {
    padding:25px;
}


.market-grid,
.opportunity-grid,
.business-grid,
.matching-grid {
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
    gap:22px;
    margin:25px 0;
}


.market-card,
.opportunity-card,
.business-card,
.offer-card {
    background:white;
    border:1px solid #e2e8f0;
    border-radius:20px;
    padding:25px;
    box-shadow:0 10px 30px rgba(15,23,42,.08);
    transition:.25s ease;
}


.market-card:hover,
.opportunity-card:hover,
.business-card:hover,
.offer-card:hover {
    transform:translateY(-5px);
}


.market-card h2,
.opportunity-card h2,
.business-card h2 {
    color:#2563eb;
}


.category-tag {
    display:inline-block;
    background:#dbeafe;
    color:#1e40af;
    padding:6px 14px;
    border-radius:20px;
    font-size:14px;
    margin:5px 0;
}


.skill-tag {
    display:inline-block;
    background:#dcfce7;
    color:#166534;
    padding:6px 12px;
    border-radius:20px;
    margin:4px;
}


.price-box {
    font-size:24px;
    font-weight:800;
    color:#16a34a;
    margin:15px 0;
}


.search-box,
.filter-box {
    background:white;
    padding:20px;
    border-radius:18px;
    box-shadow:0 8px 25px rgba(0,0,0,.08);
    margin-bottom:25px;
}


.search-box input,
.filter-box select {
    margin-bottom:10px;
}


.contact-btn {
    background:#16a34a!important;
}


.apply-btn {
    background:#2563eb!important;
}


.verified-badge {
    background:#dcfce7;
    color:#166534;
    padding:5px 12px;
    border-radius:20px;
    font-weight:600;
}


.featured-card {
    border:2px solid #2563eb;
}


.empty-state {
    text-align:center;
    padding:40px;
    background:white;
    border-radius:20px;
    color:#64748b;
}


@media(max-width:700px){

.marketplace,
.market-container {
    padding:15px;
}

.market-card,
.opportunity-card {
    padding:18px;
}

}

CSS


git add .
git commit -m "Upgrade marketplace and business UI"
git push

vercel --prod

echo "=== Marketplace UI Completed ==="

