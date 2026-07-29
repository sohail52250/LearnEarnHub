#!/data/data/com.termux/files/usr/bin/bash

cd ~/EarnTask/LearnEarnHub

echo "Backing up server.js..."
cp server.js server.js.before-courses-fix

if grep -q 'routes/courses' server.js; then
  echo "Courses route already mounted."
else
  sed -i '/const app = express();/a\
\
try{\
app.use("/api/courses", require("./routes/courses"));\
console.log("Courses API loaded");\
}catch(e){\
console.log("Courses API error:",e.message);\
}\
' server.js
fi

git add server.js
git commit -m "Enable courses API route" || true
git push

vercel --prod

echo ""
echo "Testing API..."
curl https://learn-earnhub.vercel.app/api/courses
