CREATE STREAMING LIVE TABLE customer_silver;

APPLY CHANGES INTO LIVE.customer_silver
FROM stream(LIVE.tmp_customer_transformations)
  KEYS (id)
  APPLY AS DELETE WHEN operation = "delete"
  SEQUENCE BY operation_date 
  COLUMNS * EXCEPT (operation, operation_date, _rescued_data);
