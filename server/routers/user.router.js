const router = require('express').Router();
const userController = require('../controller/user.controller');

router.post("/registeration",userController.register);

module.exports = router;
