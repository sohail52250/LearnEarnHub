
const router=require("express").Router();

const multer=require("multer");


const upload=multer({
dest:"uploads/"
});


router.post("/",upload.single("image"),(req,res)=>{


res.json({

message:"Image uploaded",
file:req.file.filename

});


});


module.exports=router;

