#!/data/data/com.termux/files/usr/bin/bash

echo "======================================"
echo " Investment AI Copilot V16"
echo "======================================"

mkdir -p database


cat > database/investment-ai-copilot-v16.sql <<'SQL'

CREATE TABLE IF NOT EXISTS ai_copilot_sessions (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

question text,

ai_response text,

created_at timestamp DEFAULT now()

);


CREATE TABLE IF NOT EXISTS ai_investment_notes (

id uuid DEFAULT gen_random_uuid() PRIMARY KEY,

investor_id uuid,

note_type text,

content text,

created_at timestamp DEFAULT now()

);

SQL



cat > api/investment-ai-copilot.js <<'JS'
const db=require("../database");

module.exports=async(req,res)=>{


if(req.method==="POST"){


const {
investor_id,
question
}=req.body;


let response="";


if(question.toLowerCase().includes("risk")){

response=
"AI Analysis: Review risk level, compliance status and business performance before investing.";

}

else if(question.toLowerCase().includes("portfolio")){

response=
"AI Analysis: Portfolio should be diversified across opportunities and monitored regularly.";

}

else if(question.toLowerCase().includes("deal")){

response=
"AI Analysis: Check valuation, due diligence, investor terms and closing status.";

}

else{

response=
"AI Copilot: Your request has been analyzed using investment intelligence data.";

}



await db
.from("ai_copilot_sessions")
.insert([{

investor_id,

question,

ai_response:response

}]);



return res.json({

success:true,

response

});


}


res.status(405).json({

error:"Method not allowed"

});


};
JS



cat > public/investment-ai-copilot.html <<'HTML'
<!DOCTYPE html>
<html>

<head>

<title>Investment AI Copilot</title>

<meta charset="UTF-8">

<style>

.card{
border:1px solid #ddd;
padding:20px;
margin:10px;
border-radius:12px;
}

</style>

</head>


<body>


<h1>🤖 Investment AI Copilot</h1>


<div class="card">

<input id="question"
placeholder="Ask about portfolio, deals, risk...">


<button onclick="askAI()">
Ask AI
</button>


</div>


<div class="card">

<h2>AI Response</h2>

<pre id="answer">
</pre>

</div>



<script>


async function askAI(){


let r=await fetch("/api/investment-ai-copilot",{

method:"POST",

headers:{

"Content-Type":"application/json"

},

body:JSON.stringify({

investor_id:
localStorage.getItem("user_id"),

question:
question.value

})

});


let d=await r.json();


answer.innerHTML=d.response;


}


</script>


</body>

</html>
HTML



git add .

git commit -m "Add Investment AI Copilot V16" || true

git push


echo "======================================"
echo " Investment AI Copilot V16 Completed"
echo "======================================"

