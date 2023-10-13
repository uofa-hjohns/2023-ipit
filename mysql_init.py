import os
import subprocess
import time

subprocess.run("sudo apt-get update", shell=True, stdout=subprocess.DEVNULL)
print("APT updated")

subprocess.run("sudo apt-get -y install mysql-server", shell=True, stdout=subprocess.DEVNULL)
print("MySQL installed through APT")

subprocess.run("python -m pip install mysql-connector-python", shell=True, stdout=subprocess.DEVNULL)
print("MySQL Connector Python installed through Python")

subprocess.run("sudo /etc/init.d/mysql stop", shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)
subprocess.run("sudo service mysql stop", shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)
subprocess.run("sudo killall -KILL mysql mysqld_safe mysqld", shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.STDOUT)
print("All MySQL instances killed")

subprocess.run("sudo mysqld_safe &", shell=True, stdout=subprocess.DEVNULL)
print("MySQL server started in safe mode")

print("Waiting 15 seconds before updating MySQL default database")
time.sleep(5)
print("Waiting 10 seconds before updating MySQL default database")
time.sleep(5)
print("Waiting 5 seconds before updating MySQL default database")
time.sleep(5)

subprocess.run("sudo mysql < mysql_root", shell=True)
print("Updated default MySQL database")