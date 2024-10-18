const Language = require('../models/language_model');

// Criar uma nova linguagem
exports.createLanguage = async (req, res) => {
  const { name } = req.body;
  const newLanguage = new Language({ name });
  await newLanguage.save();
  res.status(201).json(newLanguage);
};

// Listar todas as linguagens
exports.getLanguages = async (req, res) => {
  const languages = await Language.find();
  res.json(languages);
};

// Atualizar progresso
exports.updateProgress = async (req, res) => {
  const { id } = req.params;
  const { progress } = req.body;
  const language = await Language.findById(id);
  if (language) {
    language.progress = progress;
    await language.save();
    res.json(language);
  } else {
    res.status(404).json({ message: 'Linguagem não encontrada' });
  }
};

// Deletar uma linguagem
exports.deleteLanguage = async (req, res) => {
  const { id } = req.params;
  await Language.findByIdAndDelete(id);
  res.status(204).json({ message: 'Linguagem deletada' });
};
