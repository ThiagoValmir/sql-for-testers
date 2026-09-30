```sql
/*
============================================================
TEST SCENARIO - REGISTRATION
============================================================

OBJETIVO
--------
Utilizar SQL para validar o resultado de um cadastro
realizado pela aplicação.

CENÁRIO
-------
O usuário preenche o formulário:

Nome:
    João da Silva

E-mail:
    joao@example.com

Após enviar o formulário, o QA verifica no banco se
o registro foi criado corretamente.

USO EM QA
---------
SQL pode auxiliar na validação de:

- Criação do registro;
- Persistência dos dados;
- Unicidade do e-mail;
- Campos obrigatórios;
- Status inicial do usuário;
- Resultado de cenários negativos.

RESULTADO ESPERADO
------------------
Após um cadastro válido:

- O usuário deve existir;
- Os dados devem estar corretos;
- O e-mail deve ser único;
- Campos obrigatórios devem estar preenchidos.

============================================================
*/


-- ==========================================================
-- TESTE 1
-- Verificar se o usuário foi criado
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

O cadastro realizado pela aplicação deve estar
persistido no banco.
*/


-- ==========================================================
-- TESTE 2
-- Validar os dados persistidos
-- ==========================================================

SELECT
    id,
    name,
    email
FROM customers
WHERE email = 'joao@example.com';


/*
RESULTADO ESPERADO:

name:
    João da Silva

email:
    joao@example.com

Os dados devem corresponder aos dados enviados
pelo usuário.
*/


-- ==========================================================
-- TESTE 3
-- Validar campos obrigatórios
-- ==========================================================

SELECT
    id,
    name,
    email
FROM customers
WHERE email = 'joao@example.com'
  AND (
      name IS NULL
      OR email IS NULL
  );


/*
RESULTADO ESPERADO:

0 registros.

O cadastro não deve possuir campos obrigatórios
com valor NULL.
*/


-- ==========================================================
-- TESTE 4
-- Verificar duplicidade
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

O mesmo e-mail não deve gerar múltiplos cadastros.
*/


-- ==========================================================
-- TESTE 5
-- Verificar status inicial
-- ==========================================================

SELECT
    id,
    email,
    status
FROM customers
WHERE email = 'joao@example.com';


/*
RESULTADO ESPERADO:

O status deve corresponder à regra de negócio.

Por exemplo:

ACTIVE

ou outro status definido pelo sistema.
*/


-- ==========================================================
-- CENÁRIO NEGATIVO
-- Cadastro com e-mail já existente
-- ==========================================================

/*
Antes de executar o cadastro duplicado, o QA pode
confirmar que o e-mail já existe.
*/

SELECT
    id,
    name,
    email
FROM customers
WHERE email = 'joao@example.com';


/*
RESULTADO ESPERADO:

O registro existente deve ser encontrado.

Após tentar realizar o novo cadastro, o QA pode
executar novamente a consulta e verificar se:

COUNT(*) continua igual a 1.

*/


-- ==========================================================
-- VALIDAÇÃO APÓS TENTATIVA DE DUPLICIDADE
-- ==========================================================

SELECT
    email,
    COUNT(*) AS total
FROM customers
WHERE email = 'joao@example.com'
GROUP BY email;


/*
RESULTADO ESPERADO:

total = 1

A tentativa de cadastro duplicado não deve criar
um segundo registro.
*/
```
