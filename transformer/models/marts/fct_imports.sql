select 
    "Country",
    "Gross Wt. (Kg)",
    "Net Wt. (Kg)",
    dim_product."HS Code",
    dim_product."HS Description",
    dim_date."month",
    dim_date."year"
from 
    stg_import
inner join 
    {{ ref('dim_country') }} as dim_country
        on dim_country."Country" = stg_import."Country (Origin)"
inner join
    {{ ref('dim_product') }} as dim_product
        on dim_product."HS Code" = stg_import."HS Code"
inner join 
    {{ ref('dim_date') }} as dim_date
        on dim_date."numeric_year" = stg_import."Year" 
            and dim_date."numeric_month" = stg_import."Month"