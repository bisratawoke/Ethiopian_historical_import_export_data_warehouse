select
    dim_product."HS Code",
    dim_product."HS Description",
    dim_country."Country",
    stg_export."Unit",
    stg_export."Quantity"
   
from stg_export
inner join {{ ref('dim_country') }} as dim_country
    on dim_country."Country" = stg_export."Destination"
inner join {{ ref('dim_product') }} as dim_product
    on dim_product."HS Code" = stg_export."HS Code"
