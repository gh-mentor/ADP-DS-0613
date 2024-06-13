/*
This file contains a script of Transact SQL (T-SQL) command to interact with a database named 'Inventory'.
Requirements:
- SQL Server 20219 is installed and running
- database 'Inventory' already exists.
Details:
- Sets the default database to 'Inventory'.
- Creates a 'categories' table and related 'products' table if they do not already exist.
- Remove all rows from the 'products' table and then the 'categories'.
- Populates the 'categories' table with sample data.
- Populates the 'products' table with sample data.
- Creates stored procedures to get all categories.
- Creates a stored procedure to get all products in a specific category.
- Creates a stored procudure to get all products in a specific price range sorted by price in ascending order.
Errors:
- if the database 'Inventory' does not exist, the script will print an error message and exit.
*/

-- The following command sets the default database to 'Inventory'.
USE Inventory;

/*
The following command creates a 'categories' table if it does not already exist, with the following columns:
- category_id: an integer column that serves as the primary key.
- category_name: a string column that stores the name of the category.
- description: a string column that stores the description of the category.
*/
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'categories')
BEGIN
    CREATE TABLE categories (
        category_id INT PRIMARY KEY,
        category_name VARCHAR(50),
        description VARCHAR(255)
    );
END;


/*
The following command creates a 'products' table if it does not already exist, with the following columns:
- product_id: an integer column that serves as the primary key.
- product_name: a string column that stores the name of the product.
- category_id: an integer column that serves as a foreign key to the 'categories' table.
- price: a decimal column that stores the price of the product.

*/
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'products')
BEGIN
    CREATE TABLE products (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(50),
        category_id INT,
        price DECIMAL(10, 2),
        FOREIGN KEY (category_id) REFERENCES categories(category_id),
        -- Add a created_at column to store the timestamp of when the product was created.
        created_at DATETIME DEFAULT GETDATE(),
        -- Add an updated_at column to store the timestamp of when the product was last updated.
        updated_at DATETIME DEFAULT GETDATE()
    );
END;

-- The following commands remove all rows from the 'products' table and then the 'categories' table.
TRUNCATE TABLE products;
TRUNCATE TABLE categories;

-- The following commands populate the 'categories' table with sample data.
INSERT INTO categories (category_id, category_name, description) VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Clothing', 'Apparel and accessories'),
(3, 'Home Goods', 'Household items and decor');

-- The following commands populate the 'products' table with sample data.
INSERT INTO products (product_id, product_name, category_id, price) VALUES
(1, 'Laptop', 1, 999.99),
(2, 'Smartphone', 1, 599.99),
(3, 'T-shirt', 2, 19.99),
(4, 'Jeans', 2, 49.99),
(5, 'Sofa', 3, 399.99),
(6, 'Coffee Table', 3, 149.99);

-- The following command creates a stored procedure to get all categories.
IF OBJECT_ID('usp_GetAllCategories') IS NOT NULL
BEGIN
    DROP PROCEDURE usp_GetAllCategories;
END;

CREATE PROCEDURE usp_GetAllCategories
AS
BEGIN
    SELECT * FROM categories;
END;

-- The following command creates a stored procedure to get all products in a specific category.
IF OBJECT_ID('usp_GetProductsByCategory') IS NOT NULL
BEGIN
    DROP PROCEDURE usp_GetProductsByCategory;
END;

CREATE PROCEDURE usp_GetProductsByCategory
    @category_id INT
AS
BEGIN
    SELECT * FROM products WHERE category_id = @category_id;
END;

-- The following command creates a stored procedure to get all products in a specific price range sorted by price in ascending order.
IF OBJECT_ID('usp_GetProductsByPriceRange') IS NOT NULL
BEGIN
    DROP PROCEDURE usp_GetProductsByPriceRange;
END;

CREATE PROCEDURE usp_GetProductsByPriceRange
    @min_price DECIMAL,
    @max_price DECIMAL
AS
BEGIN
    SELECT * FROM products WHERE price BETWEEN @min_price AND @max_price ORDER BY price ASC;
END;

-- End of script








