# أهم 5 أسئلة يجب أن تتعلم طرحها عند رؤية أي جدول

1. **What does this table represent?** — ماذا يمثل هذا الجدول؟
2. **What does each row represent?** — ماذا يمثل كل صف؟
3. **What is the primary key?** — ما المفتاح الذي يميز السجل؟
4. **How is this table related to other tables?** — كيف يرتبط بالجداول الأخرى؟
5. **Can I trust the data?** — هل البيانات صحيحة ومتسقة؟

نصيحتي: في حالتك داخل Open Fiber، لا تكتفِ بتعلم SQL. حاول أن تفهم العلاقة بين Circuito وSegmento وCavo وGPON، وكيف تنتقل البيانات من عنصر إلى آخر في شبكة PNI.

هذه هي الخطوة التي ستنقلك من مجرد كتابة Queries إلى فهم نموذج بيانات الشبكة (Data Model).

# advSQL

# 7. Quick reference – all SQL commands
SPLIT
REGULAREXPRESS
LIKE 
ù
Here is your complete checklist.

| SQL command | What it does |
|---|---|
| `MAX()` | Finds maximum value |
| `MIN()` | Finds minimum value |
| `DISTINCT` | Removes duplicates |
| `COUNT()` | Counts records |
| `GROUP BY` | Groups records |
| `ORDER BY` | Sorts results |
| `ASC` | Ascending order |
| `DESC` | Descending order |
| `IN()` | Checks values in a list |
| `WHERE` | Filters records |
| `AS` | Creates aliases |
| `AND / OR / NOT` | Combines conditions |
| `IS NULL` | Finds missing values |
| `IS NOT NULL` | Finds existing values |
| `LIKE` | Searches text patterns |
| `CASE WHEN` | Creates conditional logic |
| `ELSE` | Defines the alternative condition |
| `THEN` | Defines the result of a condition |
| `HAVING` | Filters aggregated groups |
| `SUM()` | Calculates a total |
| `AVG()` | Calculates an average |
| `ROW_NUMBER()` | Numbers rows within groups |
| `COUNT() OVER()` | Counts records using a window |
| `SUM() OVER()` | Calculates window totals |
| `PARTITION BY` | Divides window functions into groups |
| `JOIN` | Combines tables |
| `INNER JOIN` | Returns matching records |
| `LEFT JOIN` | Keeps all left-side records |
| `RIGHT JOIN` | Keeps all right-side records |
| `FULL OUTER JOIN` | Keeps records from both sides |
| `UNION` | Combines queries and removes duplicates |
| `UNION ALL` | Combines queries and keeps duplicates |
| `WITH ... AS` | Creates a CTE |
| `CAST()` | Converts data types |
| `CONCAT()` | Combines strings |
| `UPPER()` | Converts text to uppercase |
| `TRIM()` | Removes surrounding spaces |
| `RLIKE` | Searches using regex |
| `RAND()` | Generates random numbers |
| `<>` | Not equal |
| `COALESCE()` | Returns the first non-NULL value |
| `TO_DATE()` | Extracts date from timestamp |
| `LIMIT` | Restricts result count |
| `DESCRIBE TABLE` | Shows table structure |

Two small corrections to remember:

- It is `AVG()`, not `AVA()`.
- It is `COUNT(*)` or `COUNT(column)`, not an empty `COUNT()`.

# 8. How I recommend practising

I suggest dividing the training into five levels, using only your Open Fiber table.

## Level 1 – Basic SQL

Beginner

`SELECT`, `WHERE`, `DISTINCT`, `COUNT`, `MIN`, `MAX`, `ORDER BY`, `LIMIT`, `IN`.

## Level 2 – Data analysis

Intermediate

`GROUP BY`, `HAVING`, `SUM`, `AVG`, `CASE WHEN`, `LIKE`, `NULL`, `COALESCE`.

## Level 3 – Data manipulation

Intermediate

`CAST`, `CONCAT`, `UPPER`, `TRIM`, `REGEX`, `TO_DATE`, `RAND`.

## Level 4 – Advanced SQL

Advanced

`JOIN`, `UNION`, `CTE`, `ROW_NUMBER`, `COUNT OVER`, `SUM OVER`, `PARTITION BY`.

## Level 5 – Real Open Fiber scenarios

Professional

