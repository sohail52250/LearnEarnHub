require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function unlockSkill(user_id,course_id,certificate_id,skill_name){


const {data,error}=await db
.from("learner_skills")
.upsert({

user_id,

course_id,

certificate_id,

skill_name,

verified:true

})
.select()
.single();



if(error) throw error;



await db
.from("opportunity_access")
.upsert({

user_id,

skill_id:data.id,

unlocked:true

});



return data;

}



async function getSkills(user_id){


const {data,error}=await db
.from("learner_skills")
.select("*")
.eq("user_id",user_id);



if(error) throw error;


return data || [];

}



module.exports={
unlockSkill,
getSkills
};

