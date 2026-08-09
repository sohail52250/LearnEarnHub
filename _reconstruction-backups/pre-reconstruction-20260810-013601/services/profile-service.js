require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function getProfile(user_id){


const {data,error}=await db
.from("learner_profiles")
.select("*")
.eq("user_id",user_id)
.single();


if(error && error.code!=="PGRST116")
throw error;


return data || null;

}



async function updateProfile(data){


const {data:result,error}=await db
.from("learner_profiles")
.upsert({

...data,

updated_at:new Date()

})
.select()
.single();



if(error) throw error;


return result;

}



async function addReview(data){


const {data:result,error}=await db
.from("learner_reviews")
.insert(data)
.select()
.single();


if(error) throw error;


return result;

}



module.exports={

getProfile,

updateProfile,

addReview

};

