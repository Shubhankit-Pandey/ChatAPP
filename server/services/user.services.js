const UserModel = require('../models/user.model');
const jwt = require("jsonwebtoken");

class UserService{
    static async registerUser(email,password){
        try{
            const createUser = new UserModel({email,password});
            return await createUser.save();
        }catch(err){
            throw err;
        }
    }
    static async getUserByEmail(email){
        try{
            return await UserModel.findOne({email});
        }catch(err){
            console.log(err);
        }
    }

    static async checkuser(email){
        try {
            return await UserModel.findOne({email});
        } catch (error) {
            throw error;
        }
    }

    static async generateToken(tokendata,secretkey,jwt_expire){
        return jwt.sign(tokendata,secretkey,{expiresIn:jwt_expire});
    }
}

module.exports = UserService;;