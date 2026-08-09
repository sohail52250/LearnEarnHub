require("dotenv").config();

const axios = require("axios");

const BASE="http://localhost:3000/api/progress";

(async()=>{

console.log("=== Testing Progress API ===");

try{

const get=await axios.get(
`${BASE}/demo-user/2`
);

console.log("GET Progress ✅");
console.log(get.data);

}catch(e){
console.log("GET Progress test skipped:",e.message);
}


try{

const post=await axios.post(
`${BASE}/complete`,
{
 user_id:"00000000-0000-0000-0000-000000000001",
 course_id:2,
 lesson_id:1
}
);

console.log("POST Complete ✅");
console.log(post.data);

}catch(e){
console.log("POST Complete test:",e.response?.data || e.message);
}

})();
