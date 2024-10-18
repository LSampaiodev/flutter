const express = require('express');
const router = express.Router();
const languageController = require('../controllers/language_controller');

router.post('/languages', languageController.createLanguage);
router.get('/languages', languageController.getLanguages);
router.put('/languages/:id', languageController.updateLanguage);
router.delete('/languages/:id', languageController.deleteLanguage);

module.exports = router;