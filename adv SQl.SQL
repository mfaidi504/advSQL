/*
SQL practice guide – l3_qlik.pni_dm_edificio_civico_scala
Great! We will use your real Open Fiber table to practise SQL, from basic queries to advanced SQL techniques used in your daily Data Engineering work.

Before writing exercises, let's understand what every SQL command does, when to use it, and how to apply it to your table.

Your table contains information about three main entities:
- Edificio: building information.
- Civico: street number / address information.
- Scala: staircase information inside a building.
It also contains network, FTTH, FWA, PNI, commercial availability, project, and construction information.

I'll use Impala/Hive-compatible SQL syntax where possible.


*/



/*
1. Basic SQL functions
1. MAX() and MIN()
Return the maximum and minimum value in a column.
- MAX() → highest value or latest date.
- MIN() → lowest value or earliest date.
Example:
*/

SELECT
    MAX(edificio_num_totale_ui) AS max_ui,
    MIN(edificio_num_totale_ui) AS min_ui
FROM l3_qlik.pni_dm_edificio_civico_scala;



SELECT
    MIN(edificio_dtt_data_aggiornamento) AS prima_data,
    MAX(edificio_dtt_data_aggiornamento) AS ultima_data
FROM l3_qlik.pni_dm_edificio_civico_scala;

/*
2. DISTINCT
Returns unique values, eliminating duplicates.

For example, find all different regions in the table:

*/


SELECT DISTINCT
    civico_des_regione
FROM l3_qlik.pni_dm_edificio_civico_scala;


/*
Without DISTINCT, you may see the same region thousands of times.
*/


/*
3. COUNT()
Counts rows or non-NULL values.

Three important versions:

Counts all rows.

COUNT(civico_id_building)
Counts only rows where this column is NOT NULL.

*/



COUNT(DISTINCT civico_id_building)



/*
*/
/*
Counts unique, non-NULL building IDs.

Practical example:
*/

SELECT
    COUNT(*) AS totale_record,
    COUNT(civico_id_building) AS building_non_null,
    COUNT(DISTINCT civico_id_building) AS building_unici
FROM l3_qlik.pni_dm_edificio_civico_scala;





/*
4. GROUP BY
Groups rows that have the same value, usually to calculate statistics for each group.

Example: how many records do we have in each region?
*/


SELECT
    civico_des_regione,
    COUNT(*) AS totale
FROM l3_qlik.pni_dm_edificio_civico_scala
GROUP BY civico_des_regione;


--You can group by multiple columns:
SELECT
    civico_des_regione,
    civico_des_provincia,
    COUNT(*) AS totale
FROM l3_qlik.pni_dm_edificio_civico_scala
GROUP BY
    civico_des_regione,
    civico_des_provincia;


/*
5. ORDER BY
Sorts the final results.
- ASC → ascending (smallest to largest, A to Z).
- DESC → descending (largest to smallest, Z to A).

*/

SELECT
    civico_des_regione,
    COUNT(*) AS totale
FROM l3_qlik.pni_dm_edificio_civico_scala
GROUP BY civico_des_regione
ORDER BY totale DESC;


/*
This shows regions with the highest number of records first.
6. IN (...)
Checks whether a value belongs to a list of values.

Instead of writing several OR conditions:
*/

SELECT *
FROM l3_qlik.pni_dm_edificio_civico_scala
WHERE civico_des_regione IN (
    'LAZIO',
    'LOMBARDIA',
    'CAMPANIA'
);


--You can also use NOT IN to exclude values.
/*
7. WHERE
Filters records before grouping and aggregation.
*/

SELECT *
FROM l3_qlik.pni_dm_edificio_civico_scala
WHERE civico_des_regione = 'LAZIO';


--You can combine conditions:
SELECT *
FROM l3_qlik.pni_dm_edificio_civico_scala
WHERE civico_des_regione = 'LAZIO'
  AND edificio_num_totale_ui > 10;


--8. AS
--Creates an alias (a temporary name) for a column or table.
SELECT
    civico_des_comune AS comune,
    civico_des_regione AS regione
FROM l3_qlik.pni_dm_edificio_civico_scala;


--You can also give a name to a calculated result:
SELECT
    SUM(edificio_num_totale_ui) AS totale_ui
FROM l3_qlik.pni_dm_edificio_civico_scala;

/*
9. AND / OR / NOT
Logical operators used to combine conditions.
Operator	Meaning
AND	Both conditions must be true
OR	At least one condition must be true
NOT	Reverses a condition

Example:
*/
SELECT *
FROM l3_qlik.pni_dm_edificio_civico_scala
WHERE civico_des_regione = 'LAZIO'
  AND edificio_num_totale_ui > 5;


/*
2. Filtering and conditional logic
10. IS NULL and IS NOT NULL
Check whether a column has a missing value.

Important: SQL does not use = NULL.
*/
SELECT *
FROM l3_qlik.pni_dm_edificio_civico_scala
WHERE civico_id_building IS NULL;


--For values that exist:
SELECT *
FROM l3_qlik.pni_dm_edificio_civico_scala
WHERE civico_id_building IS NOT NULL;


/*
11. LIKE
Searches for text patterns.

Two important wildcards:
- % → any number of characters.
- _ → exactly one character.
Example: addresses containing VIA.
*/
SELECT *
FROM l3_qlik.pni_dm_edificio_civico_scala
WHERE UPPER(civico_des_indirizzo) LIKE '%VIA%';


--Other examples:
-- Starts with ROMA
WHERE UPPER(civico_des_comune) LIKE 'ROMA%'

