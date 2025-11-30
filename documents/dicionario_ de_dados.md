. Detalhamento dos Elementos

Entidade 1:  Pessoa 
•	Descrição: Representa qualquer indivíduo cadastrado
•	Atributos:
o	Dados pessoais; 
o	Dados de endereço; 
o	Dados de contato;
o	id_pessoa (atributo-chave).

Entidade 2: Colaborador
•	Descrição: Contratado ou voluntariado que trabalha na instituição
•	Atributos:		
o	Dados de pessoa;
o	Dados funcionais e trabalhistas;
o	Id_colaborador (atributo-chave).

Entidade 3: Veterinário (removido)
•	Descrição: Contratado ou voluntariado que trabalha na instituição e possui qualificação profissional específica.
•	Atributos:
o	Dados de colaborador;
o	CRMV.

Entidade 4: Adotante 
•	Descrição: Pessoa interessada em interessada em realizar uma adoção
•	Atributos:
o	Dados de pessoa;
o	Consentimento;
o	Recibo; 
o	Id_adotante (atributo-chave).


Entidade 5: Pet
•	Descrição: Representa o animal doméstico que está ou esteve sob a tutela da instituição.
•	Atributos:
o	Dados descritivos;
o	Dados de matrícula.  
o	Id_pet (atributo-chave).

Entidade 6: Processo
•	Descrição: Representa o conjunto de atividades realizadas na instituição pelos colaboradores.
•	Atributos:
o	Tempo;
o	Nome ou descrição;
o	Tipo;
o	Dados do Colaborador responsável.  
o	Id_processo (atributo-chave).

Entidade 7: Adoção
•	Descrição: Processo de transferência de tutela do(s) pet(s) sob cuidados da instituição para o adotante.
•	Atributos:
o	Dados de processo;
o	Dados do Pet;
o	Dados do Adotante;
o	Status;
o	Id_adoção (atributo-chave).

Entidade 8: Consulta
•	Descrição: Processo de cuidados especializados, no qual há participação de um pet e de um colaborador especializado (veterinário).
•	Atributos:
o	Id_consulta (atributo-chave).
o	Dados de Pet;
o	Dados de Processo;
o	CRMV;
o	Medicamentos;
o	Dosagem.  

Entidade 9: Estoque
•	Descrição: Representa o conjunto de consumíveis ou bens de média duração utilizado nos processos gerais
•	Atributos:
o	Dados do Item;
o	Dados de Compras;
o	Tempo;
o	Id_estoque (atributo-chave).

3.3. Relacionamentos e Cardinalidades

3.3.1. Especialização: Pessoa em Colaborador e Adotante
•	Pessoa é a entidade base para os sub elementos Colaborador e Adotante. 
•	Cardinalidade é um para muitos (1:N) para ambos.

3.3.2. Relacionamento Adotante e Adoção
•	Um adotante pode participar de muitas adoções e cada adoção apresenta um adotante.
•	Cardinalidade é de um para muitos (1:N).

3.3.3. Relacionamento: Colaborador e Processo
•	Um colaborador pode realizar muitos processos e um processo é realizado por um colaborador responsável. 
•	Cardinalidade é um para muitos (1:N).

3.3.4. Especialização: Processo em Adoção e Consultas
•	Processo representa conjuntos de diversas atividades dentro da instituição. Essa entidade é base das entidades Adoção e Consulta. 
•	Cardinalidade é um para muitos (1:N) para ambos.

3.3.5. Relacionamento: Processo e Estoque
•	Processos podem utilizar muitos tipos de itens de Estoque e cada tipo de item de estoque pode estar associado a muitos processos. 
•	Cardinalidade é de muitos para muitos (N:M).

3.3.6. Relacionamento: Pet e Adoções
•	Um pet pode participar de muitas adoções (status: não completadas). E uma única adoção pode envolver muitos pets ao mesmo tempo. 
•	Cardinalidade é de muitos para muitos (N:M).

3.3.7. Relacionamento: Pet e Consultas
•	Pets podem ser atendidos em muitas consultas e em cada consulta atende-se um pet. 
•	Cardinalidade é de um para muitos (1:N).

