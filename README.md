# Data Engineering Learning Docker + Terraform

## Overview
This project is part of the Zoomcamp Data Engineering course and focuses on setting up a data pipeline using Docker, PostgreSQL, SQL, and Terraform. This is an introduction to docker and to start getting a taste of different technologies used in DE. 

## Project Structure
```
LEARNDOCKERTERRAFORMZOOMCAMP1/
│── data/
│── dataingest/
│   └── DataDiscovery_Insert.ipynb
│   └── ingest_data.py
│── gcpKeys/
│   └── zoomCamp_env.json
│── gcpVMSetUp/
│   └── gcpVMSetup.md
│── ny_taxi_postgres_data/
│── SQL Queries/
│   └── practice.sql
│── terraDemo/
│   └── .terraform/
│   └── .terraform.lock.hcl
│   └── main.tf
│   └── terraform.tfstate
│   └── terraform.tfstate.backup
│   └── variables.tf
│── zoomCampHW1/
│   └── data/
│   └── hwTerra/
│       └── main.tf
│       └── variables.tf
│   └── prepPostgress/
│       └── ingest_dataHW.py
│       └── prepPostgres.ipynb
│   └── queries/
│       └── Question3.sql
│       └── Question4.sql
│       └── Question5.sql
│       └── Question6.sql
│   └── docker-compose_q2.yml
│── .gitignore
│── docker-compose.yml
│── Dockerfile
│── README.md
│── zoomCamp_env.yml
```

## Setup
### Prerequisites
- Docker installed on your machine
- PostgreSQL and PGAdmin images
- Conda environment set up (defined in `zoomCamp_env.yml`)
- Terraform installed (`brew install terraform` on MacOS)

### Running the PostgreSQL Database with Docker
To start a PostgreSQL container with persistent storage:
```sh
docker run -it \
  -e POSTGRES_DB=ny_taxi \
  -e POSTGRES_USER=root \
  -e POSTGRES_PASSWORD=root \
  -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5435:5432 \
  postgres:13
```

### Running PGAdmin
```sh
docker run -it \
  -e PGADMIN_DEFAULT_EMAIL='admin@admin.com' \
  -e PGADMIN_DEFAULT_PASSWORD='root' \
  -p 8080:80 \
  dpage/pgadmin4
```

### Running with Docker Compose
The `docker-compose.yml` file simplifies container orchestration by defining and running multiple services at once. It sets up a PostgreSQL database and PGAdmin instance, allowing for database management via a web UI. Instead of manually setting up each container separately, `docker-compose` automates the process with:
```sh
docker-compose up
```
This will start both services as defined in the `docker-compose.yml` file.

## Data Ingestion
### Purpose of `ingest_data.py`
The `ingest_data.py` script downloads and inserts NYC taxi trip data into the PostgreSQL database:
1. **Fetches data** from the specified URL (a compressed CSV file).
2. **Extracts the data** and prepares it for insertion.
3. **Connects to PostgreSQL** using credentials and connection details passed as command-line arguments.
4. **Creates the table** if it does not already exist.
5. **Inserts the data** into the `yellow_taxi_trips` table efficiently using batch operations.
6. **Commits changes** and closes the database connection.

## Terraform Notes
### Setting up Terraform
To deploy infrastructure using Terraform, follow these steps:
1. **Set up a GCP environment**: 
   - You can create a personal account with $300 in free credits.
   - Set up a **service account** with Storage Admin and BigQuery permissions.
   - Generate a key for the service account and add it to your directory (`gcpKeys`).
   - Ensure the key is added to `.gitignore` to prevent accidental commits.

2. **Install Terraform**: 
   - On MacOS, install Terraform using:
     ```sh
     brew install terraform
     ```
   - Verify installation:
     ```sh
     terraform -version
     ```

3. **Initialize a Terraform project**: 
   - Navigate to the `terraDemo` directory:
     ```sh
     cd terraDemo
     ```
   - Set up Google Cloud credentials without hardcoding them:
     ```sh
     export GOOGLE_CREDENTIALS='path/to/your/key.json'
     echo $GOOGLE_CREDENTIALS  # Validate it worked
     ```

4. **Terraform Workflow**:
   ```sh
   terraform fmt       # Format Terraform files
   terraform init      # Initialize Terraform
   terraform plan      # Preview infrastructure changes
   terraform apply     # Deploy the resources
   ```

5. **Review and Destroy**:
   - Check the generated `terraform.tfstate` file to review deployed resources.
   - To delete resources:
     ```sh
     terraform destroy
     ```

## SQL Queries
Some important SQL queries used in the project:
- **Checking data integrity**:
```sql
SELECT COUNT(*) FROM yellow_taxi_trips;
```
- **Fetching sample data**:
```sql
SELECT * FROM yellow_taxi_trips LIMIT 10;
```
- **Aggregating trip statistics**:
```sql
SELECT vendor_id, COUNT(*) AS trip_count FROM yellow_taxi_trips GROUP BY vendor_id;
```

### Google Cloud Platform Virtual Machine Setup
The `gcpVMSetup.md` file details the step-by-step process for setting up a GCP Virtual Machine. This is to enable you to run the same project but in GCP.

## Homework
The `zoomCampHW1` directory contains homework assignments that reinforce concepts covered in the course. These assignments involve working with Terraform, PostgreSQL, and Docker to test and solidify understanding of cloud infrastructure, data ingestion, and database querying. Each problem applies real-world data engineering techniques learned throughout the sessions.




