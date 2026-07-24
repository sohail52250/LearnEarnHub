from pathlib import Path

lessons = {

"word-basics.html":("""
Microsoft Word Basics / مائیکروسافٹ ورڈ

What you will learn:
Learn how to create professional documents.

Daily Life Uses:
- Write applications
- Create CV/resume
- Make school assignments
- Prepare business documents

Steps:
1. Open Microsoft Word.
2. Create a new document.
3. Type your information.
4. Change font size and style.
5. Insert pictures and tables.
6. Save your document.

Practice:
Create your own CV with name, education and skills.

Tips:
Save your work regularly.
Use headings to organize information.
"""),

"excel-basics.html":("""
Microsoft Excel Basics / مائیکروسافٹ ایکسل

What you will learn:
Learn spreadsheets and calculations.

Daily Life Uses:
- Manage monthly expenses
- Create student marks sheets
- Track business records

Steps:
1. Open Excel.
2. Understand rows and columns.
3. Enter data.
4. Use formulas.
5. Create tables.

Important Formulas:
SUM = Add numbers
AVERAGE = Find average

Practice:
Create a monthly home expense sheet.
"""),

"powerpoint-basics.html":("""
Microsoft PowerPoint Basics / پاورپوائنٹ

What you will learn:
Create professional presentations.

Uses:
- School presentations
- Business ideas
- Training slides

Steps:
1. Create new presentation.
2. Add slides.
3. Add text and images.
4. Apply design.
5. Present your work.

Practice:
Create a 5-slide presentation about yourself.
"""),

"html-basics.html":("""
HTML Basics / ویب سائٹ بنانا

What you will learn:
HTML creates webpage structure.

Learn:
- Headings
- Paragraphs
- Links
- Images
- Lists

Practice:
Create your first personal webpage.
"""),

"css-basics.html":("""
CSS Basics / ویب ڈیزائن

What you will learn:
CSS makes websites beautiful.

Learn:
- Colors
- Fonts
- Spacing
- Layout
- Responsive design

Practice:
Design your own homepage.
"""),

"email-basics.html":("""
Email Basics / ای میل استعمال

Learn:
- Create email account
- Send messages
- Attach files
- Write professional emails

Daily Uses:
Jobs, education, business communication.

Practice:
Write a professional email.
"""),

"internet-browsing.html":("""
Internet Browsing / انٹرنیٹ استعمال

Learn:
- Search information
- Use websites
- Download files safely
- Use online services

Practice:
Search and save useful information.
"""),

"online-safety.html":("""
Online Safety / آن لائن حفاظت

Learn:
- Strong passwords
- Avoid scams
- Protect privacy
- Safe browsing

Practice:
Create a secure password.
"""),

"typing-practice.html":("""
Typing Practice / ٹائپنگ

Learn:
- Keyboard keys
- Speed improvement
- Accuracy

Practice:
Type 15 minutes daily.
"""),

"file-management.html":("""
File Management / فائل مینجمنٹ

Learn:
- Create folders
- Copy files
- Rename files
- Backup data

Practice:
Organize your computer folders.
"""),

"cloud-storage.html":("""
Cloud Storage / آن لائن اسٹوریج

Learn:
- Save files online
- Share documents
- Backup important data

Practice:
Upload and organize files.
"""),

"digital-marketing.html":("""
Digital Marketing / ڈیجیٹل مارکیٹنگ

Learn:
- Online promotion
- Social media basics
- Customer communication

Practice:
Create a simple online promotion plan.
"""),

"freelancing-basics.html":("""
Freelancing Basics / فری لانسنگ

Learn:
- Find online work
- Build skills
- Create portfolio
- Communicate professionally

Practice:
Create your skill profile.
"""),

"google-search.html":("""
Google Search Skills

Learn:
- Better searching
- Find reliable information
- Use search operators

Practice:
Find learning resources online.
"""),

"windows-basics.html":("""
Windows Basics / ونڈوز استعمال

Learn:
- Desktop
- Files and folders
- Settings
- Applications

Practice:
Organize your computer.
""")

}

for file, content in lessons.items():
    p=Path("public/lessons")/file
    if p.exists():
        html=f"""
<h1>{content.split('/')[0]}</h1>
<div class="lesson-content">
<pre>{content}</pre>
</div>
"""
        p.write_text(html,encoding="utf-8")

print("All lessons upgraded")
