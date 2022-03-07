const https = require('https');
const fs = require('fs');
const path = require('path');
const Corrosion = require('corrosion');

process.env.http_proxy = 'http://transmission:5181';

const ssl = {
  key: fs.readFileSync(path.join(__dirname, '../ssl/ssl.key')),
  cert: fs.readFileSync(path.join(__dirname, '../ssl/ssl.cert')),
};

const server = https.createServer(ssl);
const proxy = new Corrosion({
    codec: 'xor',
    prefix: '/sw/'
});

proxy.bundleScripts();

server.on('request', (request, response) => {
    if (request.url.startsWith(proxy.prefix)) return proxy.request(request, response);
    response.end(fs.readFileSync(__dirname + '/proxy.html', 'utf-8'));
}).on('upgrade', (clientRequest, clientSocket, clientHead) => proxy.upgrade(clientRequest, clientSocket, clientHead)).listen(8844);
