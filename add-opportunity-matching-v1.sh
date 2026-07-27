#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " LearnEarnHub Opportunity Matching v1"
echo "======================================"


echo "1) Creating matching database schema..."

cat > database/opportunity-matching.sql <<'SQL'

CREATE TABLE IF NOT EXISTS opportunity_matches(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,
opportunity_id uuid,

match_score integer DEFAULT 0,

status text DEFAULT 'recommended',

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS opportunity_applications(

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

user_id uuid,
opportunity_id uuid,

message text,

status text DEFAULT 'pending',

created_at timestamp DEFAULT now()

);

SQL



echo "2) Creating matching API..."

cat > api/opportunity-matches.js <<'JS'

const db=require("../database");


module.exports=async(req,res)=>{


if(req.method==="GET"){


const user_id=req.query.user_id;



const profile=await db
.from("learner_cv_profiles")
.select("technical_skills,soft_skills")
.eq("user_id",user_id)
.single();



const opportunities=await db
.from("business_opportunities")
.select("*")
.eq("approved",true);



let skills=((profile.data?.technical_skills||"")
+" "+
(profile.data?.soft_skills||""))
.toLowerCase();



let result=(opportunities.data||[])
.map(o=>{


let text=(
(o.title||"")+
" "+
(o.description||"")+
" "+
(o.category||"")
).toLowerCase();


let score=0;


skills.split(" ")
.filter(x=>x.length>3)
.forEach(word=>{

if(text.includes(word))
score+=10;

});


if(score>100)
score=100;


return {
...o,
match_score:score
};


})
.sort((a,b)=>b.match_score-a.match_score);



return res.json({

success:true,

matches:result

});


}



if(req.method==="POST"){


const {
user_id,
opportunity_id,
message
}=req.body;



const {data,error}=await db
.from("opportunity_applications")
.insert([{

user_id,
opportunity_id,
message

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



echo "3) Creating learner opportunity page..."


cat > public/matched-opportunities-v2.html <<'HTML'

<!DOCTYPE html>
<html>

<head>

<title>Matched Opportunities</title>

<meta charset="UTF-8">

<style>

.card{
border:1px solid #ddd;
padding:15px;
margin:10px;
}

</style>

</head>


<body>


<h1>
Recommended Opportunities
</h1>


<div id="list">
Loading...
</div>



<script>


let user_id=localStorage.getItem("user_id");


fetch("/api/opportunity-matches?user_id="+user_id)

.then(r=>r.json())

.then(d=>{


document.getElementById("list").innerHTML=


(d.matches||[])
.map(o=>`

<div class="card">

<h2>
${o.title||o.title_en||"Opportunity"}
</h2>

<p>
${o.description||o.description_en||""}
</p>


<h3>
Match: ${o.match_score}%
</h3>


<button onclick="apply('${o.id}')">
Apply
</button>


</div>

`)
.join("");


});


async function apply(id){


await fetch("/api/opportunity-matches",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({

user_id,

opportunity_id:id,

message:"Interested in this opportunity"

})


});


alert("Application submitted");

}


</script>


</body>

</html>

HTML



echo "4) Saving..."

git add .

git commit -m "Add learner opportunity matching system v1" || true

git push


echo "======================================"
echo " Opportunity Matching Added"
echo "======================================"

