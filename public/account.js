async function showUser(){

const client = supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

const {data,error}=await client.auth.getSession();

if(error || !data.session){
return;
}

const user=data.session.user;

const {data:profile}=await client
.from("profiles")
.select("name")
.eq("id",user.id)
.single();

const box=document.getElementById("username");

if(box && profile){
box.innerHTML="Welcome "+profile.name;
}

}


async function logoutUser(){

const client=supabase.createClient(
SUPABASE_URL,
SUPABASE_ANON_KEY
);

await client.auth.signOut();

window.location="/login.html";

}
