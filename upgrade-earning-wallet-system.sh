#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Earning Wallet Upgrade"
echo "======================================"

mkdir -p api database


echo "1) Creating earning database schema..."

cat > database/earning_wallet.sql <<'SQL'

CREATE TABLE IF NOT EXISTS wallets(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid UNIQUE,
points integer DEFAULT 0,
balance_pkr numeric DEFAULT 0,
updated_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS earning_tasks(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
title_en text,
title_ur text,
description_en text,
description_ur text,
reward_points integer DEFAULT 10,
status text DEFAULT 'active',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS task_applications(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
task_id uuid,
user_id uuid,
status text DEFAULT 'pending',
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS wallet_transactions(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
type text,
points integer,
amount_pkr numeric,
description text,
created_at timestamp DEFAULT now()
);


SQL


echo "2) Creating wallet API..."

cat > api/wallet.js <<'JS'

const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){

const user_id=req.query.user_id;


const {data,error}=await db
.from("wallets")
.select("*")
.eq("user_id",user_id)
.single();


return res.json({
success:!error,
wallet:data,
error
});

}



if(req.method==="POST"){

const {
user_id,
points,
amount_pkr,
description
}=req.body;


const {data,error}=await db
.from("wallet_transactions")
.insert([{
user_id,
type:"credit",
points,
amount_pkr,
description
}])
.select();


return res.json({
success:!error,
data,
error
});

}


res.status(405).json({
error:"Method not allowed"
});


};

JS



echo "3) Creating earning tasks API..."

cat > api/earning-tasks.js <<'JS'

const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){

const {data,error}=await db
.from("earning_tasks")
.select("*")
.eq("status","active");


return res.json({
data,error
});

}



if(req.method==="POST"){

const {
title_en,
title_ur,
description_en,
description_ur,
reward_points
}=req.body;


const {data,error}=await db
.from("earning_tasks")
.insert([{
title_en,
title_ur,
description_en,
description_ur,
reward_points
}])
.select();


return res.json({
success:!error,
data,error
});


}


res.status(405).json({
error:"Method not allowed"
});


};

JS



echo "4) Creating earning dashboard..."

cat > api/earning-dashboard.js <<'JS'

const db=require("../database");


module.exports=async(req,res)=>{

const user_id=req.query.user_id;


const wallet=await db
.from("wallets")
.select("*")
.eq("user_id",user_id);


const history=await db
.from("wallet_transactions")
.select("*")
.eq("user_id",user_id)
.order("created_at",{ascending:false});


res.json({

success:true,

wallet:wallet.data,

transactions:history.data

});


};

JS



echo "5) Git save..."

git add api database

git commit -m "Add earning marketplace wallet points system" || true

git push


echo "======================================"
echo " EARNING SYSTEM READY"
echo "======================================"

echo "Execute SQL:"
echo "database/earning_wallet.sql"

