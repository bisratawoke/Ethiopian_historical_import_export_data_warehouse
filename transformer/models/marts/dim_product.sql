with products as (
    select 
        "HS Code" as product_code , 
        "HS Description" as product_description 
    from stg_export
        union
    select 
        "HS Code" as product_code ,
        "HS Description" as product_description 
    from stg_import
)

select 
    *,
  {{ dbt_utils.generate_surrogate_key(['product_code', 'product_description']) }} as product_id
from products