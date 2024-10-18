const mongoose = require('mongoose');

const LanguageSchema = new mongoose.Schema({
  name: { type: String, required: true },
  description: { type: String, required: true },
  progress: { type: Number, default: 0 }, // Progresso de 0 a 100%
});

module.exports = mongoose.model('Language', LanguageSchema);