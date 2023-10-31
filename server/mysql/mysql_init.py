import os
import subprocess

logfile = open("mysql_initlog.txt","w")

subprocess.run("sudo apt-get update", shell=True, stdout=logfile)
print("INIT: APT packages updated")

subprocess.run("sudo apt-get -y install default-mysql-server", shell=True, stdout=logfile)
print("INIT: MySQL Default installed through APT")

subprocess.run("sudo apt-get -y install mysql-server", shell=True, stdout=logfile)
print("INIT: MySQL installed through APT")

subprocess.run("python -m pip install mysql-connector-python", shell=True, stdout=logfile)
print("INIT: MySQL-Connector-Python installed through PIP")

subprocess.run("python -m pip install -U Flask", shell=True, stdout=logfile)
print("INIT: Flask installed through PIP")

subprocess.run("python -m pip install -U flask-cors", shell=True, stdout=logfile)
print("INIT: Flask CORS installed through PIP")

subprocess.run("sudo /etc/init.d/mysql stop", shell=True, stdout=logfile, stderr=subprocess.STDOUT)
subprocess.run("sudo service mysql stop", shell=True, stdout=logfile, stderr=subprocess.STDOUT)
subprocess.run("sudo killall -KILL mysql mysqld_safe mysqld", shell=True, stdout=logfile, stderr=subprocess.STDOUT)
print("INIT: All default MySQL instances killed")

subprocess.run("sudo mysqld_safe &", shell=True, stdout=logfile)
print("INIT: MySQL server started in safe mode")

import sys
import time
for seconds in range(15,0,-1):
    sys.stdout.write("\rINIT: Waiting " + str(seconds) + " seconds before updating MySQL default database")
    sys.stdout.flush()
    time.sleep(1)

subprocess.run("sudo mysql < default.sql", shell=True)
print("\nINIT: Updated default MySQL database")

logfile.close()