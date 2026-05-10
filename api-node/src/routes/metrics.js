const express = require("express");
const router = express.Router();

router.get("/latest", async (req, res) => {
    res.json({ message: "placeholder" });
});

router.get("/history", async (req, res) => {
    res.json({ message: "placeholder" });
});

module.exports = router;
