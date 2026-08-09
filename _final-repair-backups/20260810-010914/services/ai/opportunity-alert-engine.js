require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function sendAlerts(){


console.log("AI Alert Engine Started");


const {data:matches,error}=await db

.from("recommendations")

.select("*")

.gte("match_score",80)

.eq("status","notified");



if(error) throw error;



for(const match of matches || []){


const {data:exists}=await db

.from("opportunity_alert_logs")

.select("id")

.eq("recommendation_id",match.id);



if(exists && exists.length)
continue;



await db

.from("notifications")

.insert({

user_id:match.user_id,

title:"New Opportunity Match",

message:
`AI found a ${match.match_score}% matching opportunity for you.`,

notification_type:"job_match",

is_read:false

});



await db

.from("opportunity_alert_logs")

.insert({

user_id:match.user_id,

opportunity_id:match.opportunity_id,

recommendation_id:match.id,

alert_type:"job_match",

sent:true,

sent_at:new Date()

});



console.log(
"Alert sent:",
match.user_id,
match.opportunity_id
);


}



console.log("AI Alert Engine Completed");


}



sendAlerts()
.catch(e=>{

console.error(e.message);

process.exit(1);

});
