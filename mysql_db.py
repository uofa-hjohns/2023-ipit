import os
os.system("sudo mysql < mysql_root")

import mysql.connector
mydb = mysql.connector.connect(
  host="localhost",
  user="root"
)
print(mydb) 