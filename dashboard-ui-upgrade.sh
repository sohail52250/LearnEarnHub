#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== LearnEarnHub Dashboard UI Upgrade ==="

cat >> public/assets/css/learn-earnhub-ui.css <<'CSS'

/* ===== Dashboard Professional UI ===== */

.dashboard,
.dashboard-container,
.admin-panel,
.profile-dashboard {
    padding:25px;
}


.dashboard-grid,
.dashboard-cards,
.stats-grid,
.panel-grid {
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(240px,1fr));
    gap:20px;
    margin:25px 0;
}


.dashboard-card,
.stat-box,
.panel-card {
    background:white;
    border:1px solid #e2e8f0;
    border-radius:18px;
    padding:25px;
    box-shadow:0 10px 25px rgba(15,23,42,.08);
    transition:.25s ease;
}


.dashboard-card:hover,
.stat-box:hover,
.panel-card:hover {
    transform:translateY(-4px);
}


.dashboard-card h3,
.stat-box h3,
.panel-card h3 {
    color:#2563eb;
}


.stat-number {
    font-size:36px;
    font-weight:800;
    color:#16a34a;
}


.sidebar,
.dashboard-sidebar {
    background:#0f172a;
    color:white;
    border-radius:20px;
    padding:20px;
}


.sidebar a,
.dashboard-sidebar a {
    display:block;
    padding:12px;
    margin:6px 0;
    border-radius:10px;
    color:white!important;
    text-decoration:none;
}


.sidebar a:hover,
.dashboard-sidebar a:hover {
    background:#2563eb;
}


table {
    width:100%;
    border-collapse:collapse;
    background:white;
    border-radius:16px;
    overflow:hidden;
}


th {
    background:#2563eb;
    color:white;
    padding:14px;
}


td {
    padding:14px;
    border-bottom:1px solid #e2e8f0;
}


.status-success {
    background:#dcfce7;
    color:#166534;
    padding:5px 12px;
    border-radius:20px;
}


.status-pending {
    background:#fef9c3;
    color:#854d0e;
    padding:5px 12px;
    border-radius:20px;
}


.status-danger {
    background:#fee2e2;
    color:#991b1b;
    padding:5px 12px;
    border-radius:20px;
}


.profile-card {
    display:flex;
    align-items:center;
    gap:20px;
    background:white;
    padding:25px;
    border-radius:20px;
}


.avatar {
    width:80px;
    height:80px;
    border-radius:50%;
    object-fit:cover;
}


@media(max-width:700px){

.dashboard,
.dashboard-container,
.admin-panel {
    padding:15px;
}

.profile-card {
    flex-direction:column;
    text-align:center;
}

table {
    display:block;
    overflow-x:auto;
}

}

CSS


echo "=== Dashboard UI Added ==="

git add .
git commit -m "Upgrade dashboard professional UI"
git push

vercel --prod

echo "=== Completed ==="

