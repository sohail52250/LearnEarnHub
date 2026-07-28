require("dotenv").config();

const { createClient } = require("@supabase/supabase-js");
const fs = require("fs");

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_KEY
);

async function importFile(file){

  if(!fs.existsSync(file)){
    console.log("SKIP:", file);
    return;
  }

  const raw = JSON.parse(fs.readFileSync(file,"utf8"));

  let courses = raw.data || raw;

  if(!Array.isArray(courses)){
    courses=[courses];
  }

  const {data,error}=await supabase
    .from("courses")
    .insert(courses)
    .select("id,title_en,points");

  console.log("\nFILE:",file);

  if(error){
    console.log("ERROR:",error.message);
  }else{
    console.log("INSERTED:",data.length);
    console.table(data);
  }
}


async function run(){

 await importFile("./course-content.json");
 await importFile("./course-content-data.json");
 await importFile("./real-courses.json");

 console.log("\nDONE");

}

run();
