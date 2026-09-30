# /*

# 05 - LIKE

## OBJETIVO

Aprender a realizar pesquisas utilizando padrões de texto.

## EXPLICAÇÃO

LIKE permite pesquisar valores que correspondem a
determinado padrão.

Caracteres especiais:

%
Representa zero ou vários caracteres.

_
Representa exatamente um caractere.

Exemplos:

'Jo%'
Começa com "Jo".

'%Silva'
Termina com "Silva".

'%Maria%'
Contém "Maria".

## USO EM QA

LIKE pode ser utilizado para:

* Localizar usuários;
* Investigar dados;
* Encontrar produtos;
* Pesquisar e-mails;
* Identificar padrões inesperados.

## RESULTADO ESPERADO

Devem ser retornados somente os registros que correspondem
ao padrão informado.
====================

*/

-- ==========================================================
-- EXEMPLO 1
-- Nomes que começam com "Jo"
-- ==========================================================

SELECT
id,
name
FROM customers
WHERE name LIKE 'Jo%';

/*
RESULTADO ESPERADO:

Devem aparecer nomes como:

João
José
Jonas

Nomes que não começam com "Jo" não devem aparecer.
*/

-- ==========================================================
-- EXEMPLO 2
-- Nomes que terminam com "Silva"
-- ==========================================================

SELECT
id,
name
FROM customers
WHERE name LIKE '%Silva';

/*
RESULTADO ESPERADO:

Somente clientes cujo nome termina com "Silva"
devem ser retornados.
*/

-- ==========================================================
-- EXEMPLO 3
-- Produtos contendo "Notebook"
-- ==========================================================

SELECT
id,
name,
price
FROM products
WHERE name LIKE '%Notebook%';

/*
RESULTADO ESPERADO:

Devem ser retornados produtos que possuam "Notebook"
em qualquer parte do nome.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

Um usuário informa que não consegue localizar um produto
chamado "Notebook Gamer".

O QA pode pesquisar produtos relacionados ao termo.
*/

SELECT
id,
name,
price
FROM products
WHERE name LIKE '%Notebook%';

/*
RESULTADO ESPERADO:

O produto "Notebook Gamer", caso esteja cadastrado,
deve aparecer no resultado.

Caso não apareça, o QA pode investigar:

* Cadastro do produto;
* Nome armazenado no banco;
* Dados utilizados pela aplicação;
* Regra de pesquisa;
* Possível bug na funcionalidade de busca.
  */
