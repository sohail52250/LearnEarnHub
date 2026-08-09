require("dotenv").config();
const db = require("./database");

async function check(){

const {data,error}=await db
.from("learning_path_courses")
.select("*")
.limit(20);

console.log("DATA:");
console.log(data);

console.log("ERROR:");
console.log(error);

process.exit();
}

check();
