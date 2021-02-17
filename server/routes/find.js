const express = require("express");
const router = express.Router();
const Dashboard = require("../dashboardSchema");
const writeResponse = require("../utils/writeResponse");
const async = require("async");

const TCPClient = require("../connect");

router.post("/image", async (req, res) => {
  const imageData = req.body.imageData;
  var socket = TCPClient.getSocket();
  TCPClient.writeData(socket, imageData + "\r\n");
  var fishName;

  var dataArray = "";

  function dataHandler(data) {
    var response = data.toString();
    var splittedResponse = response.split(" ");

    var message = splittedResponse[0];
    fishName = splittedResponse[1];
    var analysedImageData = splittedResponse[2];

    console.log('IN /find ' + response.substring(0, 30));
    if (message === "fish") {
      console.log("FISH RESULT : ", fishName);
      dataArray = dataArray.concat(analysedImageData);
    }
    else if (dataArray != "") {
      console.log("Not total data");
      dataArray = dataArray.concat(response);
    }
    if (response.includes("\r\n") === true) {
      console.log("END of Data");
      sendImage(dataArray);
      dataArray = "";
    }
  }

  // pour recevoir la réponse de l'algo
  socket.on('data', dataHandler);

  function sendImage(imageData) {
    socket.off("data", dataHandler);
    var img = Buffer.from(imageData, 'base64');

    res.writeHead(200, {
      'Content-Type': 'image/png',
      'Content-Length': img.length
    });
    res.end(img)
  }
})

