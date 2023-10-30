from flask import Flask, request, jsonify, render_template
from server.mysql.mysql_db import mysql_connect # Import your database connection function here
import json
from flask_cors import CORS

app = Flask(__name__, template_folder='/workspaces/2023-ipit/client/html', static_folder='/workspaces/2023-ipit/client/html')
CORS(app)  # Enable CORS for the entire app

# Define a route for your HTML page
@app.route('/')
def index():
    return render_template('admin.html')

# Define an API route to get entries from the database
@app.route('/get_entries', methods=['GET'])
def get_entries():
    entries = get_entries_from_database()
    return jsonify(entries)

def get_entries_from_database():
    try:
        connection = mysql_connect()
        cursor = connection.cursor()

        query = "SELECT * FROM Entries"  # Adjust the SQL query as needed
        cursor.execute(query)

        # Fetch all rows as a list of dictionaries
        columns = [column[0] for column in cursor.description]
        data = [dict(zip(columns, row)) for row in cursor.fetchall()]

        cursor.close()
        connection.close()

        return data  # Return data as a Python list

    except Exception as error:
        return {"error": str(error)}

if __name__ == "__main__":
    app.run(debug=True)