-- Ends with ROMA
WHERE UPPER(civico_des_comune) LIKE '%ROMA'

-- Contains ROMA
WHERE UPPER(civico_des_comune) LIKE '%ROMA%'


/*
12. CASE WHEN THEN ELSE
Allows you to create conditional logic inside SQL.

Think of it as if / else in programming.

Example: classify buildings according to their number of residential units.
*/
SELECT
    edificio_cod_edificio,
    edificio_num_totale_ui,

    CASE
        WHEN edificio_num_totale_ui >= 50 THEN 'LARGE'
        WHEN edificio_num_totale_ui >= 20 THEN 'MEDIUM'
        WHEN edificio_num_totale_ui > 0 THEN 'SMALL'
        ELSE 'NO UNITS'
    END AS building_category

FROM l3_qlik.pni_dm_edificio_civico_scala;


--SQL evaluates the conditions from top to bottom.


--13. COALESCE()
--Returns the first value that is NOT NULL.

--Example:
SELECT
    COALESCE(
        civico_des_comune,
        'UNKNOWN'
    ) AS comune
FROM l3_qlik.pni_dm_edificio_civico_scala;


--If the municipality is NULL, it returns UNKNOWN.

--You can use multiple columns:
COALESCE(
    des_indirizzo_master,
    civico_des_indirizzo,
    'ADDRESS UNKNOWN'
)


/*
14. 
Means NOT EQUAL TO.

Example:
*/
SELECT *
FROM l3_qlik.pni_dm_edificio_civico_scala
WHERE civico_des_regione <> 'LAZIO';


--It excludes Lazio, but also excludes NULL values because comparisons with NULL are unknown.
--15. HAVING
--Filters groups after GROUP BY.
/*
The difference:
- WHERE filters individual rows before aggregation.
- HAVING filters groups after aggregation.
Example: municipalities with more than 1,000 records.
*/
SELECT
    civico_des_comune,
    COUNT(*) AS totale
FROM l3_qlik.pni_dm_edificio_civico_scala
GROUP BY civico_des_comune
HAVING COUNT(*) > 1000;


--You can combine both:
SELECT
    civico_des_comune,
    COUNT(*) AS totale
FROM l3_qlik.pni_dm_edificio_civico_scala
WHERE civico_des_regione = 'LAZIO'
GROUP BY civico_des_comune
HAVING COUNT(*) > 100;


/*
3. Aggregation functions
16. SUM() and AVG()
- SUM() calculates the total.
- AVG() calculates the average.
Example:

*/
SELECT
    SUM(edificio_num_totale_ui) AS totale_ui,
    AVG(edificio_num_totale_ui) AS media_ui,
    MAX(edificio_num_totale_ui) AS massimo_ui,
    MIN(edificio_num_totale_ui) AS minimo_ui
FROM l3_qlik.pni_dm_edificio_civico_scala;


--You can also calculate averages by region:
SELECT
    civico_des_regione,
    AVG(edificio_num_totale_ui) AS media_ui
FROM l3_qlik.pni_dm_edificio_civico_scala
GROUP BY civico_des_regione;

/*
17. COUNT() OVER (PARTITION BY ...)
This is a window function.

Unlike GROUP BY, it does not reduce the number of rows.

It calculates a value for each row based on a group of related rows.
*/
--Example:
SELECT
    cod_comune_istat,
    civico_des_comune,
    COUNT(*) OVER (
        PARTITION BY cod_comune_istat
    ) AS totale_record_comune
FROM l3_qlik.pni_dm_edificio_civico_scala;


--Every record belonging to the same municipality receives the same count.
/*
18. ROW_NUMBER() OVER (...)
Assigns a sequential number to each row.

This is especially useful for identifying duplicates, first records, last records, and selecting one record per group.

Your example:

*/
ROW_NUMBER() OVER (
    PARTITION BY cod_start, cod_end
    ORDER BY seq_no
) AS rn

/*
Explanation:
- PARTITION BY cod_start, cod_end: creates a separate group for each pair.
- ORDER BY seq_no: sorts records within each group.
- ROW_NUMBER(): assigns 1, 2, 3, 4...
Using your table:
*/
SELECT
    edificio_cod_edificio,
    scala_cod_scala,
    scala_dtt_data_aggiornamento,

    ROW_NUMBER() OVER (
        PARTITION BY edificio_cod_edificio
        ORDER BY scala_dtt_data_aggiornamento DESC
    ) AS rn

FROM l3_qlik.pni_dm_edificio_civico_scala;


--Here, rn = 1 represents the most recently updated staircase record for each building (assuming the date is populated).
--19. SUM() OVER (...)
--Calculates a sum across a window without collapsing the rows.

--Example:
SELECT
    civico_des_comune,
    edificio_num_totale_ui,

    SUM(edificio_num_totale_ui) OVER (
        PARTITION BY civico_des_comune
    ) AS totale_ui_comune

FROM l3_qlik.pni_dm_edificio_civico_scala;


-- 20. ORDER BY inside OVER()
-- Important distinction:
COUNT(*) OVER (
    PARTITION BY edificio_cod_edificio
)


-- Counts all records in each building partition.

-- But:
COUNT(*) OVER (
    PARTITION BY edificio_cod_edificio
    ORDER BY scala_cod_scala
)


-- In common Impala/Hive window-function implementations, adding ORDER BY can produce a running count rather than the total count.

-- For a total count, omit ORDER BY.

-- For a running count, use it intentionally.


-- 4. Combining tables and queries
-- 21. JOIN
-- A JOIN combines information from two tables using a common column.

-- For example, imagine you have:
-- - Table A: building information.
-- - Table B: building network information.
-- You can combine them using edificio_cod_edificio.

