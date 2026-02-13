-- =============================================
-- 0. DROP EXISTING TABLES
-- =============================================

DROP TABLE IF EXISTS ${schema_bronze}.sales;
DROP TABLE IF EXISTS ${schema_bronze}.users;
DROP TABLE IF EXISTS ${schema_bronze}.b_sales;
DROP TABLE IF EXISTS ${schema_bronze}.b_users;
DROP TABLE IF EXISTS ${schema_silver}.s_sales;
DROP TABLE IF EXISTS ${schema_silver}.s_users;


-- =============================================
-- 1. SCHEMA CREATION
-- =============================================
CREATE SCHEMA IF NOT EXISTS ${schema_bronze};
CREATE SCHEMA IF NOT EXISTS ${schema_silver};
CREATE SCHEMA IF NOT EXISTS ${schema_gold};

-- =============================================
-- 2. TABLE CREATION
-- =============================================

-- Tabla de Clientes
CREATE TABLE IF NOT EXISTS ${schema_bronze}.customers (
  address string,
  email string,
  id string,
  firstname string,
  lastname string,
  operation string,
  operation_date string,
  _rescued_data string 
) USING DELTA
TBLPROPERTIES (delta.enableChangeDataFeed = true);

-- Tabla de Usuarios
CREATE TABLE IF NOT EXISTS ${schema_bronze}.users (
    user_id INT,
    user_name STRING,
    email STRING,
    registration_date DATE,
    _ingested_at TIMESTAMP
) USING DELTA
TBLPROPERTIES (delta.enableChangeDataFeed = true);

-- Tabla de Ventas
CREATE TABLE IF NOT EXISTS ${schema_bronze}.sales (
    sale_id STRING,
    user_id INT,
    amount DOUBLE,
    product_id STRING,
    sale_date DATE,
    _ingested_at TIMESTAMP
) USING DELTA
TBLPROPERTIES (delta.enableChangeDataFeed = true);

-- =============================================
-- 3. DATA INSERTION
-- =============================================
 
 INSERT INTO ${schema_bronze}.customers VALUES 
 ( 'Sitio 1', 'paco@gmail.com', '0', 'Paco', 'Paquito', 'insert', '2024-01-01', ''),
 ( 'Sitio 2', 'ana@gmail.com', '1', 'Ana', 'Garcia', 'insert', '2024-01-01', ''),
 ( 'Sitio 3', 'luis@gmail.com', '2', 'Luis', 'Perez', 'insert', '2024-01-01', ''),
 ( 'Sitio 4', 'maria@gmail.com', '3', 'Maria', 'Lopez', 'insert', '2024-01-01', ''),
 ( 'Sitio 5', 'carlos@gmail.com', '4', 'Carlos', 'Ruiz', 'insert', '2024-01-01', ''),
 ( 'Sitio 6', 'juan@gmail.com', '5', 'Juan', 'Cuesta', 'insert', '2024-01-01', '')
 ;


INSERT INTO ${schema_bronze}.users VALUES 
(1, 'Ana Garcia', 'ana.g@example.com', '2024-01-10', current_timestamp()),
(2, 'Luis Perez', 'luis.p@example.com', '2024-01-12', current_timestamp()),
(3, 'Maria Lopez', 'm.lopez@example.com', '2024-01-15', current_timestamp()),
(4, 'Carlos Ruiz', 'cruiz@example.com', '2024-02-01', current_timestamp()),
(5, 'Juan Cuesta', 'p.paquito@example.com', '2024-02-01', current_timestamp());

INSERT INTO ${schema_bronze}.sales VALUES 
('S001', 1, 150.50, 'PROD_A', '2024-02-05', current_timestamp()),
('S002', 2, 89.99, 'PROD_B', '2024-02-06', current_timestamp()),
('S003', 1, 45.00, 'PROD_C', '2024-02-07', current_timestamp()),
('S004', 3, 210.00, 'PROD_A', '2024-02-08', current_timestamp()),
('S005', 4, 12.50, 'PROD_D', '2024-02-09', current_timestamp()),
('S006', 5, 1.50, 'PROD_E', '2024-02-09', current_timestamp()),
('S007', 5, 100.28, 'PROD_F', '2024-02-09', current_timestamp());

-- =============================================
-- 4. VERIFY CREATION IS OK
-- =============================================
SELECT * FROM ${schema_bronze}.users;
SELECT * FROM ${schema_bronze}.sales;