// dependencies
var express = require('express');
var routes = require('./routes');
var api = require('./routes/api');
var http = require('http');
var path = require('path');
var app = express();
var mongoose = require('mongoose');
var config = require('./config');
var user = require('./models/user');
var passport = require('passport');
var GoogleStrategy = require('passport-google').Strategy;

// connect to mongo
mongoose.connect(config.mongoUrl);

// passport settings
passport.serializeUser(function(user,done)
{
	done(null, user.id);
});

passport.deserializeUser(function(id, done){
	user.findOne({_id : id}, function(err, user){
		done(err,user);
	});
});

passport.use(new GoogleStrategy({
  returnURL: config.google.returnURL,
  realm: config.google.realm
},
  function(identifier, profile, done) {
    console.log(profile.emails[0].value)
		process.nextTick(function() {
			var query = user.findOne({'email': profile.emails[0].value});
			query.exec(function(err, oldUser){
				
				if(oldUser)
				{
					console.log("Found registered user: " + oldUser.name + " is logged in!");
					done(null, oldUser);
				} else {
					var newUser = new user();
					newUser.name = profile.displayName;
					newUser.email = profile.emails[0].value;
					console.log(newUser);
					newUser.save(function(err){
						if(err){
							throw err;
						}
						console.log("New user, " + newUser.name + ", was created");
						done(null, newUser);
					});
				}
			});
		});
	}
));

// config - all environments
app.set('port', process.env.PORT || 1337);
app.set('views', __dirname + '/views');
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
app.use(express.static(__dirname + '/public'));

// config - development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

// auth routes
app.get('/auth/google', 
  passport.authenticate('google', {scope:'email'}),
  function(req, res){
});
app.get('/auth/google/callback',
  passport.authenticate('google', { failureRedirect: '/' }),
  function(req, res) {
    res.redirect('/main');
});

// user routes
app.get('/', routes.index);
app.get('/main', routes.main);
app.get('/logout', function(req, res){
	req.logOut();
	res.redirect('/');
});
app.get('/error', function(req,res){
	res.send(401,'{err: you got an error. bud.}');
});

// authentication helper
function ensureAuthenticated(req, res, next) {
  if (req.isAuthenticated()) { return next(); }
  res.redirect('/error');
}

// run server
http.createServer(app).listen(app.get('port'), function(){
  console.log('\nRealize Change is up and listening on port ' + app.get('port'));
});

