# /*

# 04 - DISTINCT

## OBJETIVO

Aprender a utilizar DISTINCT para retornar valores únicos.

## EXPLICAÇÃO

DISTINCT elimina valores duplicados do resultado da consulta.

Importante:

DISTINCT não remove registros da tabela.

Ele apenas evita que valores repetidos sejam apresentados
no resultado da consulta.

## USO EM QA

Pode ser utilizado para analisar:

* Estados;
* Cidades;
* Categorias;
* Status;
* Tipos de pagamento;
* Outros valores que podem se repetir.

Também pode ajudar a identificar valores inesperados
em uma coluna.

## RESULTADO ESPERADO

# Cada valor deve aparecer somente uma vez no resultado.

*/

-- ==========================================================
-- EXEMPLO 1
-- Estados cadastrados
-- ==========================================================

SELECT DISTINCT state
FROM customers;

/*
RESULTADO ESPERADO:

Cada estado deve aparecer apenas uma vez.

Exemplo:

SC
PR
RS
SP
*/

-- ==========================================================
-- EXEMPLO 2
-- Cidades cadastradas
-- ==========================================================

SELECT DISTINCT city
FROM customers;

/*
RESULTADO ESPERADO:

Cada cidade deve aparecer apenas uma vez.
*/

-- ==========================================================
-- EXEMPLO 3
-- Status dos clientes
-- ==========================================================

SELECT DISTINCT status
FROM customers;

/*
RESULTADO ESPERADO:

A consulta deve apresentar todos os status diferentes
existentes no banco.

Exemplo:

ACTIVE
INACTIVE
*/

-- ==========================================================
-- EXEMPLO 4
-- Categorias de produtos
-- ==========================================================

SELECT DISTINCT category
FROM products;

/*
RESULTADO ESPERADO:

Cada categoria deve aparecer somente uma vez.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O requisito do sistema determina que os únicos status
válidos para clientes são:

ACTIVE
INACTIVE

O QA pode consultar os valores existentes no banco.
*/

SELECT DISTINCT status
FROM customers;

/*
RESULTADO ESPERADO:

Somente os valores esperados devem aparecer.

Se o resultado apresentar algo como:

ACTIVE
INACTIVE
DELETED

o valor DELETED deverá ser investigado, pois pode representar
uma inconsistência em relação à regra definida.
*/
