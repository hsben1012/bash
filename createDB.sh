#!/bin/bash

DB_NAME="inventory.db"

create()
{
        sqlite3 ${DB_NAME} <<EOF
          CREATE TABLE inventory (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            isbn TEXT NOT NULL,
            quantity INTEGER NOT NULL
          );
EOF
}

insert()
{
        sqlite3 ${DB_NAME} <<EOF
        insert into inventory values("1","1492090719","17")
EOF
}

rmdb()
{
  rm ${DB_NAME}
}

[ $# == "0" ] && echo 'Please input parameters [create/rm/<SQL command>].' && exit

case $1 in
        create)
                create
                insert
        ;;

        rm)
                rmdb
        ;;

        *)
                echo "${1}" | sqlite3 inventory.db
        ;;
esac