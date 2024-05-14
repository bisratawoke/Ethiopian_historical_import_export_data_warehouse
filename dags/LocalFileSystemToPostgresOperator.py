import pandas as pd
from sqlalchemy import create_engine
from airflow.models.baseoperator import BaseOperator
from airflow.hooks.base import BaseHook

class LocalFileSystemToPostgresOperator(BaseOperator):

    def __init__(self,file_path:str,table_name:str,postgres_conn_id,**kwargs):
        super().__init__(**kwargs)
        self.postgres_conn_id = postgres_conn_id
        self.table_name = table_name
        self.file_path = file_path
    
    def execute(self,context):
        
        conn = BaseHook.get_connection(self.postgres_conn_id)
        connection_string = f'postgresql://{conn.login}:{conn.password}@{conn.host}:{conn.port}/{conn.schema}'
        engine = create_engine(connection_string)

        df = pd.read_csv(self.file_path)
        df.to_sql(self.table_name,engine,if_exists='replace',index=False)