router.post("/", async (req, res) => {
  const imageData = req.body.imageData;
  var socket = TCPClient.getSocket();

  // Envoi l'image a l'algo
  TCPClient.writeData(socket, imageData + "\r\n");
  var dataArray = "";
  var fishNames = "";

  function dataHandler(data) {
    var response = data.toString();
    var splittedResponse = response.split(" ");

    var message = splittedResponse[0];
    var analysedImageData = splittedResponse[2];

    if (message === "fish") {
      fishNames = splittedResponse[1];
      console.log("FISH RESULT : ", fishNames);
      dataArray = dataArray.concat(analysedImageData);
    }
    else if (dataArray != "") {
      console.log("Not total data");
      dataArray = dataArray.concat(response);
    }
    if (response.includes("\r\n") === true) {
      console.log("END of Data");
      sendDetails(fishNames, dataArray);
      //storeImage(fishNames, dataArray);
      dataArray = "";
    }
  }

  // pour recevoir la réponse de l'algo
  socket.on('data', dataHandler);

  function sendDetails(fishNames, analysedImageData) {
    socket.off("data", dataHandler);
    console.log("FISH NAMES", fishNames);
    splittedFish = fishNames.split(",");

    var fishData = {
      detections: [],
      image: analysedImageData
    }

    var onlyNames = [];
    splittedFish.forEach(fish => {
      var fishSplit = fish.split(":");
      fishData.detections.push({
        class: fishSplit[0],
        confidence: fishSplit[1]
      });
      onlyNames.indexOf(fishSplit[0]) === -1 ? onlyNames.push(fishSplit[0]) : ""
    })

    // console.log("Only names ", onlyNames);
    storeImage(onlyNames, imageData, fishData);
  }


  function storeImage(fishNames, imageData, fishData) {
    // supprime le listener apres avoir recu la réponse
    socket.off("data", dataHandler);

    console.log("STORE IMAGE", fishNames);

    // fishNames.forEach(fish => {
    //   async.waterfall([
    //     async.apply(findDocument, fish),
    //     addData
    //   ], function (err, data) {
    //     if (err) {
    //       console.log(err);
    //     }
    //   })
    // })
    res.status(201).json(writeResponse(true, "Poisson(s) trouvé(s)", fishData))

    function findDocument(fishName, next) {
      Dashboard.findOne({}, function (err, data) {
        console.log("FIND STATS", fishName);
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
              next(err, null, fishName)
              // res.status(201).json(writeResponse(true, "Poisson trouvé", fishName));
            }
          })
          return;
        }
        // envoi le seul document existant
        next(null, data, fishName);
      })
    }

    function addData(data, fishName, next) {
      // console.log("IN ADDDATA", data);
      //si le doc est créer pour la premiere fois ne rien faire de plus
      if (data === null) {
        next(null, fishName);
        return;
      }
      Dashboard.findOne({
        "fish.name": fishName
      }, function (err, data) {
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


// stocker l'image pour le dashboard
// function storeImage(fishName, imageData) {
//   // supprime le listener apres avoir recu la réponse
//   socket.off("data", dataHandler);

//   console.log("STORE IMAGE", fishName);
//   async.waterfall([
//     findDocument,
//     addData
//   ], function (err, fishName) {
//     if (err) {
//       console.log(err);
//     }
//     else {
//       console.log("FINAL", fishName);
//       res.status(201).json(writeResponse(true, "Poisson trouvé", {
//         name: fishName,
//         image: imageData
//       }));
//     }
//   })

//   function findDocument(next) {
//     Dashboard.findOne({}, function (err, data) {
//       // console.log("FIND STATS", data);
//       if (data === null) {
//         console.log("First Entry");
//         var firstStats = new Dashboard({
//           totalPhotos: 1,
//           totalFish: 1,
//           fish: [{
//             name: fishName,
//             totalImages: 1,
//             images: [{
//               data: imageData,
//               date: new Date()
//             }]
//           }
//           ]
//         });
//         firstStats.save(function (err) {
//           if (err) {
//             next({ status: 500, message: "Error with storage", data: err });
//             // res.status(500).json(writeResponse(false, "Error with storage", err))
//           }
//           else {
//             // envoi null si le document est créer pour la premiere fois
//             next(err, null)
//             // res.status(201).json(writeResponse(true, "Poisson trouvé", fishName));
//           }
//         })
//         return;
//       }
//       // envoi le seul document existant
//       next(null, data);
//     })
//   }

//   function addData(data, next) {
//     console.log("IN ADDDATA", data);
//     //si le doc est créer pour la premiere fois ne rien faire de plus
//     if (data === null) {
//       next(null, fishName);
//       return;
//     }
//     Dashboard.findOne({
//       "fish.name": fishName
//     }, function (err, data) {
//       console.log("FIND ONE UPDT")
//       if (err) {
//         next({ status: 500, message: "Server error", data: err });
//       } else {

//         // new fish
//         if (data === null) {
//           const newFish = {
//             name: fishName,
//             totalImages: 1,
//             images: [{
//               data: imageData,
//               date: new Date()
//             }]
//           }
//           console.log("new fish");
//           Dashboard.updateOne(
//             {},
//             {
//               $push: { "fish": newFish },
//               $inc: { "totalFish": 1 },
//               $inc: { "totalPhotos": 1 }
//             }, function (err, res) {
//               if (err) {
//                 console.log("UPDATE NEW FISH error", err);
//                 next({ status: 500, message: "Server error", data: err });
//               } else {
//                 console.log("NEW FISH RESULT", res);
//                 next(null, fishName);
//               }
//             })
//         }

//         // not new fish
//         else {
//           // var date = new Date();
//           // date.setDate(date.getDate() + 2);
//           const data = {
//             data: imageData,
//             date: new Date()
//           }
//           console.log("NOT NEW FISH");
//           Dashboard.updateOne(
//             {},
//             {
//               $inc: {
//                 "fish.$[fishName].totalImages": 1,
//                 "totalPhotos": 1
//               },
//               $push: { "fish.$[fishName].images": data },
//             },
//             {
//               "arrayFilters": [{ "fishName.name": fishName }]
//             }, function (err, res) {
//               if (err) {
//                 console.log("UPDATE NOT NEW FISH error", err);
//                 next({ status: 500, message: "Server error", data: err });
//               } else {
//                 console.log("NOT NEW FISH RESULT", res);
//                 next(null, fishName);
//               }
//             });

//           // next(null, "Not new fish");
//         }
//       }
//     })
//   }
// }