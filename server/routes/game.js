const express = require("express");
const router = express.Router();
const User = require("../userSchema");
const writeResponse = require("../utils/writeResponse");

router.get("/level", async (req, res) => {
    const id = req.body.id;
    User.findOne({
        "_id": id
    }, function (err, data) {
        var level = data.jeu;
        res.status(200).json(writeResponse(true, "infos level", level));
    }
    )
})

router.put("/level", async (req, res) => {
    const id = req.body.id;
    const exp = req.body.exp;
    var lvl;
    var needxp;

    User.findOne({
        "_id": id
    },
        function (err, success) {
            if (err)
                res.status(500).json(writeResponse(false, "Cannot find this user", err))
            else {
                console.log(success.jeu)
                if (success && success.length == 0) {
                    res.status(400).json(writeResponse(false, "exp error", id));
                }
                else {
                    //console.log("LEVEL FUCK11: " + level)
                    var newxp = success.jeu.nxtlvl - exp
                    var level = success.jeu.userlvl;
                    var xptotal = Number(success.jeu.xpscore) - (-exp);
                    console.log(success.jeu.xptotal)
                    console.log("XP TOTAL " + xptotal)
                    //console.log("LEVEL FUCK22: " + level)
                    if (newxp > 0) {
                        User.updateOne(
                            { _id: id },
                            {
                                $set: {
                                    "jeu": {
                                        xpscore: xptotal,
                                        nxtlvl: newxp,
                                        userlvl: level
                                    }
                                }
                            },
                            function (error, model) {
                                if (error) {
                                    res.status(500).json(writeResponse(false, "Cannot change exp", error))
                                }
                                else {
                                    //console.log(model);
                                    if (model.n == 0)
                                        res.status(404).json(writeResponse(false, "Cannot find this user", "userid"))
                                    else
                                        res.status(201).json(writeResponse(true, "exp changed successfully", exp));
                                }
                            }
                        );
                    }
                    else if (newxp < 0) {
                        newxp = newxp + 100;
                        level = level + 1
                        //console.log("LEVEL FUCK33: " + level)
                        User.updateOne(
                            { _id: id },
                            {
                                $set: {
                                    "jeu": {
                                        xpscore: xptotal,
                                        nxtlvl: newxp,
                                        userlvl: level
                                    }
                                }
                            },
                            function (error, model) {
                                if (error) {
                                    res.status(500).json(writeResponse(false, "Cannot change exp", error))
                                }
                                else {
                                    //console.log(model);
                                    if (model.n == 0)
                                        res.status(404).json(writeResponse(false, "Cannot find this user", "userid"))
                                    else
                                        res.status(201).json(writeResponse(true, "level up successful", exp));
                                }
                            }
                        );
                    }
                }
            }
        })
})

//AVATAR

router.put("/avatar", async (req, res) => {
    const id = req.body.id;
    const type = req.body.type;
    const seed = req.body.seed;
    const remove = req.body.remove;

    User.findOne({
        "_id": id
    },
        function (err, success) {
            if (err)
                res.status(500).json(writeResponse(false, "Cannot find this user", err))
            else {
                if (success && success.length == 0) {
                    res.status(400).json(writeResponse(false, "avatar error", id));
                }
                else {
                    User.updateOne(
                        { _id: id },
                        {
                            $set: {
                                "info.avatar": {
                                    type: remove ? null : type,
                                    seed: remove ? null : seed
                                }
                            }

                        },
                        function (error, model) {
                            if (error) {
                                res.status(500).json(writeResponse(false, "Impossible de changer l'avatar", error))
                            }
                            else {
                                if (model.n == 0)
                                    res.status(404).json(writeResponse(false, "Utilisateur introuvable"))
                                else
                                    res.status(201).json(writeResponse(true, "Avatar modifié"));
                            }
                        }
                    );
                }
            }
        })
});

//Classement trié par rapport au niveau des joueurs
router.get("/rank", async (req, res) => {
    const users = await User.find();
    var levels = [];

    users.forEach(user => {
        if (user.jeu.userlvl) {
            levels.push({
                user: user.info.firstName + " " + user.info.lastName,
                lvl: user.jeu.userlvl
            });
        }
    })

    function compare(a, b) {
        if (a.lvl > b.lvl) {
            return -1;
        }
        if (a.lvl < b.lvl) {
            return 1;
        }
        return 0;
    }
    levels.sort(compare);

    res.status(200).json(writeResponse(true, "Classements", levels));
})

module.exports = router;