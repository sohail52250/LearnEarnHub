require("dotenv").config();
const {createClient}=require("@supabase/supabase-js");

const db=createClient(
process.env.SUPABASE_URL,
process.env.SUPABASE_SERVICE_KEY
);

(async()=>{

const {data}=await db
.from("courses")
.select("id,title_en,description,category");

let weak=[];

for(const c of data){

if(
!c.description ||
c.description.length < 50
){
weak.push({
id:c.id,
title:c.title_en,
description:c.description
});
}

}

console.log("Weak descriptions:",weak.length);
console.log(weak);

})();
