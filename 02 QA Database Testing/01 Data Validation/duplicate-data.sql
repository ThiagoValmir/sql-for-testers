# /*

# DUPLICATE DATA

## OBJETIVO

Identificar registros duplicados que deveriam ser únicos.

## EXPLICAÇÃO

Dados duplicados podem ocorrer quando uma informação que
deveria ser única aparece mais de uma vez no banco.

Exemplos:

* E-mail de usuário duplicado;
* CPF duplicado;
* Código de produto duplicado;
* Número de pedido duplicado.

Uma das formas mais comuns de encontrar duplicidades
é utilizar:

```
GROUP BY
COUNT()
HAVING
```

## USO EM QA

Pode ser utilizado para:

* Validar unicidade;
* Investigar problemas de cadastro;
* Validar migrações;
* Investigar bugs de integração;
* Verificar se regras de negócio estão sendo respeitadas.

## RESULTADO ESPERADO

Quando o campo deveria ser único, a consulta deve retornar
0 registros duplicados.
=======================

*/

-- ==========================================================
-- EXEMPLO 1
-- E-mails duplicados
-- ==========================================================

SELECT
email,
COUNT(*) AS total
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

/*
RESULTADO ESPERADO:

0 registros.

Se algum e-mail aparecer no resultado, existem
dois ou mais clientes utilizando o mesmo e-mail.
*/

-- ==========================================================
-- EXEMPLO 2
-- Identificar os clientes duplicados
-- ==========================================================

SELECT
c.id,
c.name,
c.email
FROM customers c
WHERE c.email IN (
SELECT email
FROM customers
GROUP BY email
HAVING COUNT(*) > 1
)
ORDER BY c.email;

/*
RESULTADO ESPERADO:

Devem ser apresentados todos os clientes envolvidos
em duplicidades de e-mail.
*/

-- ==========================================================
-- EXEMPLO 3
-- Produtos com código duplicado
-- ==========================================================

SELECT
product_code,
COUNT(*) AS total
FROM products
GROUP BY product_code
HAVING COUNT(*) > 1;

/*
RESULTADO ESPERADO:

0 registros.

Cada product_code deveria identificar apenas um produto.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O requisito informa:

"O e-mail deve ser único no cadastro de usuários."

O QA deseja validar essa regra diretamente no banco.
*/

SELECT
email,
COUNT(*) AS total
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

/*
RESULTADO ESPERADO:

0 registros.

Se houver resultados, existe uma possível violação
da regra de unicidade.
*/
