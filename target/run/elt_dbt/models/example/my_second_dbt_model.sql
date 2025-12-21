
  create or replace   view SNOWFLAKE_LEARNING_DB.PUBLIC.my_second_dbt_model
  
  
  
  
  as (
    -- Use the `ref` function to select from other models

select *
from SNOWFLAKE_LEARNING_DB.PUBLIC.my_first_dbt_model
where id = 1
  );

