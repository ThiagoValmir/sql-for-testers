# /*

# 02 - EXISTS

## OBJETIVO

Aprender a utilizar EXISTS para verificar se uma subquery
retorna pelo menos um registro.

## EXPLICAÇÃO

EXISTS verifica se existe pelo menos um registro que
satisfaça determinada condição.

Quando a subquery encontra um registro correspondente,
EXISTS retorna TRUE.

Quando não encontra, retorna FALSE.

## USO EM QA

EXISTS pode ser utilizado para:

* Verificar se um relacionamento existe;
* Encontrar clientes que possuem pedidos;
* Validar se determinado registro foi criado;
* Investigar relacionamentos;
* Validar pré-condições de testes.

## RESULTADO ESPERADO

Somente registros para os quais a condição do EXISTS
seja verdadeira devem ser retornados.
=====================================

*/

-- ==========================================================
-- EXEMPLO 1
-- Clientes que possuem pelo menos um pedido
-- ==========================================================

SELECT
c.id,
c.name
FROM customers c
WHERE EXISTS (
SELECT 1
FROM orders o
WHERE o.customer_id = c.id
);

/*
RESULTADO ESPERADO:

Somente clientes que possuem pelo menos um pedido.
*/

-- ==========================================================
-- EXEMPLO 2
-- Clientes que não possuem pedidos
-- ==========================================================

SELECT
c.id,
c.name
FROM customers c
WHERE NOT EXISTS (
SELECT 1
FROM orders o
WHERE o.customer_id = c.id
);

/*
RESULTADO ESPERADO:

Somente clientes que não possuem nenhum pedido.
*/

-- ==========================================================
-- EXEMPLO 3
-- Produtos que já foram vendidos
-- ==========================================================

SELECT
p.id,
p.name
FROM products p
WHERE EXISTS (
SELECT 1
FROM order_items oi
WHERE oi.product_id = p.id
);

/*
RESULTADO ESPERADO:

Somente produtos que possuem pelo menos um
registro em order_items.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

Após uma compra, o QA espera que exista um item
associado ao produto comprado.

*/

SELECT
p.id,
p.name
FROM products p
WHERE p.id = 10
AND EXISTS (
SELECT 1
FROM order_items oi
WHERE oi.product_id = p.id
);

/*
RESULTADO ESPERADO:

O produto de ID 10 deve ser retornado se existir
pelo menos um item de pedido relacionado a ele.

Caso nenhum registro seja retornado, o QA deve
investigar se o fluxo de compra criou corretamente
o relacionamento esperado.
*/
