# dependencies
express = require('express');
routes = require('./routes');
api = require('./routes/api');
http = require('http');
path = require('path');
app = express();
mongoose = require('mongoose');
config = require('./config');
user = require('./models/user');
passport = require('passport');
GoogleStrategy = require('passport-google').Strategy;

# connect to mongo
mongoose.connect(config.mongoUrl);

# passport settings
passport.serializeUser (user,done) ->
	done(null, user.id);


passport.deserializeUser (id, done) ->
	user.findOne {_id : id}, (err, user) ->
		done(err,user);

passport.use(new GoogleStrategy({returnURL: config.google.returnURL, realm: config.google.realm}, (identifier, profile, done) ->
	console.log(profile.emails[0].value)
	process.nextTick () ->
		query = user.findOne({'email': profile.emails[0].value});
		query.exec (err, oldUser) ->
			
			if (oldUser)
				console.log("Found registered user: " + oldUser.name + " is logged in!");
				done(null, oldUser);
			else
				newUser = new user();
				newUser.name = profile.displayName;
				newUser.email = profile.emails[0].value;
				console.log(newUser);
				newUser.save (err) ->
					if(err) 
						throw err;
					
					console.log("New user, " + newUser.name + ", was created");
					done(null, newUser);
				
			
		

));

# config - all environments
app.set('port', process.env.PORT || 1337);
app.set('views', __dirname + './../views');
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.cookieParser());
app.use(express.bodyParser());
app.use(express.session({secret:'c00kies-@nd-cr3@M'}));
app.use(passport.initialize());
app.use(passport.session());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(__dirname + './../public'));

# config - development only
if ('development' == app.get('env'))
	app.use(express.errorHandler());


# auth routes
app.get '/auth/google', 
	passport.authenticate('google', {scope:'email'}),
	(req, res) ->

app.get '/auth/google/callback', passport.authenticate('google', { failureRedirect: '/' }), (req, res) ->
	res.redirect('/main');


# user routes
app.get('/', routes.index);
app.get('/main', routes.main);
app.get '/logout', (req, res) ->
	req.logOut();
	res.redirect('/');

app.get '/error', (req,res) ->
	res.send(401,'{err: you got an error. bud.}');


# authentication helper
ensureAuthenticated = (req, res, next) ->
	if (req.isAuthenticated())
		return next()
	res.redirect('/error');


# run server
http.createServer(app).listen app.get('port'), () ->
	console.log('\nRealize Change is up and listening on port ' + app.get('port'));