Building duplicates, civico validation, scala analysis, FTTH availability, vendibilità, and identifying the latest records.

My recommendation: Don't just memorise SQL syntax. Practise thinking like a Data Engineer: understand the data, formulate the question, write the query, and validate the result.

We can use your actual 150 columns to create realistic exercises, one at a time. I'll give you a business problem, you write the SQL query, and I'll correct it and explain any mistakes.

# كيف تفهم أي جدول SQL قبل كتابة الاستعلامات (SQL Query)

## What to check when you work with a new SQL table

عندما تفتح أي جدول (TABLE) في قاعدة البيانات لأول مرة، لا تبدأ بكتابة الاستعلامات مباشرة، بل حاول أولاً فهم الجدول وبنيته والبيانات التي يحتوي عليها والعلاقات التي تربطه بالجداول الأخرى.

### 1. افهم الغرض من الجدول (Table Purpose)

اسأل نفسك:

- لماذا تم إنشاء هذا الجدول؟
- ما نوع المعلومات التي يحتوي عليها؟
- ما مصدر البيانات؟

### 2. افهم معنى كل صف (Grain)

اسأل نفسك: ماذا يمثل كل صف؟

مثلاً:

- هل كل صف يمثل مبنى (Edificio)؟
- أم عنواناً (Civico)؟
- أم سلّماً (Scala)؟
- أم عميلاً؟

هذه أهم نقطة؛ لأنك تحتاج أن تعرف ماذا يمثل الصف قبل تحليل البيانات.

### 3. افحص الأعمدة (Columns)

استخدم:

```sql
DESCRIBE TABLE nome_tabella;
```

وحاول فهم:

- اسم كل عمود.
- نوع البيانات (Data Type).
- معنى العمود.
- هل يحتوي على أرقام، نصوص، تواريخ أو إحداثيات؟

### 4. ابحث عن المفاتيح (Keys)

حاول تحديد:

- **Primary Key (PK):** العمود أو مجموعة الأعمدة التي تميز كل سجل.
- **Foreign Key (FK):** عمود يربط الجدول بجدول آخر.

انتبه: لا تفترض أن العمود هو PK أو FK لمجرد اسمه؛ تحقق من نموذج البيانات ومن النتائج.

### 5. افهم العلاقات بين الجداول (Relationships)

اسأل نفسك:

- هل العلاقة One-to-One (1:1)؟
- هل هي One-to-Many (1:N)؟
- هل هي Many-to-Many (N:M)؟
- ما الأعمدة التي تربط الجداول ببعضها؟

مثلاً: قد يكون للمبنى عدة عناوين، وقد يكون للعنوان عدة تفاصيل مرتبطة به، لكن يجب التحقق من العلاقة الفعلية في البيانات.

### 6. استكشف البيانات (Data Exploration)

ابدأ باستعلامات بسيطة:

**عرض أول 10 سجلات:**

```sql
SELECT *
FROM nome_tabella
LIMIT 10;
```

**معرفة العدد الإجمالي للسجلات:**

```sql
SELECT COUNT(*)
FROM nome_tabella;
```

**معرفة عدد القيم الفريدة:**

```sql
SELECT COUNT(DISTINCT nome_colonna)
FROM nome_tabella;
```

**معرفة توزيع القيم داخل عمود:**

```sql
SELECT nome_colonna, COUNT(*)
FROM nome_tabella
GROUP BY nome_colonna
ORDER BY COUNT(*) DESC;
```

### 7. افحص جودة البيانات (Data Quality)

تحقق من:

- القيم الفارغة `NULL`.
- السجلات المكررة (Duplicates).
- القيم غير المنطقية.
- اختلاف تنسيق البيانات.
- الأعمدة التي تحتوي على قيم غير متوقعة.

### 8. افهم مصدر البيانات ومسارها (Data Lineage)

اسأل:

- من أين جاءت البيانات؟
- هل جاءت من جدول آخر؟
- هل تم تعديلها أو تنظيفها؟
- هل هي بيانات أصلية أم نتيجة عملية معالجة (Transformation)؟

### 9. افهم المعنى التجاري (Business Logic)

لا يكفي أن تعرف أن العمود يحتوي على 0 و1.

يجب أن تعرف ماذا تعني هذه القيم في سياق العمل.

مثلاً:

