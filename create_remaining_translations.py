from pathlib import Path
import json

courses = {

"digital-marketing": {
"title":"Digital Marketing Basics",
"intro_en":"Learn how businesses promote products and services using online platforms.",
"intro_ur":"آن لائن پلیٹ فارمز کے ذریعے مصنوعات اور خدمات کو فروغ دینا سیکھیں۔"
},

"cloud-storage": {
"title":"Cloud Storage Basics",
"intro_en":"Learn how to store, manage and access files online securely.",
"intro_ur":"فائلز کو محفوظ طریقے سے آن لائن محفوظ کرنا، منظم کرنا اور استعمال کرنا سیکھیں۔"
},

"google-search": {
"title":"Google Search Skills",
"intro_en":"Learn how to search information faster and find reliable results.",
"intro_ur":"تیزی سے معلومات تلاش کرنا اور قابل اعتماد نتائج حاصل کرنا سیکھیں۔"
},

"email-basics": {
"title":"Email Basics",
"intro_en":"Learn how to create, send and manage professional emails.",
"intro_ur":"ای میل بنانا، بھیجنا اور پیشہ ورانہ انداز میں استعمال کرنا سیکھیں۔"
},

"windows-basics": {
"title":"Windows Basics",
"intro_en":"Learn essential Windows computer operations and settings.",
"intro_ur":"ونڈوز کمپیوٹر کے بنیادی استعمال اور سیٹنگز سیکھیں۔"
},

"file-management": {
"title":"File Management Basics",
"intro_en":"Learn how to organize, rename and manage computer files.",
"intro_ur":"کمپیوٹر فائلز کو ترتیب دینا، نام تبدیل کرنا اور منظم کرنا سیکھیں۔"
},

"typing-practice": {
"title":"Typing Practice",
"intro_en":"Improve typing speed, accuracy and keyboard skills.",
"intro_ur":"ٹائپنگ کی رفتار، درستگی اور کی بورڈ کی مہارت بہتر کریں۔"
}

}


path=Path("public/translations")


for slug,data in courses.items():

    en={
        "title":data["title"],
        "intro":data["intro_en"],
        "topic1":"Getting Started",
        "topic1_text":"Learn the basic concepts and practical skills step by step.",
        "topic2":"Practice Skills",
        "topic2_text":"Practice regularly to improve your confidence and ability.",
        "practice":"Complete practical exercises to improve your skills."
    }

    ur={
        "title":data["title"],
        "intro":data["intro_ur"],
        "topic1":"شروع کریں",
        "topic1_text":"بنیادی تصورات اور عملی مہارتیں مرحلہ وار سیکھیں۔",
        "topic2":"مہارتوں کی مشق",
        "topic2_text":"اپنی صلاحیت بہتر بنانے کے لیے باقاعدگی سے مشق کریں۔",
        "practice":"اپنی مہارت بہتر بنانے کے لیے عملی مشقیں مکمل کریں۔"
    }

    (path/f"{slug}-en.json").write_text(
        json.dumps(en,indent=2,ensure_ascii=False)
    )

    (path/f"{slug}-ur.json").write_text(
        json.dumps(ur,indent=2,ensure_ascii=False)
    )


print("Remaining course translations completed:",len(courses))
