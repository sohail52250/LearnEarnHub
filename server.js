const express = require("express");
const app = express();

app.get("/api/status", (req, res) => {
  res.json({
    name: "Learn & Earn Hub",
    status: "Running"
  });
});

module.exports = app;
