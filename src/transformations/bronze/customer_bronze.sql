-- TODO: Check if there is a way to parametrize the schema when creating streaming live tables. ${var_name}.table_name is not supported
CREATE STREAMING LIVE TABLE bronze.customer_bronze
(
  address string,
  email string,
  id string,
  firstname string,
  lastname string,
  operation string,
  operation_date string,
  _rescued_data string 
)
SELECT * 
FROM STREAM bronze.customers;

CREATE TEMPORARY STREAMING LIVE TABLE tmp_customer_transformations(
  CONSTRAINT valid_id EXPECT (id IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_address EXPECT (address IS NOT NULL),
  CONSTRAINT valid_operation EXPECT (operation IS NOT NULL) ON VIOLATION DROP ROW
)
AS SELECT 
  lower(address) as address,
  email,
  id,
  concat(firstname, ' ', lastname) as c_name,
  operation,
  operation_date,
  _rescued_data
FROM STREAM(LIVE.bronze.customer_bronze);
