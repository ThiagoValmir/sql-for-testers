# /*

# 03 - AVG

## OBJETIVO

Aprender a utilizar AVG para calcular médias.

## EXPLICAÇÃO

AVG calcula a média aritmética dos valores de uma coluna.

Exemplo:

Valores:

100
200
300

AVG = 200

## USO EM QA

AVG pode ser utilizado para analisar:

* Preço médio dos produtos;
* Valor médio dos pedidos;
* Quantidade média de itens;
* Tempo médio;
* Outros valores numéricos.

Também pode ser utilizado durante análises exploratórias
e investigações.

## RESULTADO ESPERADO

O resultado deve representar a média dos valores
considerados pela consulta.
===========================

*/

-- ==========================================================
-- EXEMPLO 1
-- Preço médio dos produtos
-- ==========================================================

SELECT AVG(price) AS average_product_price
FROM products;

/*
RESULTADO ESPERADO:

A média dos preços de todos os produtos.
*/

-- ==========================================================
-- EXEMPLO 2
-- Preço médio por categoria
-- ==========================================================

SELECT
category,
AVG(price) AS average_price
FROM products
GROUP BY category;

/*
RESULTADO ESPERADO:

Uma linha para cada categoria contendo
o preço médio dos produtos daquela categoria.
*/

-- ==========================================================
-- EXEMPLO 3
-- Valor médio dos pedidos
-- ==========================================================

SELECT AVG(total_amount) AS average_order_value
FROM orders;

/*
RESULTADO ESPERADO:

O valor médio de todos os pedidos considerados
pela consulta.
*/

-- ==========================================================
-- EXEMPLO 4
-- Valor médio dos pedidos concluídos
-- ==========================================================

SELECT AVG(total_amount) AS average_completed_order
FROM orders
WHERE status = 'COMPLETED';

/*
RESULTADO ESPERADO:

A média dos valores somente dos pedidos concluídos.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

Uma regra de negócio ou requisito informa que o valor
médio dos pedidos de uma determinada campanha deveria
estar dentro de determinada faixa.

O QA pode calcular a média armazenada no banco.
*/

SELECT AVG(total_amount) AS average_order
FROM orders
WHERE status = 'COMPLETED';

/*
RESULTADO ESPERADO:

O valor deve estar dentro da faixa definida pelo requisito.

Caso esteja fora, o QA deve investigar os dados e
a regra responsável pelo cálculo.
*/
