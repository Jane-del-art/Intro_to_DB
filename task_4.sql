import mysql.connector

def show_books_table_description():
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
            print("Connected to MySQL server and using database 'alx_book_store'.")

            cursor = connection.cursor()

            # Use the database explicitly
            cursor.execute("USE alx_book_store;")

            # Show full table description of 'books' without DESCRIBE or EXPLAIN
            cursor.execute("SHOW CREATE TABLE books;")

            result = cursor.fetchone()
            if result:
                print("\n Full Description of 'books' Table:\n")
                print(result[1])  # The second column contains the CREATE TABLE statement
            else:
                print(" No description found for 'books' table.")

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
    show_books_table_description()
