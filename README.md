# E-Commerce Data Analysis & Power BI Dashboard

## 📌 Project Overview

This project is an end-to-end **E-Commerce Data Analytics** project covering data cleaning, feature engineering, SQL analysis, and Power BI reporting.

The workflow starts with an unclean e-commerce dataset, cleans and transforms the data using **Python/Pandas**, loads the cleaned data into **Microsoft SQL Server**, performs business-oriented SQL analysis, and uses **Power BI** to build an interactive dashboard.

This project demonstrates a practical data analyst workflow from raw data to business insights.

---

## 🛠️ Tools & Technologies

- **Python** — Data cleaning and feature engineering
- **Pandas** — Data manipulation
- **NumPy** — Numerical operations
- **Jupyter Notebook** — Analysis workflow
- **Microsoft SQL Server** — Data storage and SQL analysis
- **Power BI** — Interactive dashboard and visualization
- **Excel/CSV** — Source and cleaned data

## 🧹 Data Cleaning

The Python notebook performs several data preparation steps, including:

- Initial data inspection
- Checking missing values
- Checking and removing duplicate records
- Replacing invalid values and blank values
- Removing extra spaces from text fields
- Standardizing customer, city, and state names
- Handling missing discounts, phone numbers, and delivery dates

## 📊 Feature Engineering

The project creates additional analytical fields:

### Sales

```text
Sales = Quantity × Unit Price
```

### Net Amount

```text
Net Amount = Sales − (Sales × Discount / 100)
```

### Profit

The project calculates profit using a 20% assumption:

```text
Profit = Net Amount × 0.20
```

Additional time-based fields include:

- Month
- Year

---

## 🗄️ SQL Analysis

The cleaned dataset is loaded into a SQL Server database named `ecommerce`, with the main table named `orders`.

The SQL script includes analysis such as:

- Total number of orders
- Total net sales
- Sales by product
- Sales by city
- Sales by month
- Order count by payment mode
- Identification of cancelled orders

## 📈 Power BI

The cleaned/processed data is used to create an interactive Power BI dashboard for analyzing e-commerce performance.

The Power BI report can be found in:

`E-Commerce-Dashboard.pbix`


