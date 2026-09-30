# /*

# 04 - FULL OUTER JOIN

## OBJETIVO

Aprender a utilizar FULL OUTER JOIN para comparar todos
os registros de duas tabelas.

## EXPLICAÇÃO

FULL OUTER JOIN retorna:

1. Registros que possuem correspondência nas duas tabelas;
2. Registros existentes somente na tabela da esquerda;
3. Registros existentes somente na tabela da direita.

Quando não existe correspondência:

* Colunas da tabela da esquerda recebem NULL;
* Ou colunas da tabela da direita recebem NULL.

## USO EM QA

FULL OUTER JOIN é especialmente útil para:

* Comparar dois conjuntos de dados;
* Encontrar registros ausentes;
* Identificar diferenças;
* Validar migrações;
* Comparar dados antes e depois de uma operação;
* Investigar inconsistências entre tabelas.

## RESULTADO ESPERADO

Todos os registros das duas tabelas devem ser considerados.

Registros sem correspondência devem apresentar NULL
no lado correspondente.
=======================

*/

-- ==========================================================
-- EXEMPLO 1
-- Comparar clientes e pedidos
-- ==========================================================

SELECT
c.id AS customer_id,
c.name,
o.id AS order_id,
o.customer_id
FROM customers c
FULL OUTER JOIN orders o
ON c.id = o.customer_id;

/*
RESULTADO ESPERADO:

O resultado deve conter:

* Clientes que possuem pedidos;
* Clientes sem pedidos;
* Pedidos sem cliente.

Quando não houver correspondência, o lado correspondente
apresentará NULL.
*/

-- ==========================================================
-- EXEMPLO 2
-- Encontrar registros sem correspondência
-- ==========================================================

SELECT
c.id AS customer_id,
c.name,
o.id AS order_id,
o.customer_id
FROM customers c
FULL OUTER JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL
OR o.id IS NULL;

/*
RESULTADO ESPERADO:

Devem ser retornados somente registros que não possuem
correspondência.

Isso inclui:

* Clientes sem pedidos;
* Pedidos sem cliente.
  */

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

Durante uma migração de dados, o QA precisa comparar
duas fontes de informação para descobrir registros
que existem em uma fonte, mas não na outra.

O mesmo conceito pode ser aplicado para comparar
duas tabelas relacionadas.
*/

SELECT
c.id AS customer_id,
c.name,
o.id AS order_id
FROM customers c
FULL OUTER JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL
OR o.id IS NULL;

/*
RESULTADO ESPERADO:

Se todos os registros deveriam possuir correspondência:

0 registros.

Caso existam resultados, eles representam diferenças
que precisam ser investigadas.
*/

/*
IMPORTANTE:

FULL OUTER JOIN é suportado pelo PostgreSQL.

No MySQL, esse JOIN não está disponível diretamente
e normalmente é simulado utilizando UNION entre
LEFT JOIN e RIGHT JOIN.
*/
