# /*

# 04 - GROUP BY

## OBJETIVO

Aprender a agrupar registros de acordo com uma ou mais
colunas.

## EXPLICAÇÃO

GROUP BY agrupa registros que possuem o mesmo valor
em determinada coluna.

É frequentemente utilizado junto com funções de agregação:

COUNT
SUM
AVG
MIN
MAX

## USO EM QA

GROUP BY pode ser utilizado para analisar:

* Quantidade de clientes por cidade;
* Quantidade de produtos por categoria;
* Pedidos por cliente;
* Pedidos por status;
* Vendas por período;
* Dados agrupados para investigação.

## RESULTADO ESPERADO

Cada grupo deve aparecer como uma linha no resultado,
normalmente acompanhado de uma função de agregação.
===================================================

*/

-- ==========================================================
-- EXEMPLO 1
-- Quantidade de clientes por estado
-- ==========================================================

SELECT
state,
COUNT(*) AS total_customers
FROM customers
GROUP BY state;

/*
RESULTADO ESPERADO:

Uma linha para cada estado.

Exemplo:

state | total_customers
------+----------------
SC    | 50
PR    | 20
RS    | 15
*/

-- ==========================================================
-- EXEMPLO 2
-- Quantidade de clientes por cidade
-- ==========================================================

SELECT
city,
COUNT(*) AS total_customers
FROM customers
GROUP BY city;

/*
RESULTADO ESPERADO:

Cada cidade deve aparecer uma vez,
acompanhada da quantidade de clientes.
*/

-- ==========================================================
-- EXEMPLO 3
-- Quantidade de produtos por categoria
-- ==========================================================

SELECT
category,
COUNT(*) AS total_products
FROM products
GROUP BY category;

/*
RESULTADO ESPERADO:

Cada categoria deve apresentar a quantidade
de produtos cadastrados.
*/

-- ==========================================================
-- EXEMPLO 4
-- Soma do estoque por categoria
-- ==========================================================

SELECT
category,
SUM(stock_quantity) AS total_stock
FROM products
GROUP BY category;

/*
RESULTADO ESPERADO:

Cada categoria deve apresentar a quantidade
total de produtos em estoque.
*/

-- ==========================================================
-- EXEMPLO 5
-- Pedidos por status
-- ==========================================================

SELECT
status,
COUNT(*) AS total_orders
FROM orders
GROUP BY status;

/*
RESULTADO ESPERADO:

Cada status deve apresentar a quantidade
de pedidos correspondente.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O QA deseja verificar se existem pedidos em diferentes
status e quantos pedidos existem em cada um deles.
*/

SELECT
status,
COUNT(*) AS total_orders
FROM orders
GROUP BY status;

/*
RESULTADO ESPERADO:

O resultado deve apresentar cada status existente
e a quantidade correspondente.

Isso permite verificar se existem valores inesperados
ou uma quantidade de registros diferente do esperado.
*/
