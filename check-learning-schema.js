require("dotenv").config();
const db=require("./database");

async function run(){

const {data,error}=await db
.from("learning_path_courses")
.select("*")
.limit(1);

console.log(data);
console.log(error);

process.exit();
}

run();
