const express = require('express');
var mongoose = require('mongoose');
const bodyParser = require('body-parser');
var cors = require('cors');
const passport = require("passport");
var exphbs  = require('express-handlebars');
const usersRouter = require("./routes/users");
const findRouter = require("./routes/find");
const dashboardRouter = require("./routes/dashboard");
const TCPClient = require("./connect");
const aquaRouter = require("./routes/aquarium");
const gameRouter = require("./routes/game");
const fishesRouter = require("./routes/fishes");

let app = express();
const APIport = 8080;

const serverAddr = "127.0.0.1";
const serverPort = 8083;

console.log("SERVER", process.env.SERVER_ADDRESS)
console.log("GOOGLE", process.env.GOOGLE_CALLBACK_URL)

require('./routes/usersController')(passport);
app.use(passport.initialize());
app.use(bodyParser.json({limit: '50mb'}));
app.use(bodyParser.urlencoded({limit: '50mb', extended: true}));

mongoose.connect('mongodb://localhost:27017/wall-o', { useNewUrlParser: true, useUnifiedTopology: true, useFindAndModify: false });
app.use(cors())
app.use(
    bodyParser.urlencoded({
        extended: true
    })
);
app.use(bodyParser.json());
app.use(express.static(__dirname + '/public'));

app.engine('handlebars', exphbs());
app.set('view engine', 'handlebars');

app.use("/users", usersRouter);
app.use("/users/aqua", aquaRouter);
app.use("/game", gameRouter);
app.use("/find", findRouter);
app.use("/dashboard", dashboardRouter);
app.use("/fishes", fishesRouter);

const server = app.listen(APIport, function () {
    console.log('Wall-O API listening on port 8080!');
    // var client = TCPClient.connect(serverPort, serverAddr);
    // if (client) {
    //     TCPClient.setSocket(client);
    // }
});

module.exports = server;