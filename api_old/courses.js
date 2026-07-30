const db = require("../database");

module.exports = async function(req,res){

  try {

    const { data, error } = await db
      .from("courses")
      .select("id,title_en,title_ur,description_en,description_ur,content_en,content_ur,points")
      .order("created_at",{ascending:false});

    if(error){
      return res.status(500).json({
        error:error.message
      });
    }

    res.status(200).json(data);

  } catch(err){

    res.status(500).json({
      error:err.message
    });

  }

};
