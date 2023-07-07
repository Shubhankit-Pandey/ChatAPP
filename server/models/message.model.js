const db = require('../config/db');
const UserModel = require("./user.model");
const mongoose = require('mongoose');
const { Schema } = mongoose;

const messageSchema = new Schema({
    userId:{
        type: Schema.Types.ObjectId,
        ref: UserModel.modelName
    },
    description: {
        type: String,
        required: true
    },
});

const messageModel = db.model('messages',messageSchema);
module.exports = messageModel;