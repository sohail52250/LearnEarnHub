require("dotenv").config();

const { createClient } = require("@supabase/supabase-js");

const db = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

 const { data: opportunities, error } =
 await db
   .from("external_opportunities")
   .select("*")
   .limit(20);

 if(error){
   console.error(error);
   process.exit(1);
 }

 if(!opportunities || !opportunities.length){
   console.log("No opportunities found");
   process.exit(0);
 }

 const notifications = opportunities.map(o=>({
   learner_id: "GLOBAL",
   title: o.title,
   body:
     "New opportunity available: " +
     o.opportunity_type
 }));

 const result = await db
   .from("learner_notifications")
   .insert(notifications);

 if(result.error){
    console.error(result.error);
    process.exit(1);
 }

 console.log(
   "Notifications created:",
   notifications.length
 );

})();
