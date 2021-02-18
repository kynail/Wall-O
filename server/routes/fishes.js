const express = require("express");
const router = express.Router();
const Fishes = require("../fishesSchema");
const writeResponse = require("../utils/writeResponse");
const fishesData = require("../public/fishesData")

// GET FISH BY ID
router.get("/", async (req, res) => {
    const id = req.body.id;

    Fishes.findOne(
        { _id: id }, function (err, fish) {
            if (err)
                res.status(500).json(writeResponse(false, "Internal server error"));
            else {
                if (fish !== null) {
                    res.status(200).json(writeResponse(true, "Login successfull", fish));
                } else {
                    res.status(404).json(writeResponse(false, "Cannot find this fish"));
                }
            }
        }
    );
})

// GET ALL FISHES
router.get("/all", async (req, res) => {
    const fishes = await Fishes.find();
    res.status(200).json(writeResponse(true, "Fish Data found", fishes));
})

router.post("/update", async (req, res) => {
    Fishes.deleteMany({}, function (err, doc) {
        if (err) {
            res.status(500).json(writeResponse(false, "Cannot clear db"));
        }
    })
    Fishes.create(fishesData, function (err, doc) {
        if (err) {
            res.status(500).json(writeResponse(false, "Cannot update fishes db"));
        } else {
            res.status(200).json(writeResponse(true, "Updated fishes"));
        }
    })
})

module.exports = router;