const mongoose = require('mongoose');
const playerShema = new mongoose.Schema({
    playerName: {type: String, trim: true},
    socketID: {type: String},
    points: {type: Number, default: 0,},
    // X or O
    playerType: {require: true, type: String},
})
module.exports = playerShema;