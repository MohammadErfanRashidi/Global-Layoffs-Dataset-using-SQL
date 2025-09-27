# Data Cleaning 

select * 
from world_layoffs.layoffs;

# 1. Remove duplicates 
# 2. Standarize the Data
# 3. Null values 

# Creating a staging table 

create table layoffs_staging
like layoffs; 

# Testing the staging

select * 
from world_layoffs.layoffs_staging;

# Inserting the from layoffs

insert world_layoffs.layoffs_staging
select *
from world_layoffs.layoffs;

# Testing layoffs_staging again

select * 
from world_layoffs.layoffs_staging;

# Checking for duplicates with a cte 
	# Check for all columns to see if there is any repeating

with duplicate_cte as
(
select *,
ROW_NUMBER() over(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`,
stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select * 
from duplicate_cte
where row_num > 1;

# Now we create another table and add the row_num column to it

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# Checking our new table 

select *
from layoffs_staging2;

# Inserting duplicates into staging2

insert into layoffs_staging2
select *,
row_number() over(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`,
stage, country, funds_raised_millions) as row_num
from layoffs_staging;

# Checking staging2

select *
from layoffs_staging2;

# Selecting the duplicates

select *
from layoffs_staging2
where row_num > 1;

# Deleting the duplicates

delete 
from layoffs_staging2
where row_num > 1;

# Checking for deleted duplicates

select * 
from layoffs_staging2
where row_num > 1;

# Standarizing 
	# Trimming 

select company, trim(company)
from layoffs_staging2;

# Setting

update layoffs_staging2
set company = trim(company);

# Checking again

select company, trim(company)
from layoffs_staging2;

# Industry
# Analyzing the values

select distinct(industry)
from layoffs_staging2
order by 1;

select * 
from layoffs_staging2
where industry like '%Crypto%';

# updating all to Crypto

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

# Checking 
select * 
from layoffs_staging2
where industry like '%Crypto%';

# Indsutry again

select distinct industry
from layoffs_staging2
order by 1;

# Location 

select distinct(location)
from layoffs_staging2
order by 1;

# Country  

select distinct(country)
from layoffs_staging2
order by 1;

# Fixing the problem

select distinct country, trim(trailing '.' from country)
from layoffs_staging2
where country like ('United States%')
order by 1;

# Updating

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like ('United States%');

# Checking again

select distinct country
from layoffs_staging2
order by 1;

# Date

# Showcasing how to change the date column
select `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
from layoffs_staging2;

# Updating 

update layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

# Checking

SELECT `date`
from layoffs_staging2;

# Altering the column 

alter table layoffs_staging2
modify column `date` DATE;

# Nulls

select *
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is null;

# Setting blanks into nulls

update layoffs_staging2
set industry = null
where industry = '';

select *
from layoffs_staging2
where industry is null;

# Populating 

select t1.industry, t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
where (t1.industry is null) 
and t2.industry is not null;

# Updating

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null) 
and t2.industry is not null; 

# Checking again

select *
from layoffs_staging2
WHERE industry is null;

# Deleting null values in laid offs

DELETE
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is null;

# Check 

select *
from layoffs_staging2
where total_laid_off is NULL
and percentage_laid_off is null;

# Deleting the row_num column 

alter TABLE layoffs_staging2
drop column row_num;

# Check the whole data

SELECT * 
from layoffs_staging2;
