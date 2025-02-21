NYC Airbnb Data Pipeline
This project demonstrates an end-to-end data engineering workflow using Apache Airflow, pandas, and PostgreSQL (managed via pgAdmin 4). The pipeline ingests Airbnb open data for New York City from Kaggle, cleans and transforms it using pandas, and then loads it into a PostgreSQL database for analysis.
Table of Contents
Overview
Features
Project Structure
Requirements
Setup
Clone the Repository
Python Environment
Install Dependencies
Initialize Airflow
Configure PostgreSQL / pgAdmin
Running the Pipeline
Usage and Queries
Roadmap
License
Contact

Overview
Data Source: NYC Airbnb Open Data CSV from Kaggle.
Data Pipeline:
Extract: Pull CSV data from Kaggle (or local storage).
Transform: Clean and enrich data using pandas.
Load: Insert the final dataset into PostgreSQL.
Orchestration: Managed by Apache Airflow.
Database Management: Handled via PostgreSQL + pgAdmin 4.
This setup enables scheduled runs, reproducible transformations, and a central repository of cleaned Airbnb listings for further analytics.

Features
Modular Data Pipeline: Separate tasks for extract, transform, and load.
Robust Scheduling: Airflow DAG to automate and monitor pipeline runs.
Clean Data: pandas transformations to handle missing values, data types, etc.
Analytics-Ready: Load into PostgreSQL for query-based analysis or BI tools.
Scalability: Potential to extend pipeline with additional tasks, new data sources, or incremental loads.

Project Structure
bash
CopyEdit
my_airbnb_project/
├── .vscode/            # VS Code workspace config (optional)
├── airflow/
│   ├── dags/           # Airflow DAGs
│   │   ├── main_dag.py # Main DAG definition
│   │   └── transform_tasks.py
│   ├── plugins/        # Custom Airflow plugins (if any)
│   └── logs/           # Airflow task logs (auto-generated)
├── data/
│   ├── raw/            # Original CSVs from Kaggle or other sources
│   └── processed/      # Cleaned or intermediate datasets
├── scripts/
│   └── transform.py    # Reusable Python functions for data cleaning
├── tests/
│   └── test_transform.py # Unit tests for transformations
├── requirements.txt    # Python dependencies
├── README.md           # This file
└── .gitignore          # Files/folders to ignore in version control

Note: Large data files typically go in data/ and are not committed to source control. Adjust as needed.

Requirements
Python 3.7+
Apache Airflow 2.5+
pandas 1.5+
psycopg2-binary (or sqlalchemy)
PostgreSQL 13+
pgAdmin 4 (optional for DB admin)
Exact versions are pinned in requirements.txt.

Setup
1. Clone the Repository
bash
CopyEdit
git clone https://github.com/username/my_airbnb_project.git
cd my_airbnb_project

2. Python Environment
Create and activate a virtual environment (recommended):
bash
CopyEdit
python -m venv venv
source venv/bin/activate   # On macOS/Linux
# or
.\venv\Scripts\activate    # On Windows

3. Install Dependencies
bash
CopyEdit
pip install --upgrade pip
pip install -r requirements.txt

4. Initialize Airflow
Airflow needs a home directory (by default, ~/airflow) and a metadata database (often SQLite locally). You can override these in .env or environment variables if desired.
Initialize the Airflow database:
bash
CopyEdit
airflow db init


Create a user (for the Airflow UI):
bash
CopyEdit
airflow users create \
    --username admin \
    --firstname John \
    --lastname Doe \
    --role Admin \
    --email admin@example.com


5. Configure PostgreSQL / pgAdmin
Install PostgreSQL (if not already).
Start PostgreSQL server and create a new database (e.g., airbnb_db).
Optionally, use pgAdmin 4 to manage the DB:
Add a new server connection.
Create a database named airbnb_db.
Update Airflow connections:
In the Airflow UI (localhost:8080), go to Admin > Connections and set up your Postgres connection (host, port, DB name, user, password).

Running the Pipeline
Start Airflow:
bash
CopyEdit
airflow webserver -p 8080
airflow scheduler


Enable the DAG in the Airflow UI:
Go to http://localhost:8080, log in, and toggle your DAG (e.g. main_dag) On.
The pipeline tasks (Extract, Transform, and Load) will run according to the schedule defined in main_dag.py.

Usage and Queries
Data Exploration:
Use pgAdmin 4 (or any SQL client) to connect to airbnb_db.
Run sample queries, e.g.:
sql
CopyEdit
SELECT neighborhood, AVG(price) AS avg_price
FROM listings
GROUP BY neighborhood
ORDER BY avg_price DESC
LIMIT 10;


Further Analysis:
You can connect a BI tool (Tableau, Power BI, etc.) or a Python notebook that queries the same PostgreSQL database.

Roadmap
Implement incremental loads (append only new data).
Expand the pipeline to support multiple cities or other Airbnb datasets.
Add alerts/notifications (e.g., Slack) on Airflow task failures.
Dockerize for easier deployment with a docker-compose.yml.
Add more test coverage for transformation steps in scripts/transform.py.

License
MIT License – You can adapt this for your needs.

