#!/data/data/com.termux/files/usr/bin/bash

set -e

cp public/style.css public/style-before-text-scale.css


cat >> public/style.css <<'CSS'


/* ===== LearnEarnHub Global Responsive Text System ===== */


html {
    font-size: 16px;
    scroll-behavior: smooth;
}


body {
    font-size: clamp(15px, 2.5vw, 18px);
    line-height: 1.6;
    overflow-x: hidden;
}


/* Main containers */

.container,
.wrapper,
.page,
.content {
    width: min(95%, 1200px);
    margin-left:auto;
    margin-right:auto;
}


/* Headings */

h1 {
    font-size: clamp(28px, 6vw, 48px);
}

h2 {
    font-size: clamp(22px, 5vw, 36px);
}

h3 {
    font-size: clamp(18px, 4vw, 28px);
}


/* Paragraphs */

p,
li,
label,
input,
textarea,
select,
button {
    font-size: clamp(15px, 2.8vw, 18px);
}


/* Cards */

.card,
.dashboard-card,
.box {
    padding: clamp(15px,3vw,25px);
}


/* Buttons */

button,
.btn,
a.button {
    min-height:44px;
    padding:12px 18px;
}


/* Tables */

table {
    width:100%;
    overflow-x:auto;
    display:block;
}


/* Mobile */

@media(max-width:600px){

body{
    padding:12px;
}


.grid{
    grid-template-columns:1fr !important;
}


nav,
.menu{
    flex-direction:column;
}


.card{
    width:100%;
}


}


/* Large screens */

@media(min-width:1200px){

body{
    font-size:18px;
}

}


CSS


git add public/style.css

git commit -m "Add global responsive text scaling"

git push


echo "DONE"
