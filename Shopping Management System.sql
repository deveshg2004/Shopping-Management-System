-- SQL-Powered Shopping Management System

CREATE DATABASE IF NOT EXISTS shopping_case_study;
USE shopping_case_study;

-- 1. Product table
CREATE TABLE product (
    pid INT PRIMARY KEY,
    pname VARCHAR(100),
    description VARCHAR(255),
    price REAL NOT NULL,
    weight REAL,
    size VARCHAR(10),
    category VARCHAR(100)
) ENGINE=InnoDB;

-- 2. Customers table
CREATE TABLE customers (
    cid INT PRIMARY KEY,
    cname VARCHAR(100),
    phno VARCHAR(15),
    address VARCHAR(255),
    email VARCHAR(100),
    dob DATE,
    registration DATE
) ENGINE=InnoDB;

-- 3. Shopping Cart table
CREATE TABLE shoppingcart (
    cartid INT PRIMARY KEY,
    totalcost REAL,
    quantity INT
) ENGINE=InnoDB;

-- 4. Orders table
CREATE TABLE orders (
    oid INT PRIMARY KEY,
    sid INT NULL,             -- shipment / cart reference (nullable until assigned)
    num_products INT,
    amount REAL,
    odate DATE,
    paymentmethod VARCHAR(50),
    CONSTRAINT fk_orders_cart FOREIGN KEY (sid) REFERENCES shoppingcart(cartid)
) ENGINE=InnoDB;

-- 5. Payment table (uses orderid as PK per provided schema)
CREATE TABLE payment (
    orderid INT PRIMARY KEY,
    pid INT,                  -- product id (optional reference)
    amount REAL,
    paystatus VARCHAR(20),
    phno VARCHAR(15),
    CONSTRAINT fk_payment_product FOREIGN KEY (pid) REFERENCES product(pid)
) ENGINE=InnoDB;

-- 6. OnlinePayment table
CREATE TABLE onlinepayment (
    paymentid INT PRIMARY KEY,
    orderid INT,
    upi VARCHAR(50),
    cash REAL,
    credit REAL,
    debit REAL,
    netbanking VARCHAR(50),
    CONSTRAINT fk_onlinepay_order FOREIGN KEY (orderid) REFERENCES payment(orderid)
) ENGINE=InnoDB;

-- 7. OfflinePayment table
CREATE TABLE offlinepayment (
    paymentid INT PRIMARY KEY,
    orderid INT,
    cash REAL,
    credit REAL,
    debit REAL,
    CONSTRAINT fk_offlinepay_order FOREIGN KEY (orderid) REFERENCES payment(orderid)
) ENGINE=InnoDB;

-- 8. Shipment table
CREATE TABLE shipment (
    shipmentid INT PRIMARY KEY,
    oid INT,
    CONSTRAINT fk_shipment_order FOREIGN KEY (oid) REFERENCES orders(oid)
) ENGINE=InnoDB;

-- 9. Return/Replace table
CREATE TABLE returnreplace (
    returnid INT PRIMARY KEY,
    oid INT,
    returndate DATE,
    reason VARCHAR(255),
    status VARCHAR(20),
    CONSTRAINT fk_return_order FOREIGN KEY (oid) REFERENCES orders(oid)
) ENGINE=InnoDB;

-- 10. Platform table
CREATE TABLE platform (
    pname VARCHAR(50) PRIMARY KEY,
    app VARCHAR(100),
    website VARCHAR(255)
) ENGINE=InnoDB;

-- 11. Feedback table
CREATE TABLE feedback (
    fid INT PRIMARY KEY,
    pid INT,
    reviewdate DATE,
    comments VARCHAR(255),
    rating INT,
    CONSTRAINT fk_feedback_product FOREIGN KEY (pid) REFERENCES product(pid)
) ENGINE=InnoDB;

-- 12. Admin table
CREATE TABLE admin (
    aid INT PRIMARY KEY,
    aname VARCHAR(50),
    arole VARCHAR(20),
    aemail VARCHAR(100),
    phno VARCHAR(15)
) ENGINE=InnoDB;



-- Products
INSERT INTO product (pid, pname, description, price, weight, size, category) VALUES
(202, 'REALME 10 PRO', 'Mobile (2024)', 15000, 0.2, '6', 'Smartphone'),
(203, 'OPPO T1', 'Mobile (2024)', 20000, 0.2, '6\"1', 'Smartphone'),
(204, 'ASUS TUF 15', 'Laptop', 45000, 2.1, '15\"', 'Electronics'),
(205, 'HP PAVILION 14', 'Laptop', 75000, 1.7, '14\"', 'Electronics'),
(206, 'DELL INSPIRON', 'Laptop', 65000, 1.8, '15\"', 'Electronics'),
(207, 'ROCKERZ 550', 'Digital Watch', 2000, 0.2, 'DEFAULT', 'Accessories'),
(208, 'SONY XM5', 'Headphones', 30000, 0.3, 'DEFAULT', 'Accessories'),
(209, 'AVENGER BLACK HOODIE', 'Clothing', 4000, 0.2, 'Medium', 'Clothing'),
(210, 'NIKE AIR 3', 'Running Shoes', 15000, 0.8, 'DEFAULT', 'Footwear');

