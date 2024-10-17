const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors'); // Corrigido para a importação correta
const { MongoClient } = require('mongodb');

const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(cors()); // Configuração correta do CORS

// Substitua a string de conexão abaixo pela sua própria string de conexão com o banco de dados na nuvem
const uri = 'mongodb+srv://Syncrol:jcDyem3Z4AxqgD3I@cluster0.gxghv.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });

async function connectToMongoDB() {
    try {
        await client.connect();
        console.log("Conectado ao banco de dados MongoDB na nuvem");
    } catch (err) {
        console.error("Erro ao conectar ao banco de dados:", err);
    }
}

connectToMongoDB();

// Rota para inserir dados no MongoDB
app.post('/insert', async (req, res) => {
    const { name, age } = req.body;
    const db = client.db('test'); // Nome do banco de dados
    const collection = db.collection('usuarios'); // Nome da coleção

    try {
        const result = await collection.insertOne({ name, age });
        res.json({ success: true, insertedId: result.insertedId });
    } catch (err) {
        console.error("Erro ao inserir dados:", err);
        res.status(500).json({ success: false, error: err.message });
    }
});

// Rota para buscar todos os usuários
app.get('/users', async (req, res) => {
    try {
        const db = client.db('test'); // Nome do banco de dados
        const usersCollection = db.collection('usuarios'); // Nome da coleção

        // Se houver um parâmetro de nome, filtra os usuários pelo nome
        const name = req.query.name;
        const query = name ? { name: new RegExp(name, 'i') } : {};

        const users = await usersCollection.find(query).toArray();
        res.json(users); // Envia os usuários como JSON
    } catch (err) {
        console.error("Erro ao buscar usuários:", err);
        res.status(500).json({ success: false, error: 'Erro ao buscar usuários' });
    }
});

app.listen(port, () => console.log(`Servidor rodando em http://localhost:${port}`));
