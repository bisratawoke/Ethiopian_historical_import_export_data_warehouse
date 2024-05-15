with products as (
    select 
        "HS Code" , 
        "HS Description"
    from stg_export
        union
    select 
        "HS Code",
        "HS Description"
    from stg_import
)

select * from products