- هل 1 تعني أن المبنى متاح تجارياً؟
- هل 0 تعني أنه غير متاح؟
- هل هناك حالات أخرى؟

### 10. قبل عمل JOIN، تحقق من العلاقة (JOIN Validation)

هذه نقطة مهمة جداً في SQL.

قبل أن تربط جدولين، تأكد من:

- أن أعمدة الربط صحيحة.
- أن العلاقة بين الجدولين مفهومة.
- أن عدد السجلات لا يتضاعف بشكل غير متوقع بعد JOIN.

## كيف تفكر عندما تفتح أي جدول لأول مرة؟

استخدم هذه القائمة كمرجع عملي:

1. Understand the table.
2. Understand the columns.
3. Identify the keys.
4. Understand the relationships.
5. Explore the data.
6. Understand data quality.
7. Understand data lineage.
8. Understand business logic.
9. Check dates and updates.
10. Understand before joining.

## مثال عملي من Open Fiber

استخدم جدولنا:

`pni_dm_edificio_civico_scala`

وقل لها:

"Before writing any query, I want you to investigate this table. Try to understand what it represents, identify the important columns, find potential primary and foreign keys, investigate duplicates and NULL values, and understand how Building, Civico and Scala are related."

## My Golden Advice

**Never start writing a complex SQL query before understanding the data.**

First understand the table, its structure, its keys, its relationships, and its business meaning.

Then start writing SQL.

**أهم نصيحة:**

قبل أن تكتب استعلام SQL معقداً، يجب أن تفهم الجدول وبنيته وبياناته وعلاقاته ومعناه في العمل. فهم البيانات أهم من مجرد معرفة أوامر SQL.

لا تعلّمها الأوامر فقط؛ أعطها جدولاً حقيقياً من Open Fiber، واطلب منها أن تحاول فهمه بهذه الخطوات العشر قبل أن تكتب أي Query.

بهذا الشكل ستتعلم كيف تفكر كمحللة بيانات (Data Analyst)، وليس فقط كيف تكتب SQL.



# What to check when you work with a new SQL table

1. **Understand the table**

- What is the purpose of this table?
- What kind of information does it contain?
- What does each row represent (Building, Civico, Scala, etc.)?

2. **Understand the columns**

- Use `DESCRIBE TABLE` to inspect the structure.
- Understand column names and data types.
- Identify important columns and business meaning.

3. **Identify the keys**

- Find the potential Primary Key (PK).
- Identify Foreign Keys (FK).
- Understand which columns connect this table to other tables.

4. **Understand the relationships**

- One-to-One (1:1)
- One-to-Many (1:N)
- Many-to-Many (N:M)
- Understand how tables are connected through JOINs.

5. **Explore the data**

- Check total number of records using `COUNT(*)`.
- Check unique values using `DISTINCT`.
- Check NULL values.
- Check duplicates.
- Explore different values using `GROUP BY`.

6. **Understand data quality**

- Are there missing values?
- Are there duplicated records?
- Are there inconsistent values?
- Are the data types correct?
- Are there unexpected results?

7. **Understand the data lineage**

- Where does the data come from?
- Which source tables are used?
- What transformations have been applied?
- Where does the final data go?

8. **Understand the business logic**

- What do the statuses mean?
- What do the flags represent?
- What is the difference between each classification?
- What rules determine whether a record is valid or not?

9. **Check dates and updates**

- When was the table last updated?
- Are there historical records?
- Are there validity start and end dates?
- How can we identify the latest record?

10. **Understand before joining**

- Check the relationship between tables.
- Verify the keys.
- Check the number of records before and after JOIN.
- Make sure the JOIN does not unexpectedly multiply records.

## My golden advice to her

Never start writing a complex SQL query before understanding the data.

First understand the table, its structure, its keys, its relationships, and its business meaning.

Then start writing SQL.

## مثال عملي يمكنك شرحه لها

استخدم جدولنا:

`pni_dm_edificio_civico_scala`

وقل لها:

"Before writing any query, I want you to investigate this table. Try to understand what it represents, identify the important columns, find potential primary and foreign keys, investigate duplicates and NULL values, and understand how Building, Civico and Scala are related."

بهذه الطريقة أنت لا تعلّمها SQL فقط، بل تعلّمها طريقة التفكير التي يحتاجها أي Data Engineer أو Data Analyst.




