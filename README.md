# Retail Sales Analytics — dbt + Snowflake

An end-to-end analytics engineering project that transforms raw retail data into analytics-ready dimensional models using **dbt** and **Snowflake**, following the **medallion (bronze → silver → gold) architecture**.

## Overview

This project simulates a retail business with customers, products, stores, employees, promotions, orders, order items, and returns. Raw data lands in Snowflake and is progressively cleaned, joined, and modeled into a star schema ready for BI consumption (Power BI / DOMO / any SQL client).

## Architecture

```
Raw Tables (Snowflake)
        │
        ▼
   Bronze Layer (views)        →  light cleanup / column selection, 1:1 with source
        │
        ▼
   Silver Layer (tables)       →  joins, business logic, derived metrics
        │
        ▼
   Gold Layer (tables)         →  dimensional model: facts + dimensions for reporting
```

| Layer | Materialization | Purpose |
|---|---|---|
| **Bronze** (`models/bronze`) | View | Staging models mapped directly to raw source tables (`stg_customers`, `stg_orders`, `stg_products`, `stg_stores`, `stg_employees`, `stg_promotions`, `stg_order_items`, `stg_returns`) |
| **Silver** (`models/silver`) | Table | Intermediate models that join staging tables and calculate business metrics (`int_sales`, `int_returns`, `int_customer_orders`, `int_customer_metrics`, `int__product_metrics`) |
| **Gold** (`models/gold`) | Table | Final star-schema models for reporting: `fact_sales`, `fact_returns`, `dim_customer`, `dim_product`, `dim_store`, `dim_employee`, `dim_date` |

`fact_sales` is built as an **incremental model**, loading only new orders on each run using `is_incremental()`.

## Key Features

- **Medallion architecture** cleanly separating raw, cleansed, and consumption-ready layers
- **Incremental loading** on the sales fact table for efficient, repeatable runs
- **SCD Type 2 snapshot** (`snapshots/customer_snapshot.sql`) tracking historical changes to customer name, email, city, and state using the `check` strategy
- **Reusable macro** (`macros/safe_divide.sql`) to safely handle division-by-zero in derived metrics
- **Source freshness & relationships** defined in `models/sources/sources.yml`
- **Data quality tests** (`tests/schema.yml`) — uniqueness, not-null, and referential integrity checks across all dimension and fact tables
- **Seed data** for static reference data (`seeds/payment_mode.csv`)

## Tech Stack

- **dbt Core** — transformation framework
- **Snowflake** — cloud data warehouse
- **Jinja / dbt macros** — reusable SQL logic
- **dbt tests** — automated data quality checks

## Project Structure

```
dbt_project/
├── models/
│   ├── bronze/        # staging models (views)
│   ├── silver/         # intermediate models (tables)
│   ├── gold/           # fact & dimension models (tables)
│   └── sources/        # source table definitions
├── snapshots/           # SCD Type 2 snapshot models
├── macros/               # reusable Jinja macros
├── seeds/                # static reference CSVs
├── tests/                 # custom & schema tests
├── analyses/
└── dbt_project.yml
```

## Getting Started

1. Clone the repo and install dbt with the Snowflake adapter:
   ```bash
   pip install dbt-snowflake
   ```
2. Configure your `profiles.yml` with Snowflake connection details (profile name: `dbt_project`).
3. Install any package dependencies and run:
   ```bash
   dbt deps
   dbt seed
   dbt snapshot
   dbt run
   dbt test
   ```
4. Generate and view documentation:
   ```bash
   dbt docs generate
   dbt docs serve
   ```

## Data Model

**Facts:** `fact_sales`, `fact_returns`
**Dimensions:** `dim_customer`, `dim_product`, `dim_store`, `dim_employee`, `dim_date`

`fact_sales` calculates gross sales, discount amount, net sales, total cost, and profit at the order-item grain, joined against customer, product, and store dimensions.

## License

Apache License 2.0
