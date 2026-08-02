#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub User Sync Auto Setup ==="


mkdir -p api services



cat > services/user-sync-service.js <<'JS'
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

JS



cat > api/sync-user.js <<'JS'
require("dotenv").config();

const {syncUser}=require("../services/user-sync-service");


module.exports=async function(req,res){

try{

const user=await syncUser(req.body);


res.json({

success:true,

user

});


}catch(e){

res.status(500).json({

error:e.message

});

}

};

JS



if ! grep -q "sync-user" server.js
then

cat >> server.js <<'JS'


// Auth User Sync API

const syncUser=require("./api/sync-user");

app.post(
"/api/sync-user",
syncUser
);

JS

fi



node -c server.js


echo ""
echo "✅ User sync API created"

echo ""
echo "Test route:"
echo "POST /api/sync-user"

