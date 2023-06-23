const express = require('express');
const {createServer} = require('http')
const {Server} = require('socket.io')

const app = express()
const httpServer = createServer(app)
const io = new Server(httpServer)

app.route('/').get((req,res)=>{
  res.json("hello there")
})

io.on("connection",(socket)=>{
  console.log("backend connected")
})

httpServer.listen(3000)
