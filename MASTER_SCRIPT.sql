CREATE SCHEMA BPUB;
USE BPUB;

CREATE TABLE Course(
	CourseNum VARCHAR(50),
	CourseTitle VARCHAR(50),
	Instructor_FName VARCHAR(50),
	Instructor_LName VARCHAR(50),
	CONSTRAINT Course_PK PRIMARY KEY (CourseNum)
);
CREATE TABLE Distributor (
	DID VARCHAR(50),
	Dname VARCHAR(50),
	Dstreet VARCHAR(50),
	Dcity VARCHAR(50),
	Dstate VARCHAR(50),
	Dzip VARCHAR(50),
	CONSTRAINT Distributor_PK PRIMARY KEY (DID)
);
CREATE TABLE Student (
	SID VARCHAR(50),
	Fname VARCHAR(50),
	Lname VARCHAR(50),
	Suffix VARCHAR(50),
	Street VARCHAR(50),
	City VARCHAR(50),
	State VARCHAR(50),
	Zip VARCHAR(50),
	`seller?` BOOL,
	`buyer?` BOOL,
	CONSTRAINT Student_PK PRIMARY KEY (SID)
);
CREATE TABLE Book(
	ISBN VARCHAR(50),
	Title VARCHAR(50),
	Edition VARCHAR(50),
	AuthorFname VARCHAR(50),
	AuthorLname VARCHAR(50),
	AuthorSuffix VARCHAR(50),
	CourseNum VARCHAR(50),
	CONSTRAINT Book_PK PRIMARY KEY (ISBN),
	CONSTRAINT Book_FK FOREIGN KEY (CourseNum) REFERENCES Course (CourseNum)
);
CREATE TABLE Seller (
	SSID VARCHAR(50),
	CONSTRAINT Seller_PK PRIMARY KEY (SSID),
	CONSTRAINT Seller_FK FOREIGN KEY (SSID) REFERENCES Student (SID)
);
CREATE TABLE Buyer(
	BSID VARCHAR(50),
	CONSTRAINT Buyer_PK PRIMARY KEY (BSID),
	CONSTRAINT Buyer_FK FOREIGN KEY (BSID) REFERENCES Student (SID)
);
CREATE TABLE Payment (
	CheckNum VARCHAR(50),
	Date DATETIME,
	SSID VARCHAR(50),
	CONSTRAINT Payment_PK PRIMARY KEY (CheckNum),
	CONSTRAINT Payment_FK FOREIGN KEY (SSID) REFERENCES Seller (SSID)
);
CREATE TABLE Sale (
	SaleNum VARCHAR(50),
	SaleDate DATETIME,
	BSID VARCHAR(50),
	CONSTRAINT Sale_PK PRIMARY KEY (SaleNum),
	CONSTRAINT Sale_FK FOREIGN KEY (BSID) REFERENCES Buyer (BSID)
);
CREATE TABLE Book_Copy(
	SSID VARCHAR(50),
	ISBN VARCHAR(50),
	AskingPrice FLOAT,
	DateContracted DATETIME,
	BookType VARCHAR(50),
	CONSTRAINT Book_Copy_PK PRIMARY KEY (SSID,ISBN),
	CONSTRAINT Book_Copy_FK1 FOREIGN KEY (ISBN) REFERENCES Book (ISBN),
	CONSTRAINT Book_Copy_FK2 FOREIGN KEY (SSID) REFERENCES Seller (SSID)
);
CREATE TABLE Unretrieved_Book (
	SUID VARCHAR(50),
	ISBN VARCHAR(50),
	SellingPrice FLOAT,
	DID VARCHAR(50),
	CONSTRAINT Unretrieved_Book_PK PRIMARY KEY (SUID, ISBN),
	CONSTRAINT Unretrieved_Book_FK1 FOREIGN KEY (DID) REFERENCES Distributor (DID),
	CONSTRAINT Unretrieved_Book_FK2 FOREIGN KEY (SUID) REFERENCES Book_Copy (SSID),
	CONSTRAINT Unretrieved_Book_FK3 FOREIGN KEY (ISBN) REFERENCES Book_Copy (ISBN)
);
CREATE TABLE Retrieved_Book (
	SRBID VARCHAR(50),
	ISBN VARCHAR(50),
	DateRetrieved DATETIME,
	CONSTRAINT Retrieved_Book_PK PRIMARY KEY (SRBID, ISBN),
	CONSTRAINT Retrieved_Book_FK1 FOREIGN KEY (SRBID) REFERENCES Book_Copy (SSID),
	CONSTRAINT Retrieved_Book_FK2 FOREIGN KEY (ISBN) REFERENCES Book_Copy (ISBN)
);
CREATE TABLE Sold_Book (
	SSBID VARCHAR(50),
	ISBN VARCHAR(50),
	CheckNum VARCHAR(50),
	SaleNum VARCHAR(50),
	CONSTRAINT Sold_Book_PK PRIMARY KEY (SSBID, ISBN),
	CONSTRAINT Sold_Book_FK1 FOREIGN KEY (CheckNum) REFERENCES Payment (CheckNum),
	CONSTRAINT Sold_Book_FK2 FOREIGN KEY (SaleNum) REFERENCES Sale (SaleNum),
	CONSTRAINT Sold_Book_FK3 FOREIGN KEY (ISBN) REFERENCES Book_Copy (ISBN)
);

