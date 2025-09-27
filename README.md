# 📊 Global Layoffs Dataset — SQL Data Cleaning & Analysis

This project demonstrates a **complete SQL-based data cleaning pipeline** applied to a global layoffs dataset. The goal is to transform raw, messy data into a clean, structured format suitable for analysis and reporting.  

It showcases **SQL best practices** such as staging, deduplication, normalization, handling nulls, and standardization—skills essential for real-world data engineering and analytics.

---

## 🚀 Project Overview
- **Dataset**: Global layoffs dataset (companies, industries, locations, funding, and layoff counts).  
- **Objective**: Clean and prepare the dataset for accurate analysis.  
- **Tech Stack**: MySQL (InnoDB, CTEs, Window Functions).  

---

## 🛠️ Key Steps in Data Cleaning
1. **Staging Tables**  
   - Created `layoffs_staging` and `layoffs_staging2` for safe transformations.  

2. **Duplicate Removal**  
   - Used `ROW_NUMBER()` with `PARTITION BY` to identify and delete duplicate rows.  

3. **Standardization**  
   - Trimmed whitespace in text fields.  
   - Unified inconsistent industry labels (e.g., all “Crypto” variations standardized).  
   - Fixed country names (e.g., “United States.” → “United States”).  

4. **Date Formatting**  
   - Converted text-based dates into proper `DATE` format using `STR_TO_DATE()`.  

5. **Handling Nulls**  
   - Replaced blanks with `NULL`.  
   - Populated missing industries by joining on company names.  
   - Removed rows with no meaningful layoff data.  

6. **Final Cleanup**  
   - Dropped helper columns (`row_num`).  
   - Produced a clean, analysis-ready dataset.  

---

## 📂 Repository Structure
Global-Layoffs-Dataset-using-SQL/
│
├── Global_Layoffs_.sql   # Full SQL script for data cleaning pipeline
└── README.md             # Project documentation

---

## 📈 Skills Demonstrated
- SQL **data cleaning & transformation**  
- **Window functions** for deduplication  
- **Data standardization** across categorical fields  
- **Null handling & imputation** strategies  
- **Professional project documentation** for GitHub  

---

## 🔮 Next Steps
- Perform **exploratory data analysis (EDA)** on cleaned dataset.  
- Build **visualizations** (e.g., layoffs by industry, country, year).  
- Extend project into **NLP analysis** of company/industry text fields.  

---

## 🤝 Acknowledgments
Inspired by real-world data cleaning workflows and SQL best practices.  