-- There are four important types:
-- INNER JOIN

-- Returns only records matching in both tables.

-- LEFT JOIN

-- Returns all records from A, including matches from B. Missing matches from B become NULL.

-- RIGHT JOIN

-- Returns all records from B, including matching records from A.

-- FULL OUTER JOIN

-- Returns all records from both tables, matching where possible.

-- Example using your table twice:
SELECT
    a.edificio_cod_edificio,
    a.edificio_des_nome,
    b.scala_cod_scala,
    b.scala_num_totale_ui

FROM l3_qlik.pni_dm_edificio_civico_scala a

INNER JOIN l3_qlik.pni_dm_edificio_civico_scala b

    ON a.edificio_cod_edificio =
       b.edificio_cod_edificio;


-- Here:
-- - a and b are table aliases.
-- - ON defines the matching condition.
-- This is a self-join because we are joining the same table to itself.

-- Important: A self-join can multiply records if the building has multiple staircase records. Always check the cardinality before joining.
-- 22. UNION
-- Combines the results of two SELECT queries vertically.

-- Example:
SELECT
    edificio_cod_edificio AS codice,
    'EDIFICIO' AS tipo
FROM l3_qlik.pni_dm_edificio_civico_scala

UNION

SELECT
    scala_cod_edificio AS codice,
    'SCALA' AS tipo
FROM l3_qlik.pni_dm_edificio_civico_scala;


-- Important differences:
-- UNION	UNION ALL
-- Removes duplicate rows	Keeps duplicate rows
-- Usually more expensive	Usually faster
-- Returns unique combinations	Returns all combinations

-- Both queries must have the same number of columns and compatible data types.
-- 23. CTE – WITH ... AS (...)
-- CTE means Common Table Expression.

-- It allows you to create a temporary named result that you can use inside a larger query.

-- Think of it as dividing a complicated SQL query into smaller steps.

-- Example:
WITH base AS (

    SELECT
        edificio_cod_edificio,
        edificio_num_totale_ui,
        civico_des_comune

    FROM l3_qlik.pni_dm_edificio_civico_scala

    WHERE civico_des_regione = 'LAZIO'

)

SELECT
    civico_des_comune,
    SUM(edificio_num_totale_ui) AS totale_ui

FROM base

GROUP BY civico_des_comune;


-- The process:
-- 1. WITH base AS creates a temporary result.
-- 2. The first SELECT retrieves Lazio records.
-- 3. The final SELECT uses the result called base.
-- 4. The result is grouped by municipality.
-- You can create multiple CTEs:
WITH base AS (
    SELECT *
    FROM l3_qlik.pni_dm_edificio_civico_scala
),

edifici AS (
    SELECT DISTINCT edificio_cod_edificio
    FROM base
)

SELECT *
FROM edifici;


-- This is particularly useful for the complex queries you work with at Open Fiber.

-- 5. Data types and text manipulation
-- 24. CAST()
-- Converts a value from one data type to another.

-- For example, converting a number to a string:
SELECT
    CAST(edificio_cod_edificio AS STRING) AS codice
FROM l3_qlik.pni_dm_edificio_civico_scala;


//Converting a string into a number:
SELECT
    CAST(civico_des_address_number AS INT) AS numero_civico
FROM l3_qlik.pni_dm_edificio_civico_scala;


-- Converting a number into a decimal:
-- CAST(edificio_num_totale_ui AS DOUBLE)


-- Be careful: if the original value cannot be converted, the operation may return an error or NULL depending on the engine and function used.
-- 25. CONCAT()
-- Combines multiple strings into one string.

--Example:
SELECT
    CONCAT(
        civico_des_indirizzo,
        ' ',
        civico_des_address_number,
        ', ',
        civico_des_comune
    ) AS indirizzo_completo

FROM l3_qlik.pni_dm_edificio_civico_scala;


-- Example result:

-- Via Roma 25, Milano

-- Useful for creating unique identifiers or complete addresses.
-- 26. UPPER()
-- Converts text into uppercase.
SELECT
    UPPER(civico_des_comune) AS comune
FROM l3_qlik.pni_dm_edificio_civico_scala;


-- For example:

-- Milano → MILANO

-- Useful when data contains inconsistent uppercase/lowercase values.
27. TRIM()
--Removes unnecessary spaces from the beginning and end of text.
SELECT
    TRIM(civico_des_indirizzo) AS indirizzo
FROM l3_qlik.pni_dm_edificio_civico_scala;


-- Example:

-- '   Via Roma  ' → 'Via Roma'

-- You can combine both:
-- UPPER(TRIM(civico_des_comune))


-- This is useful for data cleaning.
-- 28. REGULAR EXPRESSION (REGEX)
-- A regular expression is a pattern used to search, validate, or extract text.

-- For example, RLIKE checks whether a string matches a regular expression.
SELECT *
FROM l3_qlik.pni_dm_edificio_civico_scala
WHERE civico_des_address_number RLIKE '^[0-9]+$';


-- This finds address numbers containing only digits.

-- Some useful patterns:
-- Regex	Meaning
-- ^[0-9]+$	Only digits
-- ^[A-Z]+$	Only uppercase letters
-- ^[0-9]{5}$	Exactly five digits
-- .*ROMA.*	Contains ROMA
-- ^[A-Z]	Starts with an uppercase letter
-- ^[0-9]+[A-Z]?$	Digits optionally followed by one letter

-- In Impala, RLIKE is commonly used for regex matching.
29. RAND()
Generates a random decimal number between 0 and 1.
SELECT
    edificio_cod_edificio,
    RAND() AS numero_casuale

