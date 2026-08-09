require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function createProfile(user){


const {error}=await db
.from("profiles")
.upsert({

user_id:user.id,

full_name:user.email?.split("@")[0] || "Learner"

});



if(error) throw error;


return true;

}



module.exports={
createProfile
};

