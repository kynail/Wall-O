const passport = require("passport");
const dotenv = require("dotenv");
const FacebookStrategy = require("passport-facebook").Strategy;
const GoogleStrategy = require('passport-google-oauth2').Strategy;

const User = require("../userSchema");

dotenv.config();
passport.serializeUser(function (user, done) {
  done(null, user);
});

passport.deserializeUser(function (obj, done) {
  done(null, obj);
});

module.exports = function () {

  /* GOOGLE */

  passport.use(new GoogleStrategy({
    clientID: process.env.GOOGLE_CLIENT_ID,
    clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    callbackURL: process.env.SERVER_ADDRESS + process.env.GOOGLE_CALLBACK_URL,
    passReqToCallback: true
  },
    function (request, accessToken, refreshToken, profile, done) {
      console.log("GOOGLE", profile);
      const { given_name, family_name } = profile._json;

      User.findOne(
        {
          "google": true,
          "info.lastName": family_name,
          "info.firstName": given_name
        }, function (err, user) {
          if (err) {
            console.log("Erreur Google");
            done({ status: 500, message: "Server error", data: err });
          }
          else {
            if (user === null) {
              console.log("Nouvel utilisateur Google");
              const userData = {
                info: {
                  lastName: family_name,
                  firstName: given_name,
                },
                google: true
              };
              var new_user = new User(userData);
              new_user.save(function (err) {
                if (err)
                  done({ status: 500, message: "Server error", data: err })
                else {
                  done(null, {
                    "id": new_user._id,
                    "firstName": new_user.info.firstName,
                    "lastName": new_user.info.lastName
                  })
                }
              });
            }
            else {
              console.log("Utilisateur Google existant");
              done(null, {
                "id": user._id,
                "firstName": user.info.firstName,
                "lastName": user.info.lastName,
                "age": user.info.age,
                "gender": user.info.gender,
              });
            }
          }
        });
    }
  ));

  /* FACEBOOK */


  passport.use(
    new FacebookStrategy(
      {
        clientID: process.env.FACEBOOK_CLIENT_ID,
        clientSecret: process.env.FACEBOOK_CLIENT_SECRET,
        callbackURL:  process.env.SERVER_ADDRESS + process.env.FACEBOOK_CALLBACK_URL,
        profileFields: ["name"]
      },
      function (accessToken, refreshToken, profile, done) {
        const { first_name, last_name } = profile._json;
        User.findOne(
          {
            "facebook": true,
            "info.lastName": last_name,
            "info.firstName": first_name
          }, function (err, user) {
            if (err) {
              console.log("Erreur Facebook");
              done({ status: 500, message: "Server error", data: err });
            }
            else {
              if (user === null) {
                console.log("Nouvel utilisateur Facebook");
                const userData = {
                  info: {
                    lastName: last_name,
                    firstName: first_name,
                  },
                  facebook: true
                };
                var new_user = new User(userData);
                new_user.save(function (err) {
                  if (err)
                    done({ status: 500, message: "Server error", data: err })
                  else {
                    done(null, {
                      "id": new_user._id,
                      "firstName": new_user.info.firstName,
                      "lastName": new_user.info.lastName
                    })
                  }
                });
              }
              else {
                console.log("Utilisateur Facebook existant");
                done(null, {
                  "id": user._id,
                  "firstName": user.info.firstName,
                  "lastName": user.info.lastName,
                  "age": user.info.age,
                  "gender": user.info.gender,
                });
              }
            }
          });
      }
    )
  );
}