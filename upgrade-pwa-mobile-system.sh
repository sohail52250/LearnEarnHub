#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub PWA Mobile Upgrade"
echo "======================================"

mkdir -p public/icons


echo "1) Creating manifest..."

cat > public/manifest.json <<'JSON'
{
"name":"LearnEarnHub",
"short_name":"LearnEarnHub",
"description":"Learn skills and earn opportunities online",
"start_url":"/",
"display":"standalone",
"background_color":"#ffffff",
"theme_color":"#2563eb",
"lang":"en",
"icons":[
{
"src":"/icons/icon-192.png",
"sizes":"192x192",
"type":"image/png"
},
{
"src":"/icons/icon-512.png",
"sizes":"512x512",
"type":"image/png"
}
]
}
JSON


echo "2) Creating service worker..."

cat > public/service-worker.js <<'JS'

const CACHE_NAME="learnearnhub-v1";

const FILES=[
"/",
"/index.html",
"/courses.html",
"/course-marketplace.html",
"/learner-dashboard.html",
"/manifest.json"
];


self.addEventListener("install",event=>{

event.waitUntil(
caches.open(CACHE_NAME)
.then(cache=>cache.addAll(FILES))
);

});


self.addEventListener("fetch",event=>{

event.respondWith(

caches.match(event.request)
.then(response=>{

return response || fetch(event.request);

})

);

});


JS



echo "3) Adding PWA registration..."

cat > public/pwa-register.js <<'JS'

if("serviceWorker" in navigator){

navigator.serviceWorker.register("/service-worker.js")
.then(()=>{
console.log("LearnEarnHub Offline Mode Ready");
});

}

JS



echo "4) Notification API..."

cat > api/notifications.js <<'JS'

const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="GET"){

const {data,error}=await db
.from("notifications")
.select("*")
.order("created_at",{ascending:false});


return res.json({
data,error
});

}



if(req.method==="POST"){

const {user_id,title,message}=req.body;


const {data,error}=await db
.from("notifications")
.insert([{
user_id,
title,
message
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



echo "5) Offline learning database..."

cat > database/offline_learning.sql <<'SQL'

CREATE TABLE IF NOT EXISTS notifications(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
title text,
message text,
read boolean DEFAULT false,
created_at timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS offline_learning(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
course_id uuid,
downloaded boolean DEFAULT false,
last_sync timestamp DEFAULT now()
);


CREATE TABLE IF NOT EXISTS mobile_devices(
id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
user_id uuid,
device_token text,
platform text,
created_at timestamp DEFAULT now()
);


SQL



echo "6) Add manifest link to pages..."

for file in public/*.html
do

grep -q "manifest.json" "$file" || \
sed -i 's#</head>#<link rel="manifest" href="/manifest.json"></head>#' "$file"

done



echo "7) Git save..."

git add public database api

git commit -m "Add PWA mobile offline and notification system" || true

git push


echo "======================================"
echo " PWA MOBILE UPGRADE COMPLETE"
echo "======================================"

echo "Run SQL:"
echo "database/offline_learning.sql"

