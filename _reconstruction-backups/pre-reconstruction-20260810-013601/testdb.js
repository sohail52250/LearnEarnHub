require("dotenv").config();

const db = require("./database");

async function test(){

const {data,error}=await db
.from("users")
.select("*")
.limit(5);

if(error){
console.log("Database error:");
console.log(error.message);
}else{
console.log("Supabase connected!");
console.log(data);
}

}

test();