/* CHANGE BELOW PATH OF ALL .CSV FILES TO THEIR PHYSICAL LOCATION ON THE SYSTEM BEFORE RUNNING MASTER_SCRIPT.SQL*/

load data local infile 'C:/Academy/Tamu/Info_628_Business_Database_Systems/BPUB_Project_Details/Phase_II/Phase_II_Materials/course.csv' into table course fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
load data local infile 'C:/Academy/Tamu/Info_628_Business_Database_Systems/BPUB_Project_Details/Phase_II/Phase_II_Materials/distributor.csv' into table distributor fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
load data local infile 'C:/Academy/Tamu/Info_628_Business_Database_Systems/BPUB_Project_Details/Phase_II/Phase_II_Materials/student.csv' into table student fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
load data local infile 'C:/Academy/Tamu/Info_628_Business_Database_Systems/BPUB_Project_Details/Phase_II/Phase_II_Materials/book.csv' into table book fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
load data local infile 'C:/Academy/Tamu/Info_628_Business_Database_Systems/BPUB_Project_Details/Phase_II/Phase_II_Materials/seller.csv' into table seller fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
load data local infile 'C:/Academy/Tamu/Info_628_Business_Database_Systems/BPUB_Project_Details/Phase_II/Phase_II_Materials/buyer.csv' into table buyer fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
load data local infile 'C:/Academy/Tamu/Info_628_Business_Database_Systems/BPUB_Project_Details/Phase_II/Phase_II_Materials/payment.csv' into table payment fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
load data local infile 'C:/Academy/Tamu/Info_628_Business_Database_Systems/BPUB_Project_Details/Phase_II/Phase_II_Materials/sale.csv' into table sale fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
load data local infile 'C:/Academy/Tamu/Info_628_Business_Database_Systems/BPUB_Project_Details/Phase_II/Phase_II_Materials/book_copy.csv' into table book_copy fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
load data local infile 'C:/Academy/Tamu/Info_628_Business_Database_Systems/BPUB_Project_Details/Phase_II/Phase_II_Materials/unretrieved_book.csv' into table unretrieved_book fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
load data local infile 'C:/Academy/Tamu/Info_628_Business_Database_Systems/BPUB_Project_Details/Phase_II/Phase_II_Materials/retrieved_book.csv' into table retrieved_book fields terminated by ',' enclosed by '"' lines terminated by '\r\n';
load data local infile 'C:/Academy/Tamu/Info_628_Business_Database_Systems/BPUB_Project_Details/Phase_II/Phase_II_Materials/sold_book.csv' into table sold_book fields terminated by ',' enclosed by '"' lines terminated by '\r\n';