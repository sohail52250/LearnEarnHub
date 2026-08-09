require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function addEarning(data){


const {data:result,error}=await db
.from("learner_earnings")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



async function getEarnings(learner_id){


const {data,error}=await db
.from("learner_earnings")
.select("*")
.eq("learner_id",learner_id);



if(error) throw error;


return data || [];

}



async function totalEarned(learner_id){


const rows=await getEarnings(learner_id);


return rows.reduce(
(sum,x)=>sum+Number(x.amount),
0
);


}



module.exports={

addEarning,

getEarnings,

totalEarned

};

