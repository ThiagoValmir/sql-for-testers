# /*

# 03 - ANY

## OBJETIVO

Aprender a utilizar ANY para comparar um valor com
qualquer valor retornado por uma subquery.

## EXPLICAÇÃO

ANY significa que a condição precisa ser verdadeira
para pelo menos UM dos valores retornados pela subquery.

Exemplo:

```
price > ANY (...)
```

Significa:

"O preço é maior que pelo menos um dos valores retornados?"

## IMPORTANTE

ANY é diferente de ALL.

ANY:
basta uma correspondência.

ALL:
todos os valores precisam satisfazer a condição.

## USO EM QA

ANY pode ser utilizado para:

* Comparar valores;
* Investigar limites;
* Validar regras;
* Comparar produtos;
* Analisar dados relacionados.

## RESULTADO ESPERADO

Devem ser retornados somente registros que satisfaçam
a condição em relação a pelo menos um dos valores
retornados pela subquery.
=========================

*/

-- ==========================================================
-- EXEMPLO 1
-- Produtos mais caros que algum produto da categoria
-- Notebook
-- ==========================================================

SELECT
id,
name,
price
FROM products
WHERE price > ANY (
SELECT price
FROM products
WHERE category = 'Notebook'
);

/*
RESULTADO ESPERADO:

Devem ser retornados produtos cujo preço seja maior
que pelo menos um dos preços dos notebooks.
*/

-- ==========================================================
-- EXEMPLO 2
-- Produtos mais baratos que algum produto
-- da categoria Monitor
-- ==========================================================

SELECT
id,
name,
price
FROM products
WHERE price < ANY (
SELECT price
FROM products
WHERE category = 'Monitor'
);

/*
RESULTADO ESPERADO:

Devem ser retornados produtos cujo preço seja menor
que pelo menos um preço encontrado entre os monitores.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O QA deseja identificar produtos cujo preço esteja
acima de pelo menos um produto de uma determinada
categoria.

Isso pode ser utilizado para investigar se uma regra
de classificação ou promoção está sendo aplicada
corretamente.
*/

SELECT
id,
name,
price
FROM products
WHERE price > ANY (
SELECT price
FROM products
WHERE category = 'Notebook'
);

/*
RESULTADO ESPERADO:

Somente produtos que sejam mais caros que pelo menos
um notebook devem ser retornados.
*/
