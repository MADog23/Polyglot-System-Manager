console.log("Node API starting...");

const express = require("express");
const app = express();
const port = 3000;
const { logInfo } = require("./logger");

logInfo("Node API starting...");

// TODO: Add routes
// TODO: Add Python and Java clients

app.get("/", (req, res) => {
    res.send("Node API is running");
});

app.listen(port, () => {
    console.log(`Node API listening on port ${port}`);
});
