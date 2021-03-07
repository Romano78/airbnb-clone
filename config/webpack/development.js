const path = require("path");
process.env.NODE_ENV = process.env.NODE_ENV || "development";

const environment = require("./environment");

const webpack = require("webpack");
environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    Popper: ["popper.js", "default"],
  })
);

environment.config.devServer.watchContentBase = true;
environment.config.devServer.contentBase = [
  path.join(__dirname, "../../app/views"),
];

module.exports = environment.toWebpackConfig();
