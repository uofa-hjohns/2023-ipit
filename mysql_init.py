import os
os.system("sudo apt-get update")
os.system("sudo apt-get -y install mysql-server")
os.system("python -m pip install mysql-connector-python")
os.system("sudo mysql < mysql_root")
os.system("sudo /etc/init.d/mysql stop")
os.system("sudo service mysql stop")
os.system("sudo killall -KILL mysql mysqld_safe mysqld")
os.system("sudo mysqld_safe &")