FROM l3_qlik.pni_dm_edificio_civico_scala;


-- Useful when you want to take a random sample of records.

For example:
SELECT *
FROM l3_qlik.pni_dm_edificio_civico_scala
ORDER BY RAND()
LIMIT 100;


-- This selects 100 randomly ordered records.

-- For very large tables, random sorting can be expensive.

-- 6. Dates, sorting and result limits
-- 30. TO_DATE()
-- Extracts the date portion of a timestamp, removing the time.

-- Example:
SELECT
    TO_DATE(edificio_dtt_data_aggiornamento) AS data_aggiornamento

FROM l3_qlik.pni_dm_edificio_civico_scala;


-- A timestamp such as:

-- 2026-11-05 14:30:45

-- Becomes:

-- 2026-11-05

--You can also filter by date:
SELECT *
FROM l3_qlik.pni_dm_edificio_civico_scala
WHERE TO_DATE(edificio_dtt_data_aggiornamento)
      = '2026-11-05';


-- Note: exact function compatibility can depend on the Impala/Hive version.
-- 31. LIMIT
-- Restricts the number of returned records.
SELECT *
FROM l3_qlik.pni_dm_edificio_civico_scala
LIMIT 10;


-- Returns only 10 records.

-- You can combine it with ORDER BY:
SELECT
    edificio_cod_edificio,
    edificio_num_totale_ui

FROM l3_qlik.pni_dm_edificio_civico_scala

ORDER BY edificio_num_totale_ui DESC

LIMIT 20;


-- Returns the 20 records with the highest number of units.
-- 32. DESCRIBE TABLE
-- Shows the structure of a table, including:
-- - Column names.
-- - Data types.
-- - Comments, if available.
-- Your example:
-- DESCRIBE l3_qlik.pni_dm_edificio_civico_scala;


-- You can also use:
-- DESCRIBE TABLE l3_qlik.pni_dm_edificio_civico_scala;


-- Useful when starting work with an unfamiliar database.


-- 7. Quick reference – all SQL commands
-- Here is your complete checklist.
-- SQL command	What it does
-- MAX()	Finds maximum value
-- MIN()	Finds minimum value
-- DISTINCT	Removes duplicates
-- COUNT()	Counts records
-- GROUP BY	Groups records
-- ORDER BY	Sorts results
-- ASC	Ascending order
-- DESC	Descending order
-- IN()	Checks values in a list
-- WHERE	Filters records
-- AS	Creates aliases
-- AND / OR / NOT	Combines conditions
-- IS NULL	Finds missing values
-- IS NOT NULL	Finds existing values
-- LIKE	Searches text patterns
-- CASE WHEN	Creates conditional logic
-- ELSE	Defines the alternative condition
-- THEN	Defines the result of a condition
-- HAVING	Filters aggregated groups
-- SUM()	Calculates a total
-- AVG()	Calculates an average
-- ROW_NUMBER()	Numbers rows within groups
-- COUNT() OVER()	Counts records using a window
-- SUM() OVER()	Calculates window totals
-- PARTITION BY	Divides window functions into groups
-- JOIN	Combines tables
-- INNER JOIN	Returns matching records
-- LEFT JOIN	Keeps all left-side records
-- RIGHT JOIN	Keeps all right-side records
-- FULL OUTER JOIN	Keeps records from both sides
-- UNION	Combines queries and removes duplicates
-- UNION ALL	Combines queries and keeps duplicates
-- WITH ... AS	Creates a CTE
-- CAST()	Converts data types
-- CONCAT()	Combines strings
-- UPPER()	Converts text to uppercase
-- TRIM()	Removes surrounding spaces
-- RLIKE	Searches using regex
-- RAND()	Generates random numbers
-- <>	Not equal
-- COALESCE()	Returns the first non-NULL value
-- TO_DATE()	Extracts date from timestamp
-- LIMIT	Restricts result count
-- DESCRIBE TABLE	Shows table structure

-- Two small corrections to remember:
-- - It is AVG(), not AVA().
-- - It is COUNT(*) or COUNT(column), not an empty COUNT().

-- 8. How I recommend practising
-- I suggest dividing the training into five levels, using only your Open Fiber table.
-- Level 1 – Basic SQL
-- Beginner

-- SELECT, WHERE, DISTINCT, COUNT, MIN, MAX, ORDER BY, LIMIT, IN.

-- Level 2 – Data analysis
-- Intermediate

-- GROUP BY, HAVING, SUM, AVG, CASE WHEN, LIKE, NULL, COALESCE.

-- Level 3 – Data manipulation
-- Intermediate

-- CAST, CONCAT, UPPER, TRIM, REGEX, TO_DATE, RAND.

-- Level 4 – Advanced SQL
-- Advanced

-- JOIN, UNION, CTE, ROW_NUMBER, COUNT OVER, SUM OVER, PARTITION BY.

-- Level 5 – Real Open Fiber scenarios
-- Professional

-- Building duplicates, civico validation, scala analysis, FTTH availability, vendibilità, and identifying the latest records.

-- My recommendation: Don't just memorise SQL syntax. Practise thinking like a Data Engineer: understand the data, formulate the question, write the query, and validate the result.

-- We can use your actual 150 columns to create realistic exercises, one at a time. I'll give you a business problem, you write the SQL query, and I'll correct it and explain any mistakes.




-- /*

-- */

-- المعنى المحتمل:
-- - Circuito واحد يمكن أن يحتوي على عدة Segmenti.
-- - كل Segmento يرتبط بـ Circuito واحد.
-- لكن يجب أن نثبت ذلك من البيانات.

