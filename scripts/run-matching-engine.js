require("dotenv").config();

const { createClient } = require("@supabase/supabase-js");

const db = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

 const { data:jobs } = await db
   .from("external_opportunities")
   .select("*");

 console.log("Opportunities:", jobs?.length || 0);

 if(jobs){
   jobs.forEach(j=>{
      console.log(
        "[MATCH]",
        j.title,
        "=>",
        j.opportunity_type
      );
   });
 }

})();
