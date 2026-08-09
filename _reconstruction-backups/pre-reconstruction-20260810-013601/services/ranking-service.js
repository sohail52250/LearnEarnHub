require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



function calculateLevel(points){

if(points>=10000)
return "Expert";

if(points>=5000)
return "Gold";

if(points>=2000)
return "Silver";

return "Bronze";

}



async function updateScore(user_id,points){


const level=
calculateLevel(points);



const {data,error}=await db
.from("learner_scores")
.upsert({

user_id,

total_points:points,

level,

updated_at:new Date()

})
.select()
.single();



if(error) throw error;


return data;

}



async function getRanking(){


const {data,error}=await db
.from("learner_scores")
.select("*")
.order(
"total_points",
{
ascending:false
}
)
.limit(100);



if(error) throw error;


return data || [];

}



module.exports={

updateScore,

getRanking

};

