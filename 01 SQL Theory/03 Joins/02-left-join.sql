# /*

# 02 - LEFT JOIN

## OBJETIVO

Aprender a utilizar LEFT JOIN para preservar todos os
registros da tabela da esquerda.

## EXPLICAÇÃO

LEFT JOIN retorna:

1. Todos os registros da tabela da esquerda;
2. Os registros correspondentes da tabela da direita.

Quando não existe correspondência, as colunas da tabela
da direita recebem NULL.

Exemplo:

customers
↓
orders

Se um cliente não possuir pedidos, ele ainda aparecerá
no resultado.

## USO EM QA

LEFT JOIN é especialmente útil para encontrar registros
que deveriam possuir uma relação, mas não possuem.

Exemplos:

* Clientes sem pedidos;
* Pedidos sem cliente;
* Produtos nunca vendidos;
* Registros órfãos.

## RESULTADO ESPERADO

Todos os registros da tabela da esquerda devem aparecer.

Quando não existir correspondência, os campos da tabela
da direita devem apresentar NULL.
=================================

*/

-- ==========================================================
-- EXEMPLO 1
-- Todos os clientes e seus pedidos
-- ==========================================================

SELECT
c.id AS customer_id,
c.name,
o.id AS order_id,
o.total_amount
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id;

/*
RESULTADO ESPERADO:

Todos os clientes devem aparecer.

Clientes que possuem pedidos terão informações
correspondentes na tabela orders.

Clientes sem pedidos terão:

order_id = NULL
total_amount = NULL
*/

-- ==========================================================
-- EXEMPLO 2
-- Clientes que não possuem pedidos
-- ==========================================================

SELECT
c.id,
c.name
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.id IS NULL;

/*
RESULTADO ESPERADO:

Somente clientes que não possuem pedidos devem
ser retornados.
*/

-- ==========================================================
-- EXEMPLO 3
-- Produtos que nunca foram vendidos
-- ==========================================================

SELECT
p.id,
p.name
FROM products p
LEFT JOIN order_items oi
ON p.id = oi.product_id
WHERE oi.id IS NULL;

/*
RESULTADO ESPERADO:

Devem ser retornados somente produtos que não possuem
nenhum item de pedido relacionado.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

Após uma campanha, todos os produtos ativos deveriam
ter sido vendidos pelo menos uma vez.

O QA deseja identificar produtos ativos que nunca
apareceram em um pedido.
*/

SELECT
p.id,
p.name,
p.status
FROM products p
LEFT JOIN order_items oi
ON p.id = oi.product_id
WHERE p.status = 'ACTIVE'
AND oi.id IS NULL;

/*
RESULTADO ESPERADO:

Se a regra determinar que todos os produtos ativos
devem possuir pelo menos uma venda:

0 registros.

Caso algum produto apareça, ele deve ser investigado.
*/
