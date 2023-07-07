const express = require("express");
const bodyParser = require("body-parser")
const UserRoute = require("./routers/user.router");
const messageRoute = require('./routers/message.router');
const app = express();
const cors = require('cors');

app.use(cors());
app.use(bodyParser.json())

app.use("/",UserRoute);
app.use("/",messageRoute);

module.exports = app;