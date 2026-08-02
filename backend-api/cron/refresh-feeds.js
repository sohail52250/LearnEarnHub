module.exports=async(req,res)=>{

try{

const base=
process.env.APP_URL ||
"https://learn-earnhub.vercel.app";


const response=
await fetch(
base+"/api/feeds/refresh"
);


const data=
await response.json();


res.json({

success:true,
scheduler:"active",
result:data

});


}catch(e){

res.status(500).json({
error:e.message
});

}

};
