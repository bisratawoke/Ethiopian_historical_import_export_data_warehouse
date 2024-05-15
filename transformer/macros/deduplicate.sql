{% macro deduplicate(table_name) %}
    {% set column_names =  dbt_utils.get_filtered_columns_in_relation(from=source('staging', table_name)) %}
    with x as (
        select
        *,
        ROW_NUMBER() over (
            partition by 
            {% for column_name in column_names %}
                "{{ column_name }}"{% if not loop.last %},{% endif %}
            {% endfor %}

        ) as row_num 
        from {{ table_name }}
    )
    select * from x where row_num = 1

{% endmacro %}

