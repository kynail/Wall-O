const express = require("express");
const router = express.Router();
const User = require("../userSchema");
const writeResponse = require("../utils/writeResponse");

router.get("/level", async (req, res) => {
    const id = req.body.id;
    User.findOne({
        "_id": id
    }, function (err, data) {
        var level = data?.jeu;
        res.status(200).json(writeResponse(true, "infos level", level));
    }
    )
})

router.put("/level", async (req, res) => {
    const id = req.body.id;
    const exp = req.body.exp;
    const reset = req.body.reset;
    var lvl;
    var needxp;

    User.findOne({
        "_id": id
    },
        function (err, success) {
            if (err)
                res.status(500).json(writeResponse(false, "Utilisateur introuvable", err))
            else {
                if (success && success.length == 0) {
                    res.status(400).json(writeResponse(false, "Erreur sur l'ajout d'xps", id));
                }
                else if (success) {
                    if (reset) {
                        User.updateOne(
                            { _id: id },
                            {
                                $set: {
                                    "jeu": {
                                        xpscore: 0,
                                        nxtlvl: 50,
                                        userlvl: 1
                                    }
                                }
                            },
                            function (error, model) {
                                if (error) {
                                    res.status(500).json(writeResponse(false, "Impossible d'ajouter des points d'xps", error))
                                }
                                else {
                                    //console.log(model);
                                    if (model.n == 0)
                                        res.status(404).json(writeResponse(false, "Utilisateur introuvable", "userid"))
                                    else
                                        res.status(201).json(writeResponse(true, "Expérience réinitialisé"));
                                }
                            }
                        );
                    } else {
                        var level = success.jeu.userlvl;
                        var xptotal = +success.jeu.xpscore + +exp;
                        console.log("XP TOTAL " + xptotal)
                        console.log("NEXT LVL " + success.jeu.nxtlvl)
                        console.log("XPSCORE " + success.jeu.xpscore)
                        console.log("XP " + xptotal)

                        if (success.jeu.nxtlvl > xptotal) {
                            User.updateOne(
                                { _id: id },
                                {
                                    $set: {
                                        "jeu": {
                                            xpscore: xptotal,
                                            nxtlvl: success.jeu.nxtlvl,
                                            userlvl: level
                                        }
                                    }
                                },
                                function (error, model) {
                                    if (error) {
                                        res.status(500).json(writeResponse(false, "Impossible d'ajouter des points d'xps", error))
                                    }
                                    else {
                                        //console.log(model);
                                        if (model.n == 0)
                                            res.status(404).json(writeResponse(false, "Utilisateur introuvable", "userid"))
                                        else
                                            res.status(201).json(writeResponse(true, "Vous avez gagné " + exp + " points d'expériences !", {
                                                xpscore: xptotal,
                                                nxtlvl: success.jeu.nxtlvl,
                                                userlvl: level
                                            }));
                                    }
                                }
                            );
                        }
                        else {
                            var newxp = success.jeu.nxtlvl + 10;
                            level = level + 1
                            User.updateOne(
                                { _id: id },
                                {
                                    $set: {
                                        "jeu": {
                                            xpscore: 0,
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
                                            res.status(201).json(writeResponse(true, "Félicitations, vous êtes passé niveau " + level + " !", {
                                                xpscore: 0,
                                                nxtlvl: newxp,
                                                userlvl: level
                                            }));
                                    }
                                }
                            );
                        }
                    }
                } else {
                    res.status(404).json(writeResponse(false, "Cannot find this user"));
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