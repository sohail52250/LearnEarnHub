const db = require("../database");

module.exports = async (req,res) => {

  const { data, error } = await db
    .from("users")
    .select("*")
    .limit(1);

  if(error){
    return res.status(500).json({
      success:false,
      error:error.message
    });
  }

  res.json({
    success:true,
    data
  });
};
