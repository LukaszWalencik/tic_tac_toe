const mmongoose = require('mongoose');
const playerShema = require('./player');
const { default: mongoose } = require('mongoose');

const roomSchema = new mmongoose.Schema(
    {// Ocupancy mean how many players can be in game room
        occupancy:{type: Number, default: 2},
        // How long the game will after which we will stop it
        maxRounds:{type: Number, default: 3},
        // Which round we are now in the game
        currentRound:{require: true, type: Number, default: 1,},
        players: [playerShema],
        // If room is joinable or not. When two players in room value will be false
        isJoin: {type: Boolean, default: true,},
        // which player turns is there and it will change every round
        turn: playerShema,
        // whoever creates room, that players index will be 0 or else 1. This will help with tracking rounds
        turnIndex: {type: Number,  default: 0,},
    }
)
const roomModel = mongoose.model('Room', roomSchema);
module.exports = roomModel;