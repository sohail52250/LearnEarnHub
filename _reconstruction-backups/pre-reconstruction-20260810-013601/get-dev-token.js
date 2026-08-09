require("dotenv").config();

const {createClient}=require("@supabase/supabase-js");

const supabase=createClient(
 process.env.SUPABASE_URL,
 process.env.SUPABASE_ANON_KEY
);

(async()=>{

const {data,error}=await supabase.auth.signInWithPassword({
 email:"it03346543200@gmail.com",
 password:"YOUR_PASSWORD"
});

if(error){
 console.log(error);
 return;
}

console.log("ACCESS TOKEN:");
console.log(data.session.access_token);

})();
