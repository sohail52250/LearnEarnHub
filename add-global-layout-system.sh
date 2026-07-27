#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== Create global header ==="

cat > public/global-header.html <<'HTML'
<header class="leh-header">

<div class="leh-logo">
🚀 LearnEarnHub
</div>


<nav class="leh-nav">

<a href="/index.html">Home</a>
<a href="/courses.html">Learning</a>
<a href="/matched-opportunities.html">Opportunities</a>
<a href="/business-marketplace.html">Business</a>
<a href="/guides.html">Guides</a>
<a href="/contact.html">Contact</a>

</nav>


<select id="language-select"
onchange="loadLanguage(this.value)">

<option value="en">🇬🇧 English</option>
<option value="ur">🇵🇰 اردو</option>
<option value="ar">🇸🇦 العربية</option>
<option value="nl">🇳🇱 Nederlands</option>

</select>


</header>
HTML



echo "=== Create global footer ==="

cat > public/global-footer.html <<'HTML'
<footer class="leh-footer">

<p>
🚀 LearnEarnHub
</p>

<p>
Learn Skills • Earn Opportunities • Build Business
</p>


<p>

<a href="/about.html">About</a> |

<a href="/privacy.html">Privacy</a> |

<a href="/terms.html">Terms</a> |

<a href="/security-center.html">Security</a>

</p>


<p>
© LearnEarnHub
</p>


</footer>
HTML



echo "=== Add layout CSS ==="

cat >> public/style.css <<'CSS'


/* Global LearnEarnHub Layout */


.leh-header{

display:flex;
align-items:center;
justify-content:space-between;
gap:15px;
padding:15px;
border-bottom:1px solid #ddd;
flex-wrap:wrap;

}


.leh-logo{

font-size:24px;
font-weight:bold;

}


.leh-nav{

display:flex;
gap:12px;
flex-wrap:wrap;

}


.leh-nav a{

text-decoration:none;

}


.leh-footer{

margin-top:40px;
padding:25px;
text-align:center;
border-top:1px solid #ddd;

}



@media(max-width:700px){

.leh-header{

flex-direction:column;

}


.leh-nav{

justify-content:center;

}

}

CSS



echo "=== Create injector ==="


cat > inject-global-layout.py <<'PY'
import glob

header='<div id="global-header"></div>'
footer='<div id="global-footer"></div>'


for f in glob.glob("public/*.html"):

    if "global-" in f:
        continue

    try:

        with open(f,encoding="utf8") as x:
            s=x.read()


        if "global-header" not in s:

            s=s.replace(
            "<body>",
            "<body>"+header
            )


        if "global-footer" not in s:

            s=s.replace(
            "</body>",
            footer+"</body>"
            )


        if "global-layout.js" not in s:

            s=s.replace(
            "</body>",
            '<script src="/global-layout.js"></script></body>'
            )


        with open(f,"w",encoding="utf8") as x:
            x.write(s)


    except:
        pass


print("Layout injected")
PY


python3 inject-global-layout.py



echo "=== Create loader ==="


cat > public/global-layout.js <<'JS'

async function loadPart(id,file){

let el=document.getElementById(id);

if(!el)return;


let r=await fetch(file);

el.innerHTML=await r.text();

}


loadPart(
"global-header",
"/global-header.html"
);


loadPart(
"global-footer",
"/global-footer.html"
);

JS



echo "=== Save ==="

git add .

git commit -m "Add global header footer layout system" || true

git push


echo "DONE"
