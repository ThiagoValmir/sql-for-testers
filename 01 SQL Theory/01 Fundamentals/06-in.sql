# /*

# 06 - IN

## OBJETIVO

Aprender a utilizar IN para filtrar registros que possuem
um valor dentro de uma lista específica.

## EXPLICAÇÃO

IN permite verificar se um valor corresponde a qualquer
um dos valores informados.

Por exemplo:

WHERE city IN ('Florianópolis', 'São José')

é equivalente a:

WHERE city = 'Florianópolis'
OR city = 'São José'

## USO EM QA

IN é útil quando precisamos testar vários valores
possíveis de uma determinada regra.

Exemplos:

* Status;
* Cidades;
* Categorias;
* Tipos de pagamento;
* IDs;
* Estados.

## RESULTADO ESPERADO

Somente os registros cujo valor esteja presente na lista
informada devem ser retornados.
===============================

*/

-- ==========================================================
-- EXEMPLO 1
-- Clientes de cidades específicas
-- ==========================================================

SELECT
id,
name,
city
FROM customers
WHERE city IN ('Florianópolis', 'São José');

/*
RESULTADO ESPERADO:

Devem aparecer somente clientes de:

Florianópolis
São José
*/

-- ==========================================================
-- EXEMPLO 2
-- Produtos de determinadas categorias
-- ==========================================================

SELECT
id,
name,
category
FROM products
WHERE category IN (
'Notebook',
'Monitor',
'Periféricos'
);

/*
RESULTADO ESPERADO:

Somente produtos pertencentes às categorias informadas
devem aparecer.
*/

-- ==========================================================
-- EXEMPLO 3
-- Buscar clientes por IDs
-- ==========================================================

SELECT
id,
name,
email
FROM customers
WHERE id IN (1, 5, 10);

/*
RESULTADO ESPERADO:

Devem ser retornados somente os clientes com IDs:

1
5
10
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O sistema possui diferentes status de clientes.

O QA deseja validar clientes que estejam em qualquer
um dos status considerados ativos.
*/

SELECT
id,
name,
status
FROM customers
WHERE status IN ('ACTIVE', 'PREMIUM');

/*
RESULTADO ESPERADO:

Somente clientes com status ACTIVE ou PREMIUM devem
ser retornados.

Esse tipo de consulta pode ser utilizado para validar
regras que envolvem múltiplos valores permitidos.
*/