4. Considerações
4.1. Regras de Negócio
•	As entidades Pessoa e Processo são bases para entidades especializadas: co-laborador e adotante para a primeira e adoção e consulta para a segunda;
•	A entidade processo, consulta e adoção estão sempre vinculadas a um colabo-rador. 
•	Adoção é um tipo de processo com vínculo a um adotante e um único ou múlti-plos pets;
•	Colaboradores vinculados a consultas são veterinários;
•	Consulta é um processo com vínculo a um pet e a um veterinário;
•	Um adotante pode realizar muitas adoções; 
•	Uma única adoção pode envolver muitos pets;
•	Estoque é vinculado a processos, os quais consomem recursos do estoque.

Dicionário de dados
Descrição: apresentação das tabelas de entidades com atributos, tipos de dados para cada campo, identificando chaves principais e chaves estrangeiras.

Tabela: Pessoa
id_pessoa INT NOT NULL AUTO_INCREMENT	 	 	 
nome VARCHAR(100) NOT NULL	 	 	 	 
sobrenome VARCHAR(100)	 	 	 	 	 
cpf VARCHAR(20) UNIQUE NOT NULL	 	 	 
data_nascimento DATE	 	 	 	 	 
chave-primária: id_pessoa	 	 	 	 	 
							
Tabela: Contato
id_contato INT AUTO_INCREMENT	 	 	 	 
id_pessoa INT	 	 	 	 	 	 
celular varchar(20)	 	 	 	 	 	 
telefone varchar(20)	 	 	 	 	 
email varchar(20)	 	 	 	 	 	 
chave-primária: id_contato	 	 	 	 	 
chave estrangeira: id_pessoa references pessoa(id_pessoa)	 
							
							
Tabela: Endereco
id_endereco INT NOT NULL AUTO_INCREMENT	 	 
id_pessoa INT NOT NULL	 	 	 	 	 
logradouro varchar(150) NOT NULL	 	 	 	 
numero varchar(20)	 	 	 	 	 
complemento varchar(100)	 	 	 	 	 
bairro varchar(100) NOT NULL	 	 	 	 
cidade varchar(60) NOT NULL	 	 	 	 
uf char(2) NOT NULL	 	 	 	 	 
cep int NOT NULL	 	 	 	 	 	 
chave-primária: id_endereco	 	 	 	 	 
chave estrangeira: id_pessoa references pessoa(id_pessoa)	 
							
