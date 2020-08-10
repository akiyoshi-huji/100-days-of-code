# build mysql docker image
docker image build -t example/mysql-data:latest .

# run container
docker container run -d --name mysql-data example/mysql-data:latest

# Data Volume container mount on MYSQL container
docker container run -d --rm --name mysql \
-e "MYSQL_ALLOW_EMPTY_PASSWORD=yes" \
-e "MYSQL_DATABASE=volume_test" \
-e "MYSQL_USER=example" \
-e "MYSQL_PASSWORD=example" \
--volumes-from mysql-data \
mysql:5.7

# login mysql container
docker container exec -it mysql mysql -u root -p volume_test

# CREATE TABLE on mysql
#>mysql
CREATE TABLE user(
  id int PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO user (name) VALUES ('gihyo'), ('docker'), ('Solomon Hykes');

# result
#mysql> select * from user;
#+----+---------------+
#| id | name          |
#+----+---------------+
#|  1 | gihyo         |
#|  2 | docker        |
#|  3 | Solomon Hykes |
#+----+---------------+
#3 rows in set (0.00 sec)

# stop mysql container
docker container stop mysql

# check user TABLE
docker container run -d --rm --name mysql \
-e "MYSQL_ALLOW_EMPTY_PASSWORD=yes" \
-e "MYSQL_DATABASE=volume_test" \
-e "MYSQL_USER=example" \
-e "MYSQL_PASSWORD=example" \
--volumes-from mysql-data \
mysql:5.7

# login
docker container exec -it mysql mysql -u root -p volume_test

# select table
#mysql>
select * from user;

# archiv DataVolume coutainer
docker container run -v `${PWD}`:/tmp \
--volume-from mysql-data \
busybox \
tar cvzf /tmp/mysql-backup.tar.gz /var/lib/mysql

# error
#tar cvzf /tmp/mysql-backup.tar.gz /var/lib/mysql
#zsh: permission denied: /{PWD}
#unknown flag: --volume-from
#See 'docker container run --help'.
