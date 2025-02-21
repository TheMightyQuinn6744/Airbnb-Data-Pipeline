from airflow import DAG
from airflow.operators.python import PythonOperator
from datetime import datetime
import pandas as pd
import os

# File path (Update it if needed)
FILE_PATH = "/home/hades/Projects/Airbnb Data Pipeline/data/Bank_Transaction_Fraud_Detection.csv"

# Function to extract and display the file data
def extract_data():
    if not os.path.exists(FILE_PATH):
        raise FileNotFoundError(f"🚨 File not found: {FILE_PATH}")

    df = pd.read_csv(FILE_PATH)

    # Print first 5 rows (for testing)
    print("✅ Extracted Data (First 5 Rows):")
    print(df.head())

    # Returning row count for Airflow logs
    return f"Extracted {len(df)} rows."

# Define the DAG
default_args = {
    'owner': 'admin',
    'start_date': datetime(2025, 2, 21),
    'retries': 1,
}

with DAG(
    'extract_bank_transactions',
    default_args=default_args,
    schedule_interval='@daily',
    catchup=False,
    description='Extracts Bank Transaction Fraud Detection CSV',
) as dag:

    extract_task = PythonOperator(
        task_id='extract_csv_data',
        python_callable=extract_data,
    )

    extract_task
