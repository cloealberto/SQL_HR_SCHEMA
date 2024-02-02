USE RECURSOS_HUMANOS;

-- Inserindo dados em massa de um arquivo csv na tabela "colaboradores"
LOAD DATA INFILE 'C:\\Temp\\colaboradores_table.csv'
INTO TABLE COLABORADORES
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Conferindo se deu certo o carregamento dos dados, selecionando somente as 5 primeiras linhas.
SELECT
    *
FROM
    COLABORADORES LIMIT 5;

-- Selecionando o salário mais alto entre os colaboradores
SELECT
    CONCAT(NOME, ' ', SOBRENOME) AS 'NOME COMPLETO',
    GENERO,
    SALARIO
FROM
    COLABORADORES
WHERE
    SALARIO = (
        SELECT
            MAX(SALARIO)
        FROM
            COLABORADORES
    );


-- Seleciona o salário mais baixo
SELECT
    CONCAT(NOME, ' ', SOBRENOME) AS 'NOME COMPLETO',
    GENERO,
    SALARIO
FROM
    COLABORADORES
WHERE
    SALARIO = (
        SELECT
            MIN(SALARIO)
        FROM
            COLABORADORES
    );


-- Seleciona os 5 salários mais altos entre os colaboradores
SELECT
    CONCAT(NOME,
    ' ',
    SOBRENOME) AS 'NOME COMPLETO',
    SALARIO AS 'MAIORES SALÁRIOS',
    GENERO
FROM
    COLABORADORES
ORDER BY
    SALARIO DESC LIMIT 5;




-- Seleciona os 5 salários mais baixos entre os colaboradores

SELECT
    CONCAT(NOME,
    ' ',
    SOBRENOME) AS 'NOME COMPLETO',
    SALARIO AS 'MENORES SALÁRIOS',
    GENERO
FROM
    COLABORADORES
ORDER BY
    SALARIO ASC LIMIT 5;


-- Seleciona a média salarial dos colaboradores, usando antes o função ROUND para arredondar as casas decimais para 2.
-- Tão pagando bem, hein rs. Lembrando que o dataset é totalmente fictício.

SELECT
    ROUND(AVG(SALARIO), 2) AS 'MÉDIA SALARIAL'
FROM
    COLABORADORES;



-- Total de salário real pagos pela empresa
SELECT
    ROUND(SUM(SALARIO), 2) AS 'SOMA TOTAL DE SALÁRIOS'
FROM
    COLABORADORES;

-- Total de colaboradores por gênero.
SELECT
    GENERO,
    COUNT(*) AS 'TOTAL'
FROM
    COLABORADORES
GROUP BY
    GENERO
ORDER BY
    COUNT(*) DESC;

-- Fazendo o levantamento do headcount geral
SELECT
    COUNT(DISTINCT CPF) AS 'HEADCOUNT'
FROM
    COLABORADORES;

-- Headcount por departamento

SELECT
    DNO AS 'DEPARTAMENTO',
    COUNT(*) AS 'HEADCOUNT'
FROM
    COLABORADORES
GROUP BY
    DNO
ORDER BY
    COUNT(*) DESC;



-- Verficando se a data e hora do sistema de banco de dados estão corretos.
SELECT CURRENT_TIMESTAMP;

-- Calculando a idade atual dos colaboradores com base na data de nascimento e na data atual.
SELECT
    NOME,
    DATANASCIMENTO,
    TIMESTAMPDIFF(YEAR,
    DATANASCIMENTO,
    CURRENT_DATE()) AS IDADE
FROM
    COLABORADORES
ORDER BY
    IDADE DESC LIMIT 5;


-- Inserindo dados em massa de um arquivo csv na tabela "DEPARTAMENTO"
LOAD DATA INFILE 'C:\\Temp\\departamento_table.csv'
INTO TABLE DEPARTAMENTO
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT *
FROM DEPARTAMENTO;

