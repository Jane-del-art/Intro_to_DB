import mysql.connector

def create_tables():
    connection = None
    cursor = None

    try:
        # Connect to the MySQL server and database
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='Janeisbecomingaprodev#$1',
            database='alx_book_store'
        )

        if connection.is_connected():
            print(" Connected to the 'alx_book_store' database successfully!")

            cursor = connection.cursor()

            # ------------------------------------------------------------
            # 1. AUTHORS TABLE
            # ------------------------------------------------------------
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS Authors (
                    author_id INT AUTO_INCREMENT PRIMARY KEY,
                    author_name VARCHAR(215) NOT NULL
                );
            """)
            print("Table 'Authors' created successfully.")

            # ------------------------------------------------------------
            # 2. BOOKS TABLE
            # ------------------------------------------------------------
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS Books (
                    book_id INT AUTO_INCREMENT PRIMARY KEY,
                    title VARCHAR(130) NOT NULL,
                    author_id INT,
                    price DOUBLE,
                    publication_date DATE,
                    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
                );
            """)
            print("Table 'Books' created successfully.")

            # ------------------------------------------------------------
            # 3. CUSTOMERS TABLE
            # ------------------------------------------------------------
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS Customers (
                    customer_id INT AUTO_INCREMENT PRIMARY KEY,
                    customer_name VARCHAR(215) NOT NULL,
                    email VARCHAR(215),
                    address TEXT
                );
            """)
            print("Table 'Customers' created successfully.")

            # ------------------------------------------------------------
            # 4. ORDERS TABLE
            # ------------------------------------------------------------
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS Orders (
                    order_id INT AUTO_INCREMENT PRIMARY KEY,
                    customer_id INT,
                    order_date DATE,
                    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
                );
            """)
            print("Table 'Orders' created successfully.")

            # ------------------------------------------------------------
            # 5. ORDER_DETAILS TABLE
            # ------------------------------------------------------------
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS Order_Details (
                    orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
                    order_id INT,
                    book_id INT,
                    quantity DOUBLE,
                    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
                    FOREIGN KEY (book_id) REFERENCES Books(book_id)
                );
            """)
            print("Table 'Order_Details' created successfully.")

            # Commit all changes
            connection.commit()
            print("\n All tables created successfully in 'alx_book_store'!")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")

    except Exception as e:
        print(f"Unexpected error: {e}")

    finally:
        if cursor is not None:
            cursor.close()
        if connection is not None and connection.is_connected():
            connection.close()
            print(" MySQL connection closed.")

if __name__ == "__main__":
    create_tables()
