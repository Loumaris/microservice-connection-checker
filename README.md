# microservice connection checker

This is a simple Sinatra application that provides endpoints to check the connection to a PostgreSQL database and a Redis instance.

## Endpoints

- `/`: Welcome message and available routes.
- `/check/db`: Check the connection to the PostgreSQL database.
- `/check/redis`: Check the connection to the Redis instance.

## Setup

### Prerequisites

- Docker
- PostgreSQL
- Redis

### Environment Variables

The following environment variables need to be set:

- `POSTGRESQL_DATABASE`: The name of the PostgreSQL database.
- `POSTGRESQL_USERNAME`: The username for the PostgreSQL database.
- `POSTGRESQL_PASSWORD`: The password for the PostgreSQL database.
- `POSTGRESQL_ADDRESS`: The host address of the PostgreSQL database.
- `POSTGRESQL_PORT`: The port of the PostgreSQL database.
- `REDIS_URL`: The URL of the Redis instance.
- `ENV_SECRET`: A secret key used to display environment variables in error responses.

### Building the Docker Image

```sh
docker build -t sinatra-app .