	/*
	 * Título: Data Manipulation Language, DML, para atualização e deleção de dados
	 * Autor: Vinicius de Brito e Silva
     * Data: 30/11/2025
     * Versão 1.0
     */
    
    -- ========================================
	-- Exemplos de uso de 'UPDATE' E 'DELETE' 
	-- ========================================

	-- 1. Revertendo uma adoção já finalizada (status = "Concluido")
		-- descrição: É uma situação excepcional, solicitada por um adotante.
		-- Exemplo: Adotante Elena Star (id = 6) decide reverter a adoção (id = 2) feita de dois pets (ids: 1 e 2)
		-- Etapas: 	
			-- Atualização(tabela pet): 'Adotado' para 'Divulgado' para todos os pets afetados
			UPDATE pet 
				set status_pet = 'Divulgado'
				where id_pet = 1 or id_pet = 2;

			-- Atualização(tabela adocao): de 'Concluido' para 'Nao efetivado'
			UPDATE adocao
				set status_adocao = 'Nao efetivado'
				where id_adocao = 2;
			
	-- 2. Reversao parcial(específico): adocao de multiplos pets, uma parcela dos pets é retornada aos cuidados do abrigo
	-- Ajuste: para efeitos da realização desse exemplo e defazer anterações feitas no exemplo anterior, executando:
		UPDATE pet 
			set status_pet = 'Adotado'
			where id_pet = 2;
		UPDATE adocao
			set status_adocao = 'Concluido'
			where id_adocao = 2;
	-- Aplicação: reversão de adoção(id_adocao = 2), mantendo a tutela de um pet(id_pet = 2) e retornando o outro (id_pet = 1).
	-- Etapas:
		-- Atualização(tabela pet): 'Adotado' para 'Divulgado' apenas para o pet retornado (id = 1)		
		UPDATE pet 
			set status_pet = 'Divulgado'
			where id_pet = 1; 		
	   
		-- Inserção do novo processo no sistema, classificando como 'Reversao de adocao'
		INSERT INTO processo
			(data_hora, nome_processo, tipo_processo, id_colaborador)
		VALUES 
			('2025-11-05 08:00:00', 'Reversao de adocao', 'Adocao', 2);
		
        -- Inserção de novo registro de adocao (reversao parcial da adocao: status_adocao = 'Nao efetuado')
		INSERT INTO adocao 
			(id_adotante, id_processo, status_adocao)
		VALUES
			(2, 21, 'Nao efetuado');
		
		--  Atualização de dados para o novo processo de adocao gerado
		UPDATE pet_adocao
			SET id_adocao = 3
			WHERE id_pet_adocao = 2;


	-- 3. Controle de estoque em novo aposento
	-- EXEMPLO: Controle de estoque da área comum (COPA)
		-- 3.1 Contextualizando
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
		
		-- 3.3 UPDATE CONDICIONADO: Alterando quantidades de itens após novas compras
			-- EXEMPLO: Compra de mantimentos 
			update armazem_cozinha
			set
				quantidade = quantidade - 1 -- sem compras, apenas consumo
			where cod_item = 1;
            
			update armazem_cozinha set 
				quantidade = quantidade + 3,
				data_aquisicao = '2025-11-20',
				estado = 'disponivel'
			where cod_item = 2;      
            
			update armazem_cozinha set
				quantidade = quantidade + 10,
				data_aquisicao = '2025-11-20',
				estado = 'disponivel'
			where cod_item = 3;      
            
			update armazem_cozinha set
				quantidade = quandidade + 12,
				data_aquisicao = '2025-11-20',
				estado = 'disponivel'
			where cod_item = 4;

			-- Exemplo: Atualização de 'status' dos itens no estoque
            
            -- Classifica estoque com baixo número em estoque
			update armazem_cozinha, 
				(select armazem_cozinha.cod_item from armazem_cozinha
				where armazem_cozinha.quantidade > 0 and armazem_cozinha.quantidade < 4) 
				as teste
			set estado = 'acabando'
			where armazem_cozinha.cod_item = teste.cod_item;

			-- Classifica estoque com número em estoque suficiente
			update armazem_cozinha, 
				(select armazem_cozinha.cod_item from armazem_cozinha
				where armazem_cozinha.quantidade > 3) 
				as teste
			set estado = 'disponivel'
			where armazem_cozinha.cod_item = teste.cod_item;

			-- Classifica estoque indisponível
			update armazem_cozinha, 
				(select armazem_cozinha.cod_item from armazem_cozinha
				where armazem_cozinha.quantidade = 0) 
				as teste
			set estado = 'em falta'
			where armazem_cozinha.cod_item = teste.cod_item;    


	-- 4. Apagando um registro específico: 'item'
		-- EXEMPLO: Removendo item de cod_item = 5 na tabela armazen_cozinha
		DELETE FROM armazem_cozinha where cod_item = 5;

	-- 5. Deleção de uma sequencia de QUATRO registros
		-- exemplo: Remocao dos quatro ultimos registros da tabela armazen_cozinha
		DELETE FROM armazem_cozinha
		ORDER BY cod_item desc
		LIMIT 4;

	-- 6. Deleção dos dados de um Adotante (id_pessoa = 5)
		DELETE FROM pet_adocao WHERE id_adocao = 1;
		DELETE FROM adocao WHERE id_adotante = 1;
		DELETE FROM recibo WHERE id_adotante = 1;
		DELETE FROM consentimento WHERE id_adotante = 1;
		DELETE FROM adotante WHERE id_pessoa = 5;
		DELETE FROM endereco WHERE id_pessoa = 5;
		DELETE FROM contato WHERE id_pessoa = 5;
		DELETE FROM pessoa WHERE id_pessoa = 5;


