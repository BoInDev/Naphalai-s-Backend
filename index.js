const express = require("express");
// const helmet = require("helmet");
const bodyParser = require("body-parser");
const cors = require('cors')
const app = express();
const port = 5000;
// Import router
const router_masterdata = require("./src/router/masterdata"); 
const router_auth = require("./src/router/auth_user_router");

// // Middleware to parse JSON bodies
app.use(express.json());
app.use(cors())

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET,PUT,POST,DELETE");
  res.header("Access-Control-Allow-Headers", "Content-Type");
  next();
});

//use bodyParser
app.use(bodyParser.json({extended: true}))
app.use(bodyParser.urlencoded({extended: true,limit: "500mb",parameterLimit: 500}))


// Main Router Integration
app.use('/masterdata', router_masterdata);
app.use('/auth', router_auth);

// start server
app.listen(port, () => {
  console.log(`App listening on port ${port}`);
});
