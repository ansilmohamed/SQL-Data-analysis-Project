
CREATE TABLE layoffs (
    company VARCHAR(200),
    location VARCHAR(200),
    industry VARCHAR(200),
    total_laid_off INT,
    percentage_laid_off TEXT,
    `date` VARCHAR(50),
    stage VARCHAR(200),
    country VARCHAR(200),
    funds_raised_millions INT
);
SELECT `date` FROM layoffs LIMIT 20;
SELECT COUNT(*) FROM layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT INTO layoffs_staging
SELECT 
    company, location, industry,
    total_laid_off, percentage_laid_off,
    STR_TO_DATE(`date`, '%m/%d/%Y') AS `date`,
    stage, country, funds_raised_millions
FROM layoffs;

ALTER TABLE layoffs_staging
MODIFY COLUMN `date` DATE;

SELECT `date` FROM layoffs_staging LIMIT 20;
SELECT COUNT(*) FROM layoffs_staging;

-- find duplicates
WITH duplicate_cte AS (
    SELECT *,
    ROW_NUMBER() OVER(
        PARTITION BY company, location, industry, 
                     total_laid_off, percentage_laid_off, 
                     `date`, stage, country, funds_raised_millions
    ) AS row_num
    FROM layoffs_staging
)
SELECT * FROM duplicate_cte
WHERE row_num > 1;

CREATE TABLE layoffs_staging2 AS
SELECT *,
ROW_NUMBER() OVER(
    PARTITION BY company, location, industry, 
                 total_laid_off, percentage_laid_off, 
                 `date`, stage, country, funds_raised_millions
) AS row_num
FROM layoffs_staging;

SELECT * FROM layoffs_staging2
WHERE row_num > 1;

DELETE FROM layoffs_staging2
WHERE row_num > 1;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM layoffs_staging2
WHERE row_num > 1;
SELECT COUNT(*) FROM layoffs_staging2;

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);