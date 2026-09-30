# /*

# 01 - INNER JOIN

## OBJETIVO

Aprender a combinar registros relacionados utilizando
INNER JOIN.

## EXPLICAÇÃO

INNER JOIN retorna somente os registros que possuem
correspondência nas duas tabelas.

Exemplo:

customers
id = 1

orders
customer_id = 1

Existe correspondência, portanto o registro será retornado.

Se existir um pedido com customer_id = 999 e não existir
um cliente com id = 999, esse pedido não será retornado
pelo INNER JOIN.

## USO EM QA

INNER JOIN pode ser utilizado para:

* Consultar informações relacionadas;
* Validar relacionamentos;
* Investigar pedidos;
* Consultar dados de clientes;
* Validar informações entre tabelas.

## RESULTADO ESPERADO

Somente registros que possuem correspondência nas
duas tabelas devem ser retornados.
==================================

*/

-- ==========================================================
-- EXEMPLO 1
-- Pedidos e seus respectivos clientes
-- ==========================================================

SELECT
o.id AS order_id,
c.id AS customer_id,
c.name AS customer_name,
o.order_date,
o.status
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.id;

/*
RESULTADO ESPERADO:

Cada pedido que possui um cliente correspondente deve
ser apresentado junto com as informações desse cliente.

Pedidos sem cliente correspondente não devem aparecer.
*/

-- ==========================================================
-- EXEMPLO 2
-- Produtos vendidos em pedidos
-- ==========================================================

SELECT
oi.order_id,
p.id AS product_id,
p.name AS product_name,
oi.quantity,
oi.unit_price
FROM order_items oi
INNER JOIN products p
ON oi.product_id = p.id;

/*
RESULTADO ESPERADO:

Cada item de pedido deve aparecer associado ao produto
correspondente.
*/

-- ==========================================================
-- EXEMPLO 3
-- Pedidos realizados por um cliente específico
-- ==========================================================

SELECT
c.name,
o.id AS order_id,
o.order_date,
o.total_amount
FROM customers c
INNER JOIN orders o
ON c.id = o.customer_id
WHERE c.id = 1;

/*
RESULTADO ESPERADO:

Devem ser retornados somente os pedidos pertencentes
ao cliente de ID 1.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O usuário realizou um pedido pela aplicação.

O QA deseja verificar se o pedido está corretamente
relacionado ao cliente.

*/

SELECT
o.id AS order_id,
c.id AS customer_id,
c.name,
o.total_amount
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.id
WHERE o.id = 1001;

/*
RESULTADO ESPERADO:

O pedido 1001 deve aparecer associado ao cliente correto.

O ID do cliente armazenado em orders.customer_id deve
corresponder ao customers.id.
*/
