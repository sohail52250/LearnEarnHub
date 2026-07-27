#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Backup ==="
cp public/index.html public/index-before-responsive-fix-$(date +%Y%m%d-%H%M%S).html

echo "=== Fix homepage i18n sections ==="

python3 <<'PY'
p="public/index.html"

with open(p,encoding="utf-8") as f:
    s=f.read()

replacements = {
"Learning Hub":
'<span data-i18n="learning_hub">🎓 Learning Hub</span>',

"Career & Opportunities":
'<span data-i18n="career_hub">💼 Career & Opportunities</span>',

"Business Hub":
'<span data-i18n="business_hub">🏢 Business Hub</span>',

"Sponsorship & Enterprise":
'<span data-i18n="enterprise_hub">🤝 Enterprise Zone</span>',

"Enterprise Zone":
'<span data-i18n="enterprise_hub">🤝 Enterprise Zone</span>'
}

for old,new in replacements.items():
    s=s.replace(
        f"<h2>{old}</h2>",
        f"<h2>{new}</h2>"
    )

# Add missing data attributes for cards
s=s.replace(
"<h3>🎓 Learner</h3>",
'<h3 data-i18n="learner">🎓 Learner</h3>'
)

s=s.replace(
"<h3>💼 Freelancer</h3>",
'<h3 data-i18n="freelancer">💼 Freelancer</h3>'
)

s=s.replace(
"<h3>🏢 Business</h3>",
'<h3 data-i18n="business">🏢 Business</h3>'
)

s=s.replace(
"<h3>🤝 Enterprise</h3>",
'<h3 data-i18n="enterprise">🤝 Enterprise</h3>'
)


with open(p,"w",encoding="utf-8") as f:
    f.write(s)

print("Homepage sections connected")
PY


echo "=== Add responsive mobile CSS ==="

python3 <<'PY'
p="public/index.html"

with open(p,encoding="utf-8") as f:
    s=f.read()

css="""

<style>
*{
 box-sizing:border-box;
}

html,body{
 width:100%;
 max-width:100%;
 overflow-x:hidden;
}

body{
 margin:0 auto;
 padding:15px;
 font-size:16px;
}

img,video,iframe{
 max-width:100%;
 height:auto;
}

.hero{
 width:100%;
 padding:20px 10px;
}

.grid{
 display:grid;
 grid-template-columns:
 repeat(auto-fit,minmax(min(100%,260px),1fr));
 gap:15px;
 width:100%;
}

.card{
 width:100%;
 overflow-wrap:break-word;
}

.btn{
 max-width:100%;
 display:inline-block;
}

select{
 max-width:100%;
 padding:8px;
}

@media(max-width:600px){

body{
 padding:10px;
 font-size:15px;
}

h1{
 font-size:28px;
}

h2{
 font-size:22px;
}

h3{
 font-size:18px;
}

.btn{
 width:100%;
 margin:5px 0;
 text-align:center;
}

.grid{
 grid-template-columns:1fr;
}

}
</style>

"""

if "</head>" in s and "overflow-x:hidden" not in s:
    s=s.replace("</head>",css+"</head>")

with open(p,"w",encoding="utf-8") as f:
    f.write(s)

print("Responsive CSS added")
PY


echo "=== Remove duplicate language scripts ==="

python3 <<'PY'
p="public/index.html"

with open(p,encoding="utf-8") as f:
    s=f.read()

while s.count('<script src="/language-switcher.js"></script>') > 1:
    s=s.replace(
    '<script src="/language-switcher.js"></script>',
    '',
    1
    )

if '<script src="/language-switcher.js"></script>' not in s:
    s=s.replace(
    "</body>",
    '<script src="/language-switcher.js"></script></body>'
    )

with open(p,"w",encoding="utf-8") as f:
    f.write(s)

print("Language script cleaned")
PY


echo "=== Verify ==="

grep -n "data-i18n" public/index.html
grep -n "overflow-x:hidden" public/index.html
grep -n "language-switcher" public/index.html


git add public/index.html

git commit -m "Fix homepage sections visibility and responsive scaling" || true

git push

echo "DONE"
