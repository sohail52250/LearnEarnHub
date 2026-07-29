#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== LearnEarnHub Final UI Polish ==="

cat >> public/assets/css/learn-earnhub-ui.css <<'CSS'

/* ===== Final LearnEarnHub UI Polish ===== */

/* Smooth global experience */
html {
    scroll-behavior:smooth;
}

a {
    transition:.2s ease;
}

img {
    transition:.3s ease;
}


/* Better focus accessibility */
button:focus,
a:focus,
input:focus,
textarea:focus,
select:focus {
    outline:3px solid rgba(37,99,235,.35);
    outline-offset:2px;
}


/* Loading animation */
.loading,
.loader {
    width:40px;
    height:40px;
    border-radius:50%;
    border:4px solid #e2e8f0;
    border-top-color:#2563eb;
    animation:lehSpin 1s linear infinite;
    margin:auto;
}

@keyframes lehSpin {
    to {
        transform:rotate(360deg);
    }
}


/* Fade animations */
.animate,
.fade-in {
    animation:lehFadeIn .5s ease;
}

@keyframes lehFadeIn {
    from {
        opacity:0;
        transform:translateY(15px);
    }

    to {
        opacity:1;
        transform:translateY(0);
    }
}


/* Icon styling */
.icon,
.icon-box {
    display:inline-flex;
    align-items:center;
    justify-content:center;
    width:45px;
    height:45px;
    border-radius:14px;
    background:#dbeafe;
    color:#2563eb;
}


/* Modern notification */
.alert,
.notice {
    padding:15px 20px;
    border-radius:14px;
    margin:15px 0;
}


.alert-success {
    background:#dcfce7;
    color:#166534;
}


.alert-error {
    background:#fee2e2;
    color:#991b1b;
}


/* Dark mode */
.dark-mode,
[data-theme="dark"] {

    background:#020617;
    color:#e2e8f0;

}


.dark-mode .card,
.dark-mode .course-card,
.dark-mode .dashboard-card,
.dark-mode .market-card,
[data-theme="dark"] .card {

    background:#0f172a;
    border-color:#1e293b;
    color:#e2e8f0;

}


.dark-mode h1,
.dark-mode h2,
.dark-mode h3,
[data-theme="dark"] h1,
[data-theme="dark"] h2 {

    color:white;

}


/* Mobile app feel */
@media(max-width:600px){

body {
    padding-bottom:20px;
}

button,
.btn {
    min-height:46px;
}

}


/* Reduce motion option */
@media(prefers-reduced-motion:reduce){

* {
    animation:none!important;
    transition:none!important;
}

}

CSS


echo "=== Adding theme helper ==="

cat > public/assets/js/theme-helper.js <<'JS'
(function(){

const saved = localStorage.getItem("leh-theme");

if(saved==="dark"){
 document.documentElement.setAttribute("data-theme","dark");
}

window.toggleLEHTheme=function(){

let html=document.documentElement;

if(html.getAttribute("data-theme")==="dark"){
 html.removeAttribute("data-theme");
 localStorage.setItem("leh-theme","light");
}
else{
 html.setAttribute("data-theme","dark");
 localStorage.setItem("leh-theme","dark");
}

};

})();
JS


git add .
git commit -m "Add final UI polish and theme support"
git push

vercel --prod

echo "=== Final UI Polish Completed ==="

