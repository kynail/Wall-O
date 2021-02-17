const path = require("path");
const dotenv = require("dotenv");
var hbs = require("nodemailer-express-handlebars");
var nodemailer = require("nodemailer");

dotenv.config();
var transporter = nodemailer.createTransport({
  service: 'gmail',
    auth: {
      user: process.env.WALL_O_MAIL,
      pass: process.env.WALL_O_MAIL_PASSWORD
    }
  });
  var handleBarsOptions = {
    viewEngine: {
      extName: ".handlebars",
      layoutsDir: path.resolve("./mail"),
      defaultLayout: "template",
      partialsDir: path.resolve(__dirname, "./mail/partials/")
    },
    viewPath: path.resolve("./mail/"),
  };
  transporter.use("compile", hbs(handleBarsOptions));

module.exports = transporter;