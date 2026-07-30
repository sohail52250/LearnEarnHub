#!/data/data/com.termux/files/usr/bin/bash

echo "=== Adding Course Unlock API ==="

cat > api/unlock-course.js <<'JS'
const express = require("express");
const router = express.Router();
const db = require("../database");


router.post("/", async (req,res)=>{

try{

const {
user_id,
completed_course_id
}=req.body;


if(!user_id || !completed_course_id){

return res.json({
success:false,
error:"missing data"
});

}


// find next course in learning path

const {data:pathCourse}=await db
.from("learning_path_courses")
.select("*")
.gt("sequence_number",
(
await db
.from("learning_path_courses")
.select("sequence_number")
.eq("course_id",completed_course_id)
.single()
).data.sequence_number
)
.order("sequence_number")
.limit(1)
.single();


if(!pathCourse){

return res.json({
success:true,
message:"Learning path completed"
});

}


// create unlock

const {error}=await db
.from("course_unlocks")
.insert({

user_id:user_id,
course_id:pathCourse.course_id,
unlocked:true,
unlocked_at:new Date()

});


if(error){

return res.json({
success:false,
error:error.message
});

}


res.json({

success:true,

message:"Next course unlocked",

course_id:pathCourse.course_id

});


}catch(e){

res.status(500).json({

success:false,

error:e.message

});

}

});


module.exports=router;
JS


# Add route to api/index.js

if ! grep -q "unlock-course" api/index.js
then

sed -i '/app.use("\/api\/complete-course"/a\
app.use("/api/course/unlock-next", require("./unlock-course"));' api/index.js

echo "✅ Route added"

else

echo "Route already exists"

fi


echo "=== Verification ==="

grep -n "unlock-course" api/index.js

echo "=== Complete ==="

