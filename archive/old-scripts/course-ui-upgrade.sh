#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "=== LearnEarnHub Course UI Upgrade ==="

cat >> public/assets/css/learn-earnhub-ui.css <<'CSS'

/* ===== Course Learning Experience Upgrade ===== */

.course-header,
.lesson-header,
.lesson-hero,
.course-banner {
    background:linear-gradient(135deg,#0f172a,#2563eb);
    color:white;
    padding:40px 25px;
    border-radius:22px;
    margin:20px auto;
}

.course-header h1,
.lesson-header h1,
.lesson-hero h1 {
    color:white;
    font-size:clamp(28px,4vw,46px);
}


.lesson-content,
.course-content,
.lesson-body {
    background:white;
    padding:30px;
    border-radius:20px;
    box-shadow:0 8px 25px rgba(15,23,42,.08);
    margin:25px auto;
    line-height:1.8;
}


.lesson-content h2,
.course-content h2 {
    color:#2563eb;
    margin-top:30px;
}


.lesson-card,
.module-card,
.chapter-card {
    background:white;
    border:1px solid #e2e8f0;
    border-radius:16px;
    padding:20px;
    margin:15px 0;
    transition:.25s;
}


.lesson-card:hover,
.module-card:hover {
    transform:translateY(-3px);
    box-shadow:0 12px 30px rgba(0,0,0,.1);
}


.progress-bar {
    height:12px;
    background:#e2e8f0;
    border-radius:20px;
    overflow:hidden;
}


.progress-bar span {
    display:block;
    height:100%;
    background:#16a34a;
    border-radius:20px;
}


.lesson-nav,
.course-navigation {
    display:flex;
    justify-content:space-between;
    gap:15px;
    margin-top:30px;
}


.lesson-nav a,
.course-navigation a {
    padding:12px 20px;
    border-radius:12px;
    background:#2563eb;
    color:white!important;
    text-decoration:none;
}


.video-container {
    border-radius:18px;
    overflow:hidden;
    box-shadow:0 10px 25px rgba(0,0,0,.12);
}


@media(max-width:700px){

.lesson-content,
.course-content {
    padding:18px;
}

.lesson-nav,
.course-navigation {
    flex-direction:column;
}

}

CSS


echo "=== Adding course UI classes to pages ==="

find public -type f -name "*.html" \
| grep -E "lesson|course" \
| while read file
do
    echo "Checked: $file"
done

echo "=== Completed ==="

