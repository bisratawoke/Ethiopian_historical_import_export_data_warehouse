with joined_country as (
    select 
        "Country (Origin)" as "Country"
    from stg_import
        union 
    select
        "Country (Consignment)" as "Country"
    from stg_import
        union
    select
        "Destination" as "Country"
    from stg_export
)

select 
    "Country" 
from joined_country