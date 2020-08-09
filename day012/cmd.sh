# build mysql docker image
docker image build -t example/mysql-data:latest .

# run container
docker container run -d --name mysql-data example/mysql-data:latest
