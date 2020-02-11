const sqlite3 = require("sqlite3").verbose()

let db = new sqlite3.Database(":memory:", (err) => {
    if (err) {
        return console.log(err.message)
    }
    console.log("Connected to in-memory sqlite3");
})

module.exports = db
