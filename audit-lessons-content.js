require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

const {data}=await db
.from("course_lessons")
.select("course_id,title_en,content_en");

let bad=[];

data.forEach(l=>{

if(!l.content_en || l.content_en.length < 100){
bad.push({
course:l.course_id,
lesson:l.title_en
});
}

});

console.log("Weak lessons:",bad.length);
console.log(bad.slice(0,20));

})();
