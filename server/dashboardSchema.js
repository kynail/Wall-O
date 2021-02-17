const mongoose = require("mongoose");
var Schema = mongoose.Schema;

const dashboardSchema = new Schema({
    totalPhotos: Number,
    totalFish: Number,
    fish: Array
})

module.exports = mongoose.model('dashboard', dashboardSchema);