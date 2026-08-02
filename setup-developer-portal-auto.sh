#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Developer Portal Setup ==="

mkdir -p public/developer
mkdir -p public/docs


cat > public/developer/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>
<title>LearnEarnHub Developer Portal</title>
<meta charset="UTF-8">

<style>
body{
font-family:Arial;
margin:30px;
background:#f5f5f5
}

.card{
background:white;
padding:20px;
border-radius:12px;
margin-bottom:20px
}

code{
background:#eee;
padding:5px
}

button{
padding:10px;
cursor:pointer
}

</style>

</head>

<body>


<h1>LearnEarnHub Developer Portal</h1>


<div class="card">

<h2>API Access</h2>

<p>
Use your API key:
</p>

<code>
X-API-Key: LEH_PUBLIC_API_DEMO_KEY_2026
</code>

</div>



<div class="card">

<h2>Available APIs</h2>

<ul>

<li>
Analytics API
<br>
/api/analytics?action=stats
</li>


<li>
Global Opportunities
<br>
/api/global-opportunities
</li>


<li>
Employer Jobs
<br>
/api/employer-posts
</li>


<li>
Notifications
<br>
/api/notifications
</li>


</ul>

</div>



<div class="card">

<h2>API Tester</h2>

<button onclick="testAPI()">
Test Analytics API
</button>


<pre id="out"></pre>

</div>



<script>

async function testAPI(){

let r=await fetch(
"/api/analytics?action=stats",
{
headers:{
"X-API-Key":
"LEH_PUBLIC_API_DEMO_KEY_2026"
}
}
);


let d=await r.json();

out.innerHTML=
JSON.stringify(d,null,2);

}

</script>


</body>
</html>
HTML



cat > public/docs/openapi.json <<'JSON'
{

"openapi":"3.0.0",

"info":{

"title":"LearnEarnHub API",

"version":"1.0",

"description":
"Jobs, opportunities, learning and matching API"

},


"servers":[

{
"url":"https://learn-earnhub.vercel.app"
}

],


"paths":{


"/api/analytics":{

"get":{

"summary":"Analytics statistics",

"parameters":[

{

"name":"action",

"in":"query",

"required":true,

"example":"stats"

}

]

}

},


"/api/global-opportunities":{

"get":{

"summary":"List opportunities"

}

}


}

}

JSON



cat > database/developer-portal.sql <<'SQL'


create table if not exists public.api_documentation_views
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

page text,

created_at timestamptz default now()

);



notify pgrst,'reload schema';


select *
from public.api_documentation_views;


SQL



git add .

git commit -m "Add LearnEarnHub developer portal and OpenAPI docs"


echo ""
echo "DONE"
echo ""
echo "Portal:"
echo "https://learn-earnhub.vercel.app/developer/"
echo ""
echo "SQL:"
echo "database/developer-portal.sql"

