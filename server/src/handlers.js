/**
 * Returns hello world message.
 *
 * @param {*} req
 * @param {*} res
 */
module.exports.hello_world = (req, res) => {
    console.log({
        "message": "incoming request",
        "requestPayload": req.payload,
        "operationKey": req.operationKey
    })

    res.send(200, {
        message: "Hello World!"
    })
}
