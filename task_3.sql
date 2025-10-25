import mysql.connector

def create_tables():
    connection = None
    cursor = None

    try:
        # Connect to MySQL and the specific database
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='Janeisbecomingaprodev#$1',
            database='alx_book_store'
        )

        if connection.is_connected():
            print(" Connected to 'alx_book_store' successfully!")

            cursor = connection.cursor()

            # Create Authors table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS authors (
                    author_id INT AUTO_INCREMENT PRIMARY KEY,
                    author_name VARCHAR(215) NOT NULL
                );
            """)
            print(" Table 'authors' created successfully.")

            # Create Books table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS books (
                    book_id INT AUTO_INCREMENT PRIMARY KEY,
                    title VARCHAR(130) NOT NULL,
                    author_id INT,
                    price DOUBLE,
                    publication_date DATE,
                    FOREIGN KEY (author_id) REFERENCES authors(author_id)
                );
            """)
            print(" Table 'books' created successfully.")

            # Create Customers table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS customers (
                    customer_id INT AUTO_INCREMENT PRIMARY KEY,
                    customer_name VARCHAR(215) NOT NULL,
                    email VARCHAR(215),
                    address TEXT
                );
            """)
            print(" Table 'customers' created successfully.")

            # Create Orders table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS orders (
                    order_id INT AUTO_INCREMENT PRIMARY KEY,
                    customer_id INT,
                    order_date DATE,
                    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
                );
            """)
            print(" Table 'orders' created successfully.")

            # Create Order_Details table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS order_details (
                    orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
                    order_id INT,
                    book_id INT,
                    quantity DOUBLE,
                    FOREIGN KEY (order_id) REFERENCES orders(order_id),
                    FOREIGN KEY (book_id) REFERENCES books(book_id)
                );
            """)
            print(" Table 'order_details' created successfully.")

            # Commit changes
            connection.commit()
            print("\nAll tables created successfully in 'alx_book_store'!")

    except mysql.connector.Error as err:
        print(f"MySQL Error: {err}")

    except Exception as e:
        print(f"Unexpected error: {e}")

    finally:
        if cursor:
            cursor.close()
        if connection and connection.is_connected():
            connection.close()
            print("MySQL connection closed.")

if __name__ == "__main__":
    create_tables()
