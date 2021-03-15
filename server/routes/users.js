const express = require("express");
const router = express.Router();
const User = require("../userSchema");
const writeResponse = require("../utils/writeResponse");
const async = require("async");
const crypto = require("crypto");
const path = require("path");
const transporter = require("../mail/transporter");
const passport = require("passport");
const dotenv = require("dotenv");

router.get("/", async (req, res) => {
  const users = await User.find();
  res.status(200).json(writeResponse(true, "Data found", users));
});

dotenv.config();

/* GET */

router.post("/login", async (req, res) => {
  const mail = req.body.mail;
  const password = req.body.password;

  console.log("MAIL", mail);
  console.log("Password", password);

  User.findOne(
    { "info.mail": mail }, function (err, user) {
      if (err)
        res.status(500).json(writeResponse(false, "Cannot log this user"));
      else {
        console.log(user);
        if (user !== null) {
          if (!user.validPassword(password))
            res.status(400).json(writeResponse(false, "Incorrect password"));
          else {
            res.status(200).json(writeResponse(true, "Login successfull", {
              "id": user._id,
              "firstName": user.info.firstName,
              "lastName": user.info.lastName,
              "age": user.info.age,
              "gender": user.info.gender,
              "mail": user.info.mail,
              "game": user.jeu,
              "avatar": user.info.avatar
            }));
          }
        }
        else {
          res.status(404).json(writeResponse(false, "Cannot find this user"));
        }
      }
    }
  )
})

router.get("/profil", async (req, res) => {
  const id = req.body.id;

  User.findOne({
    _id: id
  }, function (err, data) {
    if (err) {
      res.status(500).json(writeResponse(false, "Echec de récupération du profil"));
    } else {
      res.status(200).json(writeResponse(true, "Profil", data.info))
    }
  })
})

router.get("/success", (req, res) => {
  console.log("Success", req);
  res.status(200).json(writeResponse(true, "Succès"));
})

router.get("/fail", (req, res) => {
  console.log("fail", req);
  res.status(400).json(writeResponse(false, "La connexion à échoué"));
})

/* Facebook Login */

router.get("/auth/facebook", passport.authenticate("facebook"));

router.get("/auth/facebook/callback",
  passport.authenticate("facebook", { failureRedirect: "/users/failure" }),
  (req, res) => {
    console.log(req.user);
    res.status(201).json(writeResponse(true, "Connexion avec Facebook réussi", req.user));
  }
);

/* Google Login */

router.get("/auth/google",
  passport.authenticate("google", {
    scope:
      ['https://www.googleapis.com/auth/plus.login',
        , 'https://www.googleapis.com/auth/plus.profile.emails.read']
  }
  )
);

router.get("/auth/google/callback",
  passport.authenticate('google', { failureRedirect: '/users/failure' }),
  (req, res) => {
    console.log(req.user);
    res.status(201).json(writeResponse(true, "Connexion avec Google réussi", req.user));
  }
);


/* envoi du mail de reinitialisation de mot de passe */

router.get("/auth/forget", async (req, res) => {
  res.sendFile(path.resolve("./mail/forgotPassword.html"))
})

/* POST */

/* ADD NEW USER */

function isUserExist(mail, next) {
  console.log("mail", mail);
  User.findOne(
    {
      "info.mail": mail
    }, function (err, user) {
      if (err) {
        next({ status: 500, message: "Server error", data: err });
      }
      else {
        if (user === null) {
          console.log("Ok");
          next(err, user)
        }
        else {
          console.log("Errr");
          next({ status: 400, message: "Cet utilisateur existe déjà", data: mail });
        }
      }
    });
}

router.post("/register", async (req, res) => {
  console.log("POST New user", req.body);

  const mail = req.body.mail;
  const lastName = req.body.lastName;
  const firstName = req.body.firstName;
  const age = req.body.age;
  const gender = req.body.gender;
  const password = req.body.password;

  const lvl = req.body.lvl;

  async.waterfall([
    async.apply(isUserExist, mail)
  ], function (err, user) {
    if (err) {
      return res.status(err.status).json(writeResponse(false, err.message, err.data));
    }
    if (!mail || !lastName || !firstName || !password)
      res.status(401).json(writeResponse(false, "Il manque des informations"));
    else {
      var new_user = new User({
        info: {
          mail: mail,
          lastName: lastName,
          firstName: firstName,
          age: age,
          gender: gender,
        },
        jeu: {
          userlvl: lvl
        }
      });
      new_user.info.password = new_user.generateHash(password);
      new_user.save(function (err) {
        if (err)
          res.status(500).json(writeResponse(false, "Cannot create user", err))
        else {
          res.status(201).json(writeResponse(true, "New user added successfully", {
            "id": new_user._id,
            "firstName": new_user.info.firstName,
            "lastName": new_user.info.lastName,
            "age": new_user.info.age,
            "gender": new_user.info.gender,
          }));
        }
      })
    }
  })
})

/* Send forget password mail */

