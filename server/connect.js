var net = require('net');

var _socket = null;

function connect(port, addr, io) {
    var client = new net.Socket();
    client.connect(port, addr, function () {
        console.log('Connecté au serveur tcp');
        // client.write('Bonjour serveur, ici API\r\n');
    });

    client.on('close', function () {
        console.log('Connection closed');
    });

    return client;
}

function writeData(socket, data) {
    var success = !socket.write(data);
    if (!success) {
        (function (socket, data) {
            socket.once('drain', function () {
                writeData(socket, data);
            });
        })(socket, data);
    }
}

function setSocket(socket) {
    _socket = socket;
}

function getSocket() {
    return _socket
}

exports.connect = connect;
exports.writeData = writeData;
exports.getSocket = getSocket;
exports.setSocket = setSocket;