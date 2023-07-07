const messageService = require('../services/message.services');

exports.createmessage =  async (req,res,next)=>{
    try {
        const { userId,desc} = req.body;
        let messageData = await messageService.createmessage(userId, desc);
        res.json({status: true,success:messageData});
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}
