mongoose = require('mongoose');
config = require('../config');

console.log(config);

userSchema = new mongoose.Schema({
	name: String,
	email: {type: String, lowercase: true }
	answers: {type: [String] }
	questions: [String]

});

exports.user = mongoose.model('User', userSchema);

globalAnswerSchema = new mongoose.Schema({
	answers: {type: [String], user: String}
});

exports.globalAnswerSchema = mongoose.model('GlobalAnswer', globalAnswerSchema)

globalQuestionSchema = new mongoose.Schema({
	questions: [String]

});

exports.globalQuestionSchema = mongoose.model('GlobalQuestion', globalQuestionSchema)