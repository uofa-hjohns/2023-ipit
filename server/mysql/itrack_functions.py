import mysql.connector
from mysql_db import mysql_connect

def get_next_journal_line_number(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT MAX(GLE_LineNumber) FROM GeneralLedgerEntries")
    max_line_number = cursor.fetchone()[0]
    cursor.close()
    
    if max_line_number is not None:
        return max_line_number + 1
    else:
        return 1  # If there are no existing records, start from 1

def insert_asset_entry(journal_id, journal_date, gl_account, account_description, amount, line_description,
                      long_description, operator_id, operator, period, year, source,
                      journal_entry_date, vendor_id, vendor_name, invoice_voucher_id, customer_id,
                      customer_name, biller_id):
    try:
        # Use the mysql_connect function to establish the database connection
        connection = mysql_connect()

        cursor = connection.cursor()

        # Begin a transaction
        connection.start_transaction()

        # Get the next available line number
        next_line_number = get_next_journal_line_number(connection)

        # Insert data into the Customers table
        cursor.execute("INSERT INTO Customers (Customer_ID, Customer_Name, Customer_BillerID) VALUES (%s, %s, %s)",
                       (customer_id, customer_name, biller_id))

        # Insert data into the Vendors table
        cursor.execute("INSERT INTO Vendors (Vendor_ID, Vendor_Name) VALUES (%s, %s)",
                       (vendor_id, vendor_name))

        # Insert data into the Transactions table
        cursor.execute("INSERT INTO Transactions (Transaction_InvoiceID, Transaction_InvoiceAmount, TransactionFK_Customer_ID, TransactionFK_Vendor_ID) VALUES (%s, %s, %s, %s)",
                       (invoice_voucher_id, amount, customer_id, vendor_id))

        # Insert data into the GeneralLedgers table
        cursor.execute("INSERT INTO GeneralLedgers (GL_AccountID, GL_AccountDescription) VALUES (%s, %s)",
                       (gl_account, account_description))

        # Insert data into the Operators table
        cursor.execute("INSERT INTO Operators (Operator_ID, Operator_Name) VALUES (%s, %s)",
                       (operator_id, operator))

        # Insert data into the Sources table
        cursor.execute("INSERT INTO Sources (Source_ID, Source_LongDescription) VALUES (%s, %s)",
                       (source, long_description))

        # Insert data into the GeneralLedgerEntries table
        cursor.execute("INSERT INTO GeneralLedgerEntries (GLE_LineNumber, GLE_LineDescription, GLE_Period, GLE_Year, GLEFK_GL_AccountID, GLEFK_Operator_ID, GLEFK_Source_ID) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                       (next_line_number, line_description, period, year, gl_account, operator_id, source))

        # Insert data into the Journals table
        cursor.execute("INSERT INTO Journals (Journal_ID, Journal_Date, Journal_EntryDate, JournalFK_GLE_LineNumber, JournalFK_Transaction_InvoiceID) VALUES (%s, %s, %s, %s, %s)",
                       (journal_id, journal_date, journal_entry_date, next_line_number, invoice_voucher_id))

        # Commit the transaction
        connection.commit()

        print("Entries inserted successfully!")

    except mysql.connector.Error as error:
        # Rollback the transaction in case of an error
        connection.rollback()
        print(f"Error: {error}")
    finally:
        # Close the cursor and connection
        cursor.close()
        connection.close()

# Example usage:
insert_asset_entry("12345", "2023-10-24", "1001", "IT Assets", 1500.0, "New laptops", "Purchased 10 laptops",
                  "user123", "John Doe", "4", 2023, "Purchase", "2023-10-24", "123", "Vendor Inc.", "INV123",
                  "C567", "School District", "B987")
