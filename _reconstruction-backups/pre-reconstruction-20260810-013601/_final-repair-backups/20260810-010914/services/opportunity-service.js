require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



async function listOpportunities(){


const {data,error}=await db
.from("external_opportunities")
.select("*")
.order(
"created_at",
{
ascending:false
}
);



if(error) throw error;


return data || [];

}



async function addOpportunity(data){


const {data:result,error}=await db
.from("external_opportunities")
.insert(data)
.select()
.single();



if(error) throw error;


return result;

}



module.exports={

listOpportunities,

addOpportunity

};

