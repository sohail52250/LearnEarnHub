
TRUNCATE TABLE courses RESTART IDENTITY;

INSERT INTO courses
(title_en,title_ur,description_en,description_ur,points,language_group)

VALUES

('AI Career Guide',
'اے آئی کیریئر گائیڈ',
'Learn AI career opportunities and skills.',
'مصنوعی ذہانت میں کیریئر کے مواقع اور مہارتیں سیکھیں۔',
30,
'ai-career'),

('Accounting Fundamentals',
'اکاؤنٹنگ بنیادی کورس',
'Learn accounting principles.',
'اکاؤنٹنگ کے بنیادی اصول سیکھیں۔',
30,
'accounting'),

('Artificial Intelligence Complete Guide',
'مصنوعی ذہانت مکمل گائیڈ',
'Complete AI learning program.',
'مصنوعی ذہانت کا مکمل تعلیمی پروگرام۔',
30,
'ai-complete'),

('Blockchain Technology',
'بلاک چین ٹیکنالوجی',
'Learn blockchain concepts.',
'بلاک چین کے تصورات سیکھیں۔',
30,
'blockchain'),

('Digital Marketing Professional',
'ڈیجیٹل مارکیٹنگ پروفیشنل',
'Learn professional digital marketing.',
'پروفیشنل ڈیجیٹل مارکیٹنگ سیکھیں۔',
30,
'digital-marketing'),

('Freelancing Introduction',
'فری لانسنگ کا تعارف',
'Learn how to start freelancing.',
'آن لائن فری لانسنگ شروع کرنا سیکھیں۔',
30,
'freelancing'),

('Web Development Complete Course',
'مکمل ویب ڈویلپمنٹ کورس',
'Learn modern web development.',
'جدید ویب ڈویلپمنٹ سیکھیں۔',
30,
'web-development'),

('Graphic Design Professional',
'پروفیشنل گرافک ڈیزائن',
'Learn professional graphic design.',
'پروفیشنل گرافک ڈیزائن سیکھیں۔',
30,
'graphic-design'),

('Cyber Security Professional',
'پروفیشنل سائبر سیکیورٹی',
'Learn cybersecurity skills.',
'سائبر سیکیورٹی کی مہارتیں سیکھیں۔',
30,
'cyber-security'),

('Data Analysis Basics',
'ڈیٹا اینالیسس بنیادی کورس',
'Learn data analysis.',
'ڈیٹا اینالیسس سیکھیں۔',
30,
'data-analysis');

