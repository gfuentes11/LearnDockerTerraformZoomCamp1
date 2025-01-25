# Create Docker Postgres Database 
docker run -it \
  -e POSTGRES_DB=ny_taxi \
  -e POSTGRES_USER=root \
  -e POSTGRES_PASSWORD=root \
  -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5435:5432 \
  postgres:13

# Running SQL in PGCLI
docker exec -it bold_chebyshev psql -U root -d ny_taxi

# Running PGADMIN in Docker Container
docker run -it \
  -e PGADMIN_DEFAULT_EMAIL='admin@admin.com' \
  -e PGADMIN_DEFAULT_PASSWORD='root' \
  -p 8080:80 \
  dpage/pgadmin4

# Run Postgres within same Network 
docker network create pg-ZoomCampNetwork1

# Setting Up the Network for Postgres
docker run -it \
  -e POSTGRES_DB=ny_taxi \
  -e POSTGRES_USER=root \
  -e POSTGRES_PASSWORD=root \
  -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5435:5432 \
  --network=pg-ZoomCampNetwork1 \
  --name pg-ZoomCampDB1 \
  postgres:13

docker run -it \
  -e PGADMIN_DEFAULT_EMAIL='admin@admin.com' \
  -e PGADMIN_DEFAULT_PASSWORD='root' \
  -p 8080:80 \
  --network=pg-ZoomCampNetwork1 \
  --name pg-ZoomCampPgAdmin \
  dpage/pgadmin4

# Then convert the .ipynb to a py script that you used earlier to run a script to insert data over a .ipynb
jupyter nbconvert --to=script DataDiscovery_Insert.ipynb

# Script to run the DataDiscover_InsertScript.py inside the Docker Container 
URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"

python ingest_data.py \
  --user=root \
  --password=root \
  --host=localhost \
  --port=5435 \
  --db=ny_taxi \
  --table_name=yellow_taxi_trips \
  --url=${URL}

#Now let us build the image out 
docker build -t taxi_ingest:v001

# Now run ingest data job with the docker container 
URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"

docker run -it \
  --network=pg-ZoomCampNetwork1 \
  taxi_ingest:v001 \
    --user=root \
    --password=root \
    --host=pg-ZoomCampDB1 \
    --port=5432 \
    --db=ny_taxi \
    --table_name=yellow_taxi_trips \
    --url=${URL}

# Now we created the docker compose file and will run it using 
# The reason that the compose file was created to have both PGDB and ADMIN running in one container. Within the compose file. 
# This allows us to avoid writing all the code we had above. 
docker compuse -up

# In Zoom Camp They used PG Admin. Used a local connection in VS Code to run quireries and save to the project space
# for tracking 
