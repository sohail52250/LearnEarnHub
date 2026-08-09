require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function getUsers(){


const {data,error}=await db
.from("profiles")
.select(`
user_id,
full_name,
bio
`);


if(error) throw error;


return data || [];

}



async function getRole(user_id){


const {data,error}=await db
.from("user_roles")
.select("*")
.eq("user_id",user_id)
.single();



if(error && error.code!=="PGRST116")
throw error;


return data || {
role:"learner"
};

}



async function updateRole(user_id,role){


const {data,error}=await db
.from("user_roles")
.upsert({

user_id,

role,

updated_at:new Date()

})
.select()
.single();



if(error) throw error;


return data;

}



module.exports={
getUsers,
getRole,
updateRole
};