# فهم علاقات الجداول وتحليل البيانات (Data Engineering) – Open Fiber

أكيد. في رأيي هذه من أهم المهارات التي تحتاج إلى تطويرها كـ Data Engineer في Open Fiber. بل أحياناً فهم العلاقات بين الجداول أهم من معرفة كتابة SQL نفسها.

أنت لا تريد فقط أن تعرف كيف تكتب `JOIN`، بل تريد أن تفهم:

1. ما الذي تمثله كل Table؟
2. ما العلاقة بينها؟
3. ما هو الـ Primary Key؟
4. ما هو الـ Foreign Key؟
5. هل العلاقة One-to-One أم One-to-Many أم Many-to-Many؟
6. من أين تأتي البيانات وإلى أين تذهب؟
7. كيف تتأكد أن الـ JOIN لم يكرر البيانات أو يغيّر النتائج؟

خلينا نشرحها باستخدام جدولك الحقيقي.

# 1. افهم الـ Data Model أولاً

Data Model هو التصميم الذي يوضح كيف ترتبط البيانات ببعضها.

عندك في جدول:

`pni_dm_edificio_civico_scala`

ثلاثة مستويات أساسية:

### EDIFICIO

Building – المبنى

`edificio_cod_edificio`

One-to-Many?

### CIVICO

Street address – العنوان

`civico_cod_civico`

One-to-Many?

### SCALA

Staircase – مدخل / درج المبنى

`scala_cod_scala`

هذا تصور منطقي مبدئي، وليس إثباتاً للعلاقات الفعلية في قاعدة البيانات. يجب التحقق من المفاتيح والـ cardinality من البيانات.

مثلاً:

- مبنى واحد قد يحتوي على عدة عناوين أو مداخل.
- العنوان الواحد قد يحتوي على عدة سلالم.
- كل سلم قد يحتوي على عدة وحدات سكنية (UI).

لكن لا تفترض أن هذه العلاقات صحيحة دائماً قبل فحص البيانات.

# 2. Primary Key (PK) و Foreign Key (FK)

هذه من أهم المفاهيم.

## Primary Key – المفتاح الأساسي

هو العمود أو مجموعة الأعمدة التي تميز كل Record بشكل فريد داخل الجدول.

مثلاً، قد يكون:

`edificio_cod_edificio`

لكن لا يمكننا الجزم أنه Primary Key فعلي في جدولك قبل اختبار التكرار.

اختبره هكذا:

```sql
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT edificio_cod_edificio) AS unique_buildings
FROM l3_qlik.pni_dm_edificio_civico_scala;
```

إذا كان العددان متساويين ولا توجد قيم NULL، فهذا دليل على أنه فريد في البيانات الحالية.

## Foreign Key – المفتاح الأجنبي

هو عمود يشير إلى مفتاح في جدول آخر، لربط البيانات بينهما.

مثلاً، افترض أن لدينا جدولاً مستقلاً للمباني وجدولاً مستقلاً للسلالم.

```sql
building_table
--------------
edificio_cod_edificio  PK
edificio_des_nome
```

```sql
scala_table
-----------
scala_cod_scala        PK
scala_cod_edificio     FK
scala_num_piani
```

هنا:

`scala_cod_edificio` يشير إلى `building_table.edificio_cod_edificio`.

يعني نستطيع معرفة المبنى الذي ينتمي إليه كل سلم.

ملاحظة مهمة: وجود عمود بنفس الاسم لا يثبت وحده وجود Foreign Key رسمي. يجب التأكد من الـ Data Model أو الـ metadata أو قواعد العمل.

# 3. أنواع العلاقات بين الجداول (Cardinality)

يجب أن تعرف هذه الأنواع الثلاثة جيداً.

## One-to-One (1:1)

A

B

كل سجل في A يرتبط بسجل واحد في B، والعكس.

## One-to-Many (1:N)

Building A

Scala 1

Scala 2

Scala 3

مبنى واحد يحتوي على عدة سلالم، وكل سلم يرتبط بمبنى واحد.

## Many-to-Many (N:M)

A1

A2

B1

B2

كل سجل من A يمكن أن يرتبط بعدة سجلات من B، والعكس. عادةً نستخدم جدولاً وسيطاً (Bridge Table).

لماذا هذا مهم؟

