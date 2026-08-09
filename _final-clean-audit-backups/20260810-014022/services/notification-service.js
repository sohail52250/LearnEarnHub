require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function sendNotification(data){


const {data:result,error}=await db
.from("notifications")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



async function getNotifications(user_id){


const {data,error}=await db
.from("notifications")
.select("*")
.eq("user_id",user_id)
.order(
"created_at",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



async function markRead(id){


const {data,error}=await db
.from("notifications")
.update({

read_status:true

})
.eq("id",id)
.select()
.single();



if(error) throw error;


return data;

}



module.exports={

sendNotification,

getNotifications,

markRead

};

