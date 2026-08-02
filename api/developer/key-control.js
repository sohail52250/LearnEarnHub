const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



module.exports=async(req,res)=>{


try{


if(req.method==="GET"){


const result =
await db
.from("developer_keys")
.select("*");


console.log("SUPABASE URL:", process.env.SUPABASE_URL);\nconsole.log("KEY RESULT:", result.data, result.error);\n\nreturn res.json({

success:true,

keys:result.data || []

});

}



if(req.method==="POST"){


const {
action,
id
}=req.body;



if(action==="block"){

await db.rpc(
"block_api_key",
{
p_key_id:id
}
);


}



if(action==="unblock"){

await db.rpc(
"unblock_api_key",
{
p_key_id:id
}
);


}



return res.json({

success:true,

action

});

}


res.status(405).json({

error:"Method not allowed"

});



}

catch(e){

res.status(500).json({

error:e.message

});

}


};
