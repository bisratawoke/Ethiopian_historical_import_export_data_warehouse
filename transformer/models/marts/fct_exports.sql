select
    dim_product.product_id,
    dim_country.country_id,
    dim_date.date_id,
    stg_export."Unit",
    stg_export."Quantity"
from stg_export
inner join 
    {{ ref('dim_country') }} as dim_country
        on dim_country.country_name = stg_export."Destination"
inner join 
    {{ ref('dim_product') }} as dim_product
        on dim_product.product_code = stg_export."HS Code"
inner join 
    {{ ref('dim_date') }} as dim_date
        on dim_date."numeric_year" = stg_export."Year" 
        and dim_date."numeric_month" = stg_export."Month"