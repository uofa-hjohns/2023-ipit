#!/bin/bash
sudo apt-get update
sudo apt-get -y install mysql-server
python -m pip install mysql-connector-python
#sudo /etc/init.d/mysql stop
#sudo service mysql stop
#sudo killall -KILL mysql mysqld_safe mysqld
#sudo mysqld_safe &