Tabela: Colaborador
id_colaborador INT NOT NULL AUTO_INCREMENT	 	 
id_pessoa INT NOT NULL	 	 	 	 	 
cargo varchar(60)	 	 	 	 	 	 
tipo_contrato ENUM('temporario' 'efetivo')	 	 	 
data_admissao DATE	 	 	 	 	 
salario decimal (10,2)	 	 	 	 	 
status_funcional varchar(60)	 	 	 	 	 
chave-primária: id_colaborador	 	 	 	 
chave estrangeira: id_pessoa refere-se a pessoa(id_pessoa)	 
							
							
Tabela: Adotante
id_adotante INT NOT NULL AUTO_INCREMENT	 	 
id_pessoa INT NOT NULL	 	 	 	 	 
chave-primária: id_adotante	 	 	 	 	 
chave estrangeira: id_pessoa refere-se a pessoa(id_pessoa)	 
							
							
Tabela: Consentimento	 	 	 	 	 
id_consentimento INT NOT NULL AUTO_INCREMENT	 	 
id_adotante INT NOT NULL	 	 	 	 	 
documento varchar(60)	 	 	 	 	 
data_assinatura DATE	 	 	 	 	 
chave-primária: id_consentimento	 	 	 	 
chave estrangeira: id_adotante refere-se a adotante(id_adotante)	 
							
							
Tabela: Recibo
id_recibo INT NOT NULL AUTO_INCREMENT	 	 	 
id_adotante INT NOT NULL	 	 	 	 	 
valor decimal (10,2)	 	 	 	 	 
data_recibo DATE	 	 	 	 	 	 
chave-primária: id_recibo	 	 	 	 	 
chave estrangeira: id_adotante refere-se a adotante(id_adotante)	 
							
							
Tabela: Pet	 	 	 	 	 	 
id_pet INT NOT NULL AUTO_INCREMENT	 	 	 
data_entrada DATE	 	 	 	 	 
tipo_entrada ENUM('doacao' 'resgate')	 	 	 	 
local_origem varchar(100)	 	 	 	 	 
nome varchar(80)	 	 	 	 	 	 
especie ENUM('cachorro', 'gato')	 	 	 	 
raca varchar(100)	 	 	 	 	 	 
idade int	 	 	 	 	 	 	 
aparencia varchar(255)	 	 	 	 	 
comportamento varchar(255)	 	 	 	 	 
status_pet ENUM ('Sob Cuidados', 'Divulgado', 'Adotado')	 	 
chave-primária: id_pet	 	 	 	 	 
							
							
Tabela: Processo	 	 	 	 	 	 
id_processo INT NOT NULL AUTO_INCREMENT	 	 
data_hora DATETIME	 	 	 	 	 
nome_processo varchar(60)	 	 	 	 	 
tipo_processo varchar(60)	 	 	 	 	 
id_colaborador INT NOT NULL	 	 	 	 
chave-primária: id_processo	 	 	 	 	 
chave estrangeira: id_colaborador refere-se a colaborador(id_colaborador)
							
							
Tabela: Consulta	 	 	 	 	 	 
id_consulta INT NOT NULL AUTO_INCREMENT	 	 	 
id_pet INT NOT NULL	 	 	 	 	 
id_processo INT NOT NULL	 	 	 	 	 
crmv varchar(30)	 	 	 	 	 	 
chave-primária: id_consulta	 	 	 	 	 
chave estrangeira: id_pet refere-se a pet(id_pet)	 	 	 
chave estrangeira: id_processo refere-se a processo(id_processo)	 
							
							
Tabela: Medicamento	 	 	 	 	 
id_medicamento INT NOT NULL AUTO_INCREMENT	 	 
nome varchar(60) 	 	 	 	 	 	 
formula varchar(80)	 	 	 	 	 
chave-primária: id_medicamento	 	 	 	 
							
							
Tabela: Consulta_Medicamento	 	 	 	 
id_consulta_medicamento INT NOT NULL AUTO_INCREMENT	 
id_consulta INT NOT NULL	 	 	 	 	 
id_medicamento INT NOT NULL	 	 	 	 
dosagem decimal (102)	 	 	 	 	 
observacao varchar(100)	 	 	 	 	 
chave-primária: id_consulta_medicamento	 	 	 
chave estrangeira: id_consulta refere-se a consulta(id_consulta)	 
chave estrangeira: id_medicamento refere-se a medicamento(id_medicamento)
							
 
							
Tabela: Adocao	 	 	 	 	 	 
id_adocao INT NOT NULL AUTO_INCREMENT	 	 	 
id_adotante INT NOT NULL		 	 	 	 	 
id_processo INT NOT NULL	 	 	 	 	 
status_adocao varchar(100)	 	 	 	 	 
chave-primária: id_adocao	 	 	 	 	 
chave estrangeira: id_adotante refere-se a adotante(id_adotante)	 
chave estrangeira: id_processo refere-se a processo(id_processo)	 
							
							
Tabela: Pet_Adocao	 	 	 	 	 
id_pet_adocao INT NOT NULL AUTO_INCREMENT	 	 
id_pet INT NOT NULL	 	 	 	 	 
id_adocao INT NOT NULL	 	 	 	 	 
chave-primária: id_pet_adocao	 	 	 	 
chave estrangeira: id_pet refere-se a pet(id_pet)	 	 	 
chave estrangeira: id_processo refere-se a processo(id_processo)	 
							
							
Tabela: Estoque	 	 	 	 	 	 
id_item INT NOT NULL AUTO_INCREMENT	 	 	 
nome varchar(100)	 	 	 	 	 	 
tipo varchar(60)	 	 	 	 	 	 
marca varchar(60)	 	 	 	 	 	 
valor decimal (102)	 	 	 	 	 	 
data_aquisicao DATE	 	 	 	 	 
quantidade int	 	 	 	 	 	 
chave-primária: id_item	 	 	 	 	 
							
							
Tabela:  Lista_Materiais	 	 	 	 	 
id_lista_materiais INT NOT NULL AUTO_INCREMENT	 	 
id_item INT NOT NULL	 	 	 	 	 
id_processo INT NOT NULL	 	 	 	 	 
quantidade_utilizada varchar(60)	 	 	 	 
chave-primária: id_lista_materiais	 	 	 	 
chave estrangeira: id_item refere-se a estoque(id_item)	 	 
chave estrangeira: id_processo refere-se a processo(id_processo)	 

