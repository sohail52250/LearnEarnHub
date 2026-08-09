require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



function generateCode(){

return "LEH-" +
Date.now();

}



async function createVerification(data){


const code=generateCode();



const {data:result,error}=await db
.from("certificate_verification")
.insert({

certificate_id:data.certificate_id,

user_id:data.user_id,

skill_name:data.skill_name,

verification_code:code,

status:"verified"

})
.select()
.single();



if(error) throw error;


return result;

}



async function verify(code){


const {data,error}=await db
.from("certificate_verification")
.select("*")
.eq("verification_code",code)
.single();



if(error) throw error;


return data;

}



module.exports={

createVerification,

verify

};

