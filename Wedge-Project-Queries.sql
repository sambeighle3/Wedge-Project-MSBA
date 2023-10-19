--#1 
WITH filtered_data AS (
  SELECT
    EXTRACT(DATE FROM datetime) AS date,
    EXTRACT(HOUR FROM datetime) AS hour,
    total AS total_spend,
    CONCAT(
      CAST(EXTRACT(DATE FROM datetime) AS STRING),
      CAST(register_no AS STRING),
      CAST(emp_no AS STRING),
      CAST(trans_no AS STRING)
    ) AS transaction_id,
    trans_status
  FROM `wedge-project-sam-beighle.wedge_project_beighle.transArchive_20*`
  WHERE department NOT IN (0, 15)
    AND (trans_status IS NULL OR trans_status IN (' ', 'V', 'R'))
)

SELECT
  date,
  hour,
  SUM(total_spend) AS total_spend,
  COUNT(DISTINCT transaction_id) AS num_transactions,
  SUM(CASE WHEN trans_status IN ('V', 'R') THEN -1 ELSE 1 END) AS items
FROM filtered_data
GROUP BY date, hour
ORDER BY date, hour;

--#2 
WITH filtered_data AS (
  SELECT
    DISTINCT card_no AS card_no,
    EXTRACT(YEAR FROM datetime) AS year,
    EXTRACT(MONTH FROM datetime) AS month,
    total AS sales,
    CONCAT(
      CAST(EXTRACT(DATE FROM datetime) AS STRING),
      CAST(register_no AS STRING),
      CAST(emp_no AS STRING),
      CAST(trans_no AS STRING)
    ) AS transaction_id,
    trans_status
  FROM `wedge-project-sam-beighle.wedge_project_beighle.transArchive_2*`
)

SELECT
  card_no,
  year,
  month,
  SUM(sales) AS sales,
  COUNT(DISTINCT transaction_id) AS transactions,
  SUM(CASE WHEN trans_status IN ('V', 'R') THEN -1 ELSE 1 END) AS items
FROM filtered_data
GROUP BY card_no, year, month
ORDER BY year, month, card_no;

--#3
WITH filtered_data AS (
  SELECT
    transtable.upc,
    transtable.description,
    transtable.department AS dept_number,
    Dept.dept_name,
    EXTRACT(YEAR FROM transtable.datetime) AS year,
    EXTRACT(MONTH FROM transtable.datetime) AS month,
    total AS sales,
    CONCAT(
      CAST(EXTRACT(DATE FROM transtable.datetime) AS STRING),
      CAST(register_no AS STRING),
      CAST(emp_no AS STRING),
      CAST(trans_no AS STRING)
    ) AS transaction_id,
    trans_status
  FROM `wedge-project-sam-beighle.wedge_project_beighle.transArchive_20*` AS transtable
  JOIN `wedge-project-sam-beighle.wedge_project_beighle.department_lookup` AS Dept ON Dept.department = transtable.department
)

SELECT
  upc,
  description,
  dept_number,
  dept_name,
  year,
  month,
  SUM(sales) AS sales,
  COUNT(DISTINCT transaction_id) AS transactions,
  SUM(CASE WHEN trans_status IN ('V', 'R') THEN -1 ELSE 1 END) AS items
FROM filtered_data
GROUP BY upc, description, dept_number, dept_name, year, month
ORDER BY description, upc, year, month, dept_number, dept_name;


--Assesesment Query 
- Total Rows

SELECT count(*) as cnt
FROM `wedge-project-sam-beighle.wedge_project_beighle.transArchive_2*`;
--FROM 


-- January/Oct 2012 Rows 
SELECT EXTRACT(Year from datetime) as Yr,
       EXTRACT(Month from datetime) as Mo,
       count(*)
FROM `wedge-project-sam-beighle.wedge_project_beighle.transArchive_2*` 
--FROM `your_project.your_dataset.your_table_prefix_*` 
GROUP BY Yr, Mo
HAVING Yr = 2012 
ORDER BY Yr, Mo;
-- January = ?
-- October = ?


-- Rows by Month

SELECT EXTRACT(Month from datetime) as Mo,
       count(*) as cnt
FROM `wedge-project-sam-beighle.wedge_project_beighle.transArchive_2*`
--FROM `your_project.your_dataset.your_table_prefix_*` 
WHERE EXTRACT(Year from datetime) <= 2016
GROUP BY Mo
ORDER BY cnt;
-- January = ?
-- October = ?

-- Null Counts

SELECT COUNTIF(trans_subtype is NULL) as Null_TS,
       COUNTIF(datetime is NULL) as Null_DT,
       COUNTIF(local IS NULL) as Null_Local,
       COUNTIF(card_no IS NULL) as Null_CN
FROM`wedge-project-sam-beighle.wedge_project_beighle.transArchive_2*`;
--FROM `your_project.your_dataset.your_table_prefix_*` 
-- Each value


-- High volume cards

SELECT card_no, 
       COUNT(*) as cnt
FROM `wedge-project-sam-beighle.wedge_project_beighle.transArchive_2*`
--FROM `your_project.your_dataset.your_table_prefix_*` 
WHERE card_no != 3
GROUP BY card_no
ORDER BY cnt desc
LIMIT 10;
-- What card is #5 on the list and how many rows does it have?

-- 18736 Rows

SELECT card_no, 
       COUNT(*) as cnt
FROM `wedge-project-sam-beighle.wedge_project_beighle.transArchive_2*`
--FROM `your_project.your_dataset.your_table_prefix_*` 
WHERE card_no = 18736
GROUP BY card_no;
-- How many rows do I have? 


-- Popular Products

SELECT LOWER(Description), 
       COUNT(*) as cnt
FROM `wedge-project-sam-beighle.wedge_project_beighle.transArchive_2*`
--FROM `your_project.your_dataset.your_table_prefix_*` 
WHERE trans_type = "I" AND
      Description != "Discount"
GROUP BY LOWER(Description)
ORDER BY cnt desc
LIMIT 10;
-- Which product is #1? How many rows does it have? 
-- Which product is #4? How many rows does it have? 


-- Single-record items

SELECT 
	COUNT(DISTINCT Description) as SingleRecordItems
FROM (
	SELECT LOWER(Description) as Description,
		   COUNT(*) as cnt
	FROM `wedge-project-sam-beighle.wedge_project_beighle.transArchive_2*`
	--FROM `your_project.your_dataset.your_table_prefix_*` 
  WHERE trans_type = "I" AND Description != "Discount"
	GROUP BY Description
	HAVING cnt = 1
	);

-- Owner Fractions by Year	

SELECT
  Y,
  OwnerRows,
  NonOwnerRows,
  ROUND(OwnerRows/(OwnerRows+NonOwnerRows),4) AS OwnerFrac
FROM (
  SELECT
    EXTRACT(Year
    FROM
      datetime) AS Y,
    COUNTIF(card_no != 3) AS OwnerRows,
    COUNTIF(card_no = 3) AS NonOwnerRows
  FROM
    `wedge-project-sam-beighle.wedge_project_beighle.transArchive_2*`
    --`your_project.your_dataset.your_table_prefix_*` 
  GROUP BY
    Y)
ORDER BY
  Y;
  
-- Which year has the highest portion of owner rows? What year? What fraction?
-- Which year has the lowest portion of owner rows? What year? What fraction?
