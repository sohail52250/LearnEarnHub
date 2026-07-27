#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Backup homepage ==="
cp public/index.html public/index-before-i18n-connect-$(date +%Y%m%d-%H%M%S).html

echo "=== Add translation keys ==="

python3 <<'PY'
import json, os

translations = {
"en": {
"home_title":"🚀 LearnEarnHub",
"home_subtitle":"Learn Skills • Earn Opportunities • Build Business • Grow Enterprise",
"learning_hub":"🎓 Learning Hub",
"career_hub":"💼 Career & Opportunities",
"business_hub":"🏢 Business Hub",
"enterprise_hub":"🤝 Sponsorship & Enterprise",
"choose_path":"Choose Your Path",
"learner":"Learner",
"freelancer":"Freelancer",
"business":"Business",
"enterprise":"Enterprise"
},
"ur": {
"home_title":"🚀 لرن ارن حب",
"home_subtitle":"مہارتیں سیکھیں • مواقع کمائیں • کاروبار بنائیں • ادارہ ترقی دیں",
"learning_hub":"🎓 تعلیمی مرکز",
"career_hub":"💼 کیریئر اور مواقع",
"business_hub":"🏢 بزنس حب",
"enterprise_hub":"🤝 اسپانسر شپ اور انٹرپرائز",
"choose_path":"اپنا راستہ منتخب کریں",
"learner":"سیکھنے والا",
"freelancer":"فری لانسر",
"business":"کاروبار",
"enterprise":"ادارہ"
},
"ar": {
"home_title":"🚀 LearnEarnHub",
"home_subtitle":"تعلم المهارات • اكسب الفرص • ابنِ الأعمال • طور المؤسسة",
"learning_hub":"🎓 مركز التعلم",
"career_hub":"💼 الوظائف والفرص",
"business_hub":"🏢 مركز الأعمال",
"enterprise_hub":"🤝 المؤسسات والشراكات",
"choose_path":"اختر مسارك",
"learner":"متعلم",
"freelancer":"مستقل",
"business":"عمل",
"enterprise":"مؤسسة"
},
"nl": {
"home_title":"🚀 LearnEarnHub",
"home_subtitle":"Leer vaardigheden • Verdien kansen • Bouw bedrijven • Groei wereldwijd",
"learning_hub":"🎓 Leercentrum",
"career_hub":"💼 Carrière en kansen",
"business_hub":"🏢 Bedrijfscentrum",
"enterprise_hub":"🤝 Sponsoring en onderneming",
"choose_path":"Kies je pad",
"learner":"Leerling",
"freelancer":"Freelancer",
"business":"Bedrijf",
"enterprise":"Onderneming"
}
}

for lang, items in translations.items():
    path=f"public/translations/{lang}.json"
    if os.path.exists(path):
        with open(path,encoding="utf-8") as f:
            data=json.load(f)
    else:
        data={}
    data.update(items)
    with open(path,"w",encoding="utf-8") as f:
        json.dump(data,f,ensure_ascii=False,indent=2)

print("Translation keys added")
PY


echo "=== Connect homepage ==="

python3 <<'PY'
p="public/index.html"

with open(p,encoding="utf-8") as f:
    s=f.read()

s=s.replace(
"<h1>🚀 LearnEarnHub</h1>",
'<h1 data-i18n="home_title">🚀 LearnEarnHub</h1>'
)

s=s.replace(
"Learn Skills • Earn Opportunities • Grow Business",
'<span data-i18n="home_subtitle">Learn Skills • Earn Opportunities • Build Business • Grow Enterprise</span>'
)

s=s.replace(
"<h2>Learning Hub</h2>",
'<h2 data-i18n="learning_hub">🎓 Learning Hub</h2>'
)

s=s.replace(
"<h2>Career & Opportunities</h2>",
'<h2 data-i18n="career_hub">💼 Career & Opportunities</h2>'
)

s=s.replace(
"<h2>Business Hub</h2>",
'<h2 data-i18n="business_hub">🏢 Business Hub</h2>'
)

s=s.replace(
"<h2>Sponsorship & Enterprise</h2>",
'<h2 data-i18n="enterprise_hub">🤝 Sponsorship & Enterprise</h2>'
)

# remove duplicate language script
s=s.replace('<script src="/language-switcher.js"></script>\n<script src="/language-switcher.js"></script>',
            '<script src="/language-switcher.js"></script>')

if 'language-switcher.js' not in s:
    s=s.replace(
    "</body>",
    '<script src="/language-switcher.js"></script>\n</body>'
    )

with open(p,"w",encoding="utf-8") as f:
    f.write(s)

print("Homepage connected")
PY


echo "=== Check ==="
grep -n "data-i18n" public/index.html
grep -n "language-switcher" public/index.html


echo "=== Git commit ==="
git add public/index.html public/translations/*.json
git commit -m "Connect homepage multilingual EN UR AR NL" || true

echo "DONE"