-- اختبار عدد المقاطع لكل دائرة:

SELECT
    cod_circuito,
    COUNT(*) AS numero_segmenti
FROM l3_qlik.pni_dm_segmento
GROUP BY cod_circuito
ORDER BY numero_segmenti DESC
LIMIT 20;


-- إذا وجدت دوائر لها أكثر من Segmento، فهذا يدعم فرضية One-to-Many.

-- اختبار وجود Segmenti دون Circuito مطابق:
SELECT COUNT(*) AS segmenti_without_circuito
FROM l3_qlik.pni_dm_segmento s
LEFT JOIN l3_qlik.pni_dm_circuito c
    ON s.cod_circuito = c.cod_circuito
WHERE c.cod_circuito IS NULL;


-- هذا يساعدنا على اكتشاف السجلات التي لا تجد دائرة مقابلة لها.

-- 5. Data Profiling – استكشاف البيانات
-- الآن نريد أن نفهم محتوى الأعمدة، وليس فقط أسماءها.
-- A. عدد السجلات
SELECT COUNT(*) AS total_circuiti
FROM l3_qlik.pni_dm_circuito;


SELECT COUNT(*) AS total_segmenti
FROM l3_qlik.pni_dm_segmento;


-- B. معرفة القيم المختلفة (DISTINCT)
-- مثلاً، ما أنواع الدوائر الموجودة؟
SELECT DISTINCT des_tipo_circuito
FROM l3_qlik.pni_dm_circuito;


-- ما حالات الدوائر؟
SELECT DISTINCT des_stato_circuito
FROM l3_qlik.pni_dm_circuito;


-- ما أنواع الألياف؟
SELECT DISTINCT des_tipo_fibra
FROM l3_qlik.pni_dm_segmento;


-- C. معرفة توزيع الحالات (GROUP BY)
SELECT
    des_stato_circuito,
    COUNT(*) AS numero_circuiti
FROM l3_qlik.pni_dm_circuito
GROUP BY des_stato_circuito
ORDER BY numero_circuiti DESC;


-- هذا يخبرك بعدد الدوائر في كل حالة.
-- D. فحص القيم الفارغة (NULL)
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN cod_circuito IS NULL THEN 1 ELSE 0 END)
        AS null_cod_circuito,
    SUM(CASE WHEN des_nome_circuito IS NULL THEN 1 ELSE 0 END)
        AS null_nome_circuito,
    SUM(CASE WHEN des_stato_circuito IS NULL THEN 1 ELSE 0 END)
        AS null_stato
FROM l3_qlik.pni_dm_circuito;


-- ونفس الفكرة في جدول Segmento:
SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN cod_segmento IS NULL THEN 1 ELSE 0 END)
        AS null_cod_segmento,
    SUM(CASE WHEN cod_circuito IS NULL THEN 1 ELSE 0 END)
        AS null_cod_circuito,
    SUM(CASE WHEN num_numero_fibre IS NULL THEN 1 ELSE 0 END)
        AS null_numero_fibre
FROM l3_qlik.pni_dm_segmento;



-- 6. Data Quality – جودة البيانات
-- هنا نبدأ بالتفكير كمحللي بيانات.

-- مثلاً: هل يوجد تكرار في cod_segmento؟
SELECT
    cod_segmento,
    COUNT(*) AS occurrences
FROM l3_qlik.pni_dm_segmento
GROUP BY cod_segmento
HAVING COUNT(*) > 1
ORDER BY occurrences DESC;


-- هل توجد دوائر بدون اسم؟
SELECT *
FROM l3_qlik.pni_dm_circuito
WHERE des_nome_circuito IS NULL
   OR TRIM(des_nome_circuito) = '';


-- هل توجد قيم غير منطقية في عدد الألياف؟
SELECT *
FROM l3_qlik.pni_dm_segmento
WHERE num_numero_fibre < 0;


-- هل يوجد تاريخ نهاية صلاحية أقدم من تاريخ البداية؟
SELECT *
FROM l3_qlik.pni_dm_circuito
WHERE dtt_fin_val < dtt_ini_val;


-- هذا الاختبار الأخير مهم لفهم الأعمدة الزمنية.

-- 7. فهم التواريخ والتاريخية (Temporal Data)
-- لدينا أعمدة مثل:
-- - dtt_ini_val
-- - dtt_fin_val
-- - dtt_data_attivazione
-- - dtt_data_aggiornamento
-- - dtt_load_start
-- وجود dtt_ini_val وdtt_fin_val قد يشير إلى صلاحية زمنية للسجل، لكن يجب التحقق من معناهما في توثيق النظام.

-- جرّب:
SELECT
    MIN(dtt_ini_val) AS first_start,
    MAX(dtt_ini_val) AS last_start,
    MIN(dtt_fin_val) AS first_end,
    MAX(dtt_fin_val) AS last_end
FROM l3_qlik.pni_dm_circuito;


-- ولمعرفة أحدث تحديث:
SELECT *
FROM l3_qlik.pni_dm_circuito
ORDER BY dtt_data_aggiornamento DESC
LIMIT 20;


-- مفهوم إضافي: ROW_NUMBER

-- إذا تكررت الدائرة بسبب وجود أكثر من نسخة زمنية، يمكننا ترتيب النسخ حسب تاريخ التحديث:
SELECT
    cod_circuito,
    des_nome_circuito,
    dtt_data_aggiornamento,
    ROW_NUMBER() OVER (
        PARTITION BY cod_circuito
        ORDER BY dtt_data_aggiornamento DESC
    ) AS rn
FROM l3_qlik.pni_dm_circuito;


