#!/bin/bash

# Load environment variables from .env file
# source .env
export $(grep -v '^#' .env | xargs)
echo "Environment variables loaded."

# Now you can use the variables
echo "MySQL User: $MYSQL_ROOT_USER"
echo "MySQL Password: $MYSQL_ROOT_PASSWORD"
echo "MySQL Database: $MYSQL_DATABASE"
echo "MySQL Container: $MYSQL_CONTAINER_NAME"

docker exec -i mysql_db mysql -u$MYSQL_ROOT_USER -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < ./test-schema.sql
