require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function completeCertificateFlow(
user_id,
course_id,
certificate_id,
skill_name
){



// Create verified skill

const {data:skill,error}=await db
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



// Unlock opportunities

const {error:oppError}=await db
.from("opportunity_access")
.upsert({

user_id,

skill_id:skill.id,

unlocked:true

});



if(oppError) throw oppError;



return {

success:true,

message:"Certificate verified. Skill unlocked. Opportunities available.",

skill

};


}



module.exports={
completeCertificateFlow
};

