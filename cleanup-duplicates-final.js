require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_KEY
);

async function cleanup(){

 const remove=[16,92,49];

 console.log("Deleting duplicate IDs:", remove);

 const {data,error}=await db
   .from("courses")
   .delete()
   .in("id",remove)
   .select("id,title_en");

 if(error){
   console.log("DELETE ERROR:");
   console.log(error);
   return;
 }

 console.log("Deleted:");
 console.log(data);

 const {data:remaining}=await db
   .from("courses")
   .select("id,title_en");

 console.log("Total remaining courses:", remaining.length);

}

cleanup();
