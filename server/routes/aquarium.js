const express = require("express");
const router = express.Router();
const User = require("../userSchema");
const writeResponse = require("../utils/writeResponse");
const { findById } = require("../userSchema");

router.get("/", async (req, res) => {
    const id = req.body.id;
    User.findOne({
        "_id": id
    }, function (err, data) {
        var aqua = { total: data.totalaquafish, aqua: data.aquarium };
        res.status(200).json(writeResponse(true, "Données de l'aquarium :", aqua));
    }
    )
})

router.post("/add", async (req, res) => {
    console.log("POST New fish", req.body);

    const fishName = req.body.fishName;
    const id = req.body.id;

    User.findOne({
        "_id": id,
        "aquarium.fishName": fishName
    }, function (err, data) {
        console.log(data);
        if (!data) {
            User.findByIdAndUpdate({
                _id: id
            },
                {
                    $push: { aquarium: { fishName: fishName, sameFish: 1 } },
                    $inc: { "totalaquafish": 1 },
                }, function (err, data) {
                    res.status(201).json(writeResponse(true, "Poisson ajouté"))
                })
        }
        else {
            User.updateOne({
                _id: id
            },
                {
                    $inc: {
                        "aquarium.$[fish].sameFish": 1,
                        "totalaquafish": 1
                    },
                },
                {
                    "arrayFilters": [{ "fish.fishName": fishName }]
                }, function (err, data) {
                    console.log(data);
                    res.status(201).json(writeResponse(true, "Poisson LAAAAA"))
                })
        }
    })
})

module.exports = router;