# serch docker images
docker search --limit 5 mysql

# pull docker image
docker image pull jenkins:latest

# show docker log
docker container logs -f $(docker container ls --filter "ancestor=jenkins" -q)

# prune stopped docker container
docker container prune

# prune stopped docker image
docker image prune

# show system resources
docker container stats

# docker compose
# docker-compose version 1.25.5, build 8a1c60f6
# docker-py version: 4.1.0
# CPython version: 3.7.5
# OpenSSL version: OpenSSL 1.1.1f  31 Mar 2020
docker-compose version

# docker run
docker container run -d -p 9000:8080 example/echo:latest

# compose run
# make docker-compose.yml and "cd {directory}/docker-compose.yml"directory
docker-compose up -d

# compose stop
docker-compose down

# compose and build
docker-compose up -d --build
