const UserServices = require('../services/user.services');
exports.register = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const duplicate = await UserServices.getUserByEmail(email);
        if (duplicate) {
            throw new Error(`UserName ${email}, Already Registered`)
        }
        const response = await UserServices.registerUser(email, password);
        res.json({ status: true, success: 'User registered successfully' });
    } catch (err) {
        next(err);
    }
}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const user = await UserServices.checkuser(email);
        console.log("-------user---------",user);

        if(!user){
            throw new Error("user doesn't exist");
        }

        const ismatch = await user.comparePassword(password);

        if(ismatch == false){
            throw new Error("password invalid");
        }

        let tokendata = {_id:user._id,email:user.email};

        const token = await UserServices.generateToken(tokendata,"secretkey",'1h');

        res.status(200).json({status:true,token:token});

    } catch (err) {
        next(err);
    }
}