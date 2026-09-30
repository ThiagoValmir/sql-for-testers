# /*

# 05 - MULTIPLE JOINs

## OBJETIVO

Aprender a combinar três ou mais tabelas utilizando
múltiplos JOINs.

## EXPLICAÇÃO

Sistemas reais normalmente possuem informações
distribuídas em várias tabelas.

Um pedido, por exemplo, pode estar relacionado a:

customers
↓
orders
↓
order_items
↓
products

Para consultar todas essas informações em uma única
consulta, podemos utilizar múltiplos JOINs.

## USO EM QA

Múltiplos JOINs são muito úteis para investigar
fluxos completos da aplicação.

Exemplos:

* Validar um pedido completo;
* Verificar cliente, pedido e produto;
* Validar checkout;
* Investigar pagamentos;
* Conferir estoque;
* Validar informações após uma compra.

## RESULTADO ESPERADO

A consulta deve combinar corretamente os registros
das tabelas relacionadas, respeitando as chaves utilizadas
nos relacionamentos.
====================

*/

-- ==========================================================
-- EXEMPLO 1
-- Cliente + Pedido + Itens + Produto
-- ==========================================================

SELECT
c.id AS customer_id,
c.name AS customer_name,
o.id AS order_id,
o.order_date,
p.id AS product_id,
p.name AS product_name,
oi.quantity,
oi.unit_price
FROM customers c
INNER JOIN orders o
ON c.id = o.customer_id
INNER JOIN order_items oi
ON o.id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.id;

/*
RESULTADO ESPERADO:

Cada linha deve representar um item de um pedido,
contendo informações sobre:

* Cliente;
* Pedido;
* Produto;
* Quantidade;
* Preço unitário.
  */

-- ==========================================================
-- EXEMPLO 2
-- Consultar um pedido específico
-- ==========================================================

SELECT
c.name AS customer_name,
o.id AS order_id,
o.status AS order_status,
p.name AS product_name,
oi.quantity,
oi.unit_price
FROM customers c
INNER JOIN orders o
ON c.id = o.customer_id
INNER JOIN order_items oi
ON o.id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.id
WHERE o.id = 1001;

/*
RESULTADO ESPERADO:

Devem ser apresentados todos os produtos pertencentes
ao pedido 1001, juntamente com o cliente responsável
pelo pedido.
*/

-- ==========================================================
-- EXEMPLO 3
-- Calcular o valor dos itens
-- ==========================================================

SELECT
o.id AS order_id,
c.name AS customer_name,
p.name AS product_name,
oi.quantity,
oi.unit_price,
oi.quantity * oi.unit_price AS item_total
FROM customers c
INNER JOIN orders o
ON c.id = o.customer_id
INNER JOIN order_items oi
ON o.id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.id;

/*
RESULTADO ESPERADO:

Para cada item do pedido, deve ser apresentado:

quantity × unit_price

como item_total.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O usuário realizou um checkout contendo:

* Um cliente;
* Um pedido;
* Dois ou mais produtos.

O QA deseja validar se todas as informações estão
corretamente relacionadas no banco.
*/

SELECT
c.name AS customer_name,
o.id AS order_id,
o.status AS order_status,
p.name AS product_name,
oi.quantity,
oi.unit_price,
oi.quantity * oi.unit_price AS item_total
FROM customers c
INNER JOIN orders o
ON c.id = o.customer_id
INNER JOIN order_items oi
ON o.id = oi.order_id
INNER JOIN products p
ON oi.product_id = p.id
WHERE o.id = 1001;

/*
RESULTADO ESPERADO:

O pedido deve:

1. Estar relacionado ao cliente correto;
2. Possuir os produtos selecionados;
3. Possuir as quantidades corretas;
4. Possuir os preços unitários corretos;
5. Calcular corretamente o valor de cada item.

Essa consulta pode ser utilizada como parte de uma
investigação após um teste de checkout.
*/

-- ==========================================================
-- INVESTIGAÇÃO DE DADOS INCONSISTENTES
-- ==========================================================

/*
Encontrar itens de pedidos que não possuem
um produto correspondente.
*/

SELECT
oi.id AS order_item_id,
oi.order_id,
oi.product_id,
p.name AS product_name
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.id
WHERE p.id IS NULL;

/*
RESULTADO ESPERADO:

0 registros.

Caso existam resultados, existem itens de pedido
referenciando produtos que não existem.

Isso caracteriza uma possível violação de integridade
referencial e deve ser investigado.
*/
