import pendulum
from airflow.models import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator

with DAG (
    "load_task",
    start_date=None,
    schedule_interval=None
):
    
    create_dim_tables_if_not_exists = PostgresOperator(
        postgres_conn_id="my_con",
        task_id="create_dim_tables_if_not_exits_task",
        sql="sql/create_dim_tables.sql"
    )

    create_dim_tables_if_not_exists