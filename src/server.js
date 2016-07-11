var express = require('express');
var http = require('http');
var https = require('https');
var app = express();
var credentials = {key: process.env.FRONTEND_KEY, cert: process.env.FRONTEND_CERT};
var httpServer = http.createServer(app);
var httpsServer = https.createServer(credentials, app);

app.get('/', function (req, res) {
    res.send('Hello World.. !');
});

httpServer.listen(3000, function () {
    console.log('HTTP: Example app listening on port 3000!');
});

httpsServer.listen(3443, function () {
    console.log('HTTPS: Example app listening on port 3443!');
});