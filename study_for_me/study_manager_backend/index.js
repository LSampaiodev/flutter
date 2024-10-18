const express = require('express');
const dotenv = require('dotenv');
const connectDB = require('./src/config/database');
const languageRoutes = require('./src/routes/language_routes');

dotenv.config();
connectDB();

const app = express();
app.use(express.json());

app.use('/api', languageRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
