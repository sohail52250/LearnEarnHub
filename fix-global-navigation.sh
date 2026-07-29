#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== LearnEarnHub Global Navigation Fix ==="

# Backup
echo "Creating backup..."
cp -r public public_backup_before_nav_fix_$(date +%Y%m%d_%H%M%S)

echo "Updating global navigation CSS..."

cat >> public/assets/css/learn-earnhub-ui.css <<'CSS'

/* ===== LearnEarnHub Global Navigation Professional Style ===== */

.leh-header{
    display:flex!important;
    align-items:center!important;
    justify-content:space-between!important;
    flex-wrap:wrap!important;
    gap:15px!important;
    padding:15px 20px!important;
    background:white;
    border-bottom:1px solid #e5e7eb;
}

.leh-logo{
    font-size:24px!important;
    font-weight:800!important;
}

.leh-nav{
    display:flex!important;
    flex-direction:row!important;
    flex-wrap:wrap!important;
    align-items:center!important;
    gap:8px!important;
}

.leh-nav a{
    display:inline-flex!important;
    align-items:center;
    justify-content:center;
    padding:9px 15px!important;
    border-radius:12px!important;
    background:#2563eb;
    color:white!important;
    text-decoration:none!important;
    font-weight:600;
    transition:.2s ease;
}

.leh-nav a:hover{
    transform:translateY(-2px);
    opacity:.9;
}


/* Fix old simple nav menus */
body nav:not(.leh-nav){
    display:flex!important;
    flex-wrap:wrap!important;
    flex-direction:row!important;
    justify-content:center;
    align-items:center;
    gap:10px!important;
}

body nav:not(.leh-nav) a{
    display:inline-block!important;
    padding:8px 14px!important;
    border-radius:10px!important;
    background:#2563eb;
    color:white!important;
    text-decoration:none!important;
}


/* Mobile */
@media(max-width:700px){

.leh-header{
    flex-direction:column!important;
}

.leh-nav{
    justify-content:center!important;
}

.leh-nav a{
    width:auto!important;
}

}

CSS


echo "Scanning pages..."

# Add global header/footer only where missing
for f in $(find public -name "*.html"); do

    if grep -q "<body" "$f"; then

        if ! grep -q 'id="global-header"' "$f"; then
            sed -i 's/<body[^>]*>/<body><div id="global-header"><\/div>/' "$f"
            echo "Header added: $f"
        fi

        if ! grep -q 'id="global-footer"' "$f"; then
            sed -i 's#</body>#<div id="global-footer"></div><script src="/global-layout.js"></script></body>#' "$f"
            echo "Footer added: $f"
        fi

    fi

done


echo "Git update..."

git add .

git commit -m "Professional global navigation update"

git push


echo "Deploying..."

vercel --prod


echo "=== Completed Successfully ==="

