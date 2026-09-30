# /*

# ORPHAN RECORDS

## OBJETIVO

Identificar registros que possuem uma referência para
outro registro que não existe.

## EXPLICAÇÃO

Um registro órfão ocorre quando uma tabela possui uma
chave estrangeira que aponta para um registro inexistente.

Exemplo:

orders.customer_id = 10

Mas não existe:

customers.id = 10

Nesse caso, o pedido possui uma referência inválida
e é considerado um registro órfão.

## USO EM QA

Pode ser utilizado para:

* Validar integridade referencial;
* Investigar problemas de integração;
* Validar exclusões;
* Investigar falhas de migração;
* Encontrar registros inconsistentes.

## RESULTADO ESPERADO

Quando a integridade referencial estiver correta,
as consultas devem retornar 0 registros órfãos.
===============================================

*/

-- ==========================================================
-- EXEMPLO 1
-- Pedidos sem cliente correspondente
-- ==========================================================

SELECT
o.id AS order_id,
o.customer_id
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.id
WHERE c.id IS NULL;

/*
RESULTADO ESPERADO:

0 registros.

Todo pedido deve possuir um cliente existente.
*/

-- ==========================================================
-- EXEMPLO 2
-- Itens de pedido sem pedido correspondente
-- ==========================================================

SELECT
oi.id AS order_item_id,
oi.order_id
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.id
WHERE o.id IS NULL;

/*
RESULTADO ESPERADO:

0 registros.

Todo item deve estar associado a um pedido existente.
*/

-- ==========================================================
-- EXEMPLO 3
-- Itens de pedido sem produto correspondente
-- ==========================================================

SELECT
oi.id AS order_item_id,
oi.product_id
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.id
WHERE p.id IS NULL;

/*
RESULTADO ESPERADO:

0 registros.

Todo item de pedido deve possuir um produto
correspondente.
*/

-- ==========================================================
-- EXEMPLO 4
-- Encontrar todos os tipos de relacionamento inválido
-- ==========================================================

/*
Pedidos sem cliente:
*/

SELECT
o.id AS order_id,
o.customer_id
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.id
WHERE c.id IS NULL;

/*
Itens sem pedido:
*/

SELECT
oi.id AS order_item_id,
oi.order_id
FROM order_items oi
LEFT JOIN orders o
ON oi.order_id = o.id
WHERE o.id IS NULL;

/*
Itens sem produto:
*/

SELECT
oi.id AS order_item_id,
oi.product_id
FROM order_items oi
LEFT JOIN products p
ON oi.product_id = p.id
WHERE p.id IS NULL;

/*
RESULTADO ESPERADO:

Todas as consultas devem retornar:

0 registros.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

Durante um teste de checkout, o sistema criou um pedido.

O QA deseja verificar se todos os relacionamentos
foram criados corretamente.

*/

SELECT
o.id AS order_id,
o.customer_id,
c.id AS customer_exists
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.id
WHERE o.id = 1001;

/*
RESULTADO ESPERADO:

O pedido deve possuir um customer_id válido.

Exemplo esperado:

order_id | customer_id | customer_exists
1001     | 15          | 15

Se customer_exists for NULL, o pedido possui uma
referência inválida.
*/

-- ==========================================================
-- INVESTIGAÇÃO APÓS EXCLUSÃO
-- ==========================================================

/*
CENÁRIO:

Um cliente foi excluído.

O QA deseja verificar se existem pedidos apontando
para esse cliente.
*/

SELECT
o.id,
o.customer_id
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.id
WHERE c.id IS NULL;

/*
RESULTADO ESPERADO:

0 registros.

Caso existam resultados, é necessário investigar
como a exclusão do cliente deveria funcionar.

Possibilidades:

* Exclusão deveria ser bloqueada;
* Pedidos deveriam permanecer com relacionamento;
* Cliente deveria ser marcado como inativo;
* Dados relacionados deveriam ser tratados por
  uma regra de negócio específica.
  */
