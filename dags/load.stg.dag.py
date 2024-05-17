import pandas as pd
import os
import pendulum
from pathlib import Path
from sqlalchemy import create_engine
from airflow.models import DAG
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.operators.python import PythonOperator
from airflow.hooks.base import BaseHook
from airflow.operators.base import BashOperator
from LocalFileSystemToPostgresOperator import LocalFileSystemToPostgresOperator

with DAG (
    "load_task",
    start_date=None,
    schedule_interval=None
):
    
    base_dir = "/opt/airflow/source"

    create_stg_tables_if_not_exists = PostgresOperator(
        postgres_conn_id="my_con",
        task_id="create_stg_tables_if_not_exits_task",
        sql="sql/create_stg_tables.sql"
    )

    def extract_export_data(**kwargs):
        export_files_dir = os.path.join(base_dir,"export")
        export_file_names = [file_name for file_name in os.listdir(export_files_dir) if Path(file_name).suffix == '.csv']
       
        dataframes = list()
        for file_name in export_file_names:
            df = pd.read_csv(os.path.join(export_files_dir,file_name))
            dataframes.append(df)

        export_dataframe = pd.concat(dataframes,ignore_index=True)
        export_dataframe.to_csv(os.path.join(os.path.dirname(__file__),"staging","exports.csv"),index=False)
         
    def extract_import_data(**kwargs):

        import_files_dir = os.path.join(base_dir,"import")
        import_file_names = [filename for filename in os.listdir(import_files_dir) if Path(filename).suffix == '.csv']

        dataframes = list()
        for file_name in import_file_names:
            df = pd.read_csv(os.path.join(import_files_dir,file_name))
            dataframes.append(df)

        import_dataframe = pd.concat(dataframes,ignore_index=True)
        import_dataframe.to_csv(os.path.join(os.path.dirname(__file__),"staging","imports.csv"),index=False)



    extract_export_data_task = PythonOperator(
        python_callable=extract_export_data,
        task_id="extract_export_data_task"
    )

    extract_import_data_task = PythonOperator(
        python_callable=extract_import_data,
        task_id="extract_import_data_task"
    )

    load_export_data_task = LocalFileSystemToPostgresOperator(
        file_path=os.path.join(os.path.dirname(__file__),"staging","exports.csv"),
        table_name="stg_export",
        postgres_conn_id="my_con",
        task_id="load_export_data_task"
    )

    load_import_data_task = LocalFileSystemToPostgresOperator(
        file_path=os.path.join(os.path.dirname(__file__),"staging","imports.csv"),
        table_name="stg_import",
        postgres_conn_id="my_con",
        task_id="load_import_data_task"
    )

    create_data_marts_task = BashOperator(
        task_id='create_data_marts_task',
        bash_command='dbt run'
    )
  
    
    create_stg_tables_if_not_exists >> extract_export_data_task >> extract_import_data_task  >> load_export_data_task >> load_import_data_task >> create_date_marts_task