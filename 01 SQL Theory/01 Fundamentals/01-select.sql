# /*

# 01 - SELECT

## OBJETIVO

Aprender a utilizar o comando SELECT para consultar
informações armazenadas no banco de dados.

## EXPLICAÇÃO

SELECT é utilizado para recuperar dados de uma ou mais
tabelas.

Podemos utilizar:

SELECT *
-> Retorna todas as colunas.

SELECT coluna1, coluna2
-> Retorna somente as colunas especificadas.

## USO EM QA

Um QA pode utilizar SELECT para verificar se uma informação
foi corretamente armazenada após uma ação realizada
na aplicação.

Exemplo:

1. O usuário realiza um cadastro.
2. A aplicação informa que o cadastro foi realizado.
3. O QA consulta o banco utilizando SELECT.
4. O QA verifica se os dados foram realmente persistidos.

## RESULTADO ESPERADO

# A consulta deve retornar os registros armazenados na tabela.

*/

-- ==========================================================
-- EXEMPLO 1
-- Consultar todos os clientes
-- ==========================================================

SELECT *
FROM customers;

/*
RESULTADO ESPERADO:

A consulta deve retornar todos os registros da tabela
customers e todas as suas colunas.
*/

-- ==========================================================
-- EXEMPLO 2
-- Consultar apenas algumas colunas
-- ==========================================================

SELECT
id,
name,
email
FROM customers;

/*
RESULTADO ESPERADO:

O resultado deve apresentar somente:

id
name
email

Isso é útil quando não precisamos consultar todas as
informações disponíveis na tabela.
*/

-- ==========================================================
-- EXEMPLO 3
-- Consultar produtos
-- ==========================================================

SELECT
id,
name,
price,
stock_quantity
FROM products;

/*
RESULTADO ESPERADO:

A consulta deve retornar o identificador, nome, preço e
quantidade em estoque de cada produto.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

Um usuário realizou um cadastro através da aplicação.

O QA deseja verificar se o registro foi criado no banco.
*/

SELECT
id,
name,
email,
status
FROM customers;

/*
RESULTADO ESPERADO:

O cliente cadastrado deve estar presente no resultado
com os dados esperados.
*/
