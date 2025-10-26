create database Apple_project;
use apple_project;
CREATE TABLE apple_products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_url TEXT,
    brand VARCHAR(50),
    sale_price INT,
    mrp INT,
    discount_percentage INT,
    number_of_ratings INT,
    number_of_reviews INT,
    upc VARCHAR(50) UNIQUE,
    star_rating DECIMAL(3,2),
    ram VARCHAR(20)
);
SET GLOBAL local_infile = 1;
select * from apple_products;

-- removing null values 

delete from apple_products 
where product_id is null
or product_name is null
or product_url is null
or brand is null
or sale_price is null
or mrp is null
or discount_percentage is null
or number_of_ratings is null 
or number_of_reviews is null
or upc is null 
or star_rating is null
or ram is null;

select * from apple_products;


-- Data Analysis & Business Key Problems & Answers

-- Q1. Find the product with the highest number of ratings
SELECT product_name, number_of_ratings
FROM apple_products
ORDER BY number_of_ratings DESC;

-- Q2. Find all products priced above the average sale price
SELECT product_name, sale_price
FROM apple_products
WHERE sale_price > (SELECT AVG(sale_price) FROM apple_products);

-- Q3. Get top 5 best-selling products based on number of reviews
SELECT product_name, number_of_reviews
FROM apple_products
ORDER BY number_of_reviews DESC
LIMIT 5;

-- Q4. Find the best and worst-rated product for each RAM type
SELECT ram, 
       MAX(star_rating) AS best_rating,
       MIN(star_rating) AS worst_rating
FROM apple_products
GROUP BY ram;

-- Q5. Top 3 most expensive products in each RAM category
SELECT product_name, ram, sale_price
FROM (
    SELECT product_name, ram, sale_price,
           RANK() OVER (PARTITION BY ram ORDER BY sale_price DESC) AS rnk
    FROM apple_products
) t
WHERE rnk <= 3;

