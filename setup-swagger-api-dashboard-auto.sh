#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Swagger API Dashboard Setup ==="


mkdir -p public/swagger
mkdir -p api/developer


cat > public/swagger/index.html <<'HTML'
<!DOCTYPE html>
<html>
<head>

<title>LearnEarnHub API Documentation</title>

<link rel="stylesheet"
href="https://unpkg.com/swagger-ui-dist/swagger-ui.css">

</head>

<body>


<div id="swagger-ui"></div>


<script src="https://unpkg.com/swagger-ui-dist/swagger-ui-bundle.js"></script>


<script>

SwaggerUIBundle({

url:"/docs/openapi.json",

dom_id:"#swagger-ui"

});

</script>


</body>
</html>
HTML



cat > public/docs/openapi.json <<'JSON'
{

"openapi":"3.0.0",

"info":{

"title":"LearnEarnHub API",

"version":"1.0.0",

"description":
"LearnEarnHub Jobs, Opportunities, Learning and AI Matching API"

},


"servers":[

{
"url":"https://learn-earnhub.vercel.app"
}

],


"security":[

{
"ApiKeyAuth":[]
}

],


"components":{

"securitySchemes":{

"ApiKeyAuth":{

"type":"apiKey",

"name":"X-API-Key",

"in":"header"

}

}

},


"paths":{


"/api/analytics":{

"get":{

"summary":"Platform Analytics",

"parameters":[

{

"name":"action",

"in":"query",

"required":true,

"example":"stats"

}

],

"responses":{

"200":{

"description":"Analytics result"

}

}

}

},


"/api/global-opportunities":{

"get":{

"summary":"Global Opportunities",

"responses":{

"200":{

"description":"Opportunity list"

}

}

}

},


"/api/employer-posts":{

"get":{

"summary":"Employer Jobs",

"responses":{

"200":{

"description":"Job list"

}

}

}

}

}

}

JSON



cat > api/developer/dashboard.js <<'JS'

const {createClient}=require("@supabase/supabase-js");

require("dotenv").config();


const db=createClient(

process.env.SUPABASE_URL,

process.env.SUPABASE_SERVICE_KEY

);



module.exports=async(req,res)=>{


try{


let keys=await db

.from("api_partner_keys")

.select(
"id,partner_id,status,request_limit,last_used_at"
);



let docs=await db

.from("api_documentation_views")

.select("*",{count:"exact"});


res.json({

api_keys:
keys.data || [],

documentation_views:
docs.count || 0

});


}catch(e){

res.status(500)
.json({

error:e.message

});

}


};

JS



cat > database/swagger-dashboard.sql <<'SQL'


create table if not exists public.api_dashboard_logs
(

id bigint generated always as identity primary key,

partner_id bigint
references public.api_partners(id)
on delete cascade,

action text,

details jsonb default '{}'::jsonb,

created_at timestamptz default now()

);



insert into public.api_dashboard_logs
(
partner_id,
action,
details
)

select

id,

'SWAGGER_ENABLED',

jsonb_build_object(
'version',
'1.0'
)

from public.api_partners

where email='partner@learn-earnhub.com';



notify pgrst,'reload schema';



select *
from public.api_dashboard_logs;


SQL



git add .

git commit -m "Add Swagger API documentation dashboard"


echo ""
echo "DONE"
echo ""
echo "Swagger:"
echo "https://learn-earnhub.vercel.app/swagger/"
echo ""
echo "SQL:"
echo "database/swagger-dashboard.sql"

