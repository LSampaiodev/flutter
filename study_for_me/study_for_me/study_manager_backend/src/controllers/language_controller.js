const Language = require('../models/language_model');

exports.createLanguage = async (req, res) => {
  const { name, description } = req.body;
  const newLanguage = new Language({ name, description });
  await newLanguage.save();
  res.status(201).json(newLanguage);
};

exports.getLanguages = async (req, res) => {
  const languages = await Language.find();
  res.json(languages);
};

exports.updateLanguage = async (req, res) => {
  const { id } = req.params;
  const { name, description, progress } = req.body;
  const language = await Language.findByIdAndUpdate(id, { name, description, progress }, { new: true });
  if (language) {
    res.json(language);
  } else {
    res.status(404).json({ message: 'Linguagem não encontrada' });
  }
};

exports.deleteLanguage = async (req, res) => {
  const { id } = req.params;
  await Language.findByIdAndDelete(id);
  res.status(204).send();
};