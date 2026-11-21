USE Front;

-- Продукты
SELECT 'INSERT INTO dwh.dim_products (external_id, code, name, category_external_id, range_external_id) VALUES ('
     + CAST(p.id AS VARCHAR(20)) + ', '
     + ISNULL('''' + REPLACE(p.productid, '''', '''''') + '''', 'null') + ', '
     + ISNULL('''' + REPLACE(p.description, '''', '''''') + '''', 'null') + ', '
     + ISNULL(CAST(p.CategoryID AS VARCHAR(20)), 'null') + ', '
     + ISNULL(CAST(s.BaseSizeID AS VARCHAR(20)), 'null')
     + ');' AS sql
FROM product p
LEFT JOIN size s ON s.ID = p.SizeID
ORDER BY p.id;

-- Категории
SELECT 'INSERT INTO dwh.dim_categories (external_id, name, parent_external_id) VALUES ('
     + CAST(id AS VARCHAR(20)) + ', '
     + ISNULL('''' + REPLACE(description, '''', '''''') + '''', 'null') + ', '
     + CASE WHEN ISNULL(ParentID, 0) = 0
            THEN 'null'
            ELSE CAST(ParentID AS VARCHAR(20)) END
     + ');' AS sql
FROM category
ORDER BY id;

-- Поставщики
SELECT 'INSERT INTO dwh.dim_vendors (external_id, name, group_external_id) VALUES ('
     + CAST(id AS VARCHAR(20)) + ', '
     + ISNULL('''' + REPLACE(clientid, '''', '''''') + '''', 'null') + ', '
     + ISNULL(CAST(clientgroup AS VARCHAR(20)), 'null')
     + ');' AS sql
FROM vendors
ORDER BY id;

-- Группы поставщиков
SELECT 'INSERT INTO dwh.dim_vendors_group (external_id, name) VALUES ('
     + CAST(vendorgroupid AS VARCHAR(20)) + ', '
     + ISNULL('''' + REPLACE(description, '''', '''''') + '''', 'null')
     + ');' AS sql
FROM vendorgroup
ORDER BY vendorgroupid;

-- Сотрудники
SELECT 'INSERT INTO dwh.dim_employees (external_id, full_name, role_name) VALUES ('
     + CAST(p.personid AS VARCHAR(20)) + ', '
     + ISNULL('''' + REPLACE(LTRIM(RTRIM(
           ISNULL(p.lastname + ' ', '')
         + ISNULL(p.firstname + ' ', '')
         + ISNULL(p.middlename, '')
       )), '''', '''''') + '''', 'null') + ', '
     + ISNULL('''' + REPLACE(s.description, '''', '''''') + '''', 'null')
     + ');' AS sql
FROM personnel p
LEFT JOIN securityaccess s ON s.securityaccessid = p.securityaccess
ORDER BY p.personid;

-- Группы единиц измерения
SELECT 'INSERT INTO dwh.dim_ranges_group (external_id, name) VALUES ('
     + CAST(ID AS VARCHAR(20)) + ', '
     + ISNULL('''' + REPLACE(Description, '''', '''''') + '''', 'null')
     + ');' AS sql
FROM bm_classifierSizesGroup
ORDER BY ID;

-- Базовые единицы измерения
SELECT 'INSERT INTO dwh.dim_ranges (external_id, group_external_id, short_name, name) VALUES ('
     + CAST(ID AS VARCHAR(20)) + ', '
     + ISNULL(CAST(GroupID AS VARCHAR(20)), 'null') + ', '
     + ISNULL('''' + REPLACE(ShortName, '''', '''''') + '''', 'null') + ', '
     + ISNULL('''' + REPLACE(Description, '''', '''''') + '''', 'null')
     + ');' AS sql
FROM bm_classifierSizes
ORDER BY ID;

-- Виды оплаты
SELECT 'INSERT INTO dwh.dim_payment_types (external_id, name) VALUES ('
     + CAST(paymenttypeid AS VARCHAR(20)) + ', '
     + ISNULL('''' + REPLACE(description, '''', '''''') + '''', 'null')
     + ');' AS sql
FROM paymenttype
ORDER BY paymenttypeid;

-- Склады
SELECT 'INSERT INTO dwh.dim_storages (external_id, name) VALUES ('
     + CAST(id AS VARCHAR(20)) + ', '
     + ISNULL('''' + REPLACE(description, '''', '''''') + '''', 'null')
     + ');' AS sql
FROM storages
ORDER BY id;

-- Причины списания
SELECT 'INSERT INTO dwh.dim_reasons (external_id, name, parent_external_id) VALUES ('
     + CAST(ID AS VARCHAR(20)) + ', '
     + ISNULL('''' + REPLACE(Description, '''', '''''') + '''', 'null') + ', '
     + CASE WHEN ISNULL(ParentID, 0) = 0
            THEN 'null'
            ELSE CAST(ParentID AS VARCHAR(20)) END
     + ');' AS sql
FROM bm_ReasonDebit
ORDER BY ID;