لأنك إذا عملت JOIN بين جدولين بعلاقة One-to-Many، قد يتضاعف عدد الصفوف.

مثلاً:

| Building | Number of scales |
|---|---|
| 100 | 3 |
| 200 | 2 |

إذا ربطت جدول المباني بجدول السلالم، المبنى 100 سيظهر ثلاث مرات.

هذا ليس بالضرورة خطأ، لكن إذا كنت تحسب عدد المباني باستخدام `COUNT(*)` فستحصل على نتيجة خاطئة.

استخدم مثلاً:

```sql
COUNT(DISTINCT edificio_cod_edificio)
```

إذا كان المطلوب عدد المباني الفريدة.

# 4. افهم الـ Grain – مستوى تفاصيل البيانات

هذه نقطة مهمة جداً، وكثير من المبتدئين يتجاهلونها.

Grain = ماذا يمثل كل Row بالضبط؟

اسأل نفسك:

هل كل صف يمثل:

- Building؟
- Civico؟
- Scala؟
- Building + Civico؟
- Building + Scala؟
- نسخة من سجل في تاريخ معين؟

في جدولك، اسم الجدول وحده لا يكفي لمعرفة مستوى التفاصيل.

افحص الأعمدة المرشحة للمفاتيح:

```sql
SELECT
    COUNT(*) AS total_rows,

    COUNT(DISTINCT edificio_cod_edificio)
        AS edifici,

    COUNT(DISTINCT civico_cod_civico)
        AS civici,

    COUNT(DISTINCT scala_cod_scala)
        AS scale,

    COUNT(DISTINCT id_building_scala)
        AS building_scala_ids

FROM l3_qlik.pni_dm_edificio_civico_scala;
```

بعد ذلك قارن الأرقام.

مثلاً إذا كان عندك:

- 100,000 Rows
- 30,000 Buildings
- 50,000 Civici
- 70,000 Scale

هذا يعطيك فكرة أولية عن بنية البيانات، لكنه لا يثبت العلاقات وحده.

نصيحة: لا تبدأ أي تحليل قبل أن تعرف ما الذي يمثله الصف الواحد.

# 5. Data Profiling – كيف تفهم جدولاً جديداً؟

عندما يعطيك Nico أو Luca جدولاً جديداً، لا تبدأ مباشرة بكتابة JOIN.

اتبع هذه الخطوات:

## الخطوة الأولى: اكتشف حجم الجدول

```sql
SELECT COUNT(*) AS total_rows
FROM l3_qlik.pni_dm_edificio_civico_scala;
```

## الخطوة الثانية: اكتشف المفاتيح المحتملة

```sql
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT edificio_cod_edificio) AS unique_edifici,
    COUNT(DISTINCT civico_cod_civico) AS unique_civici,
    COUNT(DISTINCT scala_cod_scala) AS unique_scale
FROM l3_qlik.pni_dm_edificio_civico_scala;
```

## الخطوة الثالثة: افحص NULL

```sql
SELECT
    SUM(CASE WHEN edificio_cod_edificio IS NULL
             THEN 1 ELSE 0 END) AS null_edificio,

    SUM(CASE WHEN civico_cod_civico IS NULL
             THEN 1 ELSE 0 END) AS null_civico,

    SUM(CASE WHEN scala_cod_scala IS NULL
             THEN 1 ELSE 0 END) AS null_scala

FROM l3_qlik.pni_dm_edificio_civico_scala;
```

## الخطوة الرابعة: اكتشف التكرار

```sql
SELECT
    edificio_cod_edificio,
    COUNT(*) AS numero_record

FROM l3_qlik.pni_dm_edificio_civico_scala

GROUP BY edificio_cod_edificio

HAVING COUNT(*) > 1

ORDER BY numero_record DESC

LIMIT 20;
```

هذا يخبرك أي مبنى يظهر أكثر من مرة.

لكن تذكر: تكرار `edificio_cod_edificio` قد يكون طبيعياً إذا كان لكل مبنى عدة سلالم أو عناوين.

## الخطوة الخامسة: افهم القيم الموجودة

```sql
SELECT
    edificio_des_tipologia,
    COUNT(*) AS totale

FROM l3_qlik.pni_dm_edificio_civico_scala

GROUP BY edificio_des_tipologia

ORDER BY totale DESC;
```

