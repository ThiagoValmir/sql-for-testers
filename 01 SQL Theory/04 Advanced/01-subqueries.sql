# /*

# 01 - SUBQUERIES

## OBJETIVO

Aprender a utilizar uma consulta SQL dentro de outra consulta.

## EXPLICAÇÃO

Uma subquery é uma consulta SQL executada dentro de outra
consulta.

Ela pode ser utilizada para obter um valor ou conjunto
de valores que será utilizado pela consulta principal.

Exemplo:

Encontrar produtos com preço acima da média.

Primeiro precisamos descobrir a média:

```
SELECT AVG(price)
FROM products
```

Depois utilizamos esse resultado na consulta principal.

## USO EM QA

Subqueries podem ser utilizadas para:

* Comparar valores com médias;
* Encontrar registros acima ou abaixo de um limite;
* Validar regras de negócio;
* Investigar inconsistências;
* Criar consultas de validação mais complexas.

## RESULTADO ESPERADO

A consulta principal deve utilizar corretamente o resultado
da subquery para filtrar ou analisar os registros.
==================================================

*/

-- ==========================================================
-- EXEMPLO 1
-- Produtos acima do preço médio
-- ==========================================================

SELECT
id,
name,
price
FROM products
WHERE price > (
SELECT AVG(price)
FROM products
);

/*
RESULTADO ESPERADO:

Somente produtos cujo preço seja superior à média
de preços de todos os produtos.
*/

-- ==========================================================
-- EXEMPLO 2
-- Produtos abaixo do preço médio
-- ==========================================================

SELECT
id,
name,
price
FROM products
WHERE price < (
SELECT AVG(price)
FROM products
);

/*
RESULTADO ESPERADO:

Somente produtos cujo preço seja inferior à média.
*/

-- ==========================================================
-- EXEMPLO 3
-- Clientes que possuem mais pedidos que a média
-- ==========================================================

SELECT
customer_id,
COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > (
SELECT AVG(order_count)
FROM (
SELECT
customer_id,
COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
) AS customer_orders
);

/*
RESULTADO ESPERADO:

Devem ser retornados clientes cujo número de pedidos
seja superior à média de pedidos por cliente.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O requisito determina que produtos acima do preço médio
devem receber uma determinada classificação.

O QA pode identificar esses produtos diretamente no banco.
*/

SELECT
id,
name,
price
FROM products
WHERE price > (
SELECT AVG(price)
FROM products
);

/*
RESULTADO ESPERADO:

Todos os produtos retornados devem possuir preço
superior à média calculada.

O resultado pode ser comparado com a classificação
apresentada pela aplicação.
*/