-- هنا:
-- - PARTITION BY cod_circuito: يقسم السجلات حسب الدائرة.
-- - ORDER BY ... DESC: يضع الأحدث أولاً.
-- - ROW_NUMBER(): يعطي كل سجل رقماً ترتيبياً.
-- يمكن استخدام rn = 1 لاختيار أحدث سجل لكل دائرة، ولكن فقط إذا كان هذا هو المطلوب تجارياً، وبعد التأكد من قواعد التاريخية.

-- 8. JOIN – ربط الجدولين
-- الآن نصل إلى التطبيق العملي.

-- نريد عرض اسم الدائرة مع المقاطع المرتبطة بها.
SELECT
    c.cod_circuito,
    c.des_nome_circuito,
    c.des_stato_circuito,
    s.cod_segmento,
    s.des_nome_segmento,
    s.des_stato_segmento,
    s.num_numero_fibre
FROM l3_qlik.pni_dm_circuito c
LEFT JOIN l3_qlik.pni_dm_segmento s
    ON c.cod_circuito = s.cod_circuito
LIMIT 100;


-- لماذا استخدمنا LEFT JOIN؟

-- لأننا نريد الاحتفاظ بجميع الدوائر، حتى الدوائر التي لا تحتوي على مقاطع مطابقة.

-- لكن هناك خطر مهم:

-- إذا كان cod_circuito مكرراً في جدول pni_dm_circuito، فإن JOIN قد يضاعف عدد النتائج أكثر مما نتوقع.

-- لذلك لا تنفّذ JOIN قبل أن تفحص التكرار في الطرفين وتفهم الـ Grain.

-- 9. CTE – تنظيم الاستعلامات
-- يمكننا تنظيم التحليل باستخدام WITH:
WITH circuiti AS (
    SELECT
        cod_circuito,
        des_nome_circuito,
        des_stato_circuito
    FROM l3_qlik.pni_dm_circuito
),

segmenti AS (
    SELECT
        cod_circuito,
        COUNT(*) AS numero_segmenti,
        SUM(num_numero_fibre) AS totale_fibre
    FROM l3_qlik.pni_dm_segmento
    GROUP BY cod_circuito
)

SELECT
    c.cod_circuito,
    c.des_nome_circuito,
    c.des_stato_circuito,
    COALESCE(s.numero_segmenti, 0) AS numero_segmenti,
    COALESCE(s.totale_fibre, 0) AS totale_fibre
FROM circuiti c
LEFT JOIN segmenti s
    ON c.cod_circuito = s.cod_circuito;


-- ما الذي فعلناه؟
-- 1. أنشأنا CTE باسم circuiti.
-- 2. أنشأنا CTE باسم segmenti.
-- 3. حسبنا عدد المقاطع لكل دائرة.
-- 4. حسبنا مجموع الألياف لكل دائرة.
-- 5. ربطنا النتيجتين.
-- لماذا استخدمنا COALESCE؟

-- إذا لم توجد مقاطع لدائرة معينة، فستكون نتيجة numero_segmenti فارغة بعد JOIN. استخدمنا COALESCE لتحويلها إلى صفر.

-- ملاحظة: مجموع الألياف هنا مجموع القيم المسجلة في المقاطع، وليس بالضرورة عدد الألياف الفيزيائية الفريدة في الشبكة.

-- 10. Data Lineage – مصدر البيانات ومسارها
-- عندما ترى الجدولين في l3_qlik، لا تفترض أنهما الجداول الأصلية.

-- يجب أن تسأل:
-- - هل pni_dm_circuito مصدر مباشر من PNI؟
-- - هل تم تحميله من جدول آخر؟
-- - ما معنى dtt_load_start؟
-- - هل الجدول يحتفظ بالتاريخ أم يعرض الحالة الحالية؟
-- - هل توجد عمليات ETL أو transformations قبل وصول البيانات إلى l3_qlik؟
-- يمكنك البدء بمراجعة وصف الجدول:
DESCRIBE FORMATTED l3_qlik.pni_dm_circuito;


-- ونفس الأمر للجدول الثاني.

-- قد تجد معلومات عن التخزين أو مصدر البيانات أو خصائص الجدول، بحسب صلاحياتك وطريقة إنشائه.

-- 11. تطبيق مفاهيم SQL التي تريد تعليمها
-- هذه أمثلة تربط أوامر SQL ببياناتنا الفعلية:
-- المفهوم	مثال الاستخدام
-- MAX / MIN	أحدث وأقدم تاريخ تحديث
-- COUNT	عدد الدوائر والمقاطع
-- DISTINCT	أنواع الدوائر وحالاتها
-- GROUP BY	عدد المقاطع لكل دائرة
-- ORDER BY	ترتيب الدوائر حسب عدد المقاطع
-- HAVING	الدوائر التي لديها أكثر من 5 مقاطع
-- CASE WHEN	تصنيف الدوائر حسب الحالة
-- CAST	تحويل نوع البيانات
-- JOIN	ربط الدوائر بالمقاطع
-- UNION	دمج نتائج متوافقة من جداول مختلفة
-- WITH	تنظيم الاستعلامات باستخدام CTE
-- ROW_NUMBER	اختيار أحدث نسخة لكل دائرة
-- COUNT OVER	حساب عدد السجلات لكل دائرة دون تجميع الصفوف
-- CONCAT	تكوين وصف من اسم الدائرة وكودها
-- IS NULL	اكتشاف القيم المفقودة
-- LIKE	البحث عن أسماء دوائر بنمط معين
-- REGEXP	فحص نمط الأكواد
-- SUM	مجموع الألياف
-- AVG	متوسط عدد الألياف
-- LIMIT	عرض عدد محدود من السجلات
-- UPPER / TRIM	توحيد النصوص وتنظيفها
-- RAND	اختيار عينة عشوائية
-- <>	استبعاد حالة معينة
-- TO_DATE	استخراج التاريخ دون الوقت
-- IN	البحث عن مجموعة من الحالات

