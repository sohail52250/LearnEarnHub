#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Site-Wide Navigation Upgrade ==="

echo ""
echo "=== Detected navigation classes ==="
grep -Rho 'class="[^"]*"' public 2>/dev/null | \
tr ' ' '\n' | \
grep -Ei 'nav|menu|sidebar|dashboard|admin|course|lesson|business' | \
sort -u

cat >> public/assets/css/learn-earnhub-ui.css <<'CSS'

/* ===== SITE-WIDE PROFESSIONAL NAVIGATION ===== */

nav,
[class*="nav"],
[class*="menu"],
[class*="sidebar"]{

    display:flex !important;
    flex-direction:row !important;
    flex-wrap:wrap !important;

    align-items:center !important;
    gap:10px !important;
}

/* All navigation links */

nav a,
[class*="nav"] a,
[class*="menu"] a,
[class*="sidebar"] a{

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
[class*="nav"] a:hover,
[class*="menu"] a:hover,
[class*="sidebar"] a:hover{

    background:#2563eb !important;
    color:white !important;

    transform:translateY(-2px);
}

/* Cards */

.card,
.dashboard-card,
.panel-card,
.market-card,
.business-card,
.opportunity-card,
.course-card{

    border-radius:16px !important;
}

/* Containers */

.container,
.content,
.main-content{

    max-width:1400px;
    margin:auto;
}

/* Mobile */

@media(max-width:768px){

    nav,
    [class*="nav"],
    [class*="menu"],
    [class*="sidebar"]{

        justify-content:center !important;
    }

    nav a,
    [class*="nav"] a,
    [class*="menu"] a,
    [class*="sidebar"] a{

        min-width:120px;
    }
}

CSS

echo ""
echo "Upgrade complete."
