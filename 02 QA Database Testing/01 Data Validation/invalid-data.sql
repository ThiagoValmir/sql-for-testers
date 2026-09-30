# /*

# INVALID DATA

## OBJETIVO

Identificar dados que não obedecem às regras esperadas
pela aplicação ou pelo negócio.

## EXPLICAÇÃO

Dados inválidos são valores que existem no banco, mas
não deveriam existir de acordo com as regras definidas.

Exemplos:

* Preço negativo;
* Estoque negativo;
* Status inexistente;
* Quantidade igual a zero;
* Data futura quando não permitida;
* E-mail em formato incorreto;
* Valores fora de uma faixa permitida.

## USO EM QA

Pode ser utilizado para:

* Validar regras de negócio;
* Investigar bugs;
* Validar dados após operações;
* Testar integridade;
* Investigar problemas de integração.

## RESULTADO ESPERADO

Quando a regra proíbe determinado valor, a consulta
deve retornar 0 registros.
==========================

*/

-- ==========================================================
-- EXEMPLO 1
-- Produtos com preço negativo
-- ==========================================================

SELECT
id,
name,
price
FROM products
WHERE price < 0;

/*
RESULTADO ESPERADO:

0 registros.

Um produto não deveria possuir preço negativo.
*/

-- ==========================================================
-- EXEMPLO 2
-- Produtos com estoque negativo
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

Estoque negativo pode indicar erro de processamento,
concorrência ou falha na regra de negócio.
*/

-- ==========================================================
-- EXEMPLO 3
-- Status inválido
-- ==========================================================

SELECT
id,
name,
status
FROM products
WHERE status NOT IN (
'ACTIVE',
'INACTIVE',
'OUT_OF_STOCK'
);

/*
RESULTADO ESPERADO:

0 registros.

Somente os status definidos pela regra devem existir.
*/

-- ==========================================================
-- EXEMPLO 4
-- Quantidade inválida em pedido
-- ==========================================================

SELECT
id,
order_id,
product_id,
quantity
FROM order_items
WHERE quantity <= 0;

/*
RESULTADO ESPERADO:

0 registros.

Um item de pedido deve possuir quantidade positiva.
*/

-- ==========================================================
-- EXEMPLO 5
-- Valor unitário negativo
-- ==========================================================

SELECT
id,
order_id,
product_id,
unit_price
FROM order_items
WHERE unit_price < 0;

/*
RESULTADO ESPERADO:

0 registros.
*/

-- ==========================================================
-- EXEMPLO 6
-- Pedido com valor total negativo
-- ==========================================================

SELECT
id,
total_amount
FROM orders
WHERE total_amount < 0;

/*
RESULTADO ESPERADO:

0 registros.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

Após executar um teste de checkout, o QA deseja
garantir que nenhum pedido tenha sido criado com
valores inválidos.
*/

SELECT
id,
total_amount,
status
FROM orders
WHERE total_amount < 0
OR status NOT IN (
'PENDING',
'PAID',
'SHIPPED',
'COMPLETED',
'CANCELLED'
);

/*
RESULTADO ESPERADO:

0 registros.

Qualquer registro retornado representa uma possível
violação de regra de negócio e deve ser investigado.
*/

-- ==========================================================
-- INVESTIGAÇÃO DE DATAS
-- ==========================================================

/*
Exemplo:

Identificar pedidos com data inválida em relação
à data de criação.

*/

SELECT
id,
order_date,
created_at
FROM orders
WHERE order_date < created_at;

/*
RESULTADO ESPERADO:

Depende da regra do sistema.

Se order_date não puder ser anterior à criação
do registro:

0 registros.
*/
