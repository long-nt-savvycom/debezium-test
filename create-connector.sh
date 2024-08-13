#!/bin/bash

# Define environment variables for connector configuration files
MYSQL_SOURCE_CONNECTOR="mysql-source-connector.example.json"
PG_SOURCE_CONNECTOR="pg-source-connector.example.json"
PG_SINK_CONNECTOR="pg-sink-connector.example.json"

CONNECTORS_API_URL="http://localhost:8083/connectors"

curl -X POST -H "Content-Type: application/json" --data @"$MYSQL_SOURCE_CONNECTOR" "$CONNECTORS_API_URL"

curl -X POST -H "Content-Type: application/json" --data @"$PG_SOURCE_CONNECTOR" "$CONNECTORS_API_URL"

curl -X POST -H "Content-Type: application/json" --data @"$PG_SINK_CONNECTOR" "$CONNECTORS_API_URL"

echo "Listing all connectors..."
curl --location 'http://localhost:8083/connectors'