mongoose = require('mongoose');
# config = require('../config');

console.log(config);

userSchema = new mongoose.Schema({
	name: String,
	email: {type: String, lowercase: true }
});

module.exports = mongoose.model('User', userSchema);

# test
