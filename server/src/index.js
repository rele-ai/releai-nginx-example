const handlers = require("./handlers")
const { RBS } = require("@releai/rb-node-sdk")

// initiate the RELE.AI Server
const rbs = new RBS({
    appId: "***REMOVED***",
    appHash: "***REMOVED***"
})

// register all the handlers
rbs.use(handlers)

// start the gRPC server on port 9000
rbs.listen(9000)
