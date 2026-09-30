# /*

# 03 - ORDER BY

## OBJETIVO

Aprender a ordenar os resultados de uma consulta.

## EXPLICAÇÃO

ORDER BY permite definir a ordem em que os registros
serão apresentados.

ASC
Ordem crescente.

DESC
Ordem decrescente.

ASC é o comportamento padrão quando nenhuma direção
é especificada.

## USO EM QA

A ordenação pode facilitar análises e investigações.

Exemplos:

* Encontrar produtos com menor estoque;
* Encontrar produtos mais caros;
* Visualizar registros mais recentes;
* Organizar resultados por nome.

## RESULTADO ESPERADO

Os mesmos registros devem ser retornados, porém organizados
de acordo com a coluna e direção especificadas.
===============================================

*/

-- ==========================================================
-- EXEMPLO 1
-- Clientes em ordem alfabética
-- ==========================================================

SELECT
id,
name,
email
FROM customers
ORDER BY name ASC;

/*
RESULTADO ESPERADO:

Os clientes devem ser apresentados em ordem alfabética
pelo nome.
*/

-- ==========================================================
-- EXEMPLO 2
-- Produtos do mais barato para o mais caro
-- ==========================================================

SELECT
id,
name,
price
FROM products
ORDER BY price ASC;

/*
RESULTADO ESPERADO:

Os produtos devem aparecer começando pelo menor preço.
*/

-- ==========================================================
-- EXEMPLO 3
-- Produtos do mais caro para o mais barato
-- ==========================================================

SELECT
id,
name,
price
FROM products
ORDER BY price DESC;

/*
RESULTADO ESPERADO:

Os produtos devem aparecer começando pelo maior preço.
*/

-- ==========================================================
-- EXEMPLO 4
-- Produtos com menor estoque
-- ==========================================================

SELECT
id,
name,
stock_quantity
FROM products
ORDER BY stock_quantity ASC;

/*
RESULTADO ESPERADO:

Os produtos devem ser apresentados do menor estoque
para o maior.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O QA deseja investigar produtos que estão próximos
de ficar sem estoque.

*/

SELECT
id,
name,
stock_quantity
FROM products
WHERE stock_quantity >= 0
ORDER BY stock_quantity ASC;

/*
RESULTADO ESPERADO:

Os produtos com menor quantidade em estoque devem aparecer
primeiro, facilitando a identificação de possíveis
problemas relacionados ao estoque.
*/
