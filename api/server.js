const express = require("express");
const app = express();

app.get("/", (req,res)=>res.json({status:"online"}));
app.get("/health",(req,res)=>res.json({health:"ok"}));

app.listen(4000,()=>console.log("API running"));
