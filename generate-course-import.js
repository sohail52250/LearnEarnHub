const fs = require("fs");

const input = "numbered-course-titles.txt";

let lines = fs.readFileSync(input, "utf8")
.split("\n")
.map(x => x.trim())
.filter(Boolean);

// Remove numbering
let titles = lines.map(x => x.replace(/^\d+\s+/, "").trim());

// Non-course items
const remove = [
"Business Dashboard",
"Business Marketplace",
"Businesses & Employers",
"Cache invalidation is not working",
"Learn Skills. Build Your Future.",
"Learning Progress Summary",
"Leer vaardigheden. Bouw je toekomst.",
"My Career Profile",
"My Rewards",
"My Study Plan",
"Opportunities",
"تعلم المهارات وابنِ مستقبلك",
"مواقع",
"میرا مطالعاتی منصوبہ",
"میرا کیریئر پروفائل",
"میرے انعامات",
"کاروبار اور آجر",
"کاروباری مارکیٹ",
"کاروباری ڈیش بورڈ",
"ہنر سیکھیں، اپنا مستقبل بنائیں۔"
];

titles = titles.filter(t => !remove.includes(t));

// Create unique list
titles = [...new Set(titles)];

function sqlEscape(v){
 return v.replace(/'/g,"''");
}

let sql = `
-- LearnEarnHub multilingual course import
-- Generated automatically

INSERT INTO courses
(
 title_en,
 title_ur,
 description_en,
 description_ur,
 points
)
VALUES
`;

let rows=[];

for(let t of titles){

 let ur = "";
 let en = "";

 if(/[^\x00-\x7F]/.test(t)){
    ur=t;
 }else{
    en=t;
 }

 rows.push(`(
'${sqlEscape(en || t)}',
'${sqlEscape(ur)}',
'Learn ${sqlEscape(en || t)} skills.',
'${ur ? ur+" سیکھیں۔" : ""}',
30
)`);

}

sql += rows.join(",\n") + ";\n";

fs.writeFileSync(
"courses_multilingual_import.sql",
sql
);

fs.writeFileSync(
"clean-course-list.txt",
titles.join("\n")
);

console.log("Created:");
console.log("clean-course-list.txt");
console.log("courses_multilingual_import.sql");
console.log("Courses:", titles.length);

