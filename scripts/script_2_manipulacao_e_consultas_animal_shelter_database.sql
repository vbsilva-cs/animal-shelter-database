	/*
	 * Script de manipulação de dados e consultas - Abrigo de Animais
	 * Autor: Vinicius de Brito e Silva
     * Data: 30/11/2025
     * Versão 1.0
     */
    
    -- ============================================
	-- Seção 1: Funcionamento
	-- ============================================
    
	/* Instruções
     * Posicionar o cursor apos o caractere ';' ao final de um bloco; ou
     * Selecionar o bloco desejado.
     * Executar cada query individualmente
     * A saida resultante em cada uma é descrita em seu respectivo título.
     */
     
     
	-- ============================================
	-- Seção 2: Seleção de Banco de dados
	-- ============================================ 
    
     -- Selecionar animal_shelter_database como padrão
		USE animal_shelter_database;
        
        
	-- ============================================
	-- Seção 3: Consultas no sistema
	-- ============================================
    
    -- 2.1. - Listar todos os pets cadastrados exibindo os mais recentes primeiro.
	SELECT id_pet as num_cadastro, nome, especie, raca, idade, data_entrada
	FROM Pet
	ORDER BY data_entrada DESC;

	-- 2.2. - Exibir o total de Pets cadastrados no último mês
	SELECT COUNT(id_pet) AS total_cadastrados
	FROM Pet
	WHERE data_entrada >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

	-- 2.3. Lista o número processos realizados por cada colaborador
	SELECT pes.nome, pes.sobrenome, COUNT(pro.id_processo) AS total_processos
	FROM colaborador pesC
	INNER JOIN 
		processo pro ON pro.id_colaborador = pesC.id_colaborador
	INNER JOIN
		pessoa pes on  pes.id_pessoa = pesC.id_pessoa
	GROUP BY pesC.id_colaborador;

	-- 2.4. Histórico de adoções 
	SELECT 
		proA.id_adocao as num_adocao,
		p.nome as nome_pet,
		p.especie,
		p.raca,
		concat(pes.nome, ' ', pes.sobrenome) AS nome_adotante,
		concat(responsavel.nome, ' ', responsavel.sobrenome) as colaborador_responsavel,
		proA.status_adocao,
		pro.data_hora
	FROM pet_adocao pa  
	INNER JOIN
		pet p on p.id_pet = pa.id_pet
	INNER JOIN
		adocao proA on proA.id_adocao = pa.id_adocao
	INNER JOIN
		processo pro on pro.id_processo = proA.id_processo
	INNER JOIN
		colaborador pesC on pesC.id_colaborador = pro.id_colaborador
	INNER JOIN
		adotante pesA on pesA.id_adotante = proA.id_adotante
	INNER JOIN 
		pessoa pes on pes.id_pessoa = pesA.id_pessoa    
	INNER JOIN
		pessoa responsavel on responsavel.id_pessoa = pesC.id_pessoa;

	-- 2.5. - Histórico de prescrições feitas em consultas com um pet específico (exemplo: id_pet = 3)
	SELECT  proC.id_consulta as consulta, id_consulta_medicamento as codigo_prescrição, p.nome, p.raca, pro.data_hora, med.nome, dosagem, observacao, concat(pes.nome, ' ', pes.sobrenome) as veterinarioresponsavel
	FROM consulta_medicamento c_m
	INNER JOIN 
		consulta proC on proC.id_consulta = c_m.id_consulta
	INNER JOIN
		pet p on p.id_pet = proC.id_pet
	INNER JOIN
		processo pro on pro.id_processo = proC.id_processo
	INNER JOIN
		colaborador pesC on pesC.id_colaborador = pro.id_colaborador
	INNER JOIN
		pessoa pes on pes.id_pessoa = pesC.id_pessoa
	INNER JOIN
		medicamento med on med.id_medicamento = c_m.id_medicamento
	WHERE p.id_pet = 3; -- substitua pelo ID desejado;

	-- 2.6. - Número de adoções por espécie
	SELECT p.especie, COUNT(p.status_pet) AS total_adocoes
	FROM pet p
	where status_pet = 'Adotado'
	GROUP BY p.especie;

	-- 2.7. - Evolução mensal de adoções
	SELECT MONTH(pro.data_hora) AS mes, COUNT(proA.status_adocao) AS total_adocoes
	FROM Adocao proA
	JOIN processo pro ON pro.id_processo = proA.id_processo
	GROUP BY MONTH(pro.data_hora)
	ORDER BY mes;

	-- 2.8. - Itens com estoque abaixo de 5 unidades
	SELECT nome as item, tipo as tipo_uso, quantidade
	FROM Estoque
	WHERE quantidade < 5;

	-- 2.9. - Adotantes com mais de uma adoção
	SELECT proA.id_adotante as cadastro_adotante, pes.nome, pes.sobrenome, COUNT(proA.status_adocao) AS total_adocoes 
	FROM adocao proA
	INNER JOIN 
		adotante pesA ON pesA.id_adotante = proA.id_adotante
	INNER JOIN
		pessoa pes ON pes.id_pessoa = pesA.id_pessoa
	WHERE status_adocao = 'Concluida'
	GROUP BY proA.id_adotante
	HAVING COUNT(proA.status_adocao) > 1;

	-- 2.10. - Pets disponíveis para adoção
	SELECT id_pet as matricula, nome, especie, raca, idade, status_pet as situacao
	FROM pet
	WHERE status_pet = 'Divulgado';