-- مثال إضافي على HAVING:
SELECT
    cod_circuito,
    COUNT(*) AS numero_segmenti
FROM l3_qlik.pni_dm_segmento
GROUP BY cod_circuito
HAVING COUNT(*) > 5
ORDER BY numero_segmenti DESC;


-- ومثال على CASE WHEN:
SELECT
    cod_circuito,
    des_stato_circuito,
    CASE
        WHEN des_stato_circuito IS NULL THEN 'Sconosciuto'
        WHEN UPPER(des_stato_circuito) LIKE '%ATTIV%' THEN 'Attivo'
        ELSE 'Altro'
    END AS categoria_stato
FROM l3_qlik.pni_dm_circuito;


-- هذا مجرد تصنيف تجريبي؛ يجب معرفة القيم الفعلية ومعانيها قبل اعتماد منطق التصنيف.

-- أكيد. خلينا نطبّق أنواع الـ JOIN الأربعة على الجدولين الحقيقيين من Open Fiber:
-- - l3_qlik.pni_dm_circuito
-- - l3_qlik.pni_dm_segmento
-- وسنستخدم العمود المشترك:
-- c.cod_circuito = s.cod_circuito


-- الفكرة الأساسية: نريد معرفة كيف نربط الدوائر (Circuiti) بالمقاطع (Segmenti).
-- 1. INNER JOIN
-- السجلات المتطابقة فقط
-- الهدف: إظهار الدوائر التي لديها مقاطع مرتبطة بها، وإظهار المقاطع التي لديها دائرة مطابقة.
SELECT
    c.cod_circuito,
    c.des_nome_circuito,
    c.des_stato_circuito,
    s.cod_segmento,
    s.des_nome_segmento,
    s.num_numero_fibre
FROM l3_qlik.pni_dm_circuito c
INNER JOIN l3_qlik.pni_dm_segmento s
    ON c.cod_circuito = s.cod_circuito
LIMIT 100;


-- ماذا يحدث؟
-- - إذا وجدنا Circuito في الجدول الأول وله Segmento مطابق في الجدول الثاني، يظهر في النتيجة.
-- - إذا لم توجد دائرة مطابقة للمقطع، لا يظهر.
-- - إذا كانت الدائرة لا تملك أي مقطع، لا تظهر أيضاً.
-- مثال توضيحي:
-- Circuito	Segmento
-- C1	S1
-- C1	S2
-- C2	S3
-- C3	لا يوجد

-- نتيجة INNER JOIN:
-- Circuito	Segmento
-- C1	S1
-- C1	S2
-- C2	S3

-- لاحظ أن C3 اختفى لأنه لا يملك Segmento مطابقاً.

-- متى نستخدمه؟

-- عندما نريد تحليل الدوائر التي لديها مقاطع مرتبطة فعلياً.

-- 2. LEFT JOIN
-- كل سجلات الجدول الأيسر
-- الهدف: إظهار جميع الدوائر، سواء كان لديها مقاطع أم لا.
SELECT
    c.cod_circuito,
    c.des_nome_circuito,
    s.cod_segmento,
    s.des_nome_segmento
FROM l3_qlik.pni_dm_circuito c
LEFT JOIN l3_qlik.pni_dm_segmento s
    ON c.cod_circuito = s.cod_circuito
LIMIT 100;


-- ماذا يحدث؟
-- - كل الدوائر تظهر.
-- - إذا كانت الدائرة مرتبطة بمقاطع، تظهر بيانات المقاطع.
-- - إذا لم تكن مرتبطة بأي مقطع، تظهر بيانات الدائرة وتكون أعمدة Segmento بقيمة NULL.
-- مثال:
-- Circuito	Segmento
-- C1	S1
-- C1	S2
-- C2	S3
-- C3	NULL

-- مثال عملي في Open Fiber:

-- نريد معرفة جميع الدوائر، واكتشاف الدوائر التي ليس لديها أي Segmento.
SELECT
    c.cod_circuito,
    c.des_nome_circuito,
    c.des_stato_circuito
FROM l3_qlik.pni_dm_circuito c
LEFT JOIN l3_qlik.pni_dm_segmento s
    ON c.cod_circuito = s.cod_circuito
WHERE s.cod_circuito IS NULL;


-- هذا الاستعلام يبحث عن الدوائر التي لا تجد أي سجل مطابق في جدول Segmento.

-- متى نستخدمه؟

-- عندما نريد الاحتفاظ بكل سجلات الجدول الأساسي، حتى لو لم يكن لها ارتباط في الجدول الثاني.

-- 3. RIGHT JOIN
-- كل سجلات الجدول الأيمن
-- الهدف: إظهار جميع المقاطع (Segmenti)، حتى لو لم نجد لها دائرة مطابقة.
SELECT
    c.cod_circuito,
    c.des_nome_circuito,
    s.cod_segmento,
    s.des_nome_segmento,
    s.num_numero_fibre
FROM l3_qlik.pni_dm_circuito c
RIGHT JOIN l3_qlik.pni_dm_segmento s
    ON c.cod_circuito = s.cod_circuito
LIMIT 100;


