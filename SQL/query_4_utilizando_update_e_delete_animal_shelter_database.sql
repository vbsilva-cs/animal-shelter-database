-- DEMONSTRANDO ALTERACAO E DELECAO DE DADOS

-- UPDATE: Atualizando Dados

-- 1. UPDATE PARA REVERTER UMA ADOÇÃO CONCLUÍDA
	-- Detalhe: É uma situação excepcional, solicitada pelo adotante
	-- Exemplo: Adotante Elena Star (id = 6) decide reverter a adoção (id = 2) feita de dois pets (ids: 1 e 2)
    
-- Passo 1: Atualização(tabela pet): 'Adotado' para 'Divulgado' para todos os afetados
    UPDATE pet 
		set status_pet = 'Divulgado'
		where id_pet = 1 or id_pet = 2;

-- Passo 2: Atualização(tabela adocao): 'Concluido' -> 'Nao efetivado'
	UPDATE adocao
		set status_adocao = 'Nao efetivado'
        where id_adocao = 6;
        
-- Caso especial, reversao parcial: adocao de dois pets, na qual apenas um pet é retornado
-- Passo 1: Atualização(tabela pet): 'Adotado' para 'Divulgado' apenas para os pets retornados
-- Exemplo: retorno do pet de id = 1
    UPDATE pet 
		set status_pet = 'Divulgado'
		where id_pet = 1;
        
-- Passo 2: Inserção do novo processo de adoção no sistema (reversao parcial da adocao para 'Nao efetuado')
 -- novo registro de processo
INSERT INTO processo
	(data_hora, nome_processo, tipo_processo, id_colaborador)
VALUES 
	('2025-11-05 08:00:00', 'Reversao de adocao', 'Adocao', 2);
 -- novo registro de adocao
INSERT INTO adocao 
	(id_adotante, id_processo, status_adocao)
VALUES
	(2, 21, 'Nao efetuado');
    
--  Passo 3: atualizam-se os dados de 'pet_adocao.id_adocao' para os novos IDs gerados anteriormente
UPDATE pet_adocao
	SET id_adocao = 3
	WHERE id_pet_adocao = 2;


-- UPDATE: Controle de estoque

-- 2. Controle de estoque da área comum (COPA)

-- 2.1 Contextualizando

CREATE	TABLE armazem_cozinha (
	cod_item int auto_increment not null,
    item varchar(150),
    quantidade int,
    data_aquisicao date,
	estado ENUM ('em falta', 'acabando', 'disponivel'),
    primary key (cod_item)
);

-- Inserção de dados
INSERT INTO armazem_cozinha
	(item, quantidade, data_aquisicao, estado)    
VALUES
	('acucar', 5, '2025-10-10', 'disponivel'),
    ('farinha', 1, '2025-10-10', 'acabando'),
    ('leite', 2, '2025-10-10', 'acabando'),
    ('ovos', 0, '2025-10-10', 'em falta');
    
-- 2.2 UPDATE: Alterando quantidades de itens após novas compras
update armazem_cozinha
set
	quantidade = 4 -- sem compras, apenas consumo
where cod_item = 1;

update armazem_cozinha set 
	quantidade = 4,
    data_aquisicao = '2025-11-20',
    estado = 'disponivel'
where cod_item = 2;

update armazem_cozinha set
	quantidade = 12,
    data_aquisicao = '2025-11-20',
    estado = 'disponivel'
where cod_item = 3;

update armazem_cozinha set
	quantidade = 12,
	data_aquisicao = '2025-11-20',
    estado = 'disponivel'
where cod_item = 4;

-- 3 UPDATE COM CONDICONAIS
	-- detalhes: mesmo contexto anterior

-- 3.1 ATUALIZANDO ESTADO PARA QUANTIDADES MINIMAS
update armazem_cozinha, 
	(select armazem_cozinha.cod_item from armazem_cozinha
    where armazem_cozinha.quantidade > 0 and armazem_cozinha.quantidade < 4) 
    as teste
set estado = 'acabando'
where armazem_cozinha.cod_item = teste.cod_item;

-- 3.2 ATUALIZANDO ESTADO PARA QUANTIDADES SUFICIENTES
update armazem_cozinha, 
	(select armazem_cozinha.cod_item from armazem_cozinha
    where armazem_cozinha.quantidade > 3) 
    as teste
set estado = 'disponivel'
where armazem_cozinha.cod_item = teste.cod_item;

-- 3.3 ATUALIZANDO ESTADO PARA FALTA NO ESTOQUE
update armazem_cozinha, 
	(select armazem_cozinha.cod_item from armazem_cozinha
    where armazem_cozinha.quantidade = 0) 
    as teste
set estado = 'em falta'
where armazem_cozinha.cod_item = teste.cod_item;    


-- DELETE: Apagando registros

-- 1.1 Apagando um registro específico: 'item'
-- EXEMPLO: Removendo item de cod_item = 5 na tabela armazen_cozinha
DELETE FROM armazem_cozinha where cod_item = 5;


-- 1.2 Deleção de uma sequencia de QUATRO registros
-- exemplo: Remocao dos quatro ultimos registros da tabela armazen_cozinha
DELETE FROM armazem_cozinha
ORDER BY cod_item desc
LIMIT 5;

-- 1.3 Deleção de registro em multiplas tabelas
-- Exemplo: Adotante (id_pessoa = 5) solicita deleção de seus dados
DELETE FROM pet_adocao where id_adocao = 1;
Delete from adocao where id_adotante = 1;
delete from recibo where id_adotante = 1;
delete from consentimento where id_adotante = 1;
delete from adotante where id_pessoa = 5;
delete from endereco where id_pessoa = 5;
delete from contato where id_pessoa = 5;
delete from pessoa where id_pessoa = 5;


