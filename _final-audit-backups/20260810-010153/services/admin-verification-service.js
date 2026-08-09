require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function pendingRecords(){


const {data,error}=await db
.from("verification_records")
.select("*")
.eq(
"status",
"pending"
)
.order(
"created_at",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



async function updateStatus(id,status){


const {data,error}=await db
.from("verification_records")
.update({

status

})
.eq(
"id",
id
)
.select()
.single();



if(error) throw error;


return data;

}



module.exports={

pendingRecords,

updateStatus

};

