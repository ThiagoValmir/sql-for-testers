# /*

# 02 - SUM

## OBJETIVO

Aprender a utilizar SUM para somar valores numéricos.

## EXPLICAÇÃO

SUM retorna a soma dos valores de uma determinada coluna.

É muito utilizado para trabalhar com:

* Preços;
* Quantidades;
* Valores de pedidos;
* Valores de pagamentos;
* Estoque.

## USO EM QA

SUM pode ser utilizado para validar cálculos financeiros
e regras relacionadas a quantidade.

Por exemplo:

* Valor total de pedidos;
* Valor total de pagamentos;
* Quantidade total vendida;
* Quantidade total em estoque.

## RESULTADO ESPERADO

A soma retornada deve corresponder ao valor esperado
para o conjunto de registros analisado.
=======================================

*/

-- ==========================================================
-- EXEMPLO 1
-- Valor total dos produtos
-- ==========================================================

SELECT SUM(price) AS total_product_value
FROM products;

/*
RESULTADO ESPERADO:

A soma dos preços de todos os produtos cadastrados.
*/

-- ==========================================================
-- EXEMPLO 2
-- Estoque total
-- ==========================================================

SELECT SUM(stock_quantity) AS total_stock
FROM products;

/*
RESULTADO ESPERADO:

A quantidade total de unidades disponíveis
considerando todos os produtos.
*/

-- ==========================================================
-- EXEMPLO 3
-- Valor total dos pedidos
-- ==========================================================

SELECT SUM(total_amount) AS total_sales
FROM orders;

/*
RESULTADO ESPERADO:

A soma dos valores armazenados nos pedidos.
*/

-- ==========================================================
-- EXEMPLO 4
-- Valor total de pedidos concluídos
-- ==========================================================

SELECT SUM(total_amount) AS completed_sales
FROM orders
WHERE status = 'COMPLETED';

/*
RESULTADO ESPERADO:

A soma dos valores somente dos pedidos com status
COMPLETED.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O sistema apresenta na interface o valor total das vendas.

O QA pode consultar o banco para verificar se o valor
apresentado pela aplicação corresponde aos dados
armazenados.
*/

SELECT SUM(total_amount) AS expected_total
FROM orders
WHERE status = 'COMPLETED';

/*
RESULTADO ESPERADO:

O valor retornado pelo banco deve ser igual ao valor
apresentado pela aplicação.

Se os valores forem diferentes, existe uma inconsistência
que deve ser investigada.
*/

-- ==========================================================
-- EXEMPLO DE VALIDAÇÃO DE ESTOQUE
-- ==========================================================

SELECT SUM(stock_quantity) AS total_stock
FROM products
WHERE status = 'ACTIVE';

/*
RESULTADO ESPERADO:

A soma deve representar o estoque total dos produtos ativos.
*/
