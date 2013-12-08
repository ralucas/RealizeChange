
switch(process.env.NODE_ENV)
	when 'production' 
		config = { 
			google: {
				returnURL: 'http://realizechange.herokuapp.com/auth/google/callback',
				realm: 'http://realizechange.herokuapp.com/'
			},
			twitter: {
	
			},
			mongoUrl: 'mongodb://localhost/realizeChange',
			title: 'RealizeChange.org',
			subtitle: 'Making dreams come true...'
		}
	when 'development'
		config = { 
			google: {
				returnURL: 'http://localhost:1337/auth/google/callback',
				realm: 'http://localhost:1337/'
			},
			twitter: {
	
			},
			mongoUrl: 'mongodb://localhost/realizeChange',
			title: 'RealizeChange.org',
			subtitle: 'Making dreams come true...'
		}
	
module.exports = config



