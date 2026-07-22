require("dotenv").config();

const express = require("express");
const session = require("express-session");
const cors = require("cors");


const app = express();


app.use(cors());

app.use(express.json());

app.use(express.urlencoded({
extended:true
}));


app.use(express.static("public"));


app.use(session({

secret:"learnEarnSecret",

resave:false,

saveUninitialized:false

}));


// Routes

const authRoutes = require("./routes/auth");
const adsRoutes = require("./routes/ads");
const courseRoutes = require("./routes/courses");
const adminRoutes = require("./routes/admin");
const searchRoutes = require("./routes/search");
const profileRoutes = require("./routes/profile");
const reviewRoutes = require("./routes/reviews");
const uploadRoutes = require("./routes/upload");


// API

app.use("/api/auth", authRoutes);

app.use("/api/ads", adsRoutes);

app.use("/api/courses", courseRoutes);

app.use("/api/admin", adminRoutes);

app.use("/api/search", searchRoutes);

app.use("/api/profile", profileRoutes);

app.use("/api/reviews", reviewRoutes);

app.use("/api/upload", uploadRoutes);



app.get("/api/status",(req,res)=>{

res.json({

name:"Learn & Earn Hub",

status:"Running",

database:"Supabase"

});

});



app.get("/",(req,res)=>{

res.sendFile(__dirname+"/public/index.html");

});



const PORT = process.env.PORT || 3000;


if (require.main === module) {
  app.listen(PORT, () => {
    console.log("Learn & Earn Hub running on port " + PORT);
  });
}

module.exports = app;
