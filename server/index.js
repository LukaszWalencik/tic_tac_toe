const express = require('express');
const socket = require('socket.io');
const http = require('http');

//Initialize express
const app = express();

//Create server and socket io
var server = http.createServer(app);
var io = socket(server);

// Middle wear : manipulate data coming from client to server
app.use(express.json()); //It will convert all incoming data to json format

const PORT = process.env.PORT || 3000;

server.listen(PORT, '0.0.0.0', ()=> {console.log('Server running on port ${PORT}');})