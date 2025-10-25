import mysql.connector

def list_all_tables():
    connection = None
    cursor = None

    try:
        # Connect to MySQL server and use the alx_book_store database
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='Janeisbecomingaprodev#$1',
            database='alx_book_store'
        )

        if connection.is_connected():
            print(" Connected to MySQL server and using database 'alx_book_store'.")

            cursor = connection.cursor()

            # Execute the SQL command to list all tables
            cursor.execute("SHOW TABLES;")
            tables = cursor.fetchall()

            print("\n Tables in 'alx_book_store':")
            if tables:
                for (table_name,) in tables:
                    print(f"- {table_name}")
            else:
                print(" No tables found in the database.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")

    except Exception as e:
        print(f"Unexpected error: {e}")

    finally:
        # Always close cursor and connection
        if cursor is not None:
            cursor.close()
        if connection is not None and connection.is_connected():
            connection.close()
            print("\n MySQL connection closed.")

if __name__ == "__main__":
    list_all_tables()
