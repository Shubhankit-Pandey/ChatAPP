const router = require("express").Router();
const messageController = require('../controller/message.controller')

router.post("/createmessage",messageController.createmessage);

module.exports = router;