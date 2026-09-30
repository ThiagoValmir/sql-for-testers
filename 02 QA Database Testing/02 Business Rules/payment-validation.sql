```sql
/*
============================================================
BUSINESS RULE - PAYMENT VALIDATION
============================================================

OBJETIVO
--------
Validar se os pagamentos registrados estão de acordo
com os pedidos correspondentes.

EXPLICAÇÃO
----------
Em um fluxo de checkout, o pedido e o pagamento precisam
manter informações consistentes.

Exemplo:

Pedido:
    R$ 250,00

Pagamento aprovado:
    R$ 250,00

Uma diferença entre esses valores pode indicar uma
inconsistência que precisa ser investigada.

USO EM QA
---------
Pode ser utilizado para:

- Validar o checkout;
- Validar integrações com gateways de pagamento;
- Verificar pagamentos aprovados;
- Investigar divergências de valores;
- Validar atualizações de status;
- Investigar problemas após webhooks.

RESULTADO ESPERADO
------------------
Pedidos pagos devem possuir um pagamento correspondente.

Pagamentos aprovados devem possuir valores compatíveis
com o pedido.

Consultas de inconsistência devem retornar:

0 registros.
============================================================
*/


-- ==========================================================
-- EXEMPLO 1
-- Pagamentos com valor inválido
-- ==========================================================

SELECT
    id,
    order_id,
    amount,
    status
FROM payments
WHERE amount <= 0;


/*
RESULTADO ESPERADO:

0 registros.

O pagamento deve possuir um valor positivo.
*/


-- ==========================================================
-- EXEMPLO 2
-- Status de pagamento inválido
-- ==========================================================

SELECT
    id,
    order_id,
    amount,
    status
FROM payments
WHERE status NOT IN (
    'PENDING',
    'APPROVED',
    'DECLINED',
    'REFUNDED'
);


/*
RESULTADO ESPERADO:

0 registros.

Somente os status definidos pelo sistema devem
existir no banco.
*/


-- ==========================================================
-- EXEMPLO 3
-- Pedido pago sem pagamento
-- ==========================================================

SELECT
    o.id AS order_id,
    o.status AS order_status,
    p.id AS payment_id
FROM orders o
LEFT JOIN payments p
    ON o.id = p.order_id
WHERE o.status = 'PAID'
  AND p.id IS NULL;


/*
RESULTADO ESPERADO:

0 registros.

Um pedido com status PAID deve possuir um pagamento
correspondente.
*/


-- ==========================================================
-- EXEMPLO 4
-- Valor do pagamento diferente do pedido
-- ==========================================================

SELECT
    o.id AS order_id,
    o.total_amount AS order_total,
    p.amount AS payment_amount,
    p.status AS payment_status
FROM orders o
INNER JOIN payments p
    ON o.id = p.order_id
WHERE p.status = 'APPROVED'
  AND p.amount <> o.total_amount;


/*
RESULTADO ESPERADO:

0 registros.

Um pagamento aprovado deve possuir valor compatível
com o total do pedido.
*/


-- ==========================================================
-- CENÁRIO DE TESTE
-- ==========================================================

/*
DADOS DO TESTE

Pedido:
    ID = 1001
    Total = R$ 250,00

Pagamento:
    Status = APPROVED
    Valor = R$ 250,00
*/

SELECT
    o.id AS order_id,
    o.status AS order_status,
    o.total_amount,
    p.id AS payment_id,
    p.status AS payment_status,
    p.amount AS payment_amount
FROM orders o
INNER JOIN payments p
    ON o.id = p.order_id
WHERE o.id = 1001;


/*
RESULTADO ESPERADO:

order_status   = PAID
payment_status = APPROVED
total_amount   = 250.00
payment_amount = 250.00
*/


-- ==========================================================
-- INVESTIGAÇÃO DE INCONSISTÊNCIA
-- ==========================================================

/*
Essa consulta identifica pedidos cujo pagamento
aprovado possui valor diferente do pedido.
*/

SELECT
    o.id AS order_id,
    o.total_amount,
    p.amount,
    p.status
FROM orders o
INNER JOIN payments p
    ON o.id = p.order_id
WHERE p.status = 'APPROVED'
  AND p.amount <> o.total_amount;


/*
RESULTADO ESPERADO:

0 registros.

Qualquer registro encontrado deve ser investigado.
*/
```
