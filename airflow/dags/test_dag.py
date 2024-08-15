from airflow import DAG
from airflow.operators.dummy import DummyOperator
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.utils.dates import days_ago
from datetime import timedelta
import subprocess
import requests

connector_host = 'localhost' # Todo add to .env or key management
connector_port = 8083
dbt_path = '/home/longnt/Documents/savvy/works/data-analysic/enterprise_analysis'
dbt_model = 'department_analysis'

def check_connector_status(connector_name):
    print('CHECK_CONNECTOR_STATUS')
    # Define the URL to check the status of the connector
    # Placeholder function to check if a Debezium connector is alive
    # Replace with actual check logic (e.g., HTTP request to connector status API)
    # return True
    url = f'http://{connector_host}:{connector_port}/connectors/{connector_name}/status'
    
    try:
        # Make a GET request to the API
        response = requests.get(url)
        response.raise_for_status()  # Raise an exception for HTTP errors
        
        # Parse the JSON response
        status_data = response.json()
        
        # Check the state of the connector
        connector_state = status_data.get('connector', {}).get('state')
        tasks = status_data.get('tasks', [])
        
        # Check the state of all tasks
        all_tasks_running = all(task.get('state') == 'RUNNING' for task in tasks)
        
        # Determine if the connector and all tasks are running
        if connector_state == 'RUNNING' and all_tasks_running:
            return True
        
    except requests.RequestException as e:
        print(f"Error checking connector status: {e}")
    
    return False

def restart_connector(connector_name):
    print('RESTART_CONNECTOR')
    # Placeholder function to restart a Debezium connector if it's down
    # Replace with actual restart logic
    # subprocess.run(["your-restart-command", connector_name])
    # Define the URL to restart the connector
    url = f'http://{connector_host}:{connector_port}/connectors/{connector_name}/restart'
    
    try:
        # Make a POST request to the API to restart the connector
        response = requests.post(url)
        
        # Check if the request was successful
        if response.status_code == 202:
            print(f"Connector '{connector_name}' is restarting.")
        elif response.status_code == 200:
            print(f"Connector '{connector_name}' is already running or restarted successfully.")
        else:
            print(f"Failed to restart connector '{connector_name}'. Status code: {response.status_code}")
        
    except requests.RequestException as e:
        print(f"Error restarting connector '{connector_name}': {e}")

def get_all_connectors():
    print('GET_ALL_CONNECTORS')
    try:
        response = requests.get(f"http://{connector_host}:{connector_port}/connectors")
        response.raise_for_status()
        connectors = response.json()
        return connectors
    except requests.exceptions.RequestException as e:
        print(f"Error fetching connectors: {e}")
        return []

def monitor_connectors(**kwargs):
    connectors = get_all_connectors()
    print(connectors)
    for connector in connectors:
        if not check_connector_status(connector):
            restart_connector(connector)

# Define default arguments for the DAG
default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'start_date': days_ago(1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    'test_pipeline',
    default_args=default_args,
    description='A pipeline test debezium + dpt + metabase',
    # schedule_interval='@hourly',  # Runs every hour
    schedule_interval='* * * * *',  # Runs every minute

)

# Define tasks
start = DummyOperator(
    task_id='start',
    dag=dag,
)

monitor = PythonOperator(
    task_id='monitor_connectors',
    python_callable=monitor_connectors,
    dag=dag,
)

ingest_data = BashOperator(
    task_id='ingest_data',
    bash_command=f'curl -X GET http://{connector_host}:{connector_port}/connector-plugins',  # Example command to trigger Debezium ingestion
    dag=dag,
)

run_dbt = BashOperator(
    task_id='run_dbt',
    bash_command=f'cd {dbt_path} && dbt run --models {dbt_model}',  # Adjust paths and models as needed
    dag=dag,
)

end = DummyOperator(
    task_id='end',
    dag=dag,
)

# Define task dependencies
start >> monitor >> ingest_data >> run_dbt >> end
