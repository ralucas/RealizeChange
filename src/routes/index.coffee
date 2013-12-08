exports.index = (req, res) ->
	res.render('index', { title: app.locals.config.title, subtitle: app.locals.config.subtitle});


exports.main = (req, res) ->
	res.render('index', { title: app.locals.config.title, subtitle: app.locals.config.subtitle, username: req.user.name, 200});
	# res.send({login: "success", username: req.user.name}, 200);
	# res.redirect('/')

exports.partials = (req, res) ->
	# console.log("req params",req.params)
	name = req.params.name;
	# console.log(name)

	renderObj = { title: app.locals.config.title, subtitle: app.locals.config.subtitle, routeName: name, 200}
	res.render("partials/#{name}", renderObj);
