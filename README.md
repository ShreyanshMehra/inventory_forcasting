# Inventory Analytics Project

This project solves inventory inefficiencies using SQL and Power BI. It includes:

- Normalized SQL schema
- Data cleaning & transformation scripts
- Power BI-ready KPIs and reports
- Demand forecasting support

## Structure
- `sql/` → schema and insert scripts
- `data/` → raw dataset (ignored in Git)
- `README.md` → this file

---
## How to Run the Project Locally (SQLite CLI)

### 1. Install SQLite (if not already)

- Windows: Download from [https://www.sqlite.org/download.html](https://www.sqlite.org/download.html)
- Mac/Linux: use `brew install sqlite3` or `sudo apt install sqlite3`

To verify:
```bash
sqlite3 --version
```
### 2. Open SQLite and Create DB
```bash
cd path\to\inventory-forecasting
sqlite3 inventory.db
```
### 3. Create Tables and Load Data
```bash
.read sql/schema.sql
.mode csv
.headers on
.import data/inventory_forecasting.csv stg_inventory_raw
.read sql/insert_clean.sql
```
### 4. Run a Test Query
```bash
SELECT * FROM fact_inventory LIMIT 10;
```
