#!/bin/sh
# version check
docker -v
# pull giyho image
docker image pull gihyodocker/echo
# run gihyo (port 9000 -> 8080)
docker container run -t -p 9000:8080 gihyodocker/echo

#
# run another shell
#

# check gihyo is running
# print "Hello Docker!!"
curl http://localhost:9000/

# build example(main.go & Dockerfile)
docker image build -t example/echo:latest

# run example as background (-d option)
docker container run -d example/echo:latest

# check container status
docker container ls

# check response
# print 'curl: (7) Failed to connect to localhost port 8080: Connection refused'
curl http://localhost:8080/

# for portfowarding, stop example container
docker container stop $(docker container ls --filter "ancestor=example/echo" -q)

# portfowarding (-p option)
docker container run -d -p 9000:8080 example/echo:latest

# check response
# print "Hello Docker!!"
curl http://localhost:9000/

# show port number set by portfowarding
# PORTS (0.0.0.0:9000->8080/tcp)
docker container ls
