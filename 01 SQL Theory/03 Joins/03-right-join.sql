# /*

# 03 - RIGHT JOIN

## OBJETIVO

Aprender a utilizar RIGHT JOIN para preservar todos os
registros da tabela da direita.

## EXPLICAÇÃO

RIGHT JOIN funciona de maneira semelhante ao LEFT JOIN,
porém a tabela da direita é preservada.

Exemplo:

customers
RIGHT JOIN
orders

Todos os pedidos serão mantidos no resultado.

Se um pedido não possuir um cliente correspondente,
as informações de customers serão NULL.

## USO EM QA

RIGHT JOIN pode ser utilizado para:

* Encontrar registros sem correspondência;
* Validar relacionamentos;
* Investigar registros órfãos;
* Comparar dados entre tabelas.

## OBSERVAÇÃO

Na prática, LEFT JOIN costuma ser mais utilizado.

Muitas consultas que utilizam RIGHT JOIN podem ser
reescritas utilizando LEFT JOIN simplesmente invertendo
a ordem das tabelas.

## RESULTADO ESPERADO

Todos os registros da tabela da direita devem aparecer.

Quando não houver correspondência na tabela da esquerda,
as colunas da esquerda devem apresentar NULL.
=============================================

*/

-- ==========================================================
-- EXEMPLO 1
-- Todos os pedidos e seus clientes
-- ==========================================================

SELECT
c.id AS customer_id,
c.name AS customer_name,
o.id AS order_id,
o.total_amount
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id;

/*
RESULTADO ESPERADO:

Todos os pedidos devem aparecer.

Quando existir um pedido sem cliente correspondente,
as colunas relacionadas ao cliente apresentarão NULL.
*/

-- ==========================================================
-- EXEMPLO 2
-- Encontrar pedidos sem cliente
-- ==========================================================

SELECT
c.id AS customer_id,
c.name AS customer_name,
o.id AS order_id
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL;

/*
RESULTADO ESPERADO:

Devem ser retornados somente pedidos que não possuem
um cliente correspondente.
*/

-- ==========================================================
-- COMPARAÇÃO COM LEFT JOIN
-- ==========================================================

/*
A consulta acima pode ser escrita com LEFT JOIN:

*/

SELECT
c.id AS customer_id,
c.name AS customer_name,
o.id AS order_id
FROM orders o
LEFT JOIN customers c
ON o.customer_id = c.id
WHERE c.id IS NULL;

/*
As duas consultas possuem a mesma finalidade.

A versão com LEFT JOIN costuma ser preferida porque
a tabela principal da análise aparece primeiro.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O sistema não deveria permitir pedidos sem cliente.

O QA deseja encontrar possíveis pedidos órfãos.
*/

SELECT
o.id AS order_id,
o.customer_id
FROM customers c
RIGHT JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL;

/*
RESULTADO ESPERADO:

0 registros.

Qualquer resultado representa um pedido cujo
customer_id não possui um cliente correspondente.
*/
