from pathlib import Path
import json

courses = {

"excel-basics": {
"title":"Microsoft Excel Basics",
"intro":"Learn spreadsheets, formulas and data organization."
},

"powerpoint-basics": {
"title":"Microsoft PowerPoint Basics",
"intro":"Learn how to create professional presentations."
},

"html-basics": {
"title":"HTML Basics",
"intro":"Learn the foundation of building web pages."
},

"css-basics": {
"title":"CSS Basics",
"intro":"Learn how to style and design web pages."
},

"internet-browsing": {
"title":"Internet Browsing Basics",
"intro":"Learn how to use the internet safely and effectively."
},

"online-safety": {
"title":"Online Safety Basics",
"intro":"Learn how to protect yourself online."
},

"google-search": {
"title":"Google Search Skills",
"intro":"Learn how to find information efficiently online."
},

"cloud-storage": {
"title":"Cloud Storage Basics",
"intro":"Learn how to store and manage files online."
},

"digital-marketing": {
"title":"Digital Marketing Basics",
"intro":"Learn the fundamentals of online marketing."
},

"freelancing-basics": {
"title":"Freelancing Basics",
"intro":"Learn how to start freelancing online."
},

"typing-practice": {
"title":"Typing Practice",
"intro":"Improve your typing speed and accuracy."
},

"windows-basics": {
"title":"Windows Basics",
"intro":"Learn essential Windows computer skills."
},

"file-management": {
"title":"File Management Basics",
"intro":"Learn how to organize and manage files."
},

"email-basics": {
"title":"Email Basics",
"intro":"Learn how to use email professionally."
}

}


path=Path("public/translations")
path.mkdir(exist_ok=True)


for slug,data in courses.items():

    en_file=path/f"{slug}-en.json"
    ur_file=path/f"{slug}-ur.json"


    en_content={
        "title":data["title"],
        "intro":data["intro"],
        "topic1":"Getting Started",
        "topic1_text":"Learn the basic concepts and practical skills step by step."
    }


    ur_content={
        "title":data["title"],
        "intro":"اس کورس میں بنیادی مہارتیں آسان طریقے سے سیکھیں۔",
        "topic1":"شروع کریں",
        "topic1_text":"بنیادی تصورات اور عملی مہارتیں مرحلہ وار سیکھیں۔"
    }


    en_file.write_text(
        json.dumps(en_content,indent=2,ensure_ascii=False)
    )

    ur_file.write_text(
        json.dumps(ur_content,indent=2,ensure_ascii=False)
    )


print("Translation databases created:",len(courses))
