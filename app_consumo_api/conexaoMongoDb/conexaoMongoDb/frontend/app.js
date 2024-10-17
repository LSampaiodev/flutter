document.addEventListener('DOMContentLoaded', () => {
    // Manipulação do formulário de inserção
    document.getElementById('insertForm').addEventListener('submit', async function(event) {
        event.preventDefault();

        const name = document.getElementById('name').value;
        const age = document.getElementById('age').value;
        
        try {
            const response = await fetch('http://localhost:3000/insert', {
                mode: 'cors',
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ name, age })
            });

            const result = await response.json();
            console.log(result); // Log o resultado para depuração

            if (response.ok) {
                alert('Dados inseridos com sucesso!');
                document.getElementById('insertForm').reset(); // Limpa o formulário após o sucesso
            } else {
                alert('Erro ao inserir dados: ' + result.error); // Exibe o erro retornado
            }
        } catch (error) {
            console.error('Erro ao enviar a solicitação:', error); // Log de erros no console
            alert('Erro ao enviar a solicitação!');
        }
    });

    // Manipulação do formulário de busca
    document.getElementById('searchForm').addEventListener('submit', async function(event) {
        event.preventDefault();

        const searchName = document.getElementById('searchName').value;
        
        try {
            const response = await fetch(`http://localhost:3000/users?name=${encodeURIComponent(searchName)}`, {
                mode: 'cors',
                method: 'GET'
            });
            
            if (response.ok) {
                const users = await response.json();
                displayResults(users);
            } else {
                alert('Erro ao buscar dados!');
            }
        } catch (error) {
            console.error('Erro ao enviar a solicitação:', error); // Log de erros no console
            alert('Erro ao enviar a solicitação!');
        }
    });

    function displayResults(users) {
        const resultsDiv = document.getElementById('results');
        resultsDiv.innerHTML = '';

        if (users.length === 0) {
            resultsDiv.innerHTML = '<p>Nenhum usuário encontrado.</p>';
            return;
        }

        const list = document.createElement('ul');
        users.forEach(user => {
            const listItem = document.createElement('li');
            listItem.textContent = `Nome: ${user.name}, Idade: ${user.age}`;
            list.appendChild(listItem);
        });

        resultsDiv.appendChild(list);
    }
});
