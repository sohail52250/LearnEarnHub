require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function signup(email,password){

const {data,error}=await db.auth.admin.createUser({

email,

password,

email_confirm:true

});


if(error) throw error;


return data.user;

}



async function login(email,password){

const client=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_ANON_KEY
);


const {data,error}=await client.auth.signInWithPassword({

email,

password

});


if(error) throw error;


return data;

}



module.exports={
signup,
login
};

