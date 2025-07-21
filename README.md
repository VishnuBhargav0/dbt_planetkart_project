# PlanetKart dbt Project

Here is the data model: 
[Data Model](assets/Lineage_graph.png)
---

## Project Structure

```
dbt_planetkart_project/
├── dbt_project.yml
├── packages.yml
├── README.md
├── models/
│   ├── analytics/
│   │   ├── fact_orders.sql
│   │   ├── dimensional_customers.sql
│   │   ├── dimensional_products.sql
│   │   ├── dimensional_regions.sql
│   │   └── schema.yml
│   └── staging/
│       ├── staging_customers.sql
│       ├── staging_orders.sql
│       ├── staging_order_items.sql
│       ├── staging_products.sql
│       ├── staging_regions.sql
│       └── schema.yml
├── snapshots/
│   ├── snapshot_customers.sql
│   └── schema.yml
├── tests/
│   └── (custom data tests, if any)
├── macros/
│   └── schema_name_util.sql
└── ...
```

---

## Models and Schemas

### Staging Models (`models/staging/`)

These models clean and standardize raw data from the `PLANETKART_RAW` schema.

- **staging_customers**: Customer data with columns like `CUSTOMER_ID`, `EMAIL`, `FIRST_NAME`, `LAST_NAME`, `REGION_ID`, `SIGNUP_DATE`.
- **staging_orders**: Order data with `ORDER_ID`, `CUSTOMER_ID`, `ORDER_DATE`, `STATUS`.
- **staging_order_items**: Line items per order, with `ORDER_ID`, `PRODUCT_ID`, `QUANTITY`, `UNIT_PRICE`.
- **staging_products**: Product catalog with `PRODUCT_ID`, `PRODUCT_NAME`, `CATEGORY`, `COST`, `SKU`.
- **staging_regions**: Regional info with `REGION_ID`, `PLANET`, `ZONE`.

Each staging model has a corresponding schema in `models/staging/schema.yml` with:
- **Freshness tests** (using `dbt_utils.recency`) to ensure new data in the last 24 hours.
- **Accepted range tests** for date columns.
- **Uniqueness and not-null tests** for key columns.

---

### Analytics Models (`models/analytics/`)

These models build business logic and dimensional/fact tables.

- **dimensional_customers**: Customer dimension with demographic and registration info.
- **dimensional_products**: Product dimension with catalog info.
- **dimensional_regions**: Region dimension with planet and zone info.
- **fact_orders**: Fact table aggregating order metrics and joining customer, product, and region info.

See `models/analytics/schema.yml` for detailed column descriptions and tests.

---

### Snapshots (`snapshots/`)

- **snapshot_customers.sql**: Type 2 Slowly Changing Dimension (SCD) snapshot of the customer dimension, tracking changes over time using dbt's `check` strategy.
- **snapshots/schema.yml**: Contains tests for snapshot freshness, row count, and not-null constraints.

---

## How to Run the dbt Project

### 1. Set Up Your Environment

- Ensure Python and dbt are installed.
- Install dependencies:
  ```sh
  dbt deps
  ```

### 2. Configure Your Profile

- Edit your `~/.dbt/profiles.yml` to match your Snowflake credentials and set the schema (e.g., `PLANETKART_STAGE`).

### 3. Build and Test Models

- Run all models:
  ```sh
  dbt run
  ```
- Run all tests (schema and data tests):
  ```sh
  dbt test
  ```

### 4. Run Snapshots

- To track changes in customer data:
  ```sh
  dbt snapshot
  ```

---

## How to Run Tests

- **Schema tests** (in `schema.yml` files) are run with:
  ```sh
  dbt test
  ```
- **Custom data tests** (in the `tests/` directory) are also run with `dbt test`.

**Common tests included:**
- Freshness (`dbt_utils.recency`) — ensures recent data in staging models.
- Accepted range (`dbt_utils.accepted_range`) — ensures dates are not in the future.
- Uniqueness and not-null — ensures data integrity for key columns.
- Snapshot tests — ensures SCD2 logic and data freshness in snapshots.

---

## Resources

- [dbt Documentation](https://docs.getdbt.com/docs/introduction)
- [dbt-utils Package](https://hub.getdbt.com/dbt-labs/dbt_utils/latest/)
- [dbt Community Slack](https://community.getdbt.com/)

---

For any questions or issues, please refer to the resources above or reach out to the dbt community on Discourse or Slack.