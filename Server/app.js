const express = require("express")
const app = express()

app.get("/", function(req, res) {
    res.send("Welcome to Alcedo!")
})

app.listen("7000", function() {
    console.log("Alcedo listening on port 7000...")
})
