import mysql.connector

def create_database():
    connection = None
    cursor = None

    try:
        # Attempt to connect to MySQL server
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='Janeisbecomingaprodev#$1'
        )

        if connection.is_connected():
            print("Connected to MySQL server successfully!")
            cursor = connection.cursor()

            # Try to create the database
            try:
                cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store;")
                print("Database 'alx_book_store' created successfully!")

            except mysql.connector.Error as query_error:
                print(f"Failed to create database: {query_error}")

    except mysql.connector.Error as conn_error:
        print(f"Error while connecting to MySQL: {conn_error}")

    except Exception as e:
        print(f"An unexpected error occurred: {e}")

    finally:
        # Always close the cursor and connection safely
        if cursor is not None:
            cursor.close()
        if connection is not None and connection.is_connected():
            connection.close()
            print("MySQL connection closed.")

if __name__ == "__main__":
    create_database()
