# /*

# 05 - HAVING

## OBJETIVO

Aprender a filtrar grupos de registros utilizando HAVING.

## EXPLICAÇÃO

HAVING é utilizado para filtrar resultados após a aplicação
de GROUP BY e funções de agregação.

Diferença importante:

WHERE
Filtra registros antes do agrupamento.

HAVING
Filtra grupos depois do agrupamento.

Exemplo:

HAVING COUNT(*) > 5

Retorna somente grupos que possuem mais de cinco registros.

## USO EM QA

HAVING é útil para identificar grupos que violam
determinadas condições.

Exemplos:

* Clientes com muitos pedidos;
* Categorias com poucos produtos;
* E-mails duplicados;
* Clientes com mais de um cadastro;
* Grupos com valores acima de determinado limite.

## RESULTADO ESPERADO

Somente os grupos que atenderem à condição definida
no HAVING devem ser retornados.
===============================

*/

-- ==========================================================
-- EXEMPLO 1
-- Categorias com mais de 5 produtos
-- ==========================================================

SELECT
category,
COUNT(*) AS total_products
FROM products
GROUP BY category
HAVING COUNT(*) > 5;

/*
RESULTADO ESPERADO:

Somente categorias que possuem mais de 5 produtos
devem aparecer.
*/

-- ==========================================================
-- EXEMPLO 2
-- Estados com mais de 10 clientes
-- ==========================================================

SELECT
state,
COUNT(*) AS total_customers
FROM customers
GROUP BY state
HAVING COUNT(*) > 10;

/*
RESULTADO ESPERADO:

Somente estados com mais de 10 clientes cadastrados
devem aparecer.
*/

-- ==========================================================
-- EXEMPLO 3
-- Clientes com mais de 3 pedidos
-- ==========================================================

SELECT
customer_id,
COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 3;

/*
RESULTADO ESPERADO:

Devem ser retornados somente clientes que possuem
mais de 3 pedidos.
*/

-- ==========================================================
-- EXEMPLO 4
-- Possíveis e-mails duplicados
-- ==========================================================

SELECT
email,
COUNT(*) AS occurrences
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

/*
RESULTADO ESPERADO:

O resultado esperado normalmente é:

0 registros.

Se forem encontrados registros, significa que existem
e-mails cadastrados mais de uma vez.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O sistema possui uma regra que determina que o e-mail
de um cliente deve ser único.

O QA deseja identificar possíveis duplicidades.
*/

SELECT
email,
COUNT(*) AS occurrences
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

/*
RESULTADO ESPERADO:

Nenhum registro deve ser retornado.

Caso apareçam resultados como:

| email                                     | occurrences |
| ----------------------------------------- | ----------- |
| [joao@email.com](mailto:joao@email.com)   | 2           |
| [maria@email.com](mailto:maria@email.com) | 3           |

existem possíveis violações da regra de unicidade.

O QA deve investigar se:

* A aplicação permitiu o cadastro duplicado;
* O banco possui uma restrição UNIQUE;
* Os registros são realmente de clientes diferentes;
* Existe algum problema no processo de cadastro.
  */

-- ==========================================================
-- WHERE + GROUP BY + HAVING
-- ==========================================================

/*
É possível utilizar WHERE antes do agrupamento
e HAVING depois do agrupamento.

Exemplo:

Encontrar clientes ativos que possuem mais de
2 pedidos.
*/

SELECT
o.customer_id,
COUNT(*) AS total_orders
FROM orders o
JOIN customers c
ON c.id = o.customer_id
WHERE c.status = 'ACTIVE'
GROUP BY o.customer_id
HAVING COUNT(*) > 2;

/*
RESULTADO ESPERADO:

Somente clientes ACTIVE que possuem mais de
2 pedidos devem ser retornados.

Esse tipo de consulta é bastante útil para análise
e validação de regras de negócio.
*/
