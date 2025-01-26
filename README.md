# Data Engineering Learning Docker + Terraform

## Overview
This project is part of the Zoomcamp Data Engineering course and focuses on setting up a data pipeline using Docker, PostgreSQL, and SQL. Future sections will include Terraform for infrastructure automation and setting up a Google Cloud Platform (GCP) environment.

## Project Structure
```
LEARNDOCKERTERRAFORMZOOMCAMP1/
│── data/
│── ny_taxi_postgres_data/
│── SQL Queries/
│   └── practice.sql
│── .gitignore
│── DataDiscovery_Insert.ipynb
│── docker-compose.yml
│── Dockerfile
│── ingest_data.py
│── README.md
│── zoomCamp_env.yml
```

## Setup
### Prerequisites
- Docker installed on your machine
- PostgreSQL and PGAdmin images
- Conda environment set up (defined in `zoomCamp_env.yml`)

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
The `docker-compose.yml` file simplifies container orchestration by defining and running multiple services at once. In this project, it is used to spin up a PostgreSQL database along with a PGAdmin instance, allowing for database management via a web UI. Instead of manually setting up each container separately, `docker-compose` automates the process with a single command:
```sh
docker-compose up
```
This will start the database service (`pgdatabase`) and the PGAdmin service (`pgadmin`) as defined in the `docker-compose.yml` file.

## Data Ingestion
### Purpose of `ingest_data.py`
The `ingest_data.py` script is responsible for downloading and inserting NYC taxi trip data into the PostgreSQL database. The script performs the following tasks:
1. **Fetches data** from the specified URL (a compressed CSV file).
2. **Extracts the data** and prepares it for insertion.
3. **Connects to PostgreSQL** using credentials and connection details passed as command-line arguments.
4. **Creates the table** if it does not already exist.
5. **Inserts the data** into the `yellow_taxi_trips` table efficiently using batch operations.
6. **Commits changes** and closes the database connection.

Example command to run the ingestion job:
```sh
python ingest_data.py \
  --user=root \
  --password=root \
  --host=localhost \
  --port=5435 \
  --db=ny_taxi \
  --table_name=yellow_taxi_trips \
  --url=https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz
```

## SQL Queries
Several SQL queries are performed as part of this project, including:
- **Creating tables:**
```sql
CREATE TABLE IF NOT EXISTS yellow_taxi_trips (
    vendor_id INTEGER,
    pickup_datetime TIMESTAMP,
    dropoff_datetime TIMESTAMP,
    passenger_count INTEGER,
    trip_distance FLOAT,
    rate_code_id INTEGER,
    payment_type INTEGER,
    fare_amount FLOAT,
    total_amount FLOAT
);
```
- **Checking data integrity:**
```sql
SELECT COUNT(*) FROM yellow_taxi_trips;
```
- **Fetching sample data:**
```sql
SELECT * FROM yellow_taxi_trips LIMIT 10;
```
- **Aggregating trip statistics:**
```sql
SELECT vendor_id, COUNT(*) AS trip_count
FROM yellow_taxi_trips
GROUP BY vendor_id;
```

## Next Steps
- **Terraform Integration**: Automating infrastructure provisioning.
- **GCP Setup**: Deploying PostgreSQL to Google Cloud.
- **ETL Pipeline**: Enhancing data processing workflows.

More updates will be added as the project progresses!

