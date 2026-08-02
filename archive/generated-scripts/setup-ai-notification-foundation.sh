#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub AI Notification Foundation ==="

mkdir -p services/ai services/notifications api/notifications



cat > services/ai/opportunity-score.js <<'JS'
function scoreMatch(userSkills, opportunitySkills){

if(!userSkills || !opportunitySkills) return 0;

const user=userSkills.toLowerCase().split(",");

const opp=opportunitySkills.toLowerCase().split(",");

let score=0;

for(const s of user){
 if(opp.includes(s.trim())) score+=20;
}

if(score>100) score=100;

return score;
}

module.exports={scoreMatch};
JS



cat > services/notifications/queue.js <<'JS'
const queue=[];

function add(item){
 queue.push({
  ...item,
  created_at:new Date().toISOString()
 });
 return true;
}

function list(){
 return queue;
}

module.exports={add,list};
JS



cat > api/notifications/index.js <<'JS'
const queue=require("../../services/notifications/queue");

module.exports=(req,res)=>{

if(req.method==="GET"){
 return res.json(queue.list());
}

if(req.method==="POST"){
 queue.add(req.body);
 return res.json({success:true});
}

res.status(405).end();
};
JS



echo ""
echo "✅ AI Notification Foundation Created"
echo ""
echo "Added:"
echo "🎯 Match scoring engine"
echo "🔔 Notification queue"
echo "📬 Notification API foundation"

