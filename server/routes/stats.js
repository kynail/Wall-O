// const express = require("express");
// const router = express.Router();
// const Dashboard = require("../dashboardSchema");
// const writeResponse = require("../utils/writeResponse");

// router.get("/", async (req, res) => {
//     const dashboard = await Dashboard.find();
//     res.status(200).json(writeResponse(true, "Data found", dashboard));
// })

// router.delete('/:id', async (req, res) => {
//     const id = req.params.id;
//     Dashboard.deleteOne({ "_id": id }, function (err) {
//       if (err)
//         res.status(500).json(writeResponse(false, "Cannot delete dashboard", err));
//       else {
//         res.status(204).json();
//       }
//     });
//   })

// module.exports = router;