Título: animal-shelter-database v.0
Descrição: Projeto do banco de dados da animal-shelter
1. Visão Geral  
Gerir uma ONG, como para abrigo de animais, além de boa vontade e dedicação, re-quer boa tomada de decisão, administração dos recursos, visão e conformidade com as leis e boas práticas para garantir o bem-estar e proteção dos animais e continuidade de suas atividades. A tecnologia para o controle do fluxo da informação torna-se então uma ferramenta de grande auxílio.

3. Sobre o Abrigo
O Animal Shelter é uma organização não governamental dedicada ao acolhimento, cuidado e reabilitação de animais abandonados. Seu objetivo é proporcionar um ambiente seguro e estruturado para recuperação dos pets, promovendo sua adoção responsável.

4. Objetivo
O Projeto objetiva o monitorar dos cuidados dos animais dentro da instituição, armazenando os dados obtidos para de garantir a qualidade dos serviços e permitindo um fluxo de informação estruturado, capaz de propiciar:
•	Transparência e rastreabilidade dos dados;
•	Integração entre áreas: colaboradores, pets, estoque, adoção;
•	Suporte à tomada de decisão com base em indicadores;
•	Conformidade com legislação e políticas internas.
   
4. Escopo exclusivo
No momento, o sistema não tratará das questões contábeis e financeiras relacionadas ao patrimônio, doação, pagamentos, custos etc. Apesar de serem colocados dados de recibo para processos de adoção nos dados de adotante (fins de consideração para futuras referências).

5. Modelagem
   - Modelo entidade-relacionamento
   - Modelo relacional normalizado
   - Aplicação de regras de integração
Os destalhes estão disponíveis no diretório de documentos.

6. Diagrama Entidade-Relacionamento - DER
<img width="1133" height="1319" alt="DER completo workbench" src="https://github.com/user-attachments/assets/62d9df2a-7b29-4776-850d-9c19df46fded" />

7. Tecnologias:
  - MySQL Workbench 8.0 CE
    - Informações em: [http://dev.mysql.com/doc/workbench/en]
    - Download em: [http://dev.mysql.com/downloads]
  - Git/GitHub (versionamento e hospedagem)
     
8. Instalação e execução
   - Fazer download do MySQL community server e do Workbench e realizar sua instalação;
  - Fazer dowload dos scripts disponíveis dentro deste repositório -> [https://github.com/vbsilva-cs/animal-shelter-database.git]
  - Abrir e executar os scripts com o MySQL.

9. Consultas de relatórios
  - Gere informações e manipule dados com a linguagem de manipulação do MySQL
  - Exemplo: Para listar todos os pets cadastrados exibindo os mais recentes primeiro. Imprima e execute:
        
  SELECT id_pet as num_cadastro, nome, especie, raca, idade, data_entrada
	FROM Pet
	ORDER BY data_entrada DESC;
   
1o. Licença: Creative Commons Zero v1.0 Universal




