-- ============================================================================
-- СКРИПТ: dwh - DWH (Data Warehouse)
-- ============================================================================

DO $$
BEGIN
    CREATE SCHEMA IF NOT EXISTS dwh;

    -- Продукты

    DROP TABLE IF EXISTS dwh.dim_products CASCADE;
    DROP SEQUENCE IF EXISTS dwh.seq_dim_products CASCADE;

    CREATE SEQUENCE dwh.seq_dim_products;
    CREATE TABLE dwh.dim_products (
        id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('dwh.seq_dim_products'),
        external_id BIGINT NOT NULL UNIQUE,
        code VARCHAR(16),
        name VARCHAR(255),
        category_external_id BIGINT,
        range_external_id BIGINT,
        date_add TIMESTAMP NOT NULL DEFAULT now()
    );
    ALTER SEQUENCE dwh.seq_dim_products OWNED BY dwh.dim_products.id;
    COMMENT ON TABLE dwh.dim_products IS 'Товары (product); category_external_id, range_external_id — ID из Front';

    -- Категории

    DROP TABLE IF EXISTS dwh.dim_categories CASCADE;
    DROP SEQUENCE IF EXISTS dwh.seq_dim_categories CASCADE;

    CREATE SEQUENCE dwh.seq_dim_categories;
    CREATE TABLE dwh.dim_categories (
        id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('dwh.seq_dim_categories'),
        external_id BIGINT NOT NULL UNIQUE,
        name VARCHAR(255),
        parent_external_id BIGINT,
        date_add TIMESTAMP NOT NULL DEFAULT now()
    );
    ALTER SEQUENCE dwh.seq_dim_categories OWNED BY dwh.dim_categories.id;
    COMMENT ON TABLE dwh.dim_categories IS 'Категории товаров (category); parent_external_id — ID из Front';

    -- Поставщики

    DROP TABLE IF EXISTS dwh.dim_vendors CASCADE;
    DROP SEQUENCE IF EXISTS dwh.seq_dim_vendors CASCADE;

    CREATE SEQUENCE dwh.seq_dim_vendors;
    CREATE TABLE dwh.dim_vendors (
        id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('dwh.seq_dim_vendors'),
        external_id BIGINT NOT NULL UNIQUE,
        name VARCHAR(100),
        group_external_id BIGINT,
        date_add TIMESTAMP NOT NULL DEFAULT now()
    );
    ALTER SEQUENCE dwh.seq_dim_vendors OWNED BY dwh.dim_vendors.id;
    COMMENT ON TABLE dwh.dim_vendors IS 'Поставщики (vendors); group_external_id — ID из Front';

    -- Группы поставщиков

    DROP TABLE IF EXISTS dwh.dim_vendors_group CASCADE;
    DROP SEQUENCE IF EXISTS dwh.seq_dim_vendors_group CASCADE;

    CREATE SEQUENCE dwh.seq_dim_vendors_group;
    CREATE TABLE dwh.dim_vendors_group (
        id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('dwh.seq_dim_vendors_group'),
        external_id BIGINT NOT NULL UNIQUE,
        name VARCHAR(100),
        date_add TIMESTAMP NOT NULL DEFAULT now()
    );
    ALTER SEQUENCE dwh.seq_dim_vendors_group OWNED BY dwh.dim_vendors_group.id;
    COMMENT ON TABLE dwh.dim_vendors_group IS 'Группы поставщиков (vendorgroup)';

    -- Сотрудники

    DROP TABLE IF EXISTS dwh.dim_employees CASCADE;
    DROP SEQUENCE IF EXISTS dwh.seq_dim_employees CASCADE;

    CREATE SEQUENCE dwh.seq_dim_employees;
    CREATE TABLE dwh.dim_employees (
        id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('dwh.seq_dim_employees'),
        external_id BIGINT NOT NULL UNIQUE,
        full_name VARCHAR(150),
        role_name VARCHAR(255),
        date_add TIMESTAMP NOT NULL DEFAULT now()
    );
    ALTER SEQUENCE dwh.seq_dim_employees OWNED BY dwh.dim_employees.id;
    COMMENT ON TABLE dwh.dim_employees IS 'Сотрудники (personnel)';

    -- Группы единиц измерения

    DROP TABLE IF EXISTS dwh.dim_ranges_group CASCADE;
    DROP SEQUENCE IF EXISTS dwh.seq_dim_ranges_group CASCADE;

    CREATE SEQUENCE dwh.seq_dim_ranges_group;
    CREATE TABLE dwh.dim_ranges_group (
        id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('dwh.seq_dim_ranges_group'),
        external_id BIGINT NOT NULL UNIQUE,
        name VARCHAR(255),
        date_add TIMESTAMP NOT NULL DEFAULT now()
    );
    ALTER SEQUENCE dwh.seq_dim_ranges_group OWNED BY dwh.dim_ranges_group.id;
    COMMENT ON TABLE dwh.dim_ranges_group IS 'Группы единиц измерения (bm_classifierSizesGroup)';

    -- Базовые единицы измерения

    DROP TABLE IF EXISTS dwh.dim_ranges CASCADE;
    DROP SEQUENCE IF EXISTS dwh.seq_dim_ranges CASCADE;

    CREATE SEQUENCE dwh.seq_dim_ranges;
    CREATE TABLE dwh.dim_ranges (
        id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('dwh.seq_dim_ranges'),
        external_id BIGINT NOT NULL UNIQUE,
        group_external_id BIGINT,
        short_name VARCHAR(50),
        name VARCHAR(255),
        date_add TIMESTAMP NOT NULL DEFAULT now()
    );
    ALTER SEQUENCE dwh.seq_dim_ranges OWNED BY dwh.dim_ranges.id;
    COMMENT ON TABLE dwh.dim_ranges IS 'Базовые единицы измерения (bm_classifierSizes); group_external_id — ID из Front';

    -- Виды оплаты

    DROP TABLE IF EXISTS dwh.dim_payment_types CASCADE;
    DROP SEQUENCE IF EXISTS dwh.seq_dim_payment_types CASCADE;

    CREATE SEQUENCE dwh.seq_dim_payment_types;
    CREATE TABLE dwh.dim_payment_types (
        id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('dwh.seq_dim_payment_types'),
        external_id BIGINT NOT NULL UNIQUE,
        name VARCHAR(30),
        date_add TIMESTAMP NOT NULL DEFAULT now()
    );
    ALTER SEQUENCE dwh.seq_dim_payment_types OWNED BY dwh.dim_payment_types.id;
    COMMENT ON TABLE dwh.dim_payment_types IS 'Виды оплаты (paymenttype)';

    -- Склады

    DROP TABLE IF EXISTS dwh.dim_storages CASCADE;
    DROP SEQUENCE IF EXISTS dwh.seq_dim_storages CASCADE;

    CREATE SEQUENCE dwh.seq_dim_storages;
    CREATE TABLE dwh.dim_storages (
        id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('dwh.seq_dim_storages'),
        external_id BIGINT NOT NULL UNIQUE,
        name VARCHAR(255),
        date_add TIMESTAMP NOT NULL DEFAULT now()
    );
    ALTER SEQUENCE dwh.seq_dim_storages OWNED BY dwh.dim_storages.id;
    COMMENT ON TABLE dwh.dim_storages IS 'Склады (storages)';

    -- Причины списания

    DROP TABLE IF EXISTS dwh.dim_reasons CASCADE;
    DROP SEQUENCE IF EXISTS dwh.seq_dim_reasons CASCADE;

    CREATE SEQUENCE dwh.seq_dim_reasons;
    CREATE TABLE dwh.dim_reasons (
        id BIGINT NOT NULL PRIMARY KEY DEFAULT nextval('dwh.seq_dim_reasons'),
        external_id BIGINT NOT NULL UNIQUE,
        name VARCHAR(255),
        parent_external_id BIGINT,
        date_add TIMESTAMP NOT NULL DEFAULT now()
    );
    ALTER SEQUENCE dwh.seq_dim_reasons OWNED BY dwh.dim_reasons.id;
    COMMENT ON TABLE dwh.dim_reasons IS 'Причины списания (bm_ReasonDebit); parent_external_id — ID из Front';
END $$;
