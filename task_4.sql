import mysql.connector

def show_books_table_description():
    connection = None
    cursor = None

    try:
        # Connect to MySQL and use alx_book_store
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='Janeisbecomingaprodev#$1',
            database='alx_book_store'
        )

        if connection.is_connected():
            print("✅ Connected to MySQL server and using database 'alx_book_store'.")

            cursor = connection.cursor()

            # Equivalent of the SQL script
            cursor.execute("USE alx_book_store;")
            cursor.execute("SHOW CREATE TABLE books;")

            result = cursor.fetchone()
            if result:
                print("\n📘 Full Description of 'books' Table:\n")
                print(result[1])
            else:
                print("⚠️ No description found for 'books' table.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")

    finally:
        if cursor:
            cursor.close()
        if connection and connection.is_connected():
            connection.close()
            print("\n🔒 MySQL connection closed.")

if __name__ == "__main__":
    show_books_table_description()
