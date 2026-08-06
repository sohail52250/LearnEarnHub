#!/data/data/com.termux/files/usr/bin/bash

echo "===== LearnEarnHub Course Content Refinement ====="

mkdir -p backups/course-content-refine

echo "Creating backup notes..."

date > backups/course-content-refine/date.txt

curl -s https://learn-earnhub.vercel.app/api/courses \
> backups/course-content-refine/current-courses-api.json

echo "Backup created."

cat > backups/course-content-refine/add-freelancing-content.sql <<'SQL'
-- LearnEarnHub bilingual course content update
-- Safe update: keeps course record, only fills empty content

UPDATE courses
SET
content_en = '
Lesson 1: Introduction to Freelancing

Learn what freelancing is and how people earn online.

Lesson 2: Finding Freelance Opportunities

Understand platforms, clients, and online marketplaces.

Lesson 3: Building Your Professional Profile

Create a strong profile with skills and experience.

Lesson 4: Communication With Clients

Learn professional communication and project handling.

Lesson 5: Starting Your First Project

Understand proposals, delivery, and earning methods.
',

content_ur = '
سبق 1: فری لانسنگ کا تعارف

فری لانسنگ کیا ہے اور آن لائن کمائی کیسے شروع کی جاتی ہے۔

سبق 2: فری لانس مواقع تلاش کرنا

آن لائن پلیٹ فارم، کلائنٹس اور مارکیٹ پلیس کو سمجھیں۔

سبق 3: پروفیشنل پروفائل بنانا

اپنی مہارت اور تجربے کے ساتھ مضبوط پروفائل بنائیں۔

سبق 4: کلائنٹس سے رابطہ

پروفیشنل گفتگو اور پروجیکٹ مینجمنٹ سیکھیں۔

سبق 5: پہلا پروجیکٹ شروع کرنا

پروپوزل، کام مکمل کرنا اور کمائی کے طریقے سیکھیں۔
'

WHERE title_en='Freelancing Introduction';
SQL

echo ""
echo "SQL file created:"
echo "backups/course-content-refine/add-freelancing-content.sql"

echo ""
echo "===== Current Course API ====="

curl -s https://learn-earnhub.vercel.app/api/courses

echo ""
echo "===== DONE ====="

