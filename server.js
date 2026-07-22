require("dotenv").config();

const express = require("express");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get("/api/status", (req, res) => {
  res.json({
    name: "Learn & Earn Hub",
    status: "Running",
    database: "Supabase"
  });
});

app.get("/", (req, res) => {
  res.json({
    app: "Learn & Earn Hub",
    languages: ["English", "Urdu"],
    features: [
      "Learn",
      "Earn",
      "Marketplace",
      "Profiles"
    ]
  });
});

module.exports = app;
