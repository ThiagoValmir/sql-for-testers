```sql
/*
============================================================
BUSINESS RULE - STOCK VALIDATION
============================================================

OBJETIVO
--------
Validar regras relacionadas ao estoque dos produtos.

EXPLICAÇÃO
----------
Em um e-commerce, o estoque deve refletir corretamente
as operações realizadas pelos usuários.

Exemplo:

Estoque inicial:
    10 unidades

Compra:
    3 unidades

Estoque esperado:
    7 unidades

Uma inconsistência pode ocorrer quando:

- O estoque fica negativo;
- A quantidade comprada não é validada;
- O estoque não é atualizado;
- O estoque é atualizado mais de uma vez;
- Dois processos alteram o mesmo estoque incorretamente.

USO EM QA
---------
Pode ser utilizado para:

- Testar checkout;
- Validar baixa de estoque;
- Testar compras;
- Investigar estoque negativo;
- Investigar problemas de concorrência;
- Validar regras de disponibilidade.

RESULTADO ESPERADO
------------------
Nenhum produto deve possuir estoque negativo.

Quando a regra estiver sendo respeitada:

0 registros.
============================================================
*/


-- ==========================================================
-- EXEMPLO 1
-- Encontrar estoque negativo
-- ==========================================================

SELECT
    id,
    name,
    stock_quantity
FROM products
WHERE stock_quantity < 0;


/*
RESULTADO ESPERADO:

0 registros.

Um produto não deve possuir estoque negativo.
*/


-- ==========================================================
-- EXEMPLO 2
-- Produtos sem estoque
-- ==========================================================

SELECT
    id,
    name,
    stock_quantity
FROM products
WHERE stock_quantity = 0;


/*
RESULTADO ESPERADO:

Devem ser apresentados os produtos sem estoque.

Esses produtos normalmente não devem permitir
novas compras, dependendo da regra da aplicação.
*/


-- ==========================================================
-- EXEMPLO 3
-- Produtos disponíveis
-- ==========================================================

SELECT
    id,
    name,
    stock_quantity
FROM products
WHERE stock_quantity > 0;


/*
RESULTADO ESPERADO:

Somente produtos com pelo menos uma unidade disponível.
*/


-- ==========================================================
-- EXEMPLO 4
-- Verificar quantidade comprada
-- ==========================================================

SELECT
    oi.order_id,
    oi.product_id,
    p.name,
    oi.quantity,
    p.stock_quantity
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.id
WHERE oi.order_id = 1001;


/*
RESULTADO ESPERADO:

A quantidade comprada deve ser compatível com
a regra de estoque definida pelo sistema.
*/


-- ==========================================================
-- CENÁRIO DE TESTE
-- ==========================================================

/*
DADOS INICIAIS

Produto:
    ID = 10

Estoque inicial:
    10 unidades

Compra:
    3 unidades

ESTOQUE ESPERADO:

10 - 3 = 7
*/

SELECT
    id,
    name,
    stock_quantity
FROM products
WHERE id = 10;


/*
RESULTADO ESPERADO:

stock_quantity = 7
*/


-- ==========================================================
-- CENÁRIO NEGATIVO
-- ==========================================================

/*
ESTOQUE INICIAL:

2 unidades

O usuário tenta comprar:

5 unidades

Dependendo da regra do sistema, a compra deve ser
bloqueada.

O QA pode verificar se o produto ficou com estoque
negativo após a tentativa.
*/

SELECT
    id,
    name,
    stock_quantity
FROM products
WHERE id = 10;


/*
RESULTADO ESPERADO:

stock_quantity >= 0


Se o resultado for:

stock_quantity < 0

existe uma possível violação da regra de negócio.
*/


-- ==========================================================
-- VALIDAÇÃO GERAL
-- ==========================================================

SELECT
    id,
    name,
    stock_quantity
FROM products
WHERE stock_quantity < 0;


/*
RESULTADO ESPERADO:

0 registros.

Essa é uma consulta simples que pode ser utilizada
como uma validação geral de integridade do estoque.
*/
```
