import os
os.system("sudo mysql mysql < mysql_default.sql")

import mysql.connector
mydb = mysql.connector.connect(
  host="localhost",
  user="root"
)
print(mydb) 