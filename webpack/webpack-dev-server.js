var Express = require("express");
var webpack = require("webpack");
var logger = require("../src/helpers/Logger");

var config = require("../src/config");
var webpackConfig = require("./dev.config");
var compiler = webpack(webpackConfig);

var host = config.host;
var port = parseInt(config.port) + 1;
var serverOptions = {
  contentBase: "http://" + host + ":" + port,
  quiet: true,
  noInfo: true,
  hot: true,
  inline: true,
  lazy: false,
  publicPath: webpackConfig.output.publicPath,
  headers: { "Access-Control-Allow-Origin": "*" },
  stats: { colors: true }
};

var app = new Express();

app.use(require("webpack-dev-middleware")(compiler, serverOptions));
app.use(require("webpack-hot-middleware")(compiler));

app.listen(port, function onAppListening(err) {
  if (err) {
    logger.error({ err: err }, "Error starting dev server");
  } else {
    logger.info({ port }, "--> dev server listening");
  }
});
