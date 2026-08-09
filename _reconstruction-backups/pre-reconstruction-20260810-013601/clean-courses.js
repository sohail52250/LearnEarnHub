require("dotenv").config();

const { createClient } = require("@supabase/supabase-js");

const supabase = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_KEY
);

async function run(){

 const {data,error}=await supabase
 .from("courses")
 .select("*")
 .order("created_at",{ascending:true});


 if(error){
  console.log(error);
  return;
 }


 console.log("Total:",data.length);


 let seen=new Set();
 let remove=[];


 for(const c of data){

  let key=c.title_en.trim().toLowerCase();

  if(seen.has(key)){
    remove.push(c.id);
  }
  else{
    seen.add(key);
  }

 }


 console.log("Duplicates:",remove.length);


 if(remove.length){

 const {error:err}=await supabase
 .from("courses")
 .delete()
 .in("id",remove);


 console.log(err || "Deleted");

 }


 console.log("DONE");

}


run();
