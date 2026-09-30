# /*

# 02 - WHERE

## OBJETIVO

Aprender a filtrar registros utilizando a cláusula WHERE.

## EXPLICAÇÃO

WHERE permite especificar uma condição que deve ser
atendida pelos registros retornados.

Operadores comuns:

=

>

<

> =
> <=
> <>
> AND
> OR

## USO EM QA

WHERE é muito utilizado para localizar registros específicos
durante uma investigação.

Por exemplo:

* Encontrar um usuário específico;
* Localizar um pedido;
* Encontrar produtos com determinado preço;
* Identificar registros com determinado status.

## RESULTADO ESPERADO

Somente os registros que atenderem à condição definida
devem ser retornados.
=====================

*/

-- ==========================================================
-- EXEMPLO 1
-- Buscar cliente pelo ID
-- ==========================================================

SELECT *
FROM customers
WHERE id = 1;

/*
RESULTADO ESPERADO:

Somente o cliente cujo ID seja igual a 1 deve ser retornado.
*/

-- ==========================================================
-- EXEMPLO 2
-- Buscar clientes de uma cidade
-- ==========================================================

SELECT
id,
name,
city
FROM customers
WHERE city = 'Florianópolis';

/*
RESULTADO ESPERADO:

Devem ser retornados somente os clientes cuja cidade
seja Florianópolis.
*/

-- ==========================================================
-- EXEMPLO 3
-- Produtos com preço superior a R$ 1.000
-- ==========================================================

SELECT
id,
name,
price
FROM products
WHERE price > 1000;

/*
RESULTADO ESPERADO:

Somente produtos com preço superior a R$ 1.000 devem
ser retornados.
*/

-- ==========================================================
-- EXEMPLO 4
-- Utilizando AND
-- ==========================================================

SELECT
id,
name,
price,
stock_quantity
FROM products
WHERE price > 100
AND stock_quantity > 0;

/*
RESULTADO ESPERADO:

Devem ser retornados somente produtos que:

* Possuam preço superior a R$ 100;
* Possuam estoque maior que zero.
  */

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O requisito informa que somente produtos ativos devem
estar disponíveis para compra.

O QA pode verificar quais produtos estão inativos.
*/

SELECT
id,
name,
status
FROM products
WHERE status = 'INACTIVE';

/*
RESULTADO ESPERADO:

A consulta deve retornar somente produtos com status
INACTIVE.

O QA pode utilizar esse resultado para verificar se
produtos inativos estão sendo tratados corretamente
pela aplicação.
*/
