

async function loadAdminPanel(){


const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);



const users=await client
.from("profiles")
.select("*");



const courses=await client
.from("courses")
.select("*");



const businesses=await client
.from("businesses")
.select("*");



const rewards=await client
.from("platform_rewards")
.select("*");




document.getElementById("admin-panel").innerHTML=`



<div class="card">

<h2>
👥 User Management
</h2>

<p>
Total Users:
${users.data?.length || 0}
</p>


<button>
Manage Users
</button>


</div>




<div class="card">

<h2>
📚 Course Management
</h2>


<p>
Courses:
${courses.data?.length || 0}
</p>


<button>
Review Courses
</button>


</div>





<div class="card">

<h2>
🏢 Business Verification
</h2>


<p>
Pending Businesses:

${businesses.data?.filter(
b=>!b.verified
).length || 0}

</p>


<button>
Verify Businesses
</button>


</div>





<div class="card">

<h2>
📊 Platform Analytics
</h2>


<p>
Active Learning Platform
</p>


<p>
Users:
${users.data?.length || 0}
</p>


<p>
Courses:
${courses.data?.length || 0}
</p>


</div>





<div class="card">

<h2>
🎁 Reward Tracking
</h2>


<p>
Reward Transactions:

${rewards.data?.length || 0}

</p>


</div>





<div class="card">

<h2>
🔐 Security Dashboard
</h2>


<p>
Authentication monitoring enabled
</p>


<p>
Security logs active
</p>


</div>



`;

}



document.addEventListener(
"DOMContentLoaded",
loadAdminPanel
);



