# 📦 SQL-Powered Shopping Management System

---

## 📌 **Project Overview**

The **SQL-Powered Shopping Management System** is a database-driven application designed to efficiently handle shopping-related operations such as product storage, customer management, order tracking, shipment handling, payments, feedback, and return/replace processing.

This project demonstrates a complete **DBMS workflow**, including:

✔ Requirement analysis
✔ Entity and attribute design
✔ Conceptual, logical & physical schema
✔ Table creation using MySQL
✔ Insertion of sample customer data
✔ Relationships using Primary & Foreign Keys
✔ Views & Sample Analytical Queries

The system reduces redundancy, improves data integrity, and ensures smooth business operations through structured SQL queries.

---

## 🛠️ **Features Implemented**

### **1. Customer Management**

* Stores customer details (name, phone, email, address, DOB)
* Tracks registrations

### **2. Product Management**

* Saves product information like category, price, size, weight, etc.

### **3. Order & Payment Processing**

* Links orders to payments
* Supports **Online & Offline** payment models
* Tracks number of products & total order amount

### **4. Shopping Cart System**

* Maintains cart ID, total cost & product quantity

### **5. Shipment & Delivery**

* Maps orders to their corresponding shipment

### **6. Return / Replacement Handling**

* Stores return request status, reasons & dates

### **7. Feedback System**

* Records product ratings & user comments

### **8. Platform & Admin Management**

* Tracks platform details (app, website)
* Stores admin info and roles

---

## 🧩 **ER Diagram Overview**

The ER model includes the following relationships:

* One Customer → Many Orders
* One Order → One Payment
* One Order → One Return/Replace
* One Shopping Cart → Many Orders
* One Product → Many Feedback entries
* One Admin → Manages Platform
* One Platform → Accessed by many Customers

ISA Hierarchy:

* **Payment** → Online / Offline
* **Platform** → App / Website

---

## 🗂️ **Database Structure**

The project contains SQL commands for:

* Database creation
* Table creation with Primary & Foreign Keys
* Insert statements
* Views for analytical insight

Full SQL code is included in the file:
📄 **shopping_case_study.sql**

---

## 🧪 **Sample Queries Included**

### ✔ Total Sales for Paid Orders

```sql
SELECT SUM(amount) AS total_sales
FROM payment
WHERE paystatus = 'Paid';
```

### ✔ Customer Information View

```sql
CREATE VIEW customer_info AS
SELECT cname, phno, address
FROM customers;
```

---

## 🚀 How to Run

1. Install **MySQL Server**
2. Create a database:

   ```sql
   CREATE DATABASE shopping_case_study;
   ```
3. Import the SQL file:

   ```sql
   SOURCE shopping_case_study.sql;
   ```
4. Run queries and explore tables:

   ```sql
   SELECT * FROM customers;
   SELECT * FROM orders;
   SELECT * FROM product;
   ```

---

## 📚 **Technologies Used**

* **MySQL**
* **SQL DDL, DML, DQL**
* **ER Modeling**
* **Normalization Concepts**

---

## 🏁 Conclusion

This project demonstrates the complete implementation of a normalized and relational **Shopping Management Database System** using SQL. By managing customers, products, payments, orders, and feedback in structured tables, the system ensures accuracy, integrity, and efficient retrieval of data—making it suitable for academic and real-world scenarios.

---
