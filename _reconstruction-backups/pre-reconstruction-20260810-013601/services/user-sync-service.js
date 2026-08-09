require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);


async function syncUser(authUser){

const {data,error}=await db
.from("users")
.upsert({

id:authUser.id,

email:authUser.email,

updated_at:new Date()

})
.select()
.single();


if(error)
throw error;


return data;

}


module.exports={
syncUser
};

