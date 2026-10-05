# E-Commerce Data Analysis & Power BI Dashboard
## Dashboard Link: https://app.powerbi.com/groups/me/reports/c53ff023-a42a-470a-a169-979e61b297f9/fc3d6d8c8d8995233e1a?experience=power-bi
# E-Commerce Data Analysis & Power BI Dashboard

## Project Overview

This project is an **end-to-end E-Commerce Data Analytics project** built to demonstrate a practical Data Analyst workflow.

The project starts with an unclean e-commerce dataset and uses **Python/Pandas for data cleaning and feature engineering**, **Microsoft SQL Server for data storage and business analysis**, and **Power BI for interactive visualization and dashboarding**.

# Problem Statement

E-commerce businesses generate large amounts of transactional data containing information about customers, orders, products, pricing, discounts, payment methods, and order status.

Raw transactional data can contain duplicate records, inconsistent text values, invalid values, missing information and incorrect data types. Before meaningful business analysis can be performed, the data needs to be cleaned, transformed and structured.

The objective of this project is to transform the raw e-commerce data into an analysis-ready dataset, perform SQL-based business analysis, and create a Power BI dashboard that can help understand **sales performance, product performance, geographical performance, payment methods, and order status**.

---

# Project Objectives

- Clean and validate the raw e-commerce dataset.
- Handle duplicate and invalid records.
- Standardize text and date fields.
- Convert columns into appropriate data types.
- Create analytical features such as Sales, Net Amount and Profit.
- Store the cleaned data in Microsoft SQL Server.
- Perform business-oriented SQL analysis.
- Build an interactive Power BI dashboard.
- Extract meaningful insights from the data.

---

# Tools & Technologies

| Tool | Purpose |
|---|---|
| **Python** | Data cleaning and feature engineering |
| **Pandas** | Data manipulation and transformation |
| **NumPy** | Numerical operations |
| **Jupyter Notebook** | Python analysis workflow |
| **Microsoft SQL Server** | Data storage and SQL analysis |
| **SQLAlchemy / PyODBC** | Python-to-SQL Server connection |
| **Power BI** | Dashboard and data visualization |
| **Excel / CSV** | Source and processed data |

---

# Dataset

The project contains an e-commerce transaction dataset with fields related to:

- Order information
- Customer information
- Location
- Product and category
- Quantity
- Unit price
- Discount
- Payment mode
- Order status
- Order and delivery dates

The repository contains both the raw Excel dataset and the cleaned CSV dataset.

---

# Steps Followed

## Step 1: Load Required Libraries

Python libraries used in the notebook include:

```python
import pandas as pd
import numpy as np
```

Additional packages are used to connect Python with SQL Server.

---

## Step 2: Load the Raw Dataset

The raw Excel dataset was loaded using Pandas:

```python
df = pd.read_excel('Ecommerce_Unclean_Project.xlsx')
```

Initial inspection was performed using:

```python
df.head()
df.info()
df.describe()
df.shape
```

This helped understand the dataset structure, data types, number of records, and basic statistics.

---

# Step 3: Data Cleaning

Several data-cleaning operations were performed.

### 3.1 Missing Value Analysis

Missing values were checked using:

```python
df.isnull().sum()
```

### 3.2 Duplicate Records

Duplicate records were identified using:

```python
df.duplicated().sum()
```

Duplicates were then removed:

```python
df.drop_duplicates(inplace=True)
```

### 3.3 Handling Invalid Values

Common invalid values such as:

```text
N/A
NULL
blank values
```

were replaced with `NaN`.

```python
df.replace(['N/A','NULL',''], np.nan, inplace=True)
```

### 3.4 Removing Extra Spaces

Unnecessary spaces from text columns were removed:

```python
df = df.apply(
    lambda x: x.str.strip() if x.dtype == 'object' else x
)
```

### 3.5 Standardizing Text

Customer names, cities, and states were standardized using title case.

```python
df['Customer_Name'] = df['Customer_Name'].str.title()
df['City'] = df['City'].str.title()
df['State'] = df['State'].str.title()
```

### 3.6 Basic Email Validation

Records without an `@` symbol in the email field were filtered out.

```python
df = df[df['Email'].str.contains('@', na=False)]
```

### 3.7 Date Conversion

Order and delivery dates were converted to datetime format:

```python
df['Order_Date'] = pd.to_datetime(
    df['Order_Date'],
    errors='coerce'
)

df['Delivery_Date'] = pd.to_datetime(
    df['Delivery_Date'],
    errors='coerce'
)
```

### 3.8 Numeric Conversion

The following columns were converted to numeric values:

- Quantity
- Unit Price
- Discount

```python
cols = ['Qty', 'Unit_Price', 'Discount']

for c in cols:
    df[c] = pd.to_numeric(df[c], errors='coerce')
```

### 3.9 Invalid Quantity

Records with zero or negative quantities were removed:

```python
df = df[df['Qty'] > 0]
```

### 3.10 Missing Values

The following replacements were performed:

```python
df['Discount'] = df['Discount'].fillna(0)

df['Phone'] = df['Phone'].fillna('Unknown')

df['Delivery_Date'] = df['Delivery_Date'].fillna(
    df['Order_Date']
)
```

---

# Step 4: Feature Engineering

New analytical columns were created to support business analysis.

## Sales

Sales were calculated as:

