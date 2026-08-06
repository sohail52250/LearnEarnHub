#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "Creating Computer Fundamentals course..."

mkdir -p public/lessons/computer-fundamentals

cat > public/computer-fundamentals.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
<title>Computer Fundamentals - LearnEarnHub</title>
<meta name="description" content="Beginner computer course for LearnEarnHub learners.">
<link rel="canonical" href="https://learn-earnhub.vercel.app/computer-fundamentals.html">
</head>
<body>
<h1>💻 Computer Fundamentals - Start Here</h1>

<p>This is the first step for beginners before learning digital skills, freelancing and earning skills.</p>

<h2>Course Lessons</h2>

<ul>
<li><a href="/lessons/computer-fundamentals/what-is-computer.html">What is a Computer?</a></li>
<li><a href="/lessons/computer-fundamentals/computer-parts.html">Computer Parts</a></li>
<li><a href="/lessons/computer-fundamentals/start-shutdown.html">Start and Shutdown</a></li>
<li><a href="/lessons/computer-fundamentals/keyboard-mouse.html">Keyboard and Mouse</a></li>
<li><a href="/lessons/computer-fundamentals/windows-basics.html">Windows Basics</a></li>
<li><a href="/lessons/computer-fundamentals/files-folders.html">Files and Folders</a></li>
<li><a href="/lessons/computer-fundamentals/internet-basics.html">Internet Basics</a></li>
<li><a href="/lessons/computer-fundamentals/email-basics.html">Email Basics</a></li>
<li><a href="/lessons/computer-fundamentals/online-safety.html">Online Safety</a></li>
</ul>

</body>
</html>
EOF


create_lesson() {
cat > "public/lessons/computer-fundamentals/$1.html" <<EOF
<!DOCTYPE html>
<html>
<head>
<title>$2 - Computer Fundamentals</title>
</head>

<body>
<h1>$2</h1>

<p>Welcome to LearnEarnHub Computer Fundamentals.</p>

<p>This beginner lesson teaches basic computer knowledge step by step.</p>

<h2>Practice Task</h2>
<p>Complete this lesson and continue to the next lesson.</p>

<a href="/computer-fundamentals.html">Back to Computer Fundamentals</a>

</body>
</html>
EOF
}


create_lesson "what-is-computer" "What is a Computer?"
create_lesson "computer-parts" "Computer Parts"
create_lesson "start-shutdown" "Start and Shutdown"
create_lesson "keyboard-mouse" "Keyboard and Mouse"
create_lesson "windows-basics" "Windows Basics"
create_lesson "files-folders" "Files and Folders"
create_lesson "internet-basics" "Internet Basics"
create_lesson "email-basics" "Email Basics"
create_lesson "online-safety" "Online Safety"


grep -q "computer-fundamentals.html" public/index.html || \
sed -i '/<\/body>/i <a href="/computer-fundamentals.html">💻 Start Computer Fundamentals</a>' public/index.html


python - <<'PY'
from pathlib import Path

s=Path("public/sitemap.xml")
text=s.read_text()

pages=[
"computer-fundamentals.html",
"lessons/computer-fundamentals/what-is-computer.html",
"lessons/computer-fundamentals/computer-parts.html",
"lessons/computer-fundamentals/start-shutdown.html",
"lessons/computer-fundamentals/keyboard-mouse.html",
"lessons/computer-fundamentals/windows-basics.html",
"lessons/computer-fundamentals/files-folders.html",
"lessons/computer-fundamentals/internet-basics.html",
"lessons/computer-fundamentals/email-basics.html",
"lessons/computer-fundamentals/online-safety.html"
]

for p in pages:
    url=f"https://learn-earnhub.vercel.app/{p}"
    if url not in text:
        text=text.replace(
        "</urlset>",
        f"<url><loc>{url}</loc></url></urlset>"
        )

s.write_text(text)
print("Sitemap updated")
PY


echo "Checking files..."
find public/lessons/computer-fundamentals -type f

git add public
git commit -m "Add Computer Fundamentals root beginner course"
git push

echo "DONE"
