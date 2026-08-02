require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);

async function run(){

const course_id=49;

const lessons=[];

for(let i=1;i<=30;i++){

lessons.push({
course_id,
lesson_order:i,

title_en:`Data Analysis With Excel - Lesson ${i}`,
title_ur:`Excel کے ساتھ ڈیٹا تجزیہ - سبق ${i}`,
title_ar:`تحليل البيانات باستخدام Excel - الدرس ${i}`,
title_nl:`Data Analyse met Excel - Les ${i}`,

content_en:
`Data Analysis With Excel - Lesson ${i}

Learning Objectives:
- Understand Excel data analysis concepts
- Learn practical spreadsheet skills
- Apply formulas and analysis methods

Introduction:
This lesson teaches Data Analysis With Excel step by step.

Detailed Explanation:
Learners explore Excel tools, formulas, charts, tables and practical analysis techniques.

Practice:
Complete exercises and apply the learned skills.

Summary:
Review the important concepts before continuing.

Quiz:
Test your understanding.`,

content_ur:
`یہ سبق Excel کے ساتھ ڈیٹا تجزیہ کے بارے میں مکمل معلومات فراہم کرتا ہے۔ سبق نمبر ${i}۔`,

content_ar:
`هذا الدرس يقدم شرحا كاملا عن تحليل البيانات باستخدام Excel. الدرس ${i}.`,

content_nl:
`Deze les geeft uitleg over Data Analyse met Excel. Les ${i}.`
});

}

const {error}=await db
.from("course_lessons")
.insert(lessons);

console.log(error || "Course 49 repaired with 30 lessons");

}

run();
