require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

const lessons=[
"Introduction to Data Analysis",
"Understanding Excel Interface",
"Working with Worksheets",
"Excel Data Types",
"Data Cleaning Basics",
"Sorting and Filtering Data",
"Excel Tables",
"Using Excel Formulas",
"SUM AVERAGE COUNT Functions",
"IF Function Explained",
"Lookup Functions",
"VLOOKUP and XLOOKUP",
"Data Validation",
"Conditional Formatting",
"Pivot Tables Introduction",
"Advanced Pivot Analysis",
"Excel Charts",
"Creating Dashboards",
"Data Visualization Principles",
"Power Query Basics",
"Importing External Data",
"Cleaning Large Datasets",
"Statistical Analysis in Excel",
"Business Reports",
"Sales Data Analysis",
"Financial Data Analysis",
"Practical Excel Project",
"Real World Case Study",
"Final Project",
"Course Completion Review"
];

async function run(){

console.log("Upgrading Course 49 lessons...");

for(let i=0;i<lessons.length;i++){

const title=lessons[i];

const content_en=`
${title}

Learning Objectives:
- Understand ${title}
- Learn practical Excel data analysis skills
- Apply knowledge in real-world scenarios

Detailed Explanation:
This lesson provides step-by-step guidance about ${title}. 
Students learn concepts, tools, examples and practical techniques.

Practice:
Complete exercises and analyze sample datasets using Microsoft Excel.

Summary:
Review the important concepts before moving forward.

Quiz:
Test your understanding of this topic.
`;

const {error}=await db
.from("course_lessons")
.update({
 title_en:title,
 content_en
})
.eq("course_id",49)
.eq("lesson_order",i+1);

if(error)
 console.log("Error lesson",i+1,error.message);
else
 console.log("Updated",i+1,title);

}

console.log("DONE");

}

run();
