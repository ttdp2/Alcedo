const express = require("express")
const app = express()

let db = require("./database.js")

app.get("/", (req, res) => {
    res.send("Welcome to Alcedo!")
})

app.listen("8000", () => {
    console.log("Express listening on port 8000...")
})
