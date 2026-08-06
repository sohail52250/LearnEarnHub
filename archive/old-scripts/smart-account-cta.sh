#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Smart LearnEarnHub Account CTA ==="

cp -r public public_backup_before_smart_cta_$(date +%Y%m%d_%H%M%S)

for f in $(find public -name "*.html"); do

name=$(basename "$f")

case "$name" in
 admin*|forgot-password.html|reset-password.html)
 continue
 ;;
esac


if grep -Eqi 'type="password"|login\(|id="email"' "$f"; then


if ! grep -Eqi 'register.html|signup|create account|join now' "$f"; then


echo "Updating $f"


CTA="/register.html"
TEXT="🚀 Create Account / Join Now"


if echo "$f" | grep -qi "business\|company\|enterprise"; then
CTA="/business-register.html"
TEXT="🏢 Create Business Account"
fi


sed -i "s#</body>#<div class=\"account-cta\"><p>New to LearnEarnHub?</p><a href=\"$CTA\" class=\"btn\">$TEXT</a></div></body>#" "$f"


fi

fi

done


cat >> public/assets/css/learn-earnhub-ui.css <<'CSS'

.account-cta{
text-align:center;
margin:25px auto;
padding:18px;
}

.account-cta .btn{
display:inline-block;
background:#16a34a;
color:white;
padding:10px 20px;
border-radius:12px;
font-weight:700;
text-decoration:none;
}

.account-cta .btn:hover{
transform:translateY(-2px);
opacity:.9;
}

CSS


git add .
git commit -m "Add smart account creation CTAs"
git push

vercel --prod

echo "=== Completed ==="

