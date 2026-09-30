```sql
/*
============================================================
TEST SCENARIO - CHECKOUT
============================================================

OBJETIVO
--------
Utilizar SQL para validar o resultado de um fluxo completo
de checkout.

CENÁRIO
-------
O usuário:

1. Acessa a aplicação;
2. Seleciona produtos;
3. Adiciona os produtos ao carrinho;
4. Informa os dados necessários;
5. Finaliza a compra;
6. Realiza o pagamento.

Após a operação, o QA utiliza SQL para validar o estado
final do sistema.

VALIDAÇÕES
----------
- Pedido criado;
- Cliente correto;
- Produtos corretos;
- Quantidades corretas;
- Valores corretos;
- Total do pedido;
- Pagamento;
- Estoque;
- Relacionamentos entre as tabelas.

USO EM QA
---------
Esse tipo de consulta pode ser utilizado em:

- Testes funcionais;
- Testes de integração;
- Testes de API;
- Testes de regressão;
- Testes end-to-end;
- Investigação de bugs.

============================================================
*/


-- ==========================================================
-- TESTE 1
-- Verificar se o pedido foi criado
-- ==========================================================

SELECT
    id,
    customer_id,
    status,
    total_amount,
    order_date
FROM orders
WHERE id = 1001;


/*
RESULTADO ESPERADO:

1 registro.

O pedido deve existir após a finalização da compra.
*/


-- ==========================================================
-- TESTE 2
-- Verificar o cliente do pedido
-- ==========================================================

SELECT
    o.id AS order_id,
    o.customer_id,
    c.name,
    c.email
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.id
WHERE o.id = 1001;


/*
RESULTADO ESPERADO:

O pedido deve estar associado ao cliente que
realizou a compra.
*/


-- ==========================================================
-- TESTE 3
-- Verificar os produtos do pedido
-- ==========================================================

SELECT
    oi.order_id,
    oi.product_id,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.id
WHERE oi.order_id = 1001;


/*
RESULTADO ESPERADO:

Todos os produtos selecionados durante o checkout
devem estar associados ao pedido.

As quantidades devem corresponder às quantidades
selecionadas pelo usuário.
*/


-- ==========================================================
-- TESTE 4
-- Calcular o total do pedido
-- ==========================================================

SELECT
    o.id AS order_id,
    o.total_amount AS stored_total,
    SUM(oi.quantity * oi.unit_price) AS calculated_total
FROM orders o
INNER JOIN order_items oi
    ON o.id = oi.order_id
WHERE o.id = 1001
GROUP BY
    o.id,
    o.total_amount;


/*
RESULTADO ESPERADO:

stored_total
    =
calculated_total
*/


-- ==========================================================
-- TESTE 5
-- Encontrar divergência no total
-- ==========================================================

SELECT
    o.id AS order_id,
    o.total_amount AS stored_total,
    SUM(oi.quantity * oi.unit_price) AS calculated_total
FROM orders o
INNER JOIN order_items oi
    ON o.id = oi.order_id
WHERE o.id = 1001
GROUP BY
    o.id,
    o.total_amount
HAVING o.total_amount <>
       SUM(oi.quantity * oi.unit_price);


/*
RESULTADO ESPERADO:

0 registros.

Se houver resultado, existe uma divergência entre
o total armazenado e o total calculado.
*/


-- ==========================================================
-- TESTE 6
-- Validar pagamento
-- ==========================================================

SELECT
    o.id AS order_id,
    o.total_amount,
    p.id AS payment_id,
    p.amount AS payment_amount,
    p.status AS payment_status
FROM orders o
INNER JOIN payments p
    ON o.id = p.order_id
WHERE o.id = 1001;


/*
RESULTADO ESPERADO:

O pedido deve possuir um pagamento correspondente.

O valor e o status devem estar de acordo com
as regras definidas para o sistema.
*/


-- ==========================================================
-- TESTE 7
-- Verificar estoque dos produtos
-- ==========================================================

SELECT
    p.id,
    p.name,
    p.stock_quantity
FROM products p
INNER JOIN order_items oi
    ON p.id = oi.product_id
WHERE oi.order_id = 1001;


/*
RESULTADO ESPERADO:

O estoque deve refletir a compra realizada,
de acordo com a regra de atualização do sistema.
*/


-- ==========================================================
-- TESTE 8
-- Verificar estoque negativo
-- ==========================================================

SELECT
    p.id,
    p.name,
    p.stock_quantity
FROM products p
INNER JOIN order_items oi
    ON p.id = oi.product_id
WHERE oi.order_id = 1001
  AND p.stock_quantity < 0;


/*
RESULTADO ESPERADO:

0 registros.

Nenhum produto relacionado ao pedido deve possuir
estoque negativo.
*/


-- ==========================================================
-- TESTE 9
-- Verificar relacionamento do pedido
-- ==========================================================

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

customer_exists não deve ser NULL.

O pedido deve possuir um cliente válido.
*/


-- ==========================================================
-- TESTE 10
-- CONSULTA CONSOLIDADA
-- ==========================================================

SELECT
    c.name AS customer_name,
    c.email,
    o.id AS order_id,
    o.status AS order_status,
    p.name AS product_name,
    oi.quantity,
    oi.unit_price,
    oi.quantity * oi.unit_price AS item_total,
    o.total_amount
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

A consulta deve permitir visualizar:

Cliente
   ↓
Pedido
   ↓
Produto
   ↓
Quantidade
   ↓
Preço
   ↓
Valor do item
   ↓
Total do pedido
*/


-- ==========================================================
-- FLUXO DE VALIDAÇÃO
-- ==========================================================

/*
CHECKLIST

[ ] Pedido criado
[ ] Cliente correto
[ ] Produtos corretos
[ ] Quantidades corretas
[ ] Preços corretos
[ ] Total correto
[ ] Pagamento registrado
[ ] Status do pagamento correto
[ ] Estoque atualizado
[ ] Nenhum estoque negativo
[ ] Relacionamentos válidos


O objetivo deste cenário é demonstrar que o QA pode
validar o resultado de uma operação em diferentes
camadas:

        APLICAÇÃO
            ↓
           API
            ↓
        DATABASE

A validação no banco complementa, e não substitui,
a validação realizada pela interface e pela API.
*/
```
