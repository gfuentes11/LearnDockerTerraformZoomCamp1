# NYC Taxi Data Engineering Project

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
To bring up both PostgreSQL and PGAdmin using Docker Compose:
```sh
docker-compose up
```

### Data Ingestion
Data can be ingested using the `ingest_data.py` script. Example command:
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

## Next Steps
- **Terraform Integration**: Automating infrastructure provisioning.
- **GCP Setup**: Deploying PostgreSQL to Google Cloud.
- **ETL Pipeline**: Enhancing data processing workflows.

More updates will be added as the project progresses!