-- Customers 
INSERT INTO customers (cid, cname, phno, address, email, dob, registration) VALUES
(32111, 'John Smith',     '+1-202-555-0143', '123 Elm Street, New York, USA',        'john.smith@example.com',     '1988-05-20', '2023-01-01'),
(2541,  'Emily Johnson',  '+1-303-555-0198', '45 Oak Avenue, Denver, USA',            'emily.johnson@example.com',  '1995-11-11', '2023-03-15'),
(3632,  'Michael Brown',  '+44-20-7946-0958','10 Windsor Rd, London, UK',            'michael.brown@example.co.uk', '1990-07-07', '2022-12-10'),
(4342,  'Sophie Martin',  '+33-1-23-45-67-89','22 Rue de Paris, Lyon, France',      'sophie.martin@example.fr',   '2000-02-25', '2023-04-10'),
(5542,  'Lukas Müller',   '+49-30-1234567',   '5 Bahnhofstrasse, Berlin, Germany',    'lukas.mueller@example.de',   '1998-02-25', '2023-04-10'),
(3543,  'Anna Nowak',     '+48-22-7654321',   '12 Krakowskie Przedmiescie, Warsaw, PL','anna.nowak@example.pl',      '1997-08-15', '2023-04-10');

-- Payment (orderid is PK here)
-- Note: some pid values reference products not in this small sample (kept as-is from source)
INSERT INTO payment (orderid, pid, amount, paystatus, phno) VALUES
(1001, 203, 15000, 'Paid',    '+1-202-555-0143'),
(1002, 201, 75000, 'Pending', '+1-303-555-0198'), -- pid=201 not in product list; inserted as-is
(1003, 206, 3000,  'Paid',    '+44-20-7946-0958'),
(1004, 209, 4000,  'Failed',  '+33-1-23-45-67-89'),
(1005, 219, 3000,  'Paid',    '+49-30-1234567'),   -- pid=219 not in product sample; inserted as-is
(1006, 203, 4000,  'Failed',  '+48-22-7654321');

-- Shopping Cart
INSERT INTO shoppingcart (cartid, totalcost, quantity) VALUES
(32111, 15000, 1),
(32142, 75000, 1),
(14323, 3000, 3),
(53124, 4000, 2),
(43215, 20000,4),
(65432, 10000,2);

-- Orders
INSERT INTO orders (oid, sid, num_products, amount, odate, paymentmethod) VALUES
(1001, 32142, 1, 15000, '2023-01-10', 'Online'),
(1002, 53124, 2, 75000, '2023-02-20', 'Online'),
(1003, 32111, 3, 3000,  '2023-03-15', 'Offline'),
(1004, 143123,4, 5000,  '2023-04-10', 'Online'),
(1005, 43215, 5, 12000, '2023-05-05', 'Offline'),
(1006, 10000, 5, 15000, '2023-07-05', 'Offline');

-- Shipment
INSERT INTO shipment (shipmentid, oid) VALUES
(5001, 1001),
(5002, 1002),
(5003, 1003),
(5004, 1004),
(5006, 1005),
(5007, 1006);

-- Return / Replace
INSERT INTO returnreplace (returnid, oid, returndate, reason, status) VALUES
(101, 1003, '2023-10-22', 'Defective product', 'Pending'),
(102, 1002, '2023-10-20', 'Size issue', 'Completed'),
(103, 1005, '2023-10-22', 'Wrong item delivered', 'Pending');

-- Platform
INSERT INTO platform (pname, app, website) VALUES
('FirstClick', 'First Click App', 'www.firstclick.com');

-- Feedback (comments in English/international context)
INSERT INTO feedback (fid, pid, reviewdate, comments, rating) VALUES
(111, 204, '2023-01-11', 'Excellent product, great value', 5),
(112, 203, '2023-02-22', 'Delivery took longer than expected', 4),
(113, 201, '2023-03-15', 'Packaging was secure and product works fine', 4);

-- Admin (foreign/ international names)
INSERT INTO admin (aid, aname, arole, aemail, phno) VALUES
(1, 'John Doe',        'Manager',      'john.doe@admin.com',       '+1-202-555-0110'),
(2, 'Maria García',    'Supervisor',   'maria.garcia@admin.com',   '+34-91-1234567'),
(3, 'Ahmed Hassan',    'Administrator','ahmed.hassan@admin.com',   '+20-2-2791-1234');

-- =========================
-- Sample Queries / Views
-- 1. Total sales amount from payment table where status = 'Paid'
CREATE OR REPLACE VIEW total_paid_sales AS
SELECT SUM(amount) AS total_sales_paid
FROM payment
WHERE paystatus = 'Paid';

-- 2. Customer info view
CREATE OR REPLACE VIEW customer_info AS
SELECT cname, phno, address
FROM customers;

-- Example selects (uncomment to run)
-- SELECT * FROM product;
-- SELECT * FROM customers;
-- SELECT * FROM payment;
-- SELECT * FROM shoppingcart;
-- SELECT * FROM orders;
-- SELECT * FROM shipment;
-- SELECT * FROM returnreplace;
-- SELECT * FROM feedback;
-- SELECT * FROM admin;
-- SELECT * FROM total_paid_sales;
-- SELECT * FROM customer_info;
