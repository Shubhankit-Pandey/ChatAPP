const db = require('./config/db')
const UserModel = require('./models/user.model');

const express = require('express');
const {createServer} = require('http')
const {Server} = require('socket.io')

const app = require('./app')
const httpServer = createServer(app)
const io = new Server(httpServer)

app.route('/').get((req,res)=>{
  res.json("hello there")
})

io.on("connection",(socket)=>{
  socket.join("anonymous gp")
  console.log("backend connected")
  socket.on("sendMsg",(msg)=>{
    console.log(msg)
    console.log({...msg,"type":"othermsg"})
    io.to("anonymous gp").emit("sendMsgserver",{...msg,"type":"othermsg"})
  })
})

httpServer.listen(3000)
