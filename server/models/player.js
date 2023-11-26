const mongoose = require('mongoose');
const playerSchema = new mongoose.Schema({
    playername: {type: String, trim: true},
    socketID: {type: String},
    points: {type: Number, default: 0,},
    // X or O
    playerType: {require: true, type: String},
})
module.exports = playerSchema;