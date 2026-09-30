# /*

# 01 - COUNT

## OBJETIVO

Aprender a utilizar COUNT para contar registros ou valores.

## EXPLICAÇÃO

COUNT retorna a quantidade de registros encontrados.

Principais formas:

COUNT(*)
Conta todas as linhas.

COUNT(column)
Conta somente os registros em que a coluna
não possui NULL.

COUNT(DISTINCT column)
Conta somente valores diferentes.

## USO EM QA

COUNT pode ser utilizado para:

* Validar quantidade de registros;
* Comparar dados esperados com dados encontrados;
* Identificar possíveis duplicidades;
* Verificar quantidade de usuários;
* Validar quantidade de pedidos;
* Apoiar testes de regressão.

## RESULTADO ESPERADO

A quantidade retornada deve corresponder ao número
de registros que atendem à consulta.
====================================

*/

-- ==========================================================
-- EXEMPLO 1
-- Quantidade total de clientes
-- ==========================================================

SELECT COUNT(*) AS total_customers
FROM customers;

/*
RESULTADO ESPERADO:

Um único valor contendo a quantidade total de clientes.

Exemplo:

## total_customers

100
*/

-- ==========================================================
-- EXEMPLO 2
-- Quantidade de clientes ativos
-- ==========================================================

SELECT COUNT(*) AS active_customers
FROM customers
WHERE status = 'ACTIVE';

/*
RESULTADO ESPERADO:

A quantidade de clientes cujo status seja ACTIVE.
*/

-- ==========================================================
-- EXEMPLO 3
-- COUNT em uma coluna
-- ==========================================================

SELECT COUNT(email) AS customers_with_email
FROM customers;

/*
RESULTADO ESPERADO:

A quantidade de clientes que possuem e-mail preenchido.

Registros onde email = NULL não serão contabilizados.
*/

-- ==========================================================
-- EXEMPLO 4
-- COUNT DISTINCT
-- ==========================================================

SELECT COUNT(DISTINCT city) AS different_cities
FROM customers;

/*
RESULTADO ESPERADO:

A quantidade de cidades diferentes existentes
na tabela customers.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O sistema deveria possuir 100 clientes após a execução
de uma massa de testes.

O QA pode verificar a quantidade atual no banco.
*/

SELECT COUNT(*) AS total_customers
FROM customers;

/*
RESULTADO ESPERADO:

100

Caso o resultado seja diferente de 100, o QA deve
investigar a causa da divergência.
*/

-- ==========================================================
-- INVESTIGAÇÃO DE POSSÍVEIS DUPLICIDADES
-- ==========================================================

SELECT
email,
COUNT(*) AS occurrences
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

/*
RESULTADO ESPERADO:

0 registros.

Caso sejam retornados e-mails com occurrences > 1,
existem possíveis clientes duplicados.
*/
