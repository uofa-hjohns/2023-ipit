import sys
import mysql.connector
import os # for dumping
import subprocess # for dumping
import csv # for ledger

first_time = 0
mysql_counter = 0
logfile = open("mysql_dblog.txt","w")

display = """
SELECT
Line_Number, Line_Description,
Operator_ID, Operator_Name,
Source_ID, Source_Description,
Ledger_ID, Ledger_Description,
Journal_ID, Journal_Date, Journal_EntryDate,
Invoice_ID, Invoice_Amount,
Customer_ID, Customer_Name, Customer_BillerID,
Vendor_ID, Vendor_Name
FROM Entries 
INNER JOIN Operators ON Entries.Line_Operator_ID = Operators.Operator_ID
INNER JOIN Sources ON Entries.Line_Source_ID = Sources.Source_ID
INNER JOIN Ledgers ON Sources.Source_Ledger_ID = Ledgers.Ledger_ID
INNER JOIN Journals ON Entries.Line_Journal_ID = Journals.Journal_ID
INNER JOIN Invoices ON Journals.Journal_Invoice_ID = Invoices.Invoice_ID
INNER JOIN Customers ON Invoices.Invoice_Customer_ID = Customers.Customer_ID
INNER JOIN Vendors ON Invoices.Invoice_Vendor_ID = Vendors.Vendor_ID
ORDER BY Line_Number;
"""

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

# EXECUTE AND LOG ANY MYSQL COMMANDS
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
def db_IPITexportSQL():
  subprocess.run("sudo mysqldump --no-data=False --databases ipit --result-file=ipit.sql", shell=True)

def db_IPITexportCSV():
  print('csv export not implemented yet')

# CREATE IPIT DATABASE
def db_IPITcreate(db,dbcr):
  SQLExec = [
  """
	CREATE TABLE Customers (
	Customer_ID VARCHAR(255) PRIMARY KEY,
	Customer_Name VARCHAR(255),
	Customer_BillerID VARCHAR(255)
	)
	""",
	
	"""
	CREATE TABLE Vendors (
	Vendor_ID VARCHAR(255) PRIMARY KEY,
	Vendor_Name VARCHAR(255)
	)
	""",
	
	"""
	CREATE TABLE Ledgers (
	Ledger_ID VARCHAR(255) PRIMARY KEY,
	Ledger_Description VARCHAR(255)
	)
	""",
	
	"""
	CREATE TABLE Operators (
	Operator_ID VARCHAR(255) PRIMARY KEY,
	Operator_Name VARCHAR(255)
	)
	""",
	
	"""
	CREATE TABLE Invoices (
	Invoice_ID VARCHAR(255) PRIMARY KEY,
	Invoice_Amount VARCHAR(255),
	Invoice_Customer_ID VARCHAR(255),
	Invoice_Vendor_ID VARCHAR(255),
	CONSTRAINT FK_InvoiceCustomer FOREIGN KEY (Invoice_Customer_ID) REFERENCES Customers(Customer_ID),
	CONSTRAINT FK_InvoiceVendor FOREIGN KEY (Invoice_Vendor_ID) REFERENCES Vendors(Vendor_ID)
	)
	""",
	
	"""
	CREATE TABLE Journals (
	Journal_ID VARCHAR(255) PRIMARY KEY,
	Journal_Date VARCHAR(255),
	Journal_EntryDate VARCHAR(255),
	Journal_Invoice_ID VARCHAR(255),
	CONSTRAINT FK_JournalInvoice FOREIGN KEY (Journal_Invoice_ID) REFERENCES Invoices(Invoice_ID)
	)
	""",
	
	"""
	CREATE TABLE Sources (
	Source_ID VARCHAR(255) PRIMARY KEY,
	Source_Description VARCHAR(255),
	Source_Ledger_ID VARCHAR(255),
	CONSTRAINT FK_SourceLedger FOREIGN KEY (Source_Ledger_ID) REFERENCES Ledgers(Ledger_ID)
	)
	""",
	
	"""
	CREATE TABLE Entries (
	Line_Number INT NOT NULL PRIMARY KEY,
	Line_Description VARCHAR(255),
	Line_Operator_ID VARCHAR(255),
	Line_Source_ID VARCHAR(255),
	Line_Journal_ID VARCHAR(255),
	CONSTRAINT FK_LineOperator FOREIGN KEY (Line_Operator_ID) REFERENCES Operators(Operator_ID),
	CONSTRAINT FK_LineSource FOREIGN KEY (Line_Source_ID) REFERENCES Sources(Source_ID),
	CONSTRAINT FK_LineJournal FOREIGN KEY (Line_Journal_ID) REFERENCES Journals(Journal_ID)
	)
	"""]
  
  for x in SQLExec:
    mysql_execute(db,dbcr,x)


def getCSVarray():
  ledgerarray = []
  with open('Operating Expense Transactions.csv', 'r') as file:
    LedgerCSV = csv.reader(file)
    for entry in LedgerCSV:
        if entry[0] != "Journal ID" and (entry[5].startswith("UPH") != True) and (entry[5].startswith("Purchase") != True):
          ledgerarray.append(entry)
  return ledgerarray


def InsertIntoSQL(array,db,dbcr):
  AllQueries = []
  for entry in array:
    AllQueries.append(f"""INSERT IGNORE INTO Customers (Customer_ID, Customer_Name, Customer_BillerID) VALUES ('{entry[17]}', '{entry[18]}', '{entry[19]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO Vendors (Vendor_ID, Vendor_Name) VALUES ('{entry[14]}', '{entry[15]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO Ledgers (Ledger_ID, Ledger_Description) VALUES ('{entry[2]}','{entry[3]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO Operators (Operator_ID, Operator_Name) VALUES ('{entry[7]}','{entry[8]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO Invoices (Invoice_ID, Invoice_Amount, Invoice_Customer_ID, Invoice_Vendor_ID) VALUES ('{entry[16]}','{entry[4]}','{entry[17]}','{entry[14]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO Journals (Journal_ID, Journal_Date, Journal_EntryDate, Journal_Invoice_ID) VALUES ('{entry[0]}','{entry[1]}','{entry[13]}','{entry[16]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO Sources (Source_ID, Source_Description, Source_Ledger_ID) VALUES ('{entry[12]}','{entry[6]}','{entry[2]}')""")
    AllQueries.append(f"""INSERT IGNORE INTO Entries (Line_Number, Line_Description, Line_Operator_ID, Line_Source_ID, Line_Journal_ID) VALUES ('{entry[9]}','{entry[5]}','{entry[7]}','{entry[12]}','{entry[0]}')""")

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

  db_IPITexportSQL()
  db_IPITexportCSV()

  logfile.close()


if __name__ == "__main__":
    main()