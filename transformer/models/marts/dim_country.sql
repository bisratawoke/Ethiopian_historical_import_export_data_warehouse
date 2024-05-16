with joined_country as (
    select 
        "Country (Origin)" as country_name
    from stg_import
        union 
    select
        "Country (Consignment)" as country_name
    from stg_import
        union
    select
        "Destination" as country_name
    from stg_export
)

select 
    country_name,
    {{ dbt_utils.generate_surrogate_key(['country_name'])}} as country_id
from joined_country