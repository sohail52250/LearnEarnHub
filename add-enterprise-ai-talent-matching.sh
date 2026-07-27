#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Enterprise AI Talent Matching"
echo "======================================"


cat > database/enterprise-ai-matching.sql <<'SQL'

CREATE TABLE IF NOT EXISTS enterprise_candidate_matches(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

enterprise_id uuid,

job_id uuid,

learner_id uuid,

match_score integer DEFAULT 0,

status text DEFAULT 'recommended',

created_at timestamp DEFAULT now()

);

SQL



cat > api/enterprise-ai-matching.js <<'JS'
const db=require("../database");


module.exports=async(req,res)=>{


const job_id=req.query.job_id;


const job=await db

.from("enterprise_jobs")

.select("*")

.eq("id",job_id)

.single();



const learners=await db

.from("learner_profiles")

.select("*");



let required=(job.data?.skills||"")
.toLowerCase();



let matches=(learners.data||[])

.map(l=>{


let skills=(

(l.skills||"")
+" "+
(l.bio||"")

).toLowerCase();



let score=0;


required
.split(" ")
.filter(x=>x.length>2)
.forEach(word=>{

if(skills.includes(word))
score+=10;

});


if(score>100)
score=100;


return {

learner:l,

match_score:score

};


})


.sort((a,b)=>
b.match_score-a.match_score
);



res.json({

success:true,

matches

});


};
JS



cat > public/enterprise-talent-matching.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>AI Talent Matching</title>

<meta charset="UTF-8">

<style>

.card{
border:1px solid #ddd;
padding:15px;
margin:10px;
border-radius:10px;
}

</style>

</head>


<body>


<h1>
AI Talent Recommendations
</h1>


<div id="list">
Loading...
</div>



<script>


let job_id=
new URLSearchParams(location.search)
.get("job_id");


fetch("/api/enterprise-ai-matching?job_id="+job_id)

.then(r=>r.json())

.then(d=>{


list.innerHTML=(d.matches||[])

.map(m=>`

<div class="card">

<h3>
${m.learner.name||"Learner"}
</h3>


<p>
Match Score:
${m.match_score}%
</p>


</div>

`)

.join("");

});


</script>


</body>

</html>
HTML



git add .

git commit -m "Add enterprise AI talent matching system" || true

git push


echo "======================================"
echo " AI Talent Matching Added"
echo "======================================"

