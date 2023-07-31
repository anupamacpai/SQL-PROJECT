CREATE DATABASE library1;
USE library1;

CREATE TABLE Branch2(branch_no int NOT NULL,manager_id int,branch_address varchar(30),contact_no int);
INSERT INTO Branch2 values(1,101,'Kollam',987656564);
INSERT INTO Branch2 values(2,102,'Aluva',876545453);
INSERT INTO Branch2 values(3,103,'Kannur',879876545);
INSERT INTO Branch2 values(4,104,'Kottayam',909087654);
INSERT INTO Branch2 values(5,105,'Trivandrum',909876767);
INSERT INTO Branch2 values(1,106,'Kollam',987656564);
INSERT INTO Branch2 values(2,107,'Aluva',876545453);
INSERT INTO Branch2 values(3,108,'Kannur',879876545);


CREATE TABLE  Employee1(emp_id int PRIMARY KEY,emp_name varchar(10),Position varchar(15),salary int);
INSERT INTO Employee1 values(101,'Varun','Cashier',50000);
INSERT INTO Employee1 values(102,'Kishore','Clerk',40000);
INSERT INTO Employee1 values(103,'Daya','Manager',80000);
INSERT INTO Employee1 values(104,'Veena','PO',65000);
INSERT INTO Employee1 values(105,'Shari','Clerk',40000);
INSERT INTO Employee1 values(106,'John','PO',65000);
INSERT INTO Employee1 values(107,'Sonu','Manager',80000);
INSERT INTO Employee1 values(108,'Sara','Clerk',40000);

CREATE TABLE  Customer(customer_id int PRIMARY KEY,customer_name varchar(20),customer_address varchar(30),
Reg_date date);
select sysdate();
INSERT INTO Customer values(10,'Raju','Sreenilayam','2022-01-01');
INSERT INTO Customer values(11,'Arun','Arunvilla','2022-07-15');
INSERT INTO Customer values(12,'Manu','Manuvihar','2023-01-08');
INSERT INTO Customer values(13,'Kichu','KichuNivas','2022-10-12');
INSERT INTO Customer values(14,'Achu','Vaishnavam','2023-02-10');
INSERT INTO Customer values(15,'Seetha','Seethalayam','2021-12-09');
INSERT INTO Customer values(16,'Neena','Atharvam','2021-10-19');
INSERT INTO Customer values(17,'Geethu','Geetham','2021-08-10');
select * from Customer;

CREATE TABLE Books1(isbn int PRIMARY KEY,Book_title varchar(20),Category varchar(20),
Rental_price float,Status boolean,Author varchar(20),Publisher varchar(20));
INSERT INTO Books1 values(201,'Othello','Novel',500,True,'Shakespere','DC Books');
INSERT INTO Books1 values(202,'My story','Autobiography',300,False,'Madhavikutti','V Publishers');
INSERT INTO Books1 values(203,'Kayar','Novel',350,True,'Thakazhi','JP Books');
INSERT INTO Books1 values(204,'Randamoozham','Script',400,False,'M T Vasudevan Nair','DC Books');
INSERT INTO Books1 values(205,'Goat Days','Novel',500,True,'Benyamin','JP Books');
INSERT INTO Books1 values(206,'Discovery of India','History',600,True,'Nehru','V Publishers');
INSERT INTO Books1 values(207,'Mathilukal','Novel',400,True,'Basheer','DC Books');
INSERT INTO Books1 values(208,'Kerala History','History',450,False,'Sreedhara Menon','JP Books');
select * from Books1;

CREATE TABLE IssueStatus1(issue_id int NOT NULL,issued_cust int NOT NULL,issued_book_name varchar(20),
issue_date date,isbn_book int,FOREIGN KEY(isbn_book) REFERENCES Books1(isbn), FOREIGN KEY(issue_id) 
REFERENCES Customer(customer_id));
INSERT INTO IssueStatus1 values(10,1,'Othello','2023-06-01',201);
INSERT INTO IssueStatus1 values(11,2,'Goat Days','2023-06-12',205);
INSERT INTO IssueStatus1 values(12,3,'Kayar','2023-03-10',203);
INSERT INTO IssueStatus1 values(13,4,'Kayar','2023-01-07',203);
INSERT INTO IssueStatus1 values(14,2,'Othello','2023-02-08',201);
INSERT INTO IssueStatus1 values(15,2,'Mathilukal','2022-10-20',207);
INSERT INTO IssueStatus1 values(16,1,'Mathilukal','2022-11-10',207);
INSERT INTO IssueStatus1 values(17,3,'Discovery of India','2022-09-09',206);


CREATE TABLE  ReturnStatus(return_id int PRIMARY KEY,return_cust varchar(20),return_book_name varchar(20),
return_date date,isbn_book2 int,FOREIGN KEY(isbn_book2) REFERENCES Books1(isbn));
INSERT INTO ReturnStatus values(40,'Raju','Othello','2023-06-20',201);
INSERT INTO ReturnStatus values(41,'Arun','Goat Days','2023-06-30',205);
INSERT INTO ReturnStatus values(42,'Achu','Kayar','2023-04-20',203);
INSERT INTO ReturnStatus values(43,'Kichu','Kayar','2023-02-18',203);
INSERT INTO ReturnStatus values(44,'Manu','Othello','2023-03-14',201);
INSERT INTO ReturnStatus values(45,'Hari','Mathilukal','2022-11-11',207);
INSERT INTO ReturnStatus values(46,'Giri','Mathilukal','2022-12-10',207);
INSERT INTO ReturnStatus values(47,'Venu','Discovery of India','2022-12-18',206);


-- Retrieve the book title,category,and rental price of all available books
SELECT  Book_title,Category,Rental_price FROM Books1 where status=True;

-- List the employee names and their respective salaries in descending order of salary
SELECT emp_name,salary FROM Employee1 ORDER BY salary DESC;

-- Retrieve the book titles and the corresponding customers who have issued those books
SELECT b.Book_title,c.Customer_name  FROM Books1 b JOIN IssueStatus1 i ON b.isbn=i.isbn_book
JOIN Customer c ON i.issued_cust=c.customer_id;

-- Display the total count of books in each category    
SELECT Books1.Category,count(*) FROM Books1 GROUP BY Books1.Category;

-- Retrieve the employee names and their positions for the employees whose salaries are above Rs.50000
SELECT emp_name,position,salary FROM Employee where salary >50000;

-- List the customer names who registered before 2022-01-01 and have not issued any books yet  
SELECT customer_name FROM Customer where Reg_date<'2022-01-01' and customer_id not in
(SELECT DISTINCT issued_cust FROM IssueStatus1);

-- Display the branch numbers and the total count of employees in each branch   
SELECT  Branch2.branch_no,branch2.branch_address,count(branch_no) from Branch2 
GROUP BY Branch2.branch_address,Branch2.branch_no;

-- Display the names of customers who have issued books in the month of june2023   

SELECT DISTINCT c.customer_name FROM Customer c join issuestatus1 i on c.customer_id=i.issued_cust
 where issue_date between '2023-06-01' and '2023-06-30';


-- Retrieve book title from book table containing history
SELECT book_title FROM Books1 where Category='History';

-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees 
SELECT Branch2.branch_no, count(*) FROM Branch2 JOIN employee1 ON branch2.manager_id=
employee1.emp_id GROUP BY branch2.branch_no HAVING count(*)>5; 