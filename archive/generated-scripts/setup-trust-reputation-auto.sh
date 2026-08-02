#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Trust & Reputation Setup ==="

mkdir -p services api/trust



cat > database/trust-reputation.sql <<'SQL'

CREATE TABLE IF NOT EXISTS verification_records (

id BIGSERIAL PRIMARY KEY,

user_id UUID NOT NULL,

reference_code TEXT UNIQUE NOT NULL,

verification_type TEXT,

classification TEXT DEFAULT 'VERIFIED',

status TEXT DEFAULT 'active',

created_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS reputation_scores (

id BIGSERIAL PRIMARY KEY,

user_id UUID UNIQUE NOT NULL,

rating_score INTEGER DEFAULT 0,

completed_jobs INTEGER DEFAULT 0,

verified_skills INTEGER DEFAULT 0,

trust_level TEXT DEFAULT 'NEW',

updated_at TIMESTAMP DEFAULT NOW()

);



CREATE TABLE IF NOT EXISTS reputation_reviews (

id BIGSERIAL PRIMARY KEY,

reviewer_id UUID,

reviewed_user_id UUID NOT NULL,

rating INTEGER CHECK(rating >=1 AND rating <=5),

comment TEXT,

reference_id BIGINT REFERENCES verification_records(id),

created_at TIMESTAMP DEFAULT NOW()

);



CREATE INDEX IF NOT EXISTS verification_user_idx

ON verification_records(user_id);


CREATE INDEX IF NOT EXISTS reputation_user_idx

ON reputation_scores(user_id);


SQL



cat > services/trust-service.js <<'JS'
require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");


const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);



function generateReference(){

return "LEH-REF-" + Date.now();

}



function calculateTrust(data){


let points=0;


points += data.completed_jobs * 10;

points += data.verified_skills * 20;


if(data.rating_score>=80)
points += 30;


if(points>=150)
return "TRUSTED";


if(points>=80)
return "VERIFIED";


return "NEW";

}



async function createVerification(data){


const {data:result,error}=await db
.from("verification_records")
.insert({

user_id:data.user_id,

reference_code:generateReference(),

verification_type:data.type,

classification:data.classification || "VERIFIED"

})
.select()
.single();



if(error) throw error;


return result;

}



async function updateReputation(user_id,data){


const level=
calculateTrust(data);



const {data:result,error}=await db
.from("reputation_scores")
.upsert({

user_id,

...data,

trust_level:level,

updated_at:new Date()

})
.select()
.single();



if(error) throw error;


return result;

}



module.exports={

createVerification,

updateReputation

};

JS



cat > api/trust/index.js <<'JS'
const service=require("../../services/trust-service");


module.exports=async function(req,res){

try{


if(req.body.action==="verify"){

return res.json(
await service.createVerification(
req.body.data
)
);

}



if(req.body.action==="score"){

return res.json(
await service.updateReputation(
req.body.user_id,
req.body.data
)
);

}



res.status(400).json({

error:"Invalid request"

});


}catch(e){

res.status(500).json({

error:e.message

});

}

};

JS



if ! grep -q "/api/trust" server.js
then

cat >> server.js <<'JS'


// Trust Reputation API

const trust=require("./api/trust");


app.post(
"/api/trust",
trust
);


JS

fi



node -c server.js


echo ""

echo "✅ Trust & Reputation Engine Created"

echo ""

echo "Added:"

echo "🔐 Hidden verification records"

echo "🆔 Reference codes"

echo "⭐ Reputation scores"

echo "🏷 Trust classification"

echo "📋 Review foundation"


