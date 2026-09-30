# /*

# NULL DATA

## OBJETIVO

Identificar campos que possuem NULL quando deveriam
possuir um valor.

## EXPLICAÇÃO

NULL representa ausência de valor.

É importante lembrar que:

```
NULL != ''
```

NULL também não é igual a:

```
0
```

Para verificar NULL, utilizamos:

```
IS NULL
```

ou:

```
IS NOT NULL
```

## USO EM QA

Pode ser utilizado para:

* Validar campos obrigatórios;
* Encontrar dados incompletos;
* Investigar falhas de cadastro;
* Validar resultados de integrações;
* Verificar registros criados após uma operação.

## RESULTADO ESPERADO

Para campos obrigatórios, a consulta que procura
NULL deve retornar 0 registros.
===============================

*/

-- ==========================================================
-- EXEMPLO 1
-- Clientes sem e-mail
-- ==========================================================

SELECT
id,
name,
email
FROM customers
WHERE email IS NULL;

/*
RESULTADO ESPERADO:

Se email for obrigatório:

0 registros.
*/

-- ==========================================================
-- EXEMPLO 2
-- Clientes sem nome
-- ==========================================================

SELECT
id,
name,
email
FROM customers
WHERE name IS NULL;

/*
RESULTADO ESPERADO:

Se name for obrigatório:

0 registros.
*/

-- ==========================================================
-- EXEMPLO 3
-- Pedidos sem cliente
-- ==========================================================

SELECT
id,
customer_id,
status
FROM orders
WHERE customer_id IS NULL;

/*
RESULTADO ESPERADO:

Se todo pedido deve possuir um cliente:

0 registros.
*/

-- ==========================================================
-- EXEMPLO 4
-- Verificar múltiplos campos obrigatórios
-- ==========================================================

SELECT
id,
name,
email
FROM customers
WHERE name IS NULL
OR email IS NULL;

/*
RESULTADO ESPERADO:

Devem ser retornados somente clientes que possuem
nome ou e-mail ausente.
*/

-- ==========================================================
-- NULL x STRING VAZIA
-- ==========================================================

/*
NULL e string vazia são situações diferentes.

NULL:

```
email IS NULL
```

String vazia:

```
email = ''
```

Para investigar ambas:
*/

SELECT
id,
name,
email
FROM customers
WHERE email IS NULL
OR email = '';

/*
RESULTADO ESPERADO:

Devem ser encontrados clientes sem e-mail ou
com e-mail armazenado como string vazia.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O formulário exige nome e e-mail.

Após realizar um cadastro, o QA deseja verificar
se os dados foram persistidos corretamente.
*/

SELECT
id,
name,
email
FROM customers
WHERE id = 1001;

/*
RESULTADO ESPERADO:

O cliente deve possuir:

* name preenchido;
* email preenchido.

Nenhum campo obrigatório deve estar NULL.
*/
