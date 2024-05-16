select 
    dim_product.product_id,
    dim_country.country_id,
    dim_date.date_id,
    "Gross Wt. (Kg)",
    "Net Wt. (Kg)"
from 
    stg_import
inner join 
    {{ ref('dim_country') }} as dim_country
        on dim_country.country_name = stg_import."Country (Origin)"
inner join
    {{ ref('dim_product') }} as dim_product
        on dim_product.product_code = stg_import."HS Code"
inner join 
    {{ ref('dim_date') }} as dim_date
        on dim_date."numeric_year" = stg_import."Year" 
            and dim_date."numeric_month" = stg_import."Month"