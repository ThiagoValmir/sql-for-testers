# /*

# 07 - BETWEEN

## OBJETIVO

Aprender a filtrar valores que estejam dentro de
determinado intervalo.

## EXPLICAÇÃO

BETWEEN permite verificar se um valor está entre dois
limites.

Pode ser utilizado com:

* Números;
* Datas;
* Outros valores que possuam ordenação.

IMPORTANTE:

BETWEEN inclui os valores dos limites.

Exemplo:

BETWEEN 100 AND 500

inclui:

100
500

## USO EM QA

Pode ser utilizado para validar:

* Faixas de preço;
* Idades;
* Quantidades;
* Datas;
* Valores mínimos e máximos.

## RESULTADO ESPERADO

Somente valores dentro do intervalo informado devem
ser retornados.
===============

*/

-- ==========================================================
-- EXEMPLO 1
-- Produtos entre R$ 100 e R$ 500
-- ==========================================================

SELECT
id,
name,
price
FROM products
WHERE price BETWEEN 100 AND 500;

/*
RESULTADO ESPERADO:

Devem ser retornados produtos com preço:

> = 100
> e
> <= 500
> */

-- ==========================================================
-- EXEMPLO 2
-- Produtos fora do intervalo
-- ==========================================================

SELECT
id,
name,
price
FROM products
WHERE price NOT BETWEEN 100 AND 500;

/*
RESULTADO ESPERADO:

Devem ser retornados produtos cujo preço seja:

menor que 100

ou

maior que 500.
*/

-- ==========================================================
-- EXEMPLO 3
-- Clientes cadastrados em determinado período
-- ==========================================================

SELECT
id,
name,
created_at
FROM customers
WHERE created_at BETWEEN '2026-01-01' AND '2026-03-31';

/*
RESULTADO ESPERADO:

Devem ser retornados clientes cadastrados dentro
do período especificado.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O requisito determina que produtos de uma determinada
promoção devem possuir preço entre R$ 100 e R$ 500.

O QA pode verificar produtos que estão fora da regra.
*/

SELECT
id,
name,
price
FROM products
WHERE price NOT BETWEEN 100 AND 500;

/*
RESULTADO ESPERADO:

Nenhum produto deve ser retornado.

Caso sejam encontrados registros, eles devem ser
investigados porque não atendem à regra definida.
*/
