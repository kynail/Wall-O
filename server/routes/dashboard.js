const express = require("express");
const router = express.Router();
const writeResponse = require("../utils/writeResponse");
const Dashboard = require("../dashboardSchema");

router.get("/", async (req, res) => {
  const dashboard = await Dashboard.findOne();
  const fishData = [];

  if (dashboard) {
    dashboard.fish.forEach(element => {
      var thumbnail = "";

      if (element.name === "Poisson clown") {
        thumbnail = "http://www.aquariumofpacific.org/images/made/images/uploads/clownfish_1000_750_80auto_s.jpg";
      } else if (element.name === "Idole des maures") {
        thumbnail = "https://i.pinimg.com/originals/50/99/25/509925c6acf535917c808b12ec0d5fae.jpg";
      }

      const data = {
        fishName: element.name,
        total: element.totalImages,
        thumbnail: thumbnail
      }
      fishData.push(data);
      // console.log("DASHBOARD ", element.name);
    })
  }

  // console.log(fishData);

  res.render("dashboard-index", {
    totalPhotos: dashboard.totalPhotos,
    totalFish: dashboard.totalFish,
    fishData: fishData
  });
})


router.get("/fish", async (req, res) => {
  const name = req.query.name;

  const images = [];
  var total;
  var thumbnail = "";
  const dashboard = await Dashboard.findOne();

  dashboard.fish.forEach(element => {

    if (element.name === req.query.name) {
      if (element.name === "Poisson clown") {
        console.log("CLOOWN");
        thumbnail = "http://www.aquariumofpacific.org/images/made/images/uploads/clownfish_1000_750_80auto_s.jpg";
      }
      if (element.name === "Idole des maures") {
        console.log("IDOLE DES MAURES");
        thumbnail = "https://i.pinimg.com/originals/50/99/25/509925c6acf535917c808b12ec0d5fae.jpg";
      }
      total = element.totalImages;
      element.images.forEach(image => {
        images.push(image);
      })
    }
  })

  // group images by date

  const groups = images.reduce((groups, image) => {
    const options = { month: 'long', day: 'numeric', year: "numeric" };
    const date = image.date.toLocaleString("fr-FR", options);
    if (!groups[date]) {
      groups[date] = [];
    }
    groups[date].push(image.data);
    return groups;
  }, {});

  const groupArrays = Object.keys(groups).map((date) => {
    return {
      date,
      images: groups[date]
    };
  });

  // render

  res.render("dashboard-fish", {
    fishName: name,
    total: total,
    imagesGroup: groupArrays,
    thumbnail: thumbnail,
  })
})

router.get("/data", async (req, res) => {
  const dashboard = await Dashboard.find();
  res.status(200).json(writeResponse(true, "Data found", dashboard));
})


router.delete("/fish", async (req, res) => {
  const fishName = req.body.fishName;
  console.log("DELETE ", fishName)
  Dashboard.findOneAndUpdate(
    {},
    { $pull: { fish: { name: fishName } } },
    function (err, doc) {
      if (err) {
        console.log("ERR delete fish", err)
        res.status(500).json(writeResponse(false, "Cannot delete fish", err))
      } else {
        console.log("update Doc ", doc);
        res.status(200).json(writeResponse(true, fishName + ":" + " successfully delete"))
      }
    }
  )
})

router.delete('/:id', async (req, res) => {
  const id = req.params.id;
  Dashboard.deleteOne({ "_id": id }, function (err) {
    if (err)
      res.status(500).json(writeResponse(false, "Cannot delete dashboard", err));
    else {
      res.status(204).json();
    }
  });
})



module.exports = router;