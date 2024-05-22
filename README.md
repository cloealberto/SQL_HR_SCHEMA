# Projeto de Gestão de Recursos Humanos
Este repositório contém scripts SQL para criar e gerenciar um banco de dados de Recursos Humanos. O banco de dados é projetado para armazenar informações sobre colaboradores, departamentos, projetos, alocações e dependentes.

## Estrutura do banco de dados:

### Tabela "COLABORADORES":
Armazena informações sobre os colaboradores da empresa.
Campos: NOME, SOBRENOME, CPF, DATANASCIMENTO, ENDERECO, GENERO, SALARIO, PIS, DNO.

### Tabela "DEPARTAMENTO":
Armazena informações sobre os departamentos da empresa.
Campos: NOMEDEPARTAMENTO, NUMERODEPARTAMENTO, CPFGERENTE, GERENTEADMISSAO, DATACRIACAODEPTO.

### Tabela "LOCALIZACAO_DEPTOS":
Relacionamento entre departamentos e suas localizações.
Campos: NUMERODEPARTAMENTO, LOCALIZACAODEPARTAMENTO.

### Tabela "PROJETOS":
Armazena informações sobre os projetos em andamento na empresa.
Campos: NOMEPROJETO, NUMEROPROJETO, LOCALPROJETO, NUMERODEPARTAMENTO.

### Tabela "ALOCACAO":
Relacionamento entre colaboradores e os projetos aos quais estão alocados.
Campos: CPFCOLABORADOR, NUMEROPROJETO, HORAS.

### Tabela "DEPENDENTES":
Armazena informações sobre os dependentes dos colaboradores.
Campos: CPFCOLABORADOR, NOMEDEPENDENTE, GENERO, DATANASCIMENTO, PARENTESCO.

### Instruções de uso:
Clone este repositório em sua máquina local.
Execute os scripts SQL em seu sistema de gerenciamento de banco de dados preferido.
Os scripts criarão todas as tabelas necessárias juntamente com suas restrições e relacionamentos.
Após a criação das tabelas, você pode inserir dados conforme necessário para simular o ambiente de Recursos Humanos.

## Observações:
Certifique-se de ajustar os scripts conforme necessário para corresponder às especificações do seu ambiente de banco de dados.
Este projeto é destinado a fins educacionais e pode ser adaptado para atender às necessidades específicas do seu projeto ou organização.