```text
Sales = Quantity × Unit Price
```

Python implementation:

```python
df['Sales'] = df['Qty'] * df['Unit_Price']
```

## Net Amount

The discount-adjusted amount was calculated as:

```text
Net Amount = Sales − (Sales × Discount / 100)
```

Python implementation:

```python
df['Net_Amount'] = (
    df['Sales']
    - (df['Sales'] * df['Discount'] / 100)
)
```

## Profit

A 20% profit assumption was applied:

```text
Profit = Net Amount × 0.20
```

```python
df['Profit'] = df['Net_Amount'] * 0.20
```

## Time-Based Features

The following date-related features were created:

- Month
- Year
- Weekday

Example:

```python
df['Month'] = df['Order_Date'].dt.month_name()
df['year'] = df['Order_Date'].dt.year
df['Weekday'] = df['Order_Date'].dt.day_name()
```

The notebook subsequently removes the `Weekday` column.

---

# Step 5: Export Cleaned Dataset

After the cleaning and transformation process, the dataset was exported as:

```text
Clean_Ecommerce.csv
```

```python
df.to_csv('Clean_Ecommerce.csv', index=False)
```

This cleaned dataset was then used for the SQL Server stage.

---

# Step 6: SQL Server

A Microsoft SQL Server database named:

```text
ecommerce
```

was created.

The cleaned Pandas DataFrame was loaded into a table named:

```text
orders
```

The Python workflow uses SQLAlchemy and PyODBC to connect to SQL Server.

```python
df.to_sql(
    name='orders',
    con=engine,
    schema='dbo',
    if_exists='replace',
    index=False
)
```

> **Note:** The connection string in the notebook is configured for a local SQL Server environment using Windows/Trusted Authentication. It should be adjusted for another user's local environment.

---

# Step 7: SQL Business Analysis

The SQL script contains business-oriented queries for analysing the e-commerce dataset.

### Total Orders

```sql
SELECT COUNT(*)
FROM orders;
```

### Total Net Sales

```sql
SELECT SUM(Net_Amount)
FROM orders;
```

### Sales by Product

```sql
SELECT
    Product,
    SUM(Net_Amount) AS Sales
FROM orders
GROUP BY Product
ORDER BY Sales DESC;
```

### Sales by City

```sql
SELECT
    City,
    SUM(Net_Amount) AS Sales
FROM orders
GROUP BY City
ORDER BY Sales DESC;
```

### Sales by Month

```sql
SELECT
    Month,
    SUM(Net_Amount) AS Sales
FROM orders
GROUP BY Month
ORDER BY Sales DESC;
```

### Orders by Payment Mode

```sql
SELECT
    Payment_Mode,
    COUNT(*) AS Total_Orders
FROM orders
GROUP BY Payment_Mode
ORDER BY Total_Orders DESC;
```

### Cancelled Orders

```sql
SELECT *
FROM orders
WHERE Order_Status = 'Cancelled';
```

These queries help answer common business questions around sales, products, locations, payment methods and order status.

---

# Step 8: Power BI Dashboard

The processed data was used to create an interactive Power BI dashboard.

The dashboard is intended to provide a visual view of:

- Sales performance
- Product performance
- Geographic performance
- Payment methods
- Order status
- E-commerce KPIs


# Key Insights

Based on the cleaned dataset and SQL analysis, the project contains the following high-level findings.

### Overall Dataset

- **393 records** are present in the cleaned CSV currently included in the repository.
- Total calculated **Sales: 3,945,519**
- Total calculated **Net Amount: 3,945,519**
- Calculated **Profit: 789,103.80**, based on the 20% profit assumption.

### Top Products by Net Amount

| Product | Net Amount |
|---|---:|
| Laptop | 804,091 |
| Chair | 734,100 |
| Mouse | 710,482 |
| Bottle | 680,886 |
| Watch | 550,438 |

### Top Cities by Net Amount

| City | Net Amount |
|---|---:|
| Bengaluru | 905,682 |
| Pune | 894,771 |
| Lucknow | 586,932 |
| Delhi | 580,313 |
| Mumbai | 544,987 |

### Payment Mode Distribution

| Payment Mode | Orders |
|---|---:|
| Wallet | 89 |
| COD | 88 |
| NetBanking | 87 |
| UPI | 69 |
| Card | 60 |

### Order Status Distribution

| Order Status | Orders |
|---|---:|
| Delivered | 103 |
| Returned | 101 |
| Cancelled | 98 |
| Pending | 91 |

> **Note:** These figures are calculated from the `Clean_Ecommerce.csv` currently included in this repository. Dashboard figures may vary depending on the filters, visuals, and data-source state used in Power BI.

---

# Data Quality Note

The project intentionally demonstrates real-world data-cleaning challenges.

The cleaned CSV still contains some missing values in fields affected by missing source information, particularly:

- Order Date
- Unit Price
- Derived financial fields dependent on Unit Price
- Some date-derived fields

These values were not artificially replaced with arbitrary values. The notebook documents the cleaning decisions that were actually applied.

# Project Outcome

This project demonstrates an end-to-end approach to solving a practical data analytics problem:

**Raw Data → Cleaning → Transformation → SQL Database → Business Analysis → Power BI Dashboard → Insights**

It demonstrates the ability to work across multiple tools commonly used in Data Analyst and Business Intelligence workflows.

---
