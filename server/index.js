const express = require('express');
const socket = require('socket.io');
const http = require('http');
const mongoose = require('mongoose');
//Initialize express
const app = express();

//Create server and socket io
var server = http.createServer(app);
var io = socket(server);

io.on('connection', (socket)=> {
    console.log("Socket Connected");
    socket.on('createRoom', async ({playername})=>{
        try{
            // Create a Room object
            let room= new Room();
            let player = {socketID: socket.socketID, playername: playername, playerType: 'X',
            };

        // Add properties in room object
        room.players.push(player); // Push since its an array
        room.turn = player;
        // Save room data in mongoDB
        room= await room.save();
        // Save room id (_id) which is retured after saving
        const roomID = room._id.toString;
        // this socket will listen only whoever emnits evebts in this roomID
        socket.join(roomID);
        // Tell client that eroom has been created
        // io send data to everyone in that roomk. Whereas socket sends to youself
        io.to(roomID).emit('createRoomSuccess', room);
        } 
        catch(e){
            console.log(e);
        };
        
        console.log(playername);});
});
// Middle wear : manipulate data coming from client to server
app.use(express.json()); //It will convert all incoming data to json format

const DB = "mongodb+srv://lukasz:Falubaz21@cluster0.uqw5lmr.mongodb.net/tictactoe"

mongoose.connect(DB).then(()=> {
    console.log("MongoDB connection successfull");
}).catch((e)=>{
    console.log(e);
});

const PORT = process.env.PORT || 3000;

server.listen(PORT, '0.0.0.0', ()=> {
    console.log('Server running on port ${PORT}');
});