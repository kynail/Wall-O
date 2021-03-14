const mongoose = require("mongoose");
var Schema = mongoose.Schema;
var bcrypt = require("bcrypt");

const userSchema = new Schema({
    info: {
        mail: String,
        lastName: String,
        firstName: String,
        age: Number,
        gender: String,
        password: String,
        avatar: {
            seed: { type: String, default: null },
            type: { type: String, default: null },
        }
    },
    facebook: { type: Boolean, default: false },
    google: { type: Boolean, default: false },
    resetPasswordToken: String,
    resetPasswordExpires: Date,
    aquarium: Array,
    totalaquafish: Number,
    jeu: {
        xpscore:
            { type: Number, default: 0 },
        nxtlvl:
            { type: Number, default: 100 },
        userlvl:
            { type: Number, default: 1 }
    }
})

userSchema.methods.generateHash = function (password) {
    return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
}

userSchema.methods.validPassword = function (password) {
    return bcrypt.compareSync(password, this.info.password);
}

module.exports = mongoose.model('user', userSchema);