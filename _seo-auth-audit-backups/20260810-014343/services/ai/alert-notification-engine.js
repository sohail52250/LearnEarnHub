require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const supabase=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);


async function sendAIAlerts(){

console.log("Checking new AI matches...");


const {data:matches,error}=await supabase
.from("recommendations")
.select("*")
.eq("status","new");


if(error) throw error;


let alerts=[];


for(const match of matches || []){


const {data:job}=await supabase
.from("external_opportunities")
.select("*")
.eq("id",match.opportunity_id)
.single();


if(!job) continue;



alerts.push({

 user_id:match.user_id,

 title:"New Opportunity Match",

 message:
 `AI found a ${job.title} opportunity matching your skills.`,

 notification_type:"ai_match"

});


}



if(alerts.length){

const {error:insertError}=await supabase
.from("notifications")
.insert(alerts);


if(insertError) throw insertError;


await supabase
.from("recommendations")
.update({
 status:"notified"
})
.eq("status","new");


}



console.log(
"AI Alerts Sent:",
alerts.length
);


}



sendAIAlerts()
.catch(err=>{
console.error(err.message);
process.exit(1);
});
