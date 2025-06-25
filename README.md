# Inventory Analytics Project: Urban Retail Co.
## Setup & Environment

### Prerequisites

- [SQLite3](https://www.sqlite.org/download.html) (for database and SQL queries)
- [Power BI Desktop](https://powerbi.microsoft.com/desktop/) (for dashboarding; Windows only)
- (Optional) [Python 3.x](https://www.python.org/downloads/) with `pandas` and `jupyter` for EDA

### 1. Clone the Repository
```
git clone https://github.com/yourusername/inventory_analytics.git
cd inventory_analytics

```

### 2. Prepare the SQLite Database

**a. Create the schema:**
```
sqlite3 inventory.db < sql/schema.sql
```
**b. Import the CSV data into the staging table:**
```
sqlite3 inventory.db
.mode csv
.import data/inventory_forecasting.csv stg_inventory_raw
```
**c. Clean and populate normalized tables:**
```
sqlite3 inventory.db < sql/insert_clean.sql
```

### 3. Run Analytics Queries

Each analytics SQL file in `sql/analytics/` answers a key business question. Run any query like:
```
sqlite3 inventory.db < sql/analytics/low_inventory.sql
```
Or, open the database in the SQLite CLI and use `.read sql/analytics/low_inventory.sql`.

---
## Overview

Urban Retail Co. is a rapidly growing retail chain with both physical and online stores, offering over 5,000 SKUs across categories like groceries, electronics, clothing, and home essentials. As operations have scaled, the company faces major inventory management challenges:
- Frequent **stockouts** of fast-moving products, resulting in lost sales and poor customer experience.
- **Overstocking** of slow-moving items, tying up working capital and raising warehousing costs.
- Lack of **real-time, actionable insights** into SKU performance, reorder points, and demand trends.

This project leverages **advanced SQL analytics** and **Power BI dashboards** to turn raw inventory and sales data into business insights, enabling smarter, data-driven inventory decisions.

---

## Project Structure
```
inventory_analytics/
│
├── data/
│ └── inventory_forecasting.csv # Raw inventory and sales dataset
│
├── sql/
│ ├── schema.sql # SQL: Table creation (ERD-based)
│ ├── insert_clean.sql # SQL: Data cleaning & insert from CSV
│ └── analytics/
│ ├── low_inventory.sql # Low inventory detection
│ ├── reorder_point.sql # Reorder point estimation
│ ├── inventory_turnover.sql # Inventory turnover ratio
│ ├── forecast_accuracy.sql # Forecasting performance
│ ├── fast_slow_analysis.sql # Product movement classification
│ └── promo_seasonal.sql # Promo & seasonal impact
│
├── powerbi/
│ └── inventory_dashboard.pbix # Power BI dashboard file
│
├── docs/
│ ├── ERD.png # Entity Relationship Diagram
│ └── executive_summary.pdf # Executive summary (insights & recommendations)
│
├── notebooks/ # (Optional) Jupyter/Python EDA
│ └── exploratory_analysis.ipynb
│
└── README.md # This file

```
## Problem Statement

Urban Retail Co. struggles with:
- **Stockouts** of popular products
- **Excess inventory** of slow movers
- **Poor demand forecasting**
- **Lack of visibility** across stores, regions, and categories

**Goal:**  
Build an efficient, scalable, and actionable SQL-driven inventory analytics solution that:
- Diagnoses inefficiencies (stockouts, overstock, slow movers)
- Estimates reorder points and inventory turnover
- Highlights forecasting errors and seasonal trends
- Powers an interactive dashboard for business users

---
>>>>>>> 51c3598 (analytics)