-- ماذا يحدث؟
-- - كل المقاطع تظهر.
-- - إذا وجدنا دائرة مطابقة، تظهر بياناتها.
-- - إذا لم نجد دائرة مطابقة، تظهر بيانات المقطع وتكون أعمدة Circuito بقيمة NULL.
-- مثال:
-- Circuito	Segmento
-- C1	S1
-- C1	S2
-- C2	S3
-- NULL	S4

-- في هذا المثال S4 موجود في جدول Segmento، لكنه لا يملك دائرة مطابقة في جدول Circuito.

-- مثال عملي:

-- نريد اكتشاف المقاطع التي لا ترتبط بأي دائرة موجودة في الجدول الأول:
SELECT
    s.cod_segmento,
    s.cod_circuito,
    s.des_nome_segmento
FROM l3_qlik.pni_dm_circuito c
RIGHT JOIN l3_qlik.pni_dm_segmento s
    ON c.cod_circuito = s.cod_circuito
WHERE c.cod_circuito IS NULL;


-- متى نستخدمه؟

-- عندما يكون الجدول الثاني هو الذي نريد الاحتفاظ بجميع سجلاته، حتى دون وجود تطابق.

-- ملاحظة: يمكن تنفيذ نفس الفكرة باستخدام LEFT JOIN مع عكس ترتيب الجدولين.

-- 4. CROSS JOIN
-- كل التركيبات الممكنة
-- الهدف: إنشاء جميع التركيبات الممكنة بين سجلات الجدولين، دون شرط ربط.
SELECT
    c.cod_circuito,
    c.des_nome_circuito,
    s.cod_segmento,
    s.des_nome_segmento
FROM l3_qlik.pni_dm_circuito c
CROSS JOIN l3_qlik.pni_dm_segmento s
LIMIT 100;


-- ماذا يحدث؟

-- كل Circuito يتم دمجه مع كل Segmento، بغض النظر عن العلاقة بينهما.

-- مثال:

-- جدول Circuito:
-- Circuito
-- C1
-- C2

-- جدول Segmento:
-- Segmento
-- S1
-- S2
-- S3

-- نتيجة CROSS JOIN:
-- Circuito	Segmento
-- C1	S1
-- C1	S2
-- C1	S3
-- C2	S1
-- C2	S2
-- C2	S3

-- عدد النتائج = عدد صفوف الجدول الأول × عدد صفوف الجدول الثاني.

-- في مثالنا:

-- 2 × 3 = 6 سجلات.

-- متى نستخدمه؟
-- - إنشاء جميع التركيبات الممكنة.
-- - بناء مصفوفة احتمالات أو سيناريوهات.
-- - إعداد مجموعات اختبار.
-- انتبه: لا تستخدمه مباشرة على جدولين كبيرين في Open Fiber؛ فقد ينتج ملايين أو مليارات السجلات.

-- 5. مقارنة سريعة بين الأنواع الأربعة
-- JOIN	ماذا يحتفظ؟	الهدف
-- INNER JOIN	السجلات المتطابقة فقط	إيجاد العلاقات الموجودة
-- LEFT JOIN	كل الأيسر + المطابق	عدم فقدان سجلات الجدول الأساسي
-- RIGHT JOIN	كل الأيمن + المطابق	الاحتفاظ بكل سجلات الجدول الثاني
-- CROSS JOIN	جميع التركيبات	إنشاء كل الاحتمالات

-- تصور بصري مبسط
-- INNER JOIN
-- التقاطع فقط
-- LEFT JOIN
-- الدائرة اليسرى كاملة
-- RIGHT JOIN
-- الدائرة اليمنى كاملة
-- CROSS JOIN
-- كل التركيبات الممكنة

-- الأزرق يمثل الجدول الأيسر، والأخضر يمثل الجدول الأيمن. الرسومات توضيحية لمفهوم الاحتفاظ بالسجلات.

-- 6. تمرين عملي على بياناتك
-- أريدك أن تنفّذ هذه الاستعلامات الأربعة بالترتيب:

-- التمرين الأول: كم Circuito لديه Segmento مطابق؟
SELECT COUNT(*) AS total_matches
FROM l3_qlik.pni_dm_circuito c
INNER JOIN l3_qlik.pni_dm_segmento s
    ON c.cod_circuito = s.cod_circuito;


-- التمرين الثاني: كم Circuito ليس لديه أي Segmento؟
SELECT COUNT(*) AS circuiti_without_segmenti
FROM l3_qlik.pni_dm_circuito c
LEFT JOIN l3_qlik.pni_dm_segmento s
    ON c.cod_circuito = s.cod_circuito
WHERE s.cod_circuito IS NULL;


-- التمرين الثالث: كم Segmento لا يجد Circuito مطابقاً؟
SELECT COUNT(*) AS segmenti_without_circuito
FROM l3_qlik.pni_dm_segmento s
LEFT JOIN l3_qlik.pni_dm_circuito c
    ON s.cod_circuito = c.cod_circuito
WHERE c.cod_circuito IS NULL;


-- التمرين الرابع: اعرض اسم الدائرة وعدد المقاطع التابعة لها:
SELECT
    c.cod_circuito,
    c.des_nome_circuito,
    COUNT(s.cod_segmento) AS numero_segmenti
FROM l3_qlik.pni_dm_circuito c
LEFT JOIN l3_qlik.pni_dm_segmento s
    ON c.cod_circuito = s.cod_circuito
GROUP BY
    c.cod_circuito,
    c.des_nome_circuito
ORDER BY numero_segmenti DESC;


-- لاحظ أننا استخدمنا COUNT(s.cod_segmento) وليس COUNT(*) حتى لا نحسب الدائرة التي ليس لديها Segmento كسجل واحد.