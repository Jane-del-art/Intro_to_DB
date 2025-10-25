import mysql.connector
from mysql.connector import Error

def create_database():
    connection = None
    cursor = None

    try:
        # Try connecting to MySQL Server
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='Janeisbecomingaprodev#$1'
        )

        if connection.is_connected():
            cursor = connection.cursor()

            try:
                # Create the database if it doesn't exist
                cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store;")
                print("Database 'alx_book_store' created successfully!")

            except Error as query_error:
                print(f"Failed to create database: {query_error}")

    except Error as conn_error:
        print(f"Error while connecting to MySQL: {conn_error}")

    except Exception as e:
        print(f"An unexpected error occurred: {e}")

    finally:
        # Ensure resources are properly closed
        if cursor is not None:
            cursor.close()
        if connection is not None and connection.is_connected():
            connection.close()
            print(" MySQL connection closed.")

if __name__ == "__main__":
    create_database()
