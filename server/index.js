const express = require('express');
const socket = require('socket.io');
const http = require('http');
const mongoose = require('mongoose');
const Room = require('./models/room');
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
            let player = {socketID: socket.id, playername: playername, playerType: 'X',
            };

        // Add properties in room object
        room.players.push(player); // Push since its an array
        room.turn = player;
        // Save room data in mongoDB
        room= await room.save();
        // Save room id (_id) which is retured after saving
        const roomID = room._id.toString();
        // this socket will listen only whoever emnits evebts in this roomID
        socket.join(roomID);
        // Tell client that eroom has been created
        // io send data to everyone in that roomk. Whereas socket sends to youself
        io.to(roomID).emit('createRoomSuccess', room);
        } 
        catch(e){
            console.log(e);
        };});
        
        // console.log(playername);}

        socket.on('joinRoom', async ({playername, roomID})=>{
            try{
        if(!roomID.match(/^[0-9a-fA-f]{24}$/)){
            socket.emit('errorOccured', 'Please enter a valid room ID')
            return;
        }
        let room = await Room.findById(roomID);
        // if(room == null){
        //     socket.emit('errorOccured', 'No game room found with that ID')
        //     return;
        // }
        if(room.isJoin){
            let player = {playername: playername, socketID: socket.id, playerType: 'O'};
            socket.join(roomID);
            room.players.push(player);
        
        room.isJoin = false;
        room= await room.save();
        io.to(roomID).emit('joinRoomSuccess', room);
        io.to(roomID).emit('updatePlayers', room.players);
        io.to(roomID).emit('updateRoom', room);
        } else { socket.emit('errorOccured', 'The game is already in progress. Try another room.')}
        
            } catch(e){console.log(e)}
        });


        socket.on('tap', async ({index, roomID}) => {
            try { 
                let room = await Room.findById(roomID);
            let choice = room.turn.playerType;
        if (room.turnIndex == 0){
            room.turn = room.players[1];
            room.turnIndex =1;
        } else {
        room.turn = room.players[0];
        room.turnIndex =0;
    }
    room = await room.save();
    io.to(roomID).emit('tapped', {index, choice, room});
}catch(e){ console.log(e)
}
    
        
});
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
})