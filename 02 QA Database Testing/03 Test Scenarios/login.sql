```sql
/*
============================================================
TEST SCENARIO - LOGIN
============================================================

OBJETIVO
--------
Utilizar SQL para validar os dados relacionados ao processo
de autenticação de um usuário.

CENÁRIO
-------
O usuário informa:

E-mail:
    joao@example.com

Senha:
    ********

O QA utiliza o banco para verificar se o usuário utilizado
no teste existe, está ativo e possui os dados esperados.

IMPORTANTE
----------
Em aplicações reais, a senha normalmente é armazenada
como um hash.

O objetivo desta consulta não é verificar a senha em texto
puro, mas validar as informações relacionadas ao usuário.

USO EM QA
---------
SQL pode auxiliar na validação de:

- Existência do usuário;
- Status da conta;
- Unicidade do e-mail;
- Dados utilizados no teste;
- Estado do usuário antes e depois do login.

RESULTADO ESPERADO
------------------
O usuário utilizado no teste deve:

- Existir;
- Possuir o e-mail informado;
- Estar em um status que permita autenticação;
- Não possuir registros duplicados.
============================================================
*/


-- ==========================================================
-- TESTE 1
-- Verificar se o usuário existe
-- ==========================================================

SELECT
    id,
    name,
    email,
    status
FROM customers
WHERE email = 'joao@example.com';


/*
RESULTADO ESPERADO:

1 registro.

O usuário utilizado no teste deve existir.
*/


-- ==========================================================
-- TESTE 2
-- Verificar se o usuário está ativo
-- ==========================================================

SELECT
    id,
    email,
    status
FROM customers
WHERE email = 'joao@example.com'
  AND status = 'ACTIVE';


/*
RESULTADO ESPERADO:

1 registro.

O usuário deve possuir status ACTIVE,
caso essa seja a regra definida para permitir login.
*/


-- ==========================================================
-- TESTE 3
-- Verificar duplicidade de e-mail
-- ==========================================================

SELECT
    email,
    COUNT(*) AS total
FROM customers
WHERE email = 'joao@example.com'
GROUP BY email
HAVING COUNT(*) > 1;


/*
RESULTADO ESPERADO:

0 registros.

Um e-mail deve identificar apenas um usuário.
*/


-- ==========================================================
-- TESTE 4
-- Verificar informações do usuário
-- ==========================================================

SELECT
    id,
    name,
    email,
    status
FROM customers
WHERE email = 'joao@example.com';


/*
RESULTADO ESPERADO:

Os dados devem corresponder ao usuário utilizado
durante o teste de login.
*/


-- ==========================================================
-- CENÁRIO NEGATIVO
-- Usuário inexistente
-- ==========================================================

SELECT
    id,
    name,
    email
FROM customers
WHERE email = 'usuario_inexistente@example.com';


/*
RESULTADO ESPERADO:

0 registros.

Esse cenário pode ser utilizado para validar que a
aplicação não autentica um usuário inexistente.
*/


-- ==========================================================
-- CENÁRIO NEGATIVO
-- Usuário inativo
-- ==========================================================

SELECT
    id,
    email,
    status
FROM customers
WHERE email = 'joao@example.com'
  AND status = 'INACTIVE';


/*
RESULTADO ESPERADO:

Se o usuário estiver INACTIVE, o resultado deverá
ser utilizado para confirmar o comportamento esperado
da aplicação.

Por exemplo:

INACTIVE
    ↓
Login deve ser bloqueado
*/
```
