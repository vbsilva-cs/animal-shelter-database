## Animal Shelter Database v1.0

### 1. Visão Geral  
Este projeto apresenta a modelagem e implementação de um banco de dados relacional para a ONG fictícia Animal Shelter, dedicada ao acolhimento, cuidados e adoção de animais.

### 2. Objetivo
O objetivo é garantir transparência, rastreabilidade e eficiência nos processos internos, desde o cadastro de pets até a adoção responsável.

### 3. Estrutura do Banco de Dados
Entidades Principais
- Pessoa: dados pessoais, endereço e contato de qualquer indivíduo cadastrado;
- Colaborador: pessoa vinculada à instituição, com dados funcionais e trabalhistas;
- Adotante: pessoa interessada em adoção, com consentimento e recibos;
- Pet: animal sob tutela da instituição, com cadastro e prontuário;
- Processo: conjunto de atividades realizadas (consultas, adoções, rotinas gerais);
- Consulta: processo veterinário envolvendo pet e colaborador veterinário;
- Adoção: processo de transferência de custódia de um pet para um adotante;
- Estoque: inventário de insumos e materiais.
- Medicamento: inventário de insumos e medicamentos utilizados em consultas.
- Relacionamentos auxiliares: pet_adocao, lista_materiais, consulta_medicamento

### 6. Diagrama Entidade-Relacionamento - DER
<img width="1133" height="1319" alt="DER completo workbench" src="https://github.com/user-attachments/assets/62d9df2a-7b29-4776-850d-9c19df46fded" />

### 7. Tecnologias:
  - MySQL Workbench 8.0 CE
    - Informações em: [http://dev.mysql.com/doc/workbench/en]
    - Download em: [http://dev.mysql.com/downloads]
  - Git/GitHub (versionamento e hospedagem)
     
### 8. Instalação e execução
  1. Download e instalação do SGBD (exemplo de SGBD: MySQL community server);
  2. Clone o repositório:
	 Bash
		git clone https://github.com/vbsilva-cs/animal-shelter-database.git
  	ou
     Baixe o repositório em formato .zip pelo link [https://github.com/vbsilva-cs/animal-shelter-database/archive/refs/heads/main.zip]
  3. Exportar scripts para o SGBD instalado.

### 9. Exemplos de Consultas
	-- Listar todos os pets cadastrados exibindo os mais recentes primeiro.
		
			SELECT id_pet as num_cadastro, nome, especie, raca, idade, data_entrada
			FROM Pet
			ORDER BY data_entrada DESC;
	
	-- Exibir o total de Pets cadastrados no último mês
	
			SELECT COUNT(id_pet) AS total_cadastrados
			FROM Pet
			WHERE data_entrada >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);
   
### 1o. Licença: Creative Commons Zero v1.0 Universal




