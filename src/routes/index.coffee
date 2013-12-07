exports.index = (req, res) ->
	res.render('index', { title: 'RealizeChange.Org', subtitle: 'Making that Change happen' });


exports.main = (req, res) ->
	res.send("you are logged in. do some damage!", 200);
