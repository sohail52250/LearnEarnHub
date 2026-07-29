#!/data/data/com.termux/files/usr/bin/bash

find public -name "*.html" | while read file
do
if ! grep -q 'meta name="description"' "$file"; then
sed -i '/<head>/a\
<meta name="description" content="LearnEarnHub - Learn skills, find opportunities, earn online, and grow your career.">\
<meta name="robots" content="index,follow">\
<meta property="og:type" content="website">\
<meta property="og:title" content="LearnEarnHub">\
<meta property="og:description" content="Learn, Earn and Grow.">\
<link rel="canonical" href="https://learn-earnhub.vercel.app/">' "$file"
fi
done
