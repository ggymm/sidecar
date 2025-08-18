### MySQL

#### 下载服务

[下载地址](https://dev.mysql.com/downloads/mysql/)

#### 配置服务

```ini

[mysqld]
port=3306
basedir=C:/Users/ggymm/service/mysql-8.4.6-winx64
datadir=C:/Users/ggymm/service/mysql-8.4.6-winx64/data
default-time-zone='+08:00'
character-set-server=utf8mb4
default-storage-engine=INNODB
max_connections=50000
max_allowed_packet=16M

[mysqld]
port=3306
basedir=/Volumes/Data/App/MySQL/mysql-8.4.6-macos15-arm64/
datadir=/Volumes/Data/App/MySQL/mysql-8.4.6-macos15-arm64/data
default-time-zone='+08:00'
character-set-server=utf8mb4
default-storage-engine=INNODB
max_connections=50000
max_allowed_packet=16M

```

```bash

./mysqld --initialize --console
./bin/mysqld --defaults-file=./my.cnf --initialize --console

# 使用密码登录
mysql -uroot -p
# 0%lW!CW,;S:z

# 设置新密码
set password for root@localhost='root';
flush privileges;

```


#### 启动脚本

```bash

# startup.sh
bin/mysqld --defaults-file=my.cnf --console

```

#### 停止脚本

```bash

# shutdown.sh
pid=$(cat /tmp/mysql.sock.lock)
kill $pid

```