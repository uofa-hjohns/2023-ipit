import sys
import mysql.connector
import os # for dumping
import subprocess # for dumping
import csv # for ledger

first_time = 0
mysql_counter = 0
logfile = open("mysql_dblog.txt","w")

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

def mysql_execute(db,dbcr,command):
  dbcr.execute(command)
  db.commit()

  global mysql_counter
  mysql_counter += 1

  global logfile
  logfile.write(f"{mysql_counter} :: {command}\n")

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
  subprocess.run("sudo mysqldump --no-data=False --databases ipit --result-file=ipit.sql", shell=True)

# CREATE IPIT DATABASE
def db_IPITcreate(db,dbcr):
  SQLExec = [
  """CREATE TABLE Customers (
  Customer_ID VARCHAR(255) PRIMARY KEY, 
  Customer_Name VARCHAR(255), 
  Customer_BillerID VARCHAR(255)
  )""",

  """CREATE TABLE Vendors (
  Vendor_ID INT NOT NULL PRIMARY KEY, 
  Vendor_Name VARCHAR(255)
  )""",
  
  """CREATE TABLE Transactions (
  Transaction_InvoiceID VARCHAR(255) PRIMARY KEY, 
  Transaction_InvoiceAmount INT NOT NULL, 
  TransactionFK_Customer_ID VARCHAR(255), 
  TransactionFK_Vendor_ID INT NOT NULL, 
  CONSTRAINT FK_TransactionCustomers FOREIGN KEY (TransactionFK_Customer_ID) REFERENCES Customers(Customer_ID), 
  CONSTRAINT FK_TransactionVendors FOREIGN KEY (TransactionFK_Vendor_ID) REFERENCES Vendors(Vendor_ID)
  )""",
  
  """CREATE TABLE GeneralLedgers (
  GL_AccountID INT NOT NULL PRIMARY KEY, 
  GL_AccountDescription VARCHAR(255)
  )""",
  
  """CREATE TABLE Operators (
  Operator_ID VARCHAR(255) PRIMARY KEY, 
  Operator_Name VARCHAR(255)
  )""",
  
  """CREATE TABLE Sources (
  Source_ID VARCHAR(255) PRIMARY KEY, 
  Source_LongDescription VARCHAR(255)
  )""",
  
  """CREATE TABLE GeneralLedgerEntries (
  GLE_LineNumber INT NOT NULL PRIMARY KEY, 
  GLE_LineDescription VARCHAR(255), 
  GLE_Period INT NOT NULL, 
  GLE_Year YEAR NOT NULL,
  GLEFK_GL_AccountID INT NOT NULL, 
  GLEFK_Operator_ID VARCHAR(255), 
  GLEFK_Source_ID VARCHAR(255), 
  CONSTRAINT FK_GLEtGL FOREIGN KEY (GLEFK_GL_AccountID) REFERENCES GeneralLedgers(GL_AccountID), 
  CONSTRAINT FK_GLEOper FOREIGN KEY (GLEFK_Operator_ID) REFERENCES Operators(Operator_ID), 
  CONSTRAINT FK_GLESrc FOREIGN KEY (GLEFK_Source_ID) REFERENCES Sources(Source_ID)
  )""",
  
  """CREATE TABLE Journals (
  Journal_ID VARCHAR(255) PRIMARY KEY,
  Journal_Date VARCHAR(255),
  Journal_EntryDate VARCHAR(255),
  JournalFK_GLE_LineNumber INT NOT NULL,
  JournalFK_Transaction_InvoiceID VARCHAR(255),
  CONSTRAINT FK_Journals_GLE FOREIGN KEY (JournalFK_GLE_LineNumber) REFERENCES GeneralLedgerEntries(GLE_LineNumber),
  CONSTRAINT FK_Journals_Transactions FOREIGN KEY (JournalFK_Transaction_InvoiceID) REFERENCES Transactions(Transaction_InvoiceID)
  )"""]
  
  for x in SQLExec:
    mysql_execute(db,dbcr,x)


def getCSVarray():
  ledgerarray = []
  with open('Operating Expense Transactions.csv', 'r') as file:
    LedgerCSV = csv.reader(file)
    for entry in LedgerCSV:
        if entry[0] != "Journal ID":
          ledgerarray.append(entry)
  return ledgerarray

def InsertIntoSQL(array,db,dbcr):
  AllQueries = []
  for entry in array:
    AllQueries.append(f"""INSERT IGNORE INTO Customers (Customer_ID, Customer_Name, Customer_BillerID) VALUES ('{entry[17]}', '{entry[18]}', '{entry[19]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO Vendors (Vendor_ID, Vendor_Name) VALUES ('{entry[14]}', '{entry[15]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO Transactions (Transaction_InvoiceID, Transaction_InvoiceAmount, TransactionFK_Customer_ID, TransactionFK_Vendor_ID) VALUES ('{entry[16]}','{entry[4]}','{entry[17]}','{entry[14]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO GeneralLedgers (GL_AccountID, GL_AccountDescription) VALUES ('{entry[2]}','{entry[3]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO Operators (Operator_ID, Operator_Name) VALUES ('{entry[7]}','{entry[8]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO Sources(Source_ID, Source_LongDescription) VALUES ('{entry[12]}','{entry[6]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO GeneralLedgerEntries(GLE_LineNumber, GLE_LineDescription, GLE_Period, GLE_Year, GLEFK_GL_AccountID, GLEFK_Operator_ID, GLEFK_Source_ID) VALUES ('{entry[9]}','{entry[5]}','{entry[10]}','{entry[11]}','{entry[2]}','{entry[7]}','{entry[12]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO Journals(Journal_ID, Journal_Date, Journal_EntryDate, JournalFK_GLE_LineNumber, JournalFK_Transaction_InvoiceID) VALUES ('{entry[0]}','{entry[1]}','{entry[13]}','{entry[9]}','{entry[16]}')""")

  for query in AllQueries:
    mysql_execute(db,dbcr,query)


# MAIN FUNCTION
def main():
  db = mysql_connect()
  dbcr = db.cursor()

  if first_time == 1:
    print("IPIT database is empty, initializing...")
    db_IPITcreate(db,dbcr)

  InsertIntoSQL(getCSVarray(),db,dbcr)

  db_IPITexport()

  logfile.close()


if __name__ == "__main__":
    main()