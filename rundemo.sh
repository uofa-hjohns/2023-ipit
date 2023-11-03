#!/bin/sh
cd server/mysql
python mysql_init.py
python mysql_db.py
cd ../../
python app.py