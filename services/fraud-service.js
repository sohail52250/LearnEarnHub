require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



function analyzeProfile(data){


let risk="LOW";

let flags=[];



if(data.email && data.email.includes("temp")){

risk="MEDIUM";

flags.push("Temporary email pattern");

}



if(data.same_reference){

risk="HIGH";

flags.push("Duplicate reference detected");

}



if(data.multiple_accounts){

risk="HIGH";

flags.push("Multiple accounts detected");

}



return {

risk,

flags

};


}



async function createFlag(data){


const result=
analyzeProfile(data);



if(result.flags.length===0){

return {

status:"CLEAR"

};

}



const {data:flag,error}=await db
.from("fraud_flags")
.insert({

user_id:data.user_id,

flag_type:result.flags.join(","),

risk_level:result.risk,

details:JSON.stringify(data)

})
.select()
.single();



if(error) throw error;


return flag;

}



module.exports={

analyzeProfile,

createFlag

};

