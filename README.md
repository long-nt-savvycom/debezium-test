## 
### Step by step

1. Step 1: Setup Database
    - If you want to connect with exist source databases
    - Copy file docker-compose.exist.yml to docker-compose.yml
    - config all services on docker-compose file and your database into one network

2. Step 1.2 (Optional)
    - If you don't have any exist source databases
    - Copy file docker-compose.test.yml to docker-compose.yml

3. Step 2: Build infra
    - After modify docker-compose file and .env file completely
    - Run: `docker compose up -d` (or `docker-compose up -d` for old version)

4. Step 2.2: Create test data (Optional)
    - If you create test source databases like step 1.2
    - Access to test database and run script like `create-source-table.sql`
    - Or Run: `sh create-mysql-data.sh` and `sh create-postgres-data.sh`

5. Step 3: Config source connectors
    - (Optional) if you do the test, you can run file create-connector.sh and skip step 3 and 4
    - Copy from `mysql-source-connector.example.json` or `pg-source-connector.example.json` (if your source db is mysql or postgres) to `source_1_config_file_name.json`

    - Modify source_1_config_file_name.json file with matching info of your database (name, username, password...)

    - To setup source connector: `curl -X POST -H "Content-Type: application/json" --data ./source_1_config_file_name.json http://localhost:8083/connectors`

    - (Optional) To list all connectors: `curl --location 'http://localhost:8083/connectors'`

    - (Optional) To check connector status: `curl --location 'http://localhost:8083/connectors/{name_connector}/status'`

    - (Optional) To delete connector: `curl --location --request DELETE 'http://localhost:8083/connectors/postgres-sink'`

    - (Optional) To update connector: `curl --location --request PUT 'http://localhost:8083/connectors/postgres-connector/config' \
--header 'Content-Type: application/json' \
--data ./update_file_config.json`

    - If you have many source, do the same with the other sources

6. Step 4: Config sink connectors
    - Do the same with step 3 with `pg-sink-connector.example.json` file
    - Change `source.*\\..*` with `{start_topic_name}.*\\..*`

7. Step 5: Checking with kafdrop
    - Open: `http://localhost:9000` and check topic names change