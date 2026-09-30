# /*

# 04 - ALL

## OBJETIVO

Aprender a utilizar ALL para comparar um valor com
todos os valores retornados por uma subquery.

## EXPLICAÇÃO

ALL significa que a condição precisa ser verdadeira
para TODOS os valores retornados pela subquery.

Exemplo:

```
price > ALL (...)
```

Significa:

"O preço é maior que todos os valores retornados?"

## USO EM QA

ALL pode ser utilizado para:

* Validar valores acima de todos os registros de um grupo;
* Comparar limites;
* Validar regras de negócio;
* Investigar valores extremos;
* Comparar produtos.

## RESULTADO ESPERADO

Somente registros que satisfaçam a condição em relação
a TODOS os valores retornados pela subquery devem
ser apresentados.
=================

*/

-- ==========================================================
-- EXEMPLO 1
-- Produtos mais caros que todos os notebooks
-- ==========================================================

SELECT
id,
name,
price
FROM products
WHERE price > ALL (
SELECT price
FROM products
WHERE category = 'Notebook'
);

/*
RESULTADO ESPERADO:

Somente produtos cujo preço seja maior que o preço
de TODOS os notebooks encontrados na subquery.
*/

-- ==========================================================
-- EXEMPLO 2
-- Produtos mais baratos que todos os monitores
-- ==========================================================

SELECT
id,
name,
price
FROM products
WHERE price < ALL (
SELECT price
FROM products
WHERE category = 'Monitor'
);

/*
RESULTADO ESPERADO:

Somente produtos cujo preço seja menor que o preço
de todos os monitores.
*/

-- ==========================================================
-- ANY x ALL
-- ==========================================================

/*
ANY:

```
price > ANY (...)
```

O produto precisa ser mais caro que pelo menos um
dos valores.

ALL:

```
price > ALL (...)
```

O produto precisa ser mais caro que todos os valores.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O requisito determina que determinado produto deve
possuir preço superior a todos os produtos de uma
categoria específica.

*/

SELECT
id,
name,
price
FROM products
WHERE price > ALL (
SELECT price
FROM products
WHERE category = 'Notebook'
);

/*
RESULTADO ESPERADO:

Todos os produtos retornados devem possuir preço
superior ao maior preço entre os notebooks.
*/
