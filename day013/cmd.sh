# Docker in Docker up
docker-compose up -d

#ERROR: The Compose file './docker-compose.yml' is invalid because:
#Invalid top-level property "servise". Valid top-level sections for this Compose file are: version, services, networks, volumes, and extensions starting with "x-".

#You might be seeing this error because you're using the wrong Compose file version. Either specify a supported version (e.g "2.2" or "3.3") and place your service definitions under the `services` key, or omit the `version` key and place your service definitions at the root of the file to use version 1.
#For more on the Compose file format versions, see https://docs.docker.com/compose/compose-file/

# Docker in Docker up
docker-compose up -d

#ERROR: Service 'manager' depends on service 'registry' which is undefined.

# check
docker container ls
#CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS                                                              NAMES
#4cdc78a4054a        docker:18.05.0-ce-dind   "dockerd-entrypoint.…"   2 minutes ago       Up 2 minutes        2375/tcp, 4789/udp, 7946/tcp, 7964/udp                             worker01
#1dec7f09c3b5        docker:18.05.0-ce-dind   "dockerd-entrypoint.…"   2 minutes ago       Up 2 minutes        2375/tcp, 4789/udp, 7946/tcp, 7964/udp                             worker03
#16c4b97fdcab        docker:18.05.0-ce-dind   "dockerd-entrypoint.…"   2 minutes ago       Up 2 minutes        2375/tcp, 4789/udp, 7946/tcp, 7964/udp                             worker02
#fbc24576bc8c        docker:18.05.0-ce-dind   "dockerd-entrypoint.…"   2 minutes ago       Up 2 minutes        2375/tcp, 3375/tcp, 0.0.0.0:9000->9000/tcp, 0.0.0.0:8000->80/tcp   manager
#26dc38a144b3        registry:2.6             "/entrypoint.sh /etc…"   2 minutes ago       Up 2 minutes        0.0.0.0:5000->5000/tcp                                             registry

# docker swarm
docker container exec -it manager docker swarm init
# ATTNETION check JOIN token

#Swarm initialized: current node (ttxxpxg7n1056up526umh8diz) is now a manager.
#To add a worker to this swarm, run the following command:
#    docker swarm join --token {token}
#To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

# join worker01 to maneger
docker container exec -it worker01 docker swarm join \
--token {token}
#This node joined a swarm as a worker.

# worker02 and worker03
docker container exec -it worker02 docker swarm join \
--token {token}
docker container exec -it worker03 docker swarm join \
--token {token}

# check Swarm cluster
docker container exec -it manager docker node ls
#ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
#tm0s3dl87pi2rk5yd3am71c0g     1dec7f09c3b5        Ready               Active                                  18.05.0-ce
#rdkb1opj0g0i0n1gnipfggzhx     4cdc78a4054a        Ready               Active                                  18.05.0-ce
#5at1j14vd4g7vrun2doqp06pw     16c4b97fdcab        Ready               Active                                  18.05.0-ce
#ttxxpxg7n1056up526umh8diz *   fbc24576bc8c        Ready               Active              Leader              18.05.0-ce

# set tag
docker image tag example/echo:latest localhost:5000/example/echo:latest

# push docker image to docker registry
docker image push localhost:5000/example/echo:latest
