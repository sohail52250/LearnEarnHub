#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Notification Foundation ==="

cat > database/create-learner-notifications.sql <<'SQL'

create table if not exists public.learner_notifications (
    id bigint generated always as identity primary key,

    learner_id text,

    title text not null,
    body text,

    read boolean default false,

    created_at timestamptz default now()
);

create index if not exists idx_learner_notifications_read
on public.learner_notifications(read);

notify pgrst,'reload schema';

SQL

mkdir -p scripts

cat > scripts/generate-notifications.js <<'JS'
require("dotenv").config();

const { createClient } = require("@supabase/supabase-js");

const db = createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

 const { data: opportunities, error } =
 await db
   .from("external_opportunities")
   .select("*")
   .limit(20);

 if(error){
   console.error(error);
   process.exit(1);
 }

 if(!opportunities || !opportunities.length){
   console.log("No opportunities found");
   process.exit(0);
 }

 const notifications = opportunities.map(o=>({
   learner_id: "GLOBAL",
   title: o.title,
   body:
     "New opportunity available: " +
     o.opportunity_type
 }));

 const result = await db
   .from("learner_notifications")
   .insert(notifications);

 if(result.error){
    console.error(result.error);
    process.exit(1);
 }

 console.log(
   "Notifications created:",
   notifications.length
 );

})();
JS

echo ""
echo "Created:"
echo "database/create-learner-notifications.sql"
echo "scripts/generate-notifications.js"
echo ""
echo "Run SQL in Supabase first."
