
async function loadAdminCenter(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const courses =
await client

.from("instructor_courses")

.select("id",{count:"exact"});



const users =
await client

.from("profiles")

.select("id",{count:"exact"});



const businesses =
await client

.from("businesses")

.select("id",{count:"exact"});




document.getElementById(
"admin-stats"
).innerHTML=`

<h2>Platform Overview</h2>

<p>
📚 Courses:
${courses.count || 0}
</p>

<p>
👤 Users:
${users.count || 0}
</p>

<p>
🏢 Businesses:
${businesses.count || 0}
</p>

`;



document.getElementById(
"activity"
).innerHTML=`

<h2>
System Status
</h2>

<p>
✅ Course system active
</p>

<p>
✅ Instructor system active
</p>

<p>
✅ Business network active
</p>

`;

}


document.addEventListener(
"DOMContentLoaded",
loadAdminCenter
);

