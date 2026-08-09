require("dotenv").config();
const db = require("./database");

async function check(){

for (const table of [
"courses",
"course_lessons",
"learning_path_courses",
"course_unlocks"
]){

const {data,error,count}=await db
.from(table)
.select("*",{count:"exact"})
.limit(5);

console.log("\nTABLE:",table);
console.log("COUNT:",count);
console.log("DATA:",data);
console.log("ERROR:",error);

}

process.exit();
}

check();
