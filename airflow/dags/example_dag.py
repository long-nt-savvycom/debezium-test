from airflow import DAG
from airflow.operators.dummy import DummyOperator
from datetime import datetime, timedelta

# Define the default_args
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': datetime(2023, 8, 15),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    'example_dag',
    default_args=default_args,
    description='A simple example DAG',
    schedule_interval=timedelta(days=1),
)

# Define tasks
start = DummyOperator(
    task_id='start',
    dag=dag,
)

end = DummyOperator(
    task_id='end',
    dag=dag,
)

# Define the task dependencies
start >> end
