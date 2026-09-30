```sql
/*
============================================================
BUSINESS RULE - ORDER TOTAL
============================================================

OBJETIVO
--------
Validar se o valor total de um pedido corresponde
corretamente à soma dos seus itens.

EXPLICAÇÃO
----------
Em um e-commerce, o total do pedido normalmente é
calculado a partir da quantidade e do preço de cada item.

Fórmula:

    quantidade × preço_unitário

O total do pedido deve corresponder à soma de todos
os itens.

Exemplo:

Produto A
2 × R$ 100,00 = R$ 200,00

Produto B
1 × R$ 50,00 = R$ 50,00

Total esperado:
R$ 250,00

USO EM QA
---------
Essa consulta pode ser utilizada para:

- Validar o cálculo do checkout;
- Verificar valores persistidos no banco;
- Investigar divergências de preço;
- Validar pedidos após uma compra;
- Apoiar testes de regressão;
- Investigar bugs relacionados ao carrinho.

RESULTADO ESPERADO
------------------
O valor armazenado em orders.total_amount deve ser
igual à soma dos valores dos itens.

Quando não houver inconsistências:

0 registros.
============================================================
*/


-- ==========================================================
-- EXEMPLO 1
-- Calcular o total esperado de cada pedido
-- ==========================================================

SELECT
    o.id AS order_id,
    o.total_amount AS stored_total,
    SUM(oi.quantity * oi.unit_price) AS calculated_total
FROM orders o
INNER JOIN order_items oi
    ON o.id = oi.order_id
GROUP BY
    o.id,
    o.total_amount;


/*
RESULTADO ESPERADO:

stored_total deve ser igual a calculated_total.

Exemplo:

order_id | stored_total | calculated_total
1001     | 250.00       | 250.00
*/


-- ==========================================================
-- EXEMPLO 2
-- Encontrar pedidos com total incorreto
-- ==========================================================

SELECT
    o.id AS order_id,
    o.total_amount AS stored_total,
    SUM(oi.quantity * oi.unit_price) AS calculated_total
FROM orders o
INNER JOIN order_items oi
    ON o.id = oi.order_id
GROUP BY
    o.id,
    o.total_amount
HAVING o.total_amount <>
       SUM(oi.quantity * oi.unit_price);


/*
RESULTADO ESPERADO:

0 registros.

Se houver registros, existe uma diferença entre
o valor armazenado e o valor calculado.
*/


-- ==========================================================
-- EXEMPLO 3
-- Verificar os itens de um pedido
-- ==========================================================

SELECT
    oi.order_id,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_total
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.id
WHERE oi.order_id = 1001;


/*
RESULTADO ESPERADO:

Cada item deve apresentar:

quantidade
preço unitário
valor total do item

A soma de item_total deve corresponder
ao total do pedido.
*/


-- ==========================================================
-- CENÁRIO DE TESTE
-- ==========================================================

/*
DADOS DO TESTE

Produto A:
2 unidades × R$ 100,00

Produto B:
1 unidade × R$ 50,00

Total esperado:

R$ 250,00
*/

SELECT
    o.id AS order_id,
    o.total_amount,
    SUM(oi.quantity * oi.unit_price) AS expected_total
FROM orders o
INNER JOIN order_items oi
    ON o.id = oi.order_id
WHERE o.id = 1001
GROUP BY
    o.id,
    o.total_amount;


/*
RESULTADO ESPERADO:

total_amount  = 250.00
expected_total = 250.00
*/


-- ==========================================================
-- INVESTIGAÇÃO DE BUG
-- ==========================================================

/*
Se a aplicação apresentar R$ 250,00 para o cliente,
mas o banco possuir:

total_amount = 200.00

a consulta poderá revelar a inconsistência.

Esse tipo de consulta ajuda o QA a determinar se
o problema está relacionado à persistência dos dados,
ao cálculo do backend ou à apresentação na interface.
*/
```
