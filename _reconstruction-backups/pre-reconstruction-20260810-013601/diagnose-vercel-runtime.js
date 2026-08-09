const fs = require("fs");

console.log("=== LearnEarnHub Runtime Check ===");

try{
  require("./server.js");
  console.log("✅ server.js loaded");
}catch(e){
  console.log("❌ server.js failed");
  console.error(e);
}

console.log("");

const files = [
  "./api/analytics.js",
  "./api/employer-posts/index.js",
  "./api/opportunities/global.js"
];

for(const f of files){
  try{
    require(f);
    console.log("✅",f);
  }catch(e){
    console.log("❌",f);
    console.error(e.message);
  }
}

console.log("");
console.log("=== ENV ===");

[
 "SUPABASE_URL",
 "SUPABASE_ANON_KEY",
 "SUPABASE_SERVICE_KEY"
].forEach(k=>{
 console.log(
  k,
  process.env[k] ? "FOUND" : "MISSING"
 );
});
