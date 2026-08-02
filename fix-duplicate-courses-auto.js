require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

async function run(){

console.log("Checking duplicate courses...");

const {data:courses,error}=await db
.from("courses")
.select("id,title_en,created_at")
.order("created_at");

if(error){
 console.log(error);
 return;
}

let map={};

courses.forEach(c=>{
 let k=c.title_en.trim().toLowerCase();
 if(!map[k]) map[k]=[];
 map[k].push(c);
});

let duplicates=[];

for(const k in map){
 if(map[k].length>1){
  console.log("\nDuplicate:",k);
  map[k].forEach(x=>console.log(
   x.id,
   x.title_en,
   x.created_at
  ));

  // keep oldest, delete newer
  map[k]
   .sort((a,b)=>new Date(a.created_at)-new Date(b.created_at))
   .slice(1)
   .forEach(x=>duplicates.push(x.id));
 }
}

console.log("\nDelete IDs:",duplicates);

if(!duplicates.length){
 console.log("No duplicates found");
 return;
}


const childTables=[
"course_modules",
"course_lessons",
"learning_path_courses",
"course_quizzes",
"learning_progress",
"quiz_questions",
"certificates"
];


for(const table of childTables){

 const {error}=await db
 .from(table)
 .delete()
 .in("course_id",duplicates);

 console.log(
  table,
  error ? error.message : "cleaned"
 );

}


const {data:deleted,error:delError}=await db
.from("courses")
.delete()
.in("id",duplicates)
.select("id,title_en");


console.log("\nDeleted courses:",deleted);
console.log("Delete error:",delError);


const {data:left}=await db
.from("courses")
.select("title_en");

let check={};

left.forEach(c=>{
 let t=c.title_en.toLowerCase().trim();
 check[t]=(check[t]||0)+1;
});


console.log("\nRemaining duplicates:");

console.log(
 Object.entries(check)
 .filter(([k,v])=>v>1)
);


console.log("\nTotal courses:",left.length);

}

run();
