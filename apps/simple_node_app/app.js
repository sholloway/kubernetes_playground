const http = require('http')
const os = require('os')

const LISTEN_PORT = 8080

console.log('Starting Node.js App')

let requestHandler = (request, response) => {
    console.log(`Inbound request received from: ${request.connection.remoteAddress}`)
    response.writeHead(200)
    response.end(`You've hit: ${os.hostname()}`)
}

let server = http.createServer(requestHandler)
server.listen(LISTEN_PORT)