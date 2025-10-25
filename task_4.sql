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
            print(" Connected to MySQL server and using database 'alx_book_store'.")

            cursor = connection.cursor()

            # Query to get table structure using INFORMATION_SCHEMA
            query = """
                SELECT COLUMN_NAME, COLUMN_TYPE
                FROM INFORMATION_SCHEMA.COLUMNS
                WHERE TABLE_SCHEMA = 'alx_book_store'
                AND TABLE_NAME = 'Books';
            """
            cursor.execute(query)
            results = cursor.fetchall()

            print("\n Full description of 'books' table:")
            if results:
                for column_name, column_type in results:
                    print(f"- {column_name}: {column_type}")
            else:
                print(" No columns found for 'books' table.")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")

    finally:
        if cursor:
            cursor.close()
        if connection and connection.is_connected():
            connection.close()
            print("\n MySQL connection closed.")

if __name__ == "__main__":
    show_books_table_description()

