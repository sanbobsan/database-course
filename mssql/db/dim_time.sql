DO $$
DECLARE
    date_from CONSTANT DATE := '2012-01-01';
    date_to CONSTANT DATE := '2027-12-31';
BEGIN
    CREATE SCHEMA IF NOT EXISTS dwh;

    DROP TABLE IF EXISTS dwh.dim_time CASCADE;

    CREATE TABLE dwh.dim_time (
        id INT NOT NULL PRIMARY KEY, -- вида 202611
        month_start DATE NOT NULL,
        month_end DATE NOT NULL,
        month_name VARCHAR(20) NOT NULL,
        year INT NOT NULL,
        quarter_number INT NOT NULL,
        quarter_name VARCHAR(20) NOT NULL
    );

    COMMENT ON TABLE dwh.dim_time IS 'Временные метрики';

    INSERT INTO dwh.dim_time (id, month_start, month_end, month_name, year, quarter_number, quarter_name)
    SELECT
        TO_CHAR(d, 'YYYYMM')::INT,
        d::DATE,
        (d + INTERVAL '1 month' - INTERVAL '1 day')::DATE,
        (ARRAY['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь',
               'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'])[EXTRACT(MONTH FROM d)::INT],
        EXTRACT(YEAR FROM d)::INT,
        EXTRACT(QUARTER FROM d)::INT,
        EXTRACT(QUARTER FROM d)::INT || ' квартал'
    FROM GENERATE_SERIES(
        DATE_TRUNC('month', date_from),
        DATE_TRUNC('month', date_to),
        INTERVAL '1 month'
    ) AS d;
END $$;
