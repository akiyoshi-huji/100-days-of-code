# Stack
docker container exec -it manager docker network create --driver=overlay --attachable ch03

# cp yml to manager container
docker container cp ch03-webapi.yml manager:/stack

# deploy Stack
docker container exec -it manager docker stack deploy -c /stack/ch03-webapi.yml echo
#Creating service echo_api
#Creating service echo_nginx

# check stack container
docker container exec -it manager docker stack services echo
#ID                  NAME                MODE                REPLICAS            IMAGE                               PORTS
#jq9p6bwjxaxg        echo_nginx          replicated          3/3                 gihyodocker/nginx-proxy:latest
#pgo9ubo6evnk        echo_api            replicated          3/3                 registry:5000/example/echo:latest

# check ps
docker container exec -it manager docker stack ps echo

# cp visualizer
docker container cp visualizer.yml manager:/stack

# visualizer
docker container exec -it manager docker stack deploy -c /stack/visualizer.yml visualizer
#port Additional property port is not allowed
