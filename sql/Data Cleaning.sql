
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

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT company, industry
FROM layoffs_staging2
WHERE company IN ('Airbnb', 'Bally\'s Interactive', 'Carvana', 'Juul')
ORDER BY company;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

SELECT company, industry
FROM layoffs_staging2
WHERE company IN ('Airbnb', 'Bally\'s Interactive', 'Carvana', 'Juul')
ORDER BY company;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;   

DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT COUNT(*) FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;
SELECT * FROM layoffs_staging2
LIMIT 10;