# SQL for QA

Repositório dedicado ao estudo e à prática de **SQL aplicado à área de Quality Assurance (QA)**.

O objetivo deste projeto é demonstrar conhecimentos em SQL por meio de exercícios, exemplos práticos e cenários que representam situações que podem ser encontradas no dia a dia de um profissional de QA.

A proposta é ir além da escrita de consultas SQL, mostrando como o conhecimento em banco de dados pode ser utilizado para **validar informações, investigar problemas, verificar regras de negócio e apoiar a identificação de defeitos**.

---

## Objetivos

Este projeto tem como objetivos:

* Praticar e consolidar conhecimentos em SQL;
* Demonstrar diferentes recursos e comandos da linguagem;
* Utilizar SQL para análise e validação de dados;
* Simular situações encontradas em atividades de QA;
* Validar regras de negócio diretamente no banco de dados;
* Investigar inconsistências e possíveis defeitos;
* Demonstrar a relação entre testes de software e banco de dados.

---

## Tecnologias

* **SQL**
* **Git / GitHub**

---

## Estrutura do Projeto

```text
sql-for-qa/
│
├── 01-fundamentals/
│   ├── README.md
│   ├── 01-select.sql
│   ├── 02-where.sql
│   ├── 03-order-by.sql
│   ├── 04-distinct.sql
│   ├── 05-like.sql
│   ├── 06-in.sql
│   ├── 07-between.sql
│   └── 08-null.sql
│
├── 02-aggregation/
│   ├── README.md
│   ├── 01-count.sql
│   ├── 02-sum.sql
│   ├── 03-avg.sql
│   ├── 04-group-by.sql
│   └── 05-having.sql
│
├── 03-joins/
│   ├── README.md
│   ├── 01-inner-join.sql
│   ├── 02-left-join.sql
│   ├── 03-right-join.sql
│   └── 04-multiple-joins.sql
│
├── 04-advanced/
│   ├── README.md
│   ├── 01-subqueries.sql
│   ├── 02-exists.sql
│   ├── 03-any.sql
│   ├── 04-all.sql
│   ├── 05-union.sql
│   └── 06-case.sql
│
├── 05-qa-database-testing/
│   ├── README.md
│   │
│   ├── data-validation/
│   │   ├── duplicate-data.sql
│   │   ├── null-data.sql
│   │   ├── invalid-data.sql
│   │   └── orphan-records.sql
│   │
│   ├── business-rules/
│   │   ├── order-total.sql
│   │   ├── payment-validation.sql
│   │   └── stock-validation.sql
│   │
│   └── test-scenarios/
│       ├── registration.sql
│       ├── login.sql
│       └── checkout.sql
│
├── 06-real-world-project/
│   ├── README.md
│   │
│   ├── database/
│   │   ├── create-tables.sql
│   │   └── insert-data.sql
│   │
│   ├── queries/
│   │   ├── customer-analysis.sql
│   │   ├── product-analysis.sql
│   │   ├── order-analysis.sql
│   │   └── payment-analysis.sql
│   │
│   └── bugs/
│       ├── BUG-001.md
│       ├── BUG-002.md
│       └── BUG-003.md
│
└── docs/
    ├── database-model.png
    └── test-strategy.md
```

---

# Conteúdo

## 01 — SQL Fundamentals

Introdução aos principais comandos utilizados para consulta e filtragem de dados.

Conteúdos:

* `SELECT`
* `WHERE`
* `ORDER BY`
* `DISTINCT`
* `LIKE`
* `IN`
* `BETWEEN`
* `IS NULL`
* Operadores relacionais e lógicos

Os exemplos utilizam um banco de dados fictício para demonstrar a aplicação dos comandos em diferentes cenários.

---

## 02 — Aggregation

Consultas utilizadas para analisar e resumir conjuntos de dados.

Conteúdos:

* `COUNT`
* `SUM`
* `AVG`
* `MIN`
* `MAX`
* `GROUP BY`
* `HAVING`

Os exemplos demonstram como utilizar funções de agregação para obter informações e identificar padrões ou inconsistências nos dados.

---

## 03 — JOINs

Consultas envolvendo dados distribuídos entre diferentes tabelas.

Conteúdos:

* `INNER JOIN`
* `LEFT JOIN`
* `RIGHT JOIN`
* Múltiplos `JOINs`

Além de demonstrar a sintaxe, os exemplos apresentam situações em que JOINs podem ser utilizados para investigar relacionamentos entre registros.

---

## 04 — Advanced SQL

Consultas e recursos mais avançados da linguagem.

Conteúdos:

