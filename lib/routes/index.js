// Generated by CoffeeScript 1.6.3
(function() {
  exports.index = function(req, res) {
    return res.render('index', {
      title: app.locals.config.title,
      subtitle: app.locals.config.subtitle
    });
  };

  exports.main = function(req, res) {
    return res.render('index', {
      title: app.locals.config.title,
      subtitle: app.locals.config.subtitle,
      username: req.user.name,
      200: 200
    });
  };

}).call(this);