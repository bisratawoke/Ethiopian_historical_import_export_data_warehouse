{% macro deduplicate(table_name) %}

    {% set column_names = dbt_utils.get_filtered_columns_in_relation(from=source('staging', table_name)) %}
    {% set partition_columns = column_names | join(', ') %}
    
    with x as (
        select
        *,
        ROW_NUMBER() over (
            partition by {{ partition_columns }}
            order by (SELECT NULL)
        ) as row_num 
        from {{ table_name }}
    )
    select * from x where row_num = 1

{% endmacro %}


