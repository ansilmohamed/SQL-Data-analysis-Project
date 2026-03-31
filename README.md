# 🧹 Layoffs Data Cleaning & Analysis — MySQL

A complete end-to-end data cleaning and exploratory analysis project using **MySQL**, built on a real-world dataset of global tech layoffs (2020–2023).

---

## 📌 Project Overview

This project demonstrates a professional data cleaning workflow using MySQL, followed by exploratory data analysis (EDA) to uncover meaningful insights about global tech layoffs. The dataset contains 2,361 raw records of company layoffs across industries, countries, and years.

---

## 🗂️ Project Structure

```
SQL-Data-analysis-project/
│
├── data/
│   └── layoffs.csv               # Raw dataset (source: Alex Freberg / Kaggle)
│
├── sql/
│   ├── 01_data_cleaning.sql      # Full data cleaning pipeline
│   └── 02_data_analysis.sql      # Exploratory data analysis queries
│
└── README.md
```

---

## 🛠️ Tools Used

- **MySQL** — data cleaning, transformation, and analysis
- **MySQL Workbench** — query execution and schema management
- **Git & GitHub** — version control and project hosting

---

## 🧼 Data Cleaning Steps

The raw dataset was cleaned using a **staging table approach** to preserve the original data at all times.

| Step | Description |
|------|-------------|
| 1 | Created `layoffs_staging` table — safe copy of raw data |
| 2 | Fixed date column — converted from `VARCHAR` to proper `DATE` type using `STR_TO_DATE()` |
| 3 | Removed 5 duplicate rows using `ROW_NUMBER()` window function |
| 4 | Standardized `industry` column — unified 3 variations of `Crypto` into one |
| 5 | Standardized `country` column — removed trailing periods from `United States.` |
| 6 | Imputed missing `industry` values using self-join on company name |
| 7 | Deleted 361 rows with no layoff data (`total_laid_off` and `percentage_laid_off` both NULL) |
| 8 | Dropped helper column `row_num` post-cleaning |

**Raw dataset:** 2,361 rows → **Clean dataset:** 1,995 rows

---

## 📊 Key Findings

### 🏢 Top Companies by Total Layoffs
| Company | Total Laid Off |
|---------|---------------|
| Amazon | 18,150 |
| Google | 12,000 |
| Meta | 11,000 |
| Salesforce | 10,090 |
| Microsoft | 10,000 |

### 🏭 Most Affected Industries
| Industry | Total Laid Off |
|----------|---------------|
| Consumer | 45,182 |
| Retail | 43,613 |
| Transportation | 33,748 |
| Finance | 28,344 |

### 🌍 Most Affected Countries
| Country | Total Laid Off |
|---------|---------------|
| United States | 256,559 |
| India | 35,993 |
| Netherlands | 17,220 |

### 📅 Layoffs by Year
| Year | Total Laid Off |
|------|---------------|
| 2022 | 160,661 ← Worst year |
| 2023 | 125,677 ← Partial year |
| 2021 | 15,823 |
| 2020 | 80,998 |

### 🏆 Top Companies Per Year
- **2020** — Dominated by travel & ride-sharing (Uber, Airbnb, Booking.com) — COVID impact
- **2022** — Dominated by Big Tech (Meta, Amazon) — interest rate hikes and growth correction
- **2023** — Continued Big Tech layoffs with no sign of slowing

---

## 💡 Insights & Observations

- **2022 was the worst year** for layoffs, driven by rising interest rates and post-pandemic correction in Big Tech valuations
- **The US accounts for ~66% of all layoffs** in the dataset, reflecting its dominance in the global tech industry
- **Consumer and Retail sectors** were hardest hit overall, while travel companies dominated 2020 layoffs specifically due to COVID-19
- **Even the largest tech companies** (Amazon, Google, Meta, Microsoft) were not immune — showing that scale does not guarantee stability

---

## 📂 Dataset Source

- Dataset: [Alex Freberg's MySQL YouTube Series](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series)
- Original source: Layoffs.fyi

---

## 👤 Author

**Ansil Mohamed**
- 📧 ansilmohamedcp@gmail.com
- 💼 www.linkedin.com/in/ansilmohamed
- 🐙 [github.com/ansilmohamed](https://github.com/ansilmohamed)