-- Fazendo o levantamento dos gerentes de cada departamento, com remuneração, gênero e data de admissão.
-- Usando a função UPPER para retornar o nome concatenado em letras maiúsculas.
SELECT
    D.NOMEDEPARTAMENTO AS DEPARTAMENTO,
    UPPER(CONCAT(C.NOME,
    ' ',
    C.SOBRENOME)) AS 'NOME DO GERENTE',
    C.SALARIO AS 'REMUNERAÇÃO',
    C.GENERO,
    D.GERENTEADMISSAO AS 'DATA DE ADMISSÃO'
FROM
    DEPARTAMENTO AS D
    JOIN COLABORADORES AS C
    ON D.CPFGERENTE = C.CPF
ORDER BY
    DEPARTAMENTO;

-- Inserindo dados em massa de um arquivo csv na tabela "LOCALIZACAO_DEPTOS"
LOAD DATA INFILE 'C:\\Temp\\localizacaodeptos.csv'
INTO TABLE LOCALIZACAO_DEPTOS
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Checando a ingestão de dados na tabela "LOCALIZACAO_DEPTOS", chamando apenas 5 primeiras linhas.
SELECT
    *
FROM
    LOCALIZACAO_DEPTOS LIMIT 5;




-- Inserindo dados em massa de um arquivo csv na tabela "PROJETOS"
LOAD DATA INFILE 'C:\\Temp\\projetos.csv'
INTO TABLE PROJETOS
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Checando a ingestão de dados na tabela "PROJETOS", chamando apenas 5 primeiras linhas.
SELECT
    *
FROM
    PROJETOS LIMIT 5;



-- Inserindo dados em massa de um arquivo csv na tabela "ALOCACAO"
LOAD DATA INFILE 'C:\\Temp\\alocacao.csv'
INTO TABLE ALOCACAO
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT
    *
FROM
    ALOCACAO LIMIT 5;


-- Inserindo dados em massa de um arquivo csv na tabela "DEPENDENTES"
LOAD DATA INFILE 'C:\\Temp\\dependentes.csv'
INTO TABLE DEPENDENTES
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT
    *
FROM
    DEPENDENTES LIMIT 5;


-- Como 'PAI' não aparecia na consulta WHERE, descobri que havia um espaço no final da palavra.
-- Então usei UPDATE para limpar essa sujeira nos dados.
SELECT
    *
FROM
    DEPENDENTES
WHERE
    PARENTESCO LIKE 'PAI%';

-- Atualizando os registros tirando o espaço no final da palavra 'PAI '.
UPDATE DEPENDENTES
SET
    PARENTESCO = 'PAI'
WHERE
    PARENTESCO LIKE 'PAI%';

-- O mesmo para 'MAE ';.
UPDATE DEPENDENTES
SET
    PARENTESCO = 'MAE'
WHERE
    PARENTESCO LIKE 'MAE%';

-- O mesmo para 'CONJUGE '
UPDATE DEPENDENTES
SET
    PARENTESCO = 'CONJUGE'
WHERE
    PARENTESCO LIKE 'CONJUGE%';
--- Agora os registros aparecem no WHERE.
SELECT
    *
FROM
    DEPENDENTES
WHERE
    PARENTESCO IN ('PAI', 'MAE') LIMIT 5;



-- Aqui percebemos que a data de nascimento do conjuge cadastrada estava com erro de +20 anos.
-- Usamos a funcão 'DATE_SUB' para subtrair os anos e 'INTERVAL 20 YEAR' para definir o intervalo de tempo.
UPDATE DEPENDENTES
SET
    DATANASCIMENTO = DATE_SUB(
        DATANASCIMENTO,
        INTERVAL 20 YEAR
    )
WHERE
    PARENTESCO = 'CONJUGE'
    AND DATANASCIMENTO BETWEEN '2000-01-31' AND '2024-12-31';

-- Todos os dados foram inseridos nas tabelas

