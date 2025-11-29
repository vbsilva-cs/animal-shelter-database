	-- CRIAR BANCO DE DADOS
    CREATE DATABASE animal_shelter_database;
    
    -- SELECIONAR BANCO DE DADOS PADRÃO
    USE animal_shelter_database;
	
    -- CONSTRUIR TABELAS
	CREATE table pessoa (
		id_pessoa INT NOT NULL AUTO_INCREMENT,
		nome VARCHAR(100) NOT NULL,
		sobrenome VARCHAR(100),
		cpf VARCHAR(20) UNIQUE NOT NULL,
		data_nascimento DATE,
        primary key(id_pessoa)
	);

	CREATE table contato (
		id_contato INT AUTO_INCREMENT,
		id_pessoa INT,
		celular varchar(20),
		telefone varchar(20),
		email varchar(100),
		primary key(id_contato),
		foreign key(id_pessoa) references pessoa(id_pessoa)
	);

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

	CREATE table adotante (
		id_adotante INT NOT NULL AUTO_INCREMENT,
		id_pessoa INT NOT NULL,
		primary key(id_adotante),
		foreign key(id_pessoa) references pessoa(id_pessoa)
	);

	CREATE table consentimento (
		id_consentimento INT NOT NULL AUTO_INCREMENT,
		id_adotante INT NOT NULL,
		documento varchar(60),
		data_assinatura DATE,
		primary key(id_consentimento),
		foreign key(id_adotante) references adotante(id_adotante)
	);

	CREATE table recibo (
		id_recibo INT NOT NULL AUTO_INCREMENT,    
		id_adotante INT NOT NULL,
		valor decimal (10,2),
		data_recibo DATE,
		primary key(id_recibo),
		foreign key(id_adotante) references adotante(id_adotante)
	);

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

	CREATE table processo (
		id_processo INT NOT NULL AUTO_INCREMENT,
		data_hora DATETIME,
		nome_processo varchar(60),
		tipo_processo varchar(60),
		id_colaborador INT NOT NULL,    
		primary key(id_processo),
		foreign key(id_colaborador) references colaborador(id_colaborador)
	);

	CREATE table consulta (
		id_consulta INT NOT NULL AUTO_INCREMENT,
		id_pet INT NOT NULL,
		id_processo INT NOT NULL,
		crmv varchar(30),
		primary key(id_consulta),
		foreign key(id_pet) references pet(id_pet),
		foreign key(id_processo) references processo(id_processo)
	);

	CREATE table medicamento (
		id_medicamento INT NOT NULL AUTO_INCREMENT,
		nome varchar(60), 
		formula varchar(80),
		primary key(id_medicamento)
	);

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

	CREATE table adocao (
		id_adocao INT NOT NULL AUTO_INCREMENT,
		id_adotante	INT NOT NULL,
		id_processo INT NOT NULL,
		status_adocao varchar(100),
		primary key(id_adocao),
		foreign key(id_adotante) references adotante(id_adotante),
		foreign key(id_processo) references processo(id_processo)
	);

	CREATE table pet_adocao	 (
		id_pet_adocao INT NOT NULL AUTO_INCREMENT,
		id_pet INT NOT NULL,
		id_adocao INT NOT NULL,
		primary key(id_pet_adocao),
		foreign key(id_adocao) references adocao(id_adocao),
		foreign key(id_pet) references pet(id_pet)
	);

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

	CREATE table lista_materiais (
		id_lista_materiais INT NOT NULL AUTO_INCREMENT,
		id_item INT NOT NULL,
		id_processo INT NOT NULL,
		quantidade_utilizada varchar(60),
		primary key(id_lista_materiais),
		foreign key(id_item) references estoque(id_item),
		foreign key(id_processo) references processo(id_processo)
	);