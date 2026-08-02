#!/data/data/com.termux/files/usr/bin/bash

echo "=== LearnEarnHub Professional Job Marketplace UI Setup ==="

mkdir -p public/jobs



cat > public/jobs/index.html <<'HTML'
<!DOCTYPE html>

<html>

<head>

<title>LearnEarnHub Global Jobs</title>

<meta name="viewport" content="width=device-width, initial-scale=1">


<style>

body{

font-family:Arial,sans-serif;

background:#f4f7fb;

padding:20px;

}


.header{

background:#1565c0;

color:white;

padding:20px;

border-radius:15px;

}


.search-box{

background:white;

padding:15px;

margin:15px 0;

border-radius:12px;

}


input,select,button{

width:100%;

padding:12px;

margin:6px 0;

border-radius:8px;

border:1px solid #ddd;

}


button{

background:#1565c0;

color:white;

border:none;

}


.job{

background:white;

padding:18px;

margin:12px 0;

border-radius:15px;

box-shadow:0 2px 8px #ddd;

}


.badge{

display:inline-block;

padding:5px 10px;

border-radius:20px;

background:#e3f2fd;

margin:3px;

}


.remote{

background:#e8f5e9;

}


.source{

background:#fff3e0;

}


.apply{

display:block;

background:#1565c0;

color:white;

text-align:center;

padding:10px;

border-radius:8px;

text-decoration:none;

margin-top:10px;

}


</style>

</head>


<body>


<div class="header">

<h1>🌍 LearnEarnHub Jobs</h1>

<p>Global jobs, tasks and freelance opportunities</p>

</div>



<div class="search-box">


<input id="keyword" placeholder="Search job">


<input id="skill" placeholder="Skill">


<select id="type">

<option value="">All Types</option>

<option>job</option>

<option>freelance</option>

<option>task</option>

<option>internship</option>

</select>



<select id="remote">

<option value="">Location</option>

<option value="true">
Remote
</option>

</select>



<button onclick="loadJobs()">

Search Opportunities

</button>


</div>



<div id="jobs">

Loading...

</div>



<script>


async function loadJobs(){


let params=new URLSearchParams({

keyword:keyword.value,

skill:skill.value,

type:type.value,

remote:remote.value

});



let response=
await fetch(
"/api/search-opportunities?"+params
);



let data=
await response.json();



jobs.innerHTML=
data.map(j=>`

<div class="job">


<h2>
${j.title}
</h2>


<p>
🏢 ${j.company || "Company"}
</p>


<span class="badge source">
${j.source_name || "LearnEarnHub"}
</span>


<span class="badge">
Skill: ${j.required_skills || j.required_skill || "Not specified"}
</span>


${j.remote ? 
'<span class="badge remote">🏠 Remote</span>'
:
''
}



<p>
💰 ${j.salary || "Salary not provided"}
</p>


<p>
🌍 ${j.country || "Global"}
</p>



<a class="apply"
href="${j.apply_url}"
target="_blank">

Apply Now

</a>


</div>

`).join("")
|| "No opportunities found";


}



loadJobs();


</script>


</body>

</html>
HTML



node -c server.js


echo ""

echo "✅ Professional Job Marketplace UI Created"

echo ""

echo "Added:"

echo "💼 Job cards"

echo "🔎 Search"

echo "🎓 Skill display"

echo "🌍 Source badges"

echo "🏠 Remote label"

echo "💰 Salary field"

echo "🔗 Apply links"