function findUser(mail, next) {
  User.findOne(
    {
      "info.mail": mail
    }, function (err, user) {
      if (err) {
        next({ status: 500, message: "Server error", data: err });
      }
      else {
        if (user !== null) {
          next(err, user)
        }
        else
          next({ status: 404, message: "Cannot find this user", data: mail });
      }
    });
}

function createToken(user, next) {
  crypto.randomBytes(20, function (err, buffer) {
    if (err) {
      console.log("create token", err);
      return next({ status: 500, message: "Server error", data: err })
    }
    var token = buffer.toString("hex");
    next(err, user, token);
  })
}

function updateTokenForUser(user, token, next) {
  User.findByIdAndUpdate(
    { _id: user._id },
    {
      resetPasswordToken: token,
      resetPasswordExpires: Date.now() + 86400000
    },
    { upsert: true, new: true },
    function (err, user) {
      if (err) {
        console.log("update token", err);
        return next({ status: 500, message: "Server error", data: err })
      }
      next(err, token, user)
    }
  )
}

router.post("/auth/forget", async (req, res) => {
  const mail = req.body.mail;
  async.waterfall([
    async.apply(findUser, mail),
    createToken,
    updateTokenForUser,
  ], function (err, token, user) {
    if (err) {
      console.log(err)
      res.status(err.status).json(writeResponse(false, err.message, err.data));
    } else {
      console.log("FINAL", token, user);
      var mailData = {
        to: mail,
        from: process.env.WALL_O_MAIL,
        template: "forgotPasswordMail",
        subject: "réinitialisation de votre mot de passe - Wall-O",
        context: {
          url: "http://wall_o.com/forget/" + token,
          name: user.info.firstName
        }
      };
      transporter.sendMail(mailData, function (error, info) {
        if (error) {
          console.log("SEND MAIL", error);
          res.status(500).json(writeResponse(false, "Cannot send mail", error));
        } else {
          res.status(200).json(writeResponse(true, "Mail send successfully"))
          console.log('Message sent: ' + info.response);
        }
      });
      transporter.close();
    }
  })
})

// CONTACT
router.post("/contact", async (req, res) => {
  const obj = req.body.object;
  const message = req.body.message;
  const id = req.body.id;

  User.findOne({
    "_id": id
  }, function (err, user) {
    if (err) {
      res.status(500).json(writeResponse(false, "Impossible d'envoyer l'email", err));
    } else {
      if (user === null) {
        res.status(404).json(writeResponse(false, "Utilisateur introuvable", err));
      } else {
        var mailData = {
          to: process.env.WALL_O_MAIL,
          from: process.env.WALL_O_MAIL,
          template: "contactMail",
          subject: "[Contact Wall-O] " + obj,
          context: {
            mail: user.info.mail,
            id: user._id,
            body: message
          }
        };
        transporter.sendMail(mailData, function (error, info) {
          if (error) {
            console.log("SEND MAIL", error);
            res.status(500).json(writeResponse(false, "Cannot send mail", error));
          } else {
            res.status(200).json(writeResponse(true, "Mail send successfully"))
            console.log('Message sent: ' + info.response);
          }
        });
        transporter.close();
      }
    }
  })
})

/* Password reset */

router.post("/auth/reset", async (req, res) => {
  const token = req.body.token;
  const newPassword = req.body.newPassword;
  const verifyPassword = req.body.verifyPassword;
  console.log(req.body);
  User.findOne(
    {
      resetPasswordToken: token,
      resetPasswordExpires: {
        $gt: Date.now()
      }
    }, function (err, user) {
      if (!err && user) {
        if (newPassword === verifyPassword) {
          user.info.password = user.generateHash(newPassword);
          user.resetPasswordToken = undefined;
          user.resetPasswordExpires = undefined;
          user.save(function (err) {
            if (err) {
              return res.status(500).json(writeResponse(false, "Server error", err));
            }
            else {
              var mailData = {
                to: process.env.WALL_O_MAIL,
                from: user.info.mail,
                template: "resetPasswordMail",
                subject: "Confirmation de votre réinitialisation de mot de passe - Wall-O",
                context: {
                  name: user.info.firstName
                }
              };
              transporter.sendMail(mailData, function (err, info) {
                if (!err) {
                  console.log("message sent:", info.response);
                  return res.status(201).json(writeResponse(true, "Password reset"));
                }
                else {
                  console.log("send mail error resetpassword", err);
                  return res.status(500).json(writeResponse(false, "Cannot send mail", err));
                }
              })
            }
          })
        }
        else {
          console.log("password not match");
          return res.status(422).json(writeResponse(false, "Password did not match"));
        }
      }
      else {
        console.log("invalid token", err);
        return res.status(400).json(writeResponse(false, "Token is invalid or has expired"))
      }
    }
  )
})

/* DELETE */

/* DELETE USER */

/* A FAIRE : MESSAGE D'ERREUR USER NOT FOUND */

router.delete('/:mail', async (req, res) => {
  const mail = req.params.mail;
  User.deleteOne({ "_id": mail }, function (err) {
    if (err)
      res.status(500).json(writeResponse(false, "Cannot delete user", err));
    else {
      res.status(204).json();
    }
  });
})

module.exports = router;