* Subqueries
* `EXISTS`
* `ANY`
* `ALL`
* `UNION`
* `CASE`

Novos conceitos poderão ser adicionados conforme o desenvolvimento do projeto.

---

# 05 — SQL for QA

Seção dedicada à aplicação prática de SQL em atividades de Quality Assurance.

O objetivo é demonstrar como um QA pode utilizar consultas SQL para verificar o comportamento e a integridade dos dados de uma aplicação.

### Data Validation

Exemplos de validações:

* Identificação de registros duplicados;
* Identificação de valores `NULL` indevidos;
* Identificação de valores inválidos;
* Identificação de registros órfãos;
* Verificação de integridade dos relacionamentos.

### Business Rules

Validação de regras de negócio diretamente no banco de dados.

Exemplos:

* Validação do valor total de pedidos;
* Validação de pagamentos;
* Validação de estoque;
* Validação de quantidade de itens;
* Comparação entre valores armazenados e valores calculados.

### Test Scenarios

Simulação de cenários relacionados a funcionalidades de uma aplicação.

Exemplos:

* Cadastro de usuário;
* Login;
* Alteração de dados;
* Criação de pedidos;
* Checkout;
* Pagamento.

A intenção é demonstrar como o banco de dados pode ser utilizado como uma fonte adicional de evidências durante a execução de testes.

---

# 06 — Real World Project

Projeto prático baseado em um sistema fictício de **e-commerce**.

O banco de dados simula uma aplicação contendo entidades como:

* Clientes;
* Endereços;
* Produtos;
* Categorias;
* Pedidos;
* Itens de pedidos;
* Pagamentos.

O projeto será utilizado para aplicar os conceitos apresentados nas seções anteriores em um cenário mais próximo de uma aplicação real.

### Exemplos de atividades

* Consultar informações de clientes;
* Analisar pedidos;
* Validar produtos;
* Verificar pagamentos;
* Validar relacionamentos entre tabelas;
* Investigar inconsistências;
* Identificar possíveis defeitos;
* Validar regras de negócio.

---

# SQL aplicado à investigação de defeitos

Uma das propostas deste projeto é utilizar SQL não apenas para consultar dados, mas também como ferramenta de investigação.

Por exemplo, considerando a seguinte regra:

> O valor total de um pedido deve corresponder à soma dos seus itens.

Uma consulta pode ser utilizada para identificar pedidos que não atendem a essa regra:

```sql
SELECT
    o.id,
    o.total_amount,
    SUM(oi.quantity * oi.unit_price) AS calculated_total
FROM orders o
JOIN order_items oi
    ON o.id = oi.order_id
GROUP BY
    o.id,
    o.total_amount
HAVING o.total_amount <> SUM(oi.quantity * oi.unit_price);
```

Caso a consulta retorne registros, eles podem ser investigados como possíveis inconsistências ou defeitos.

A investigação pode então ser documentada em um **Bug Report**, contendo:

* Descrição;
* Pré-condições;
* Passos para reprodução;
* Consulta SQL utilizada;
* Resultado esperado;
* Resultado encontrado;
* Evidências;
* Severidade.

---

# Abordagem de Testes

As consultas presentes neste projeto seguem uma abordagem baseada em:

**Cenário → Regra → Consulta → Resultado esperado → Resultado encontrado → Evidência**

Exemplo:

```text
Cenário:
Cliente realiza um pedido.

Regra:
O valor total do pedido deve corresponder à soma dos seus itens.

Consulta:
SQL utilizado para calcular o valor dos itens.

Resultado esperado:
O valor calculado deve ser igual ao valor armazenado.

Resultado encontrado:
Os valores são diferentes.

Conclusão:
Possível inconsistência identificada no banco de dados.
```

---

# O que este projeto demonstra

Por meio deste projeto, busco demonstrar conhecimentos em:

### SQL

* Consultas;
* Filtragem de dados;
* Ordenação;
* Funções de agregação;
* JOINs;
* Subqueries;
* Operadores e condições;
* Análise de dados.

### Quality Assurance

* Validação de dados;
* Testes de integridade;
* Validação de regras de negócio;
* Investigação de defeitos;
* Análise de resultados;
* Criação de cenários de teste;
* Documentação de bugs;
* Utilização do banco de dados como apoio aos testes.

---

# Evolução do projeto

Este é um projeto de estudo e portfólio que será desenvolvido de forma incremental.

Novos exercícios, consultas, cenários de teste e técnicas de SQL serão adicionados conforme novos conhecimentos forem adquiridos e aplicados ao contexto de Quality Assurance.

---

## Status

**Em desenvolvimento**
