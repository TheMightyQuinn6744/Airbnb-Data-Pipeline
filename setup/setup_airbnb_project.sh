#!/bin/bash

# Define project directory
PROJECT_DIR="/home/hades/Projects/Airbnb Data Pipeline"

# Define subdirectories
DIRS=(
    "$PROJECT_DIR/dags"           # Airflow DAGs folder
    "$PROJECT_DIR/scripts"        # ETL scripts
    "$PROJECT_DIR/data"           # Data storage (raw & processed)
    "$PROJECT_DIR/logs"           # Logs directory
    "$PROJECT_DIR/plugins"        # Custom Airflow plugins
    "$PROJECT_DIR/config"         # Configuration files
    "$PROJECT_DIR/tests"          # Unit tests
    "$PROJECT_DIR/notebooks"      # Jupyter notebooks for EDA
    "$PROJECT_DIR/docs"           # Documentation
)

# Create project directories
echo "📁 Creating Airbnb Data Pipeline project directories..."
for dir in "${DIRS[@]}"; do
    mkdir -p "$dir"
    echo "✅ Created: $dir"
done

# Create necessary files
echo "📝 Creating essential project files..."
touch "$PROJECT_DIR/config/airflow.cfg"
touch "$PROJECT_DIR/config/db_config.yaml"
touch "$PROJECT_DIR/requirements.txt"
touch "$PROJECT_DIR/.gitignore"
touch "$PROJECT_DIR/README.md"

# Initialize virtual environment if not existing
VENV_PATH="$PROJECT_DIR/airflow_venv"
if [ ! -d "$VENV_PATH" ]; then
    echo "🐍 Creating Python virtual environment..."
    python3 -m venv "$VENV_PATH"
    echo "✅ Virtual environment created at $VENV_PATH"
else
    echo "🔄 Virtual environment already exists at $VENV_PATH"
fi

# Done!
echo "🚀 Airbnb Data Pipeline project structure is set up!"
echo "Navigate to: cd '$PROJECT_DIR'"
