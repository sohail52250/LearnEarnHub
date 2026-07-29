#!/data/data/com.termux/files/usr/bin/bash

echo "=== Fixing LearnEarnHub Navigation UI ==="

cat >> public/style.css <<'CSS'

/* ===== Professional Navbar Fix ===== */

.leh-header{
    display:flex !important;
    align-items:center !important;
    justify-content:space-between !important;
    gap:20px !important;
    padding:16px 24px !important;
    flex-wrap:wrap !important;
}

.leh-logo{
    font-size:24px !important;
    font-weight:700 !important;
}

.leh-nav{
    display:flex !important;
    flex-direction:row !important;
    flex-wrap:wrap !important;
    align-items:center !important;
    justify-content:center !important;
    gap:12px !important;
}

.leh-nav a{
    display:inline-flex !important;
    align-items:center !important;
    justify-content:center !important;

    padding:10px 18px !important;

    text-decoration:none !important;
    font-weight:600 !important;

    border-radius:12px !important;

    background:#2563eb !important;
    color:#ffffff !important;

    transition:.25s ease !important;
}

.leh-nav a:hover{
    transform:translateY(-2px);
    opacity:.92;
}

#language-select{
    padding:10px 14px;
    border-radius:10px;
}

@media(max-width:700px){

    .leh-header{
        flex-direction:column !important;
        text-align:center;
    }

    .leh-nav{
        width:100%;
        justify-content:center !important;
    }

    .leh-nav a{
        min-width:130px;
    }
}

CSS

echo "Navbar CSS installed."
