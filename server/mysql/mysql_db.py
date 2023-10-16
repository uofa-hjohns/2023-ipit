import sys
import mysql.connector
import os # for dumping
import subprocess # for dumping

first_time = 0

# CONNECT TO MYSQL SERVER
def mysql_connect():
  try:
    tstdb = mysql.connector.connect(host="localhost", user="root")
  except:
    sys.exit('ERROR: Connection to MySQL server failed (unable to connect to server)\nEXITING...')

  try:
    db = mysql.connector.connect(host="localhost", user="root", database="ipit")
    print("Connection to MySQL server succeeded")
    return db
  except:
    print("ERROR: Connection to MySQL server failed (IPIT database does not exist)\n- ATTEMPTING TO IMPORT FROM ipit.sql -")
    db_IPITimport()
    
    try:
      db = mysql.connector.connect(host="localhost", user="root", database="ipit")
      print("Connection to MySQL server succeeded")
      return db
    except:
      sys.exit('ERROR: Connection to MySQL server failed (importing IPIT database unsuccessful)\nEXITING...')


# IMPORT IPIT DATABASE FROM FILE
def db_IPITimport():
  try:
    IPITsql = open("ipit.sql","r")
    IPITsql.close()
  except:
    print("ERROR: ipit.sql does not exist\n- ATTEMPTING TO CREATE ipit.sql -")
    try:
      IPITsql = open("ipit.sql","w")
      IPITsql.write("CREATE DATABASE ipit")
      IPITsql.close()

      global first_time
      first_time = 1

      print("Successfully created ipit.sql")
    except:
      sys.exit('ERROR: failed to create ipit.sql\nEXITING...')

  subprocess.run("sudo mysql < ipit.sql", shell=True)


# BACKUP/DUMP IPIT DATABASE TO FILE
def db_IPITexport():
  subprocess.run("sudo mysqldump --databases ipit > ipit.sql", shell=True, stdout=subprocess.DEVNULL)

# CREATE IPIT DATABASE
def db_IPITcreate(db,dbcr):
  dbcr.execute("CREATE TABLE Customers (CustomerID VARCHAR(255) PRIMARY KEY, CustomerName VARCHAR(255), BillerID VARCHAR(255))")
  dbcr.execute("CREATE TABLE Vendors (VendorID INT NOT NULL PRIMARY KEY, VendorName VARCHAR(255))")
  dbcr.execute("CREATE TABLE Transactions (InvoiceID VARCHAR(255) PRIMARY KEY, Amount INT NOT NULL, CustomerID VARCHAR(255), VendorID INT NOT NULL, CONSTRAINT FK_TransCust FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), CONSTRAINT FK_TransVend FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID))")


# MAIN FUNCTION
def main():
  db = mysql_connect()
  dbcr = db.cursor()

  if first_time == 1:
    print("IPIT database is empty, initializing...")
    db_IPITcreate(db,dbcr)

  db_IPITexport()


if __name__ == "__main__":
    main()