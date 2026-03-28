-- Step 1: Create staging table with same structure as original
CREATE TABLE layoffs_staging 
LIKE layoffs;

-- Step 2: Copy all data into staging table
INSERT INTO layoffs_staging
SELECT * FROM layoffs;

-- Step 3: Verify it looks correct
SELECT * FROM layoffs_staging
LIMIT 10;
SET sql_mode = '';

SELECT COUNT(*) FROM layoffs_staging;
SELECT COUNT(*) FROM layoffs;



