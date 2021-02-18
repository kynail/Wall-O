const mongoose = require("mongoose");
var Schema = mongoose.Schema;

const fishesSchema = new Schema({
    name:String,
    scientificName: String,
    image: String,
    desc: String,
})

module.exports = mongoose.model('wallo_fishes', fishesSchema);