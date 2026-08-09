require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function sendMessage(data){


const {data:result,error}=await db
.from("messages")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



async function inbox(user_id){


const {data,error}=await db
.from("messages")
.select("*")
.eq("receiver_id",user_id)
.order(
"created_at",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



module.exports={

sendMessage,

inbox

};

