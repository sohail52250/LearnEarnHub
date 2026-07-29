#!/data/data/com.termux/files/usr/bin/bash

echo "=== Universal LearnEarnHub UI Fix ==="

cat >> public/assets/css/learn-earnhub-ui.css <<'CSS'

/* ===== UNIVERSAL NAVIGATION SYSTEM ===== */

/* Common navigation containers */
nav,
.leh-nav,
.menu,
.navbar,
.navigation,
.sidebar-nav,
.course-navigation,
.lesson-nav,
.dashboard-nav,
.admin-nav,
.business-nav {

    display:flex !important;
    flex-wrap:wrap !important;
    gap:10px !important;
    align-items:center !important;
}

/* Common navigation links */
nav a,
.leh-nav a,
.menu a,
.navbar a,
.navigation a,
.sidebar-nav a,
.course-navigation a,
.lesson-nav a,
.dashboard-nav a,
.admin-nav a,
.business-nav a {

    display:inline-flex !important;
    align-items:center !important;
    justify-content:center !important;

    padding:10px 16px !important;

    border-radius:12px !important;

    text-decoration:none !important;
    font-weight:600 !important;

    background:#ffffff !important;
    color:#0f172a !important;

    border:1px solid #e2e8f0 !important;

    transition:.25s ease !important;
}

nav a:hover,
.leh-nav a:hover,
.menu a:hover,
.navbar a:hover,
.navigation a:hover,
.sidebar-nav a:hover,
.course-navigation a:hover,
.lesson-nav a:hover,
.dashboard-nav a:hover,
.admin-nav a:hover,
.business-nav a:hover {

    background:#2563eb !important;
    color:white !important;

    transform:translateY(-2px);
}

/* Admin / dashboard cards */
.card,
.dashboard-card,
.panel-card,
.market-card,
.opportunity-card,
.business-card {

    border-radius:16px !important;
}

/* Mobile */
@media(max-width:700px){

    nav,
    .leh-nav,
    .menu,
    .navbar,
    .navigation,
    .sidebar-nav,
    .course-navigation,
    .lesson-nav,
    .dashboard-nav,
    .admin-nav,
    .business-nav {

        justify-content:center !important;
    }

    nav a,
    .leh-nav a,
    .menu a,
    .navbar a,
    .navigation a,
    .sidebar-nav a,
    .course-navigation a,
    .lesson-nav a,
    .dashboard-nav a,
    .admin-nav a,
    .business-nav a {

        min-width:120px;
    }
}

CSS

echo "Universal UI styles added."
