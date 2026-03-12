create database project
use project

-- To store categories like (phones, laptop, earphones)
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

-- To store the details of the suppliers.
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255)
);

-- To store the details of the employees.
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(150) NOT NULL,
    role VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100)
);

-- To store the details of the warhouse
CREATE TABLE warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_name VARCHAR(100),
    location VARCHAR(150),
    capacity INT
);

-- To store the deatils of the customers.
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(150) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255)
);

-- To store the details of the products.
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category_id INT,
    supplier_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- To store the deatils about which products were available in wghich warehouse.
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    warehouse_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id)
);

-- To store the orders which are recieved.
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(12,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- To store the order details.
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price_at_purchase DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- To store the details about the shipments.
CREATE TABLE shipments (
    shipment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    employee_id INT,
    shipment_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- To store the details about payments.
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(12,2),
    payment_method VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

select count(*) from products

-- Queries

-- To view all the products
select * from products

-- To view all the suppliers
select * from suppliers

-- To select products which price above then 50k
select * from products where price > 50000

-- To show customer name and email
select customer_name, email from customers

-- To select customers whose from chennai
select * from customers where address like '%chennai%'

-- To get details about order date
select order_id, order_date, total_amount from orders where year(order_date) = 2024;

-- To get most expensive products
select product_name, price from products order by  price desc limit 5;

-- To select product name which has category_id = 1
select product_name from products where category_id = 1

-- To get total number of customers
select COUNT(*) as total_customers from customers; 

-- To get name of employees who are delivery Executives
select employee_name from employees where role = 'Delivery Executive';


-- Show product name with its category name
select p.product_name, c.category_name from products p join categories c on p.category_id = c.category_id;

-- Show product name with supplier name
select p.product_name, s.supplier_name from products p join suppliers s on p.supplier_id = s.supplier_id;

-- Show orders withh customer name
select o.order_id, c.customer_name, o.order_date from orders o join customers c on o.customer_id = c.customer_id;

-- Show order details with product name
select od.order_id, p.product_name, od.quantity from order_details od join products p on od.product_id = p.product_id;

-- Show total number of products per category
select c.category_name, COUNT(p.product_id) AS total_products
from products p join categories c on p.category_id = c.category_id group by c.category_name;

-- Show total revenue per order
select o.order_id, SUM(od.quantity * od.price_at_purchase) as total_revenue
from orders o join order_details od on o.order_id = od.order_id group by o.order_id;

-- Show total order placed by per customer
select c.customer_name, COUNT(o.order_id) as total_orders
from customers c join orders o on c.customer_id = o.customer_id group by c.customer_name;

-- Show warehouse name with total stock quantity
select w.warehouse_name, SUM(i.quantity) as total_stock
from warehouses w join inventory i on w.warehouse_id = i.warehouse_id group by w.warehouse_name;

-- Show supplier with number of product supplied
select s.supplier_name, COUNT(p.product_id) as products_supplied
from suppliers s join products p on s.supplier_id = p.supplier_id group by s.supplier_name;

-- Show shipment status with employee name 
select sh.shipment_id, e.employee_name, sh.status
from shipments sh join employees e on sh.employee_id = e.employee_id;

-- Show payment details with customer name
select p.payment_id, c.customer_name, p.amount, p.status
from payments p join orders o on p.order_id = o.order_id join customers c on o.customer_id = c.customer_id;

-- Show product stored in each warehouse
select w.warehouse_name, p.product_name, i.quantity
from inventory i join products p on i.product_id = p.product_id join warehouses w on i.warehouse_id = w.warehouse_id;

-- Show total revenue generated by per customer
select c.customer_name, SUM(o.total_amount) as total_spent
from customers c join orders o on c.customer_id = o.customer_id group by c.customer_name;

-- Show average product price per category
select c.category_name, avg(p.price) as avg_price
from products p join categories c on p.category_id = c.category_id group by c.category_name;

-- Show total quantity sold per product
select p.product_name, SUM(od.quantity) as total_sold
from order_details od join products p on od.product_id = p.product_id group by p.product_name;


-- Top 5 customer by total spending
select c.customer_name, SUM(o.total_amount) as total_spent from customers c
join orders o on c.customer_id = o.customer_id group by c.customer_name order by total_spent DESC limit 5;

-- Most sold product
select p.product_name, SUM(od.quantity) as total_sold
from order_details od join products p on od.product_id = p.product_id group by p.product_name order by total_sold DESC limit 1;

-- Products never ordered
select p.product_name from products p left join order_details od on p.product_id = od.product_id
where od.product_id is null;

-- Customers who never placed an order
select c.customer_name
from customers c left join orders o on c.customer_id = o.customer_id where o.customer_id is null;

-- Suppliers supplying more than 10 products
select s.supplier_name, COUNT(p.product_id) as product_count
from suppliers s join products p on s.supplier_id = p.supplier_id group by s.supplier_name having product_count > 10;

-- Warehouse with highest stock
select w.warehouse_name, SUM(i.quantity) as total_stock
from warehouses w
join inventory i on w.warehouse_id = i.warehouse_id group by w.warehouse_name order by total_stock DESC limit 1;

-- Orders without shipments
select o.order_id from orders o left join shipments s on o.order_id = s.order_id where s.order_id is null;

-- Employees who handled more than 20 shipments
select e.employee_name, COUNT(sh.shipment_id) as shipments_handled
from employees e join shipments sh on e.employee_id = sh.employee_id group by e.employee_name having shipments_handled > 20;

-- Product priced above average price
select product_name, price from products where price > (select avg(price) from products);

-- Month with highest revenue
select month (order_date) as month,
       SUM(total_amount) as monthly_revenue
from orders group by month (order_date) order by monthly_revenue DESC limit 1;





-- SET FOREIGN_KEY_CHECKS = 1;

-- drop table suppliers

-- show tables from project
