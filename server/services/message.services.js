const messageModel = require("../models/message.model");

class messageService{
    static async createmessage(userId,description){
            const createToDo = new messageModel({userId,description});
            return await createToDo.save();
    }
}

module.exports = messageService;