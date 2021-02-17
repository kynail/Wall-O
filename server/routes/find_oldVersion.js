const express = require("express");
const router = express.Router();
const Dashboard = require("../dashboardSchema");
const writeResponse = require("../utils/writeResponse");
const async = require("async");

const TCPClient = require("../connect");

router.post("/", async (req, res) => {
  const imageData = req.body.imageData;
  var socket = TCPClient.getSocket();

  // Envoi l'image a l'algo
  TCPClient.writeData(socket, imageData + "\r\n");
  var fishName;

  function dataHandler(data) {
    var response = data.toString();
    var message = response.substr(0, response.indexOf(' '));
    fishName = response.substr(response.indexOf(' ') + 1);
    console.log('IN /find ' + response);
    if (message === "fish") {
      console.log("FISH RESULT : ", fishName);
      storeImage(fishName, imageData);
    }
  }

  // pour recevoir la réponse de l'algo
  socket.on('data', dataHandler);

  // stocker l'image pour le dashboard
  function storeImage(fishName, imageData) {
    // supprime le listener apres avoir recu la réponse
    socket.off("data", dataHandler);
  
    console.log("STORE IMAGE", fishName);
    async.waterfall([
      findDocument,
      addData
    ], function (err, fishName) {
      if (err) {
        console.log(err);
      }
      else {
        console.log("FINAL", fishName);
        res.status(201).json(writeResponse(true, "Poisson trouvé", fishName));
      }
    })

    function findDocument(next) {
      Dashboard.findOne({}, function (err, data) {
        // console.log("FIND STATS", data);
        if (data === null) {
          console.log("First Entry");
          var firstStats = new Dashboard({
            totalPhotos: 1,
            totalFish: 1,
            fish: [{
              name: fishName,
              totalImages: 1,
              images: [{
                data: imageData,
                date: new Date()
              }]
            }
            ]
          });
          firstStats.save(function (err) {
            if (err) {
              next({ status: 500, message: "Error with storage", data: err });
              // res.status(500).json(writeResponse(false, "Error with storage", err))
            }
            else {
              // envoi null si le document est créer pour la premiere fois
              next(err, null)
              // res.status(201).json(writeResponse(true, "Poisson trouvé", fishName));
            }
          })
          return;
        }
        // envoi le seul document existant
        next(null, data);
      })
    }

    function addData(data, next) {
      console.log("IN ADDDATA", data);
      //si le doc est créer pour la premiere fois ne rien faire de plus
      if (data === null) {
        next(null, fishName);
        return;
      }
      Dashboard.findOne({
        "fish.name": fishName
      }, function (err, data) {
        console.log("FIND ONE UPDT")
        if (err) {
          next({ status: 500, message: "Server error", data: err });
        } else {

          // new fish
          if (data === null) {
            const newFish = {
              name: fishName,
              totalImages: 1,
              images: [{
                data: imageData,
                date: new Date()
              }]
            }
            console.log("new fish");
            Dashboard.updateOne(
              {},
              {
                $push: { "fish": newFish },
                $inc: { "totalFish": 1 },
                $inc: { "totalPhotos": 1 }
              }, function (err, res) {
                if (err) {
                  console.log("UPDATE NEW FISH error", err);
                  next({ status: 500, message: "Server error", data: err });
                } else {
                  console.log("NEW FISH RESULT", res);
                  next(null, fishName);
                }
              })
          }

          // not new fish
          else {
            // var date = new Date();
            // date.setDate(date.getDate() + 2);
            const data = {
              data: imageData,
              date: new Date()
            }
            console.log("NOT NEW FISH");
            Dashboard.updateOne(
              {},
              {
                $inc: {
                  "fish.$[fishName].totalImages": 1,
                  "totalPhotos": 1
                },
                $push: { "fish.$[fishName].images": data },
              },
              {
                "arrayFilters": [{ "fishName.name": fishName }]
              }, function (err, res) {
                if (err) {
                  console.log("UPDATE NOT NEW FISH error", err);
                  next({ status: 500, message: "Server error", data: err });
                } else {
                  console.log("NOT NEW FISH RESULT", res);
                  next(null, fishName);
                }
              });

            // next(null, "Not new fish");
          }
        }
      })
    }

  }
})

module.exports = router;