كرر ذلك مع:

- `edificio_des_stato_connessione`
- `edificio_des_stato_vendibilita`
- `scala_des_stato_reale`
- `des_cluster_civico`
- `flg_tipo_rete`

ستكتشف ما تعنيه البيانات عملياً، وما هي الحالات الموجودة.

# 6. Data Lineage – من أين تأتي البيانات؟

هذه مهارة مهمة جداً في Data Engineering.

Data Lineage يعني تتبع مسار البيانات:

- من أي Source جاءت؟
- ما هي الجداول التي استخدمت؟
- ما هي التحويلات التي أجريت؟
- ما هو الجدول النهائي الذي استقبل النتائج؟
- هل تم حذف أو تعديل بعض السجلات؟

مثال تصوري:

SOURCE TABLES

Building / Civico / Scala

TRANSFORMATION

JOIN + FILTER + CASE + CAST

FINAL TABLE

Validated analytical dataset

مثلاً، إذا وجدت جدولاً نهائياً اسمه `analisi_finale`، يجب أن تعرف:

1. هل جاء من `pni_dm_edificio_civico_scala`؟
2. هل تم ربطه مع جدول آخر؟
3. هل استخدمنا `DISTINCT`؟
4. هل اخترنا آخر تحديث باستخدام `ROW_NUMBER()`؟
5. هل استبعدنا بعض الحالات باستخدام `WHERE`؟

لا يكفي أن تعرف كيف تم إنشاء الجدول. يجب أن تستطيع إعادة بناء منطق إنشائه.

# 7. Data Modeling – كيف تفكر في تصميم البيانات؟

هناك نموذجان مهمان:

## A. Normalized Data Model

تقسيم البيانات إلى جداول منفصلة لتقليل التكرار.

مثلاً:

- `BUILDING`
- `CIVICO`
- `SCALA`

كل جدول يحتوي على معلومات تخص الكيان نفسه، مع مفاتيح تربط الجداول.

## B. Star Schema

يستخدم كثيراً في التحليل وBusiness Intelligence.

FACT TABLE

`FACT_VENDIBILITA`

Measures: number of UI, available units

DIM_BUILDING

DIM_DATE

DIM_REGION

DIM_NETWORK

نموذج مبسط: جدول Fact في الوسط، وجداول Dimensions حوله.

- Fact Table: يحتوي على الأحداث أو المقاييس التي تريد تحليلها.
- Dimension Tables: تحتوي على معلومات تصف الأحداث، مثل المنطقة والمبنى والتاريخ.

# 8. أهم 10 أسئلة تسألها عندما تستلم أي Table جديد

احفظ هذه القائمة. استخدمها في كل مشروع:

| # | السؤال | المفهوم |
|---|---|---|
| 1 | What does this table represent? | Business meaning |
| 2 | What does one row represent? | Grain |
| 3 | What is the Primary Key? | PK |
| 4 | What are the Foreign Keys? | FK |
| 5 | What other tables are related? | Relationships |
| 6 | Is it 1:1, 1:N or N:M? | Cardinality |
| 7 | Where does the data come from? | Data Lineage |
| 8 | Are there duplicates or NULLs? | Data Quality |
| 9 | How frequently is the table updated? | Data Freshness |
| 10 | What transformations were applied? | Data Transformation |

# 9. مصطلحات إضافية يجب أن تعرفها

| Term | المعنى |
|---|---|
| PK | Primary Key |
| FK | Foreign Key |
| Grain | مستوى تفاصيل كل سجل |
| Cardinality | عدد العلاقات بين السجلات |
| Schema | هيكل قاعدة البيانات |
| Data Dictionary | شرح الأعمدة ومعانيها |
| Data Lineage | مصدر ومسار البيانات |
| Data Profiling | فحص وفهم البيانات |
| Data Quality | جودة البيانات |
| Normalization | تنظيم البيانات وتقليل التكرار |
| Denormalization | دمج البيانات لتحسين التحليل |
| Star Schema | نموذج Fact وDimensions |
| Bridge Table | جدول وسيط لعلاقة Many-to-Many |
| Surrogate Key | مفتاح اصطناعي |
| Natural Key | مفتاح مستمد من بيانات العمل |
| Slowly Changing Dimension | تتبع تغير بيانات الأبعاد بمرور الوقت |









