const db = require("./database");

module.exports = async function(req,res){
  const { data, error } = await db
    .from("users")
    .select("*")
    .limit(1);

  if(error){
    return res.status(500).json({error:error.message});
  }

  res.json({
    connected:true,
    rows:data
  });
}
