# /*

# 05 - UNION

## OBJETIVO

Aprender a combinar resultados de duas ou mais consultas
utilizando UNION.

## EXPLICAÇÃO

UNION combina os resultados de consultas SELECT.

Por padrão, UNION remove registros duplicados.

Para manter duplicidades, utilizamos:

```
UNION ALL
```

As consultas devem possuir:

* A mesma quantidade de colunas;
* Tipos de dados compatíveis nas posições correspondentes.

## USO EM QA

UNION pode ser utilizado para:

* Combinar diferentes conjuntos de dados;
* Comparar resultados;
* Criar consultas de investigação;
* Unificar informações de diferentes fontes;
* Validar registros encontrados por diferentes condições.

## RESULTADO ESPERADO

O resultado deve conter os registros das consultas
combinadas.

# Com UNION, duplicidades são removidas.

*/

-- ==========================================================
-- EXEMPLO 1
-- Clientes ativos ou pendentes
-- ==========================================================

SELECT
id,
name,
status
FROM customers
WHERE status = 'ACTIVE'

UNION

SELECT
id,
name,
status
FROM customers
WHERE status = 'PENDING';

/*
RESULTADO ESPERADO:

Todos os clientes ACTIVE e PENDING.

Registros duplicados são removidos.
*/

-- ==========================================================
-- EXEMPLO 2
-- UNION ALL
-- ==========================================================

SELECT
id,
name
FROM customers
WHERE status = 'ACTIVE'

UNION ALL

SELECT
id,
name
FROM customers
WHERE status = 'ACTIVE';

/*
RESULTADO ESPERADO:

Cada consulta retorna os mesmos clientes.

Como UNION ALL mantém duplicidades,
os registros aparecerão duas vezes.
*/

-- ==========================================================
-- EXEMPLO 3
-- Encontrar diferentes tipos de inconsistência
-- ==========================================================

SELECT
id,
name
FROM customers
WHERE email IS NULL

UNION

SELECT
id,
name
FROM customers
WHERE status IS NULL;

/*
RESULTADO ESPERADO:

Clientes que possuem:

* email NULL
  OU
* status NULL

Como UNION remove duplicidades, um cliente que
atenda às duas condições aparecerá apenas uma vez.
*/

-- ==========================================================
-- APLICAÇÃO EM QA
-- ==========================================================

/*
CENÁRIO:

O QA deseja gerar uma lista única de clientes que
possuam qualquer uma das duas inconsistências:

1. E-mail ausente;
2. Status ausente.
   */

SELECT
id,
name,
email,
status
FROM customers
WHERE email IS NULL

UNION

SELECT
id,
name,
email,
status
FROM customers
WHERE status IS NULL;

/*
RESULTADO ESPERADO:

Cada cliente com pelo menos uma dessas inconsistências
deve aparecer no resultado.

Clientes que possuem as duas inconsistências devem
aparecer somente uma vez.
*/

-- ==========================================================
-- OBSERVAÇÃO
-- ==========================================================

/*
UNION:

Remove duplicidades.

UNION ALL:

Mantém duplicidades.

Essa diferença pode ser importante durante uma
investigação de dados.
*/
