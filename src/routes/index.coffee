# renderObj = { title: app.locals.config.title, subtitle: app.locals.config.subtitle, 200}

exports.index = (req, res) ->
	res.render('index', { title: app.locals.config.title, subtitle: app.locals.config.subtitle});


exports.main = (req, res) ->
	# renderObj.username = req.user.name
	res.render('index', { title: app.locals.config.title, subtitle: app.locals.config.subtitle, username: req.user.name, 200});
	# res.send({login: "success", username: req.user.name}, 200);
	# res.redirect('/')

exports.partials = (req, res) ->
	# console.log("req params",req.params)
	renderObj = {}
	renderObj.title = app.locals.config.title
	renderObj.subtitle =  app.locals.config.subtitle
	renderObj.username = req.user.name
	renderObj.routeName = req.params.name;

	# console.log(name)
	res.render("partials/#{req.params.name}", renderObj);