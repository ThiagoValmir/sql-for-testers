# /*

# 08 - NULL

## OBJETIVO

Aprender a identificar valores NULL no banco de dados.

## EXPLICAÇÃO

NULL representa ausência de informação.

NULL não significa:

0
''
FALSE

É importante diferenciar NULL de um valor vazio ou zero.

Para verificar NULL utilizamos:

IS NULL

Para verificar valores que NÃO são NULL:

IS NOT NULL

IMPORTANTE:

Não devemos utilizar:

WHERE column = NULL

ou:

WHERE column <> NULL

para verificar valores nulos.

## USO EM QA

A identificação de NULL é muito importante para verificar
a qualidade dos dados.

Pode ser utilizada para encontrar:

* Clientes sem e-mail;
* Produtos sem categoria;
* Pedidos sem cliente;
* Registros incompletos;
* Dados obrigatórios que não foram armazenados.

## RESULTADO ESPERADO

Quando estivermos validando um campo obrigatório,
o resultado esperado normalmente será zero registros
com valor NULL.
===============

*/

-- ==========================================================
-- EXEMPLO 1
-- Clientes sem CPF
-- ==========================================================

SELECT
id,
name,
cpf
FROM customers
WHERE cpf IS NULL;

/*
RESULTADO ESPERADO:

Devem ser retornados somente clientes que não possuem
CPF armazenado.
*/

-- ==========================================================
-- EXEMPLO 2
-- Clientes com CPF
-- ==========================================================

SELECT
id,
name,
cpf
FROM customers
WHERE cpf IS NOT NULL;

/*
RESULTADO ESPERADO:

Devem ser retornados somente clientes que possuem
CPF armazenado.
*/

-- ==========================================================
-- EXEMPLO 3
-- Produtos sem categoria
-- ==========================================================

SELECT
id,
name,
category
FROM products
WHERE category IS NULL;

/*
RESULTADO ESPERADO:

Devem ser retornados produtos que não possuem
categoria informada.
*/

-- ==========================================================
-- EXEMPLO 4
-- Produtos sem estoque informado
-- ==========================================================

SELECT
id,
name,
stock_quantity
FROM products
WHERE stock_quantity IS NULL;

/*
RESULTADO ESPERADO:

Devem ser retornados somente produtos cujo estoque
não esteja informado.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O requisito determina que todo cliente deve possuir
um endereço de e-mail.

O QA deseja verificar se existem clientes sem e-mail.
*/

SELECT
id,
name,
email
FROM customers
WHERE email IS NULL;

/*
RESULTADO ESPERADO:

0 registros.

Caso algum cliente seja retornado, existe um registro
sem e-mail e o QA deve investigar se:

* O campo deveria ser obrigatório;
* A aplicação permitiu o cadastro incompleto;
* O banco deveria possuir uma restrição NOT NULL;
* Existe algum problema no processo de cadastro.
  */

-- ==========================================================
-- OUTRO EXEMPLO DE VALIDAÇÃO
-- ==========================================================

/*
Regra:

Todo produto ACTIVE deve possuir estoque informado.
*/

SELECT
id,
name,
stock_quantity,
status
FROM products
WHERE status = 'ACTIVE'
AND stock_quantity IS NULL;

/*
RESULTADO ESPERADO:

0 registros.

Qualquer resultado pode indicar uma inconsistência
nos dados ou uma falha na regra de negócio.
*/
