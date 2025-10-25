import mysql.connector
from mysql.connector import Error

def create_connection(host="localhost", user="root", password="Janeisbecomingaprodev#$1"):
    """Establish connection to MySQL server."""
    try:
        conn = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            auth_plugin="mysql_native_password"
        )
        if conn.is_connected():
            print("Connected to MySQL server.")
        return conn
    except Error as e:
        print(f"Error while connecting: {e}")
        return None


def create_database(cursor):
    """Create the alx_book_store database if it doesn't exist."""
    try:
        cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store;")
        print("Database 'alx_book_store' created or already exists.")
    except Error as e:
        print(f"Error creating database: {e}")


def use_database(cursor):
    """Select the alx_book_store database for use."""
    try:
        cursor.execute("USE alx_book_store;")
        print("Using database 'alx_book_store'.")
    except Error as e:
        print(f"Error selecting database: {e}")


def create_tables(cursor):
    """Create all necessary tables for the bookstore."""
    try:
        # Authors table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS Authors (
                author_id INT AUTO_INCREMENT PRIMARY KEY,
                author_name VARCHAR(215) NOT NULL
            );
        """)

        # Books table
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

        # Customers table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS Customers (
                customer_id INT AUTO_INCREMENT PRIMARY KEY,
                customer_name VARCHAR(215) NOT NULL,
                email VARCHAR(215),
                address TEXT
            );
        """)

        # Orders table
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS Orders (
                order_id INT AUTO_INCREMENT PRIMARY KEY,
                customer_id INT,
                order_date DATE,
                FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
            );
        """)

        # Order_Details table
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

        print("All tables created successfully.")
    except Error as e:
        print(f"Error creating tables: {e}")


def main():
    """Main function to create database and tables."""
    conn = create_connection()
    if conn:
        cursor = conn.cursor()
        create_database(cursor)
        use_database(cursor)
        create_tables(cursor)
        cursor.close()
        conn.close()
        print("Database setup completed successfully!")
        print("Connection closed.")


if __name__ == "__main__":
    main()
