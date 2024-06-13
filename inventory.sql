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
- category_name: a string column that stores the name of the category (e.g., Electronics, Clothing, Home Goods).
- description: a string column that stores the description of the category (optional).


*/
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'categories')
BEGIN
    CREATE TABLE categories (
        category_id INT PRIMARY KEY,
        category_name VARCHAR(50),
        description VARCHAR(255),
        
    );
END;


/*
The following command creates a 'products' table if it does not already exist, with the following columns:
- product_id: an integer column that serves as the primary key.
- product_name: a string column that stores the name of the product.
- category_id: an integer column that serves as a foreign key to the 'categories' table.
- price: a decimal column that stores the price of the product.
- SKU: a string column that stores the stock keeping unit of the product.
- created_at: a datetime column that stores the timestamp of when the product was created.
- updated_at: a datetime column that stores the timestamp of when the product was last updated.
*/
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'products')
BEGIN
    CREATE TABLE products (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(50),
        category_id INT,
        price DECIMAL(10, 2),
        SKU VARCHAR(50),
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
INSERT INTO products (product_id, product_name, category_id, price, SKU) VALUES
(1, 'Laptop', 1, 999.99, 'ABC123'),
(2, 'Smartphone', 1, 599.99, 'DEF456'),
(3, 'T-Shirt', 2, 19.99, 'GHI789'),
(4, 'Jeans', 2, 39.99, 'JKL012'),
(5, 'Coffee Maker', 3, 49.99, 'MNO345'),
(6, 'Throw Pillow', 3, 9.99, 'PQR678');

-- The following command creates a stored procedure to get all categories.
IF OBJECT_ID('dbo.GetCategories') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetCategories;
END;
GO
CREATE PROCEDURE dbo.GetCategories
AS
BEGIN
    SELECT * FROM categories;
END;
GO

-- The following command creates a stored procedure to get all products in a specific category.
IF OBJECT_ID('dbo.GetProductsByCategory') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetProductsByCategory;
END;
GO
CREATE PROCEDURE dbo.GetProductsByCategory
    @category_id INT
AS
BEGIN
    SELECT * FROM products WHERE category_id = @category_id;
END;
GO

-- The following command creates a stored procedure to get all products in a specific price range sorted by price in ascending order.
IF OBJECT_ID('dbo.GetProductsByPriceRange') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.GetProductsByPriceRange;
END;
GO
CREATE PROCEDURE dbo.GetProductsByPriceRange
    @min_price DECIMAL(10, 2),
    @max_price DECIMAL(10, 2)
AS
BEGIN
    SELECT * FROM products WHERE price BETWEEN @min_price AND @max_price ORDER BY price ASC;
END;
GO

-- End of script