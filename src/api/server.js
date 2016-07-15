var env = process.env.ENVIRONMENT,
    express = require('express'),
    http = require('http'),
    https = require('https'),
    app = express(),
    credentials = {key: process.env.FRONTEND_KEY, cert: process.env.FRONTEND_CERT},
    httpServer = http.createServer(app),
    httpsServer = https.createServer(credentials, app);

app.get('/', function (req, res) {
    res.send('Hello World - FROM: ' + env);
});

httpServer.listen(3000, function () {
    console.log('HTTP: Example app listening on port 3000!!!!');
});

httpsServer.listen(3443, function () {
    console.log('HTTPS: Example app listening on port 3443!');
});