# /*

# 06 - CASE

## OBJETIVO

Aprender a utilizar CASE para criar condições dentro
de consultas SQL.

## EXPLICAÇÃO

CASE permite executar uma lógica condicional.

A estrutura básica é:

CASE
WHEN condição THEN resultado
WHEN condição THEN resultado
ELSE resultado
END

É semelhante à ideia:

SE condição
faça X
SENÃO SE condição
faça Y
SENÃO
faça Z

## USO EM QA

CASE pode ser utilizado para:

* Classificar registros;
* Criar categorias;
* Identificar situações de teste;
* Validar regras de negócio;
* Facilitar análises;
* Transformar dados em informações mais fáceis
  de interpretar.

## RESULTADO ESPERADO

Cada registro deve receber a classificação
correspondente à condição que atender.
======================================

*/

-- ==========================================================
-- EXEMPLO 1
-- Classificar estoque
-- ==========================================================

SELECT
id,
name,
stock_quantity,
CASE
WHEN stock_quantity = 0 THEN 'OUT_OF_STOCK'
WHEN stock_quantity < 10 THEN 'LOW_STOCK'
ELSE 'IN_STOCK'
END AS stock_status
FROM products;

/*
RESULTADO ESPERADO:

Produtos serão classificados como:

0 unidades
→ OUT_OF_STOCK

1 até 9 unidades
→ LOW_STOCK

10 ou mais unidades
→ IN_STOCK
*/

-- ==========================================================
-- EXEMPLO 2
-- Classificar preço
-- ==========================================================

SELECT
id,
name,
price,
CASE
WHEN price < 100 THEN 'LOW_PRICE'
WHEN price BETWEEN 100 AND 500 THEN 'MEDIUM_PRICE'
ELSE 'HIGH_PRICE'
END AS price_category
FROM products;

/*
RESULTADO ESPERADO:

Cada produto deve receber uma categoria de preço
de acordo com seu valor.
*/

-- ==========================================================
-- EXEMPLO 3
-- Classificar pedidos
-- ==========================================================

SELECT
id,
total_amount,
status,
CASE
WHEN status = 'COMPLETED' THEN 'SUCCESS'
WHEN status = 'CANCELLED' THEN 'FAILED'
ELSE 'IN_PROGRESS'
END AS test_category
FROM orders;

/*
RESULTADO ESPERADO:

COMPLETED
→ SUCCESS

CANCELLED
→ FAILED

Outros status
→ IN_PROGRESS
*/

-- ==========================================================
-- EXEMPLO 4
-- Identificar situação de estoque
-- ==========================================================

SELECT
id,
name,
stock_quantity,
CASE
WHEN stock_quantity = 0 THEN 'REQUIRES_RESTOCK'
WHEN stock_quantity < 5 THEN 'ATTENTION'
ELSE 'NORMAL'
END AS inventory_condition
FROM products;

/*
RESULTADO ESPERADO:

O resultado deve indicar quais produtos:

* Precisam de reposição;
* Precisam de atenção;
* Estão em situação normal.
  */

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O requisito define:

* Estoque 0 → produto indisponível;
* Estoque de 1 a 4 → estoque baixo;
* Estoque >= 5 → estoque normal.

O QA pode reproduzir essa regra diretamente no banco.
*/

SELECT
id,
name,
stock_quantity,
CASE
WHEN stock_quantity = 0 THEN 'UNAVAILABLE'
WHEN stock_quantity BETWEEN 1 AND 4 THEN 'LOW_STOCK'
ELSE 'NORMAL'
END AS expected_status
FROM products;

/*
RESULTADO ESPERADO:

A coluna expected_status representa o resultado esperado
de acordo com a regra de negócio.

Esse resultado pode ser comparado com o status apresentado
pela aplicação.

*/

-- ==========================================================
-- INVESTIGAÇÃO DE BUG
-- ==========================================================

/*
CENÁRIO:

A aplicação deveria classificar automaticamente
os produtos de acordo com o estoque.

O banco pode ser utilizado para encontrar produtos
que estejam com uma classificação incorreta.

*/

SELECT
id,
name,
stock_quantity,
status,
CASE
WHEN stock_quantity = 0 THEN 'UNAVAILABLE'
WHEN stock_quantity BETWEEN 1 AND 4 THEN 'LOW_STOCK'
ELSE 'NORMAL'
END AS expected_status
FROM products;

/*
RESULTADO ESPERADO:

O QA pode comparar:

status
VS
expected_status

Se forem diferentes, existe uma possível inconsistência
entre o estado armazenado e a regra de negócio esperada.
*/
