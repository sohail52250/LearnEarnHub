#!/data/data/com.termux/files/usr/bin/bash

echo "===== LearnEarnHub Course Content Setup ====="

COURSE_ID="9340f8f3-8d69-4881-8585-42f1af2f77c4"

cat > course-content.sql <<SQL

CREATE TABLE IF NOT EXISTS course_lessons (
 id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
 course_id uuid REFERENCES courses(id),
 title_en text,
 title_ur text,
 content_en text,
 content_ur text,
 lesson_order integer DEFAULT 1,
 created_at timestamp DEFAULT now()
);

INSERT INTO course_lessons
(course_id,title_en,title_ur,content_en,content_ur,lesson_order)

VALUES

(
'$COURSE_ID',
'Introduction to Freelancing',
'فری لانسنگ کا تعارف',
'Learn what freelancing is, how online platforms work, and how beginners can start earning online.',
'فری لانسنگ کیا ہے، آن لائن پلیٹ فارم کیسے کام کرتے ہیں، اور نئے افراد آن لائن کمائی کیسے شروع کر سکتے ہیں۔',
1
),

(
'$COURSE_ID',
'Finding Your First Client',
'اپنا پہلا کلائنٹ تلاش کرنا',
'Learn client communication, portfolio creation and professional proposals.',
'کلائنٹ سے رابطہ، پورٹ فولیو بنانا اور پروفیشنل پروپوزل تیار کرنا سیکھیں۔',
2
),

(
'$COURSE_ID',
'Building Online Skills',
'آن لائن مہارتیں بنانا',
'Learn digital skills including writing, design, marketing and technology skills.',
'رائٹنگ، ڈیزائن، مارکیٹنگ اور ٹیکنالوجی کی مہارتیں سیکھیں۔',
3
);

SQL

echo "SQL created:"
cat course-content.sql

echo ""
echo "Upload this SQL in Supabase SQL Editor."

echo ""
echo "After database update test:"
echo "curl https://learn-earnhub.vercel.app/api/courses"

