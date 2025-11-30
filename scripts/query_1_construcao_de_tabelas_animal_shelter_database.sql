	/*
	 * Script de inicialização do banco de dados - Abrigo de Animais
	 * Autor: Vinicius de Brito e Silva
     * Data: 30/11/2025
     * Versão 1.0
     */
    
    -- ============================================
	-- Seção 1: Criação do Schema
	-- ============================================
    
    -- Criar banco de dados da instituição
    CREATE DATABASE animal_shelter_database;
    
    -- Selecionar como banco de dados padrão
    USE animal_shelter_database;
	
	-- ============================================
	-- Seção 2: Criação de tabelas
	-- ============================================     
    
    -- Tabela de pessoas
	CREATE table pessoa (
		id_pessoa INT NOT NULL AUTO_INCREMENT,
		nome VARCHAR(100) NOT NULL,
		sobrenome VARCHAR(100),
		cpf VARCHAR(20) UNIQUE NOT NULL,
		data_nascimento DATE,
        primary key(id_pessoa)
	);
    
	-- Tabela de contato
	CREATE table contato (
		id_contato INT AUTO_INCREMENT,
		id_pessoa INT,
		celular varchar(20),
		telefone varchar(20),
		email varchar(100),
		primary key(id_contato),
		foreign key(id_pessoa) references pessoa(id_pessoa)
	);

	-- Tabela de endereço
	CREATE table endereco (
		id_endereco INT NOT NULL AUTO_INCREMENT,
		id_pessoa INT NOT NULL,
		logradouro varchar(150) NOT NULL,
		numero varchar(20),
		complemento varchar(100),
		bairro varchar(100) NOT NULL,
		cidade varchar(60) NOT NULL,
		uf char(2) NOT NULL,
		cep varchar(10) NOT NULL,
		primary key(id_endereco),
		foreign key(id_pessoa) references pessoa(id_pessoa)
	);

	-- Tabela de colaborador
	CREATE table colaborador (
		id_colaborador INT NOT NULL AUTO_INCREMENT,
		id_pessoa INT NOT NULL,
		cargo varchar(60),
		tipo_contrato varchar(60),
		data_admissao DATE,
		salario decimal (10,2),
		status_funcional varchar(60),
		primary key(id_colaborador),
		foreign key(id_pessoa) references pessoa(id_pessoa)
	);

	-- Tabela de adotante
	CREATE table adotante (
		id_adotante INT NOT NULL AUTO_INCREMENT,
		id_pessoa INT NOT NULL,
		primary key(id_adotante),
		foreign key(id_pessoa) references pessoa(id_pessoa)
	);

	-- Tabela de consentimento
	CREATE table consentimento (
		id_consentimento INT NOT NULL AUTO_INCREMENT,
		id_adotante INT NOT NULL,
		documento varchar(60),
		data_assinatura DATE,
		primary key(id_consentimento),
		foreign key(id_adotante) references adotante(id_adotante)
	);

	-- Tabela de recibo
	CREATE table recibo (
		id_recibo INT NOT NULL AUTO_INCREMENT,    
		id_adotante INT NOT NULL,
		valor decimal (10,2),
		data_recibo DATE,
		primary key(id_recibo),
		foreign key(id_adotante) references adotante(id_adotante)
	);

	-- Tabela de pet
	CREATE table pet (
		id_pet INT NOT NULL AUTO_INCREMENT,
		data_entrada DATE,
		tipo_entrada ENUM('doacao', 'resgate'),
		local_origem varchar(100),
		nome varchar(80),
		especie ENUM('cachorro', 'gato'),
		raca varchar(100),
		idade varchar(20),
		aparencia varchar(255),
		comportamento varchar(255),    
		status_pet ENUM ('Sob Cuidados', 'Divulgado', 'Adotado'),
		primary key(id_pet)
	);

	-- Tabela de processo
	CREATE table processo (
		id_processo INT NOT NULL AUTO_INCREMENT,
		data_hora DATETIME,
		nome_processo varchar(60),
		tipo_processo varchar(60),
		id_colaborador INT NOT NULL,    
		primary key(id_processo),
		foreign key(id_colaborador) references colaborador(id_colaborador)
	);

	-- Tabela de consulta
	CREATE table consulta (
		id_consulta INT NOT NULL AUTO_INCREMENT,
		id_pet INT NOT NULL,
		id_processo INT NOT NULL,
		crmv varchar(30),
		primary key(id_consulta),
		foreign key(id_pet) references pet(id_pet),
		foreign key(id_processo) references processo(id_processo)
	);

	-- Tabela de medicamento
	CREATE table medicamento (
		id_medicamento INT NOT NULL AUTO_INCREMENT,
		nome varchar(60), 
		formula varchar(80),
		primary key(id_medicamento)
	);

	-- Tabela de uso de medicamentos em consultas
	CREATE table consulta_medicamento (
		id_consulta_medicamento INT NOT NULL AUTO_INCREMENT,
        id_consulta INT NOT NULL,
		id_medicamento INT NOT NULL,	
		dosagem varchar(10),
		observacao varchar(100),
		primary key(id_consulta_medicamento),
		foreign key(id_medicamento) references medicamento(id_medicamento),
		foreign key(id_consulta) references consulta(id_consulta)
	);

	-- Tabela de adocao
	CREATE table adocao (
		id_adocao INT NOT NULL AUTO_INCREMENT,
		id_adotante	INT NOT NULL,
		id_processo INT NOT NULL,
		status_adocao varchar(100),
		primary key(id_adocao),
		foreign key(id_adotante) references adotante(id_adotante),
		foreign key(id_processo) references processo(id_processo)
	);

	-- Tabela de pets envolvidos em um processo de adocao
	CREATE table pet_adocao	 (
		id_pet_adocao INT NOT NULL AUTO_INCREMENT,
		id_pet INT NOT NULL,
		id_adocao INT NOT NULL,
		primary key(id_pet_adocao),
		foreign key(id_adocao) references adocao(id_adocao),
		foreign key(id_pet) references pet(id_pet)
	);

	-- Tabela de estoque
	CREATE table estoque (
		id_item INT NOT NULL AUTO_INCREMENT,
		nome varchar(100),
		tipo varchar(60),
		marca varchar(60),
		valor decimal (10,2),
		data_aquisicao DATE,
		quantidade int,
		primary key(id_item)
	);

	-- Tabela de uso de materiais em procedimentos
	CREATE table lista_materiais (
		id_lista_materiais INT NOT NULL AUTO_INCREMENT,
		id_item INT NOT NULL,
		id_processo INT NOT NULL,
		quantidade_utilizada varchar(60),
		primary key(id_lista_materiais),
		foreign key(id_item) references estoque(id_item),
		foreign key(id_processo) references processo(id_processo)
	);
    
    -- ============================================
	-- Seção 3: Preenchimento preliminar dos campos 
	-- ============================================ 
    
    
    INSERT INTO pessoa
		(nome, sobrenome, cpf, data_nascimento)
	VALUES
		('Romulo', 'Jobs', '015.015.015-15', '1988-01-01'),
		('Alfredo', 'Logan', '016.016.016-16', '1970-05-15'),
		('Roberta', 'Lind', '017.017.017-17', '1990-09-23'),
		('Iolanda', 'House', '018.018.018-18', '1972-03-18'),
		('Hugo', 'Powers', '016.017.018-15', '1985-04-02'),
		('Elena', 'Star', '014.107.108-16', '1992-11-21');
    
	INSERT INTO contato
		(id_pessoa, celular, telefone, email)
	VALUES
		(1, '1198998-1112', NULL, 'romJ@animalshelter.com'),
		(2, '117887-2112', NULL, 'alfL@animalshelter.com'),
		(3, '1195445-1234', NULL, 'robL@animalshelter.com'),
		(4, '1191221-3302', NULL, 'iolH@animalshelter.com'),
		(5, '1196556-7894', NULL, NULL),
		(6, '1198558-7485', NULL, NULL);

	INSERT INTO endereco 
		(id_pessoa, logradouro, numero, complemento, bairro, cidade, uf, cep)
	VALUES
		(1, 'Rua alfa', 550, 'bloco A, apto 10', 'Bairro Alfa', 'São Paulo', 'SP', '12345-678'),
		(2, 'Rua Beta', 1005, NULL , 'Jardim Beta', 'São Paulo', 'SP', '11111-222'),
		(3, 'Rua Gamma', 132, NULL, 'da Gamma', 'São Paulo', 'SP', '22222-333'),
		(4, 'Avenida Delta', 200, 'bloco C, apto 43', 'Jardim Delta', 'São Paulo', 'SP', '33333-444'),
		(5, 'Estrada Epsilon', 350, NULL, 'Bairro Epsilon', 'Embu das Artes', 'SP', '55555-333'),
		(6, 'Rua Zeta', 800, NULL, 'Jardim Zeta', 'Cotia', 'SP', '12355-777');

	INSERT INTO colaborador 
		(id_pessoa, cargo, tipo_contrato, data_admissao, salario, status_funcional)
	VALUES
		(1, 'Ajudante Geral', 'CLT', '2024-02-20', 1800.00, 'ativo'),
		(2, 'Administração', 'CLT', '2024-02-20', 1800.00, 'ativo'),
		(3, 'Ajudante Geral', 'Temporario', '2025-10-28', 1800.00, 'ativo'),
		(4, 'Veterinária', 'Temporario', '2025-10-29', 3000.00, 'ativo');

	INSERT INTO adotante
		(id_pessoa)
	VALUES
		(5),
		(6);

	INSERT INTO consentimento
		(id_adotante, documento, data_assinatura)
	VALUES
		(1, 'CA-001', '2025-11-03'),
		(2, 'CA-002', '2025-11-04');
    
	INSERT INTO recibo
		(id_adotante, valor, data_recibo)
	VALUES
		(2, 0.00, '2025-11-04');

	INSERT INTO pet
		(data_entrada, tipo_entrada, local_origem, nome, especie, raca, idade, aparencia, comportamento, status_pet)
	VALUES
		('2025-11-01', 'resgate', 'Abandonado em São Paulo', 'Ursa', 'cachorro', 'labradora', '3 meses', 'pelagem: bege, olhos: castanhos', 'Dócil', 'Adotado'),
		('2025-11-01', 'resgate', 'Abandonado em Sao Paulo', 'Rex', 'cachorro', 'labrador', '3 meses', 'pelagem: marrom, olhos: castanhos', 'Dorminhoco', 'Adotado'),
		('2025-11-03', 'doacao', 'Sao Paulo', 'Jasper', 'gato', 'Siamês', '1 ano', 'pelagem: predominante bege com manchas pretas nas extremidades do corpo e rosto, olhos: azuis, cauda: longa', 'Evita carinhos', 'Divulgado'),
		('2025-11-05', 'doacao', 'Sao Paulo', 'Tom', 'gato', 'SRD', '1 ano', 'pelagem: branca, olhos: castanhos, cauda: longa', 'Dócil e Dorminhoco', 'Sob Cuidados'),
		('2025-11-06', 'resgate', 'N/A', 'Zip', 'cachorro', 'SRD', '2 anos', 'pelagem: preto com manchas brancas no peito e longos, olhos: castanhos, cauda: longa', 'Muito dócil', 'Sob Cuidados');

	INSERT INTO processo
		(data_hora, nome_processo, tipo_processo, id_colaborador)
	VALUES 
		('2025-11-01 10:00:00', 'Primeira Rotina', 'Cuidados', '1'),
		('2025-11-01 10:30:00', 'Limpeza do ambiente','Limpeza', '3'),
		('2025-11-01 14:00:00', 'Segunda Rotina', 'Cuidados', '3'),
		('2025-11-01 15:00:00', 'Acompanhamento especializado', 'Consulta', '4'),
		('2025-11-01 18:00:00', 'Terceira Rotina', 'Cuidados', '2'),
		('2025-11-02 10:00:00', 'Primeira Rotina', 'Cuidados', '1'),
		('2025-11-02 14:00:00', 'Segunda Rotina', 'Cuidados', '3'),
		('2025-11-02 15:00:00', 'Acompanhamento especializado', 'Consulta', '4'),
		('2025-11-02 18:00:00', 'Terceira Rotina', 'Cuidados', '2'),
		('2025-11-03 10:00:00', 'Primeira Rotina', 'Cuidados', '1'),
		('2025-11-03 10:30:00', 'Limpeza do ambiente', 'Limpeza', '3'),
		('2025-11-03 11:30:00', 'Processo de adoção', 'Adocao', '2'),
		('2025-11-03 14:00:00', 'Acompanhamento especializado', 'Cuidados', '3'),
		('2025-11-03 15:00:00', 'Segunda Rotina', 'Consulta', '4'),
		('2025-11-03 18:00:00', 'Terceira Rotina', 'Cuidados', '2'),
		('2025-11-04 10:00:00', 'Primeira Rotina','Cuidados', '1'),
		('2025-11-04 10:30:00', 'Limpeza do ambiente', 'Limpeza', '3'),
		('2025-11-04 14:00:00', 'Segunda Rotina', 'Cuidados', '3'),
		('2025-11-04 15:45:00', 'Processo de adoção', 'Adocao', '2'),
		('2025-11-04 18:00:00', 'Terceira Rotina', 'Cuidados', '2');


	INSERT INTO consulta
		(id_pet, id_processo, crmv)
	VALUES 
		(3, 4, 'SP 12345-VP'),
		(3, 8, 'SP 12345-VP'),
		(3, 14, 'SP 12345-VP');

	INSERT INTO medicamento
		(id_medicamento, nome, formula)
	VALUES
		(1, 'Soro Fisiologico', NULL);
		
	INSERT INTO consulta_medicamento
		(id_consulta, id_medicamento, dosagem, observacao)
	VALUES
		(1, 1, '100 ml', NULL),
		(2, 1, '100 ml', NULL),
		(3, 1, '100 ml', NULL);

	INSERT INTO adocao
		(id_adotante, id_processo, status_adocao)
	VALUES
		(1, 12,'Nao efetivado'),
		(2, 19, 'Concluida');

	INSERT INTO pet_adocao
		(id_pet, id_adocao)
	VALUES 
		(3, 1),
		(1, 2),
		(2, 2);

	INSERT INTO estoque 
		(id_item, nome, tipo, marca, valor, data_aquisicao, quantidade)
	VALUES
		(1, 'Ração Canina', 'Alimento', 'BoaEscolha!', 200.00, '2025-10-26', 5),
		(2, 'Ração Felina', 'Alimento', 'PurrPurr', 40.00, '2025-10-26', 3),
		(3, 'Petisco para Caes', 'Alimento', 'Uau, au!',  3.00, '2025-10-26', 20),	
		(4, 'Petisco para Gatos', 'Alimento', 'Petit chat',  3.00, '2025-10-26', 20),
		(5, 'Sacos para dejetos', 'Higiene e Limpeza', 'PlastiK',  0.15, '2025-10-26', 100),
		(6, 'Desinfetante', 'Higiene e Limpeza', 'Removal',  8.00, '2025-10-26', 8),
		(7, 'Kit acessórios', 'Suporte e Brinquedos', 'Diversos',  200.00, '2025-10-26', 17);
		
	INSERT INTO lista_materiais
		(id_item, id_processo, quantidade_utilizada)
	VALUES
		(1,1, '500g'),
		(2,1, '200g'),
		(1,3, '500g'),
		(2,3, '200g'),
		(1,5, '500g'),
		(2,5, '200g'),
		(1,7, '500g'),
		(2,7, '200g'),
		(1,8, '500g'),
		(2,8, '200g'),
		(1,9, '500g'),
		(2,9, '200g'),
		(1,10, '500g'),
		(2,10, '200g'),
		(1,11, '500g'),
		(2,11, '200g'),
		(1,12, '500g'),
		(2,12, '200g'),
		(1,13, '500g'),
		(2,13, '200g'),
		(1,14, '500g'),
		(2,14, '200g');