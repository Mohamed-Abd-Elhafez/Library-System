CREATE TABLE [Book] (
  [Book_ID] INT NOT NULL,
  [Author] VARCHAR(50) NOT NULL,
  [Title] VARCHAR(50) NOT NULL,
  [Price] DECIMAL NOT NULL,
  [Available] BIT,
  PRIMARY KEY ([Book_ID])
);

CREATE TABLE [Publisher] (
  [Publisher_ID] INT NOT NULL,
  [Address] VARCHAR(100),
  [Name] VARCHAR(50) NOT NULL,
  PRIMARY KEY ([Publisher_ID])
);

CREATE TABLE [Member] (
  [Member_ID] INT NOT NULL,
  [Name] VARCHAR(50) NOT NULL,
  [Address] VARCHAR(100) NOT NULL,
  [MemberShip_type] VARCHAR(50) NOT NULL,
  [MemberShip_date] DATE NOT NULL,
  [Expire_date] DATE NOT NULL,
  PRIMARY KEY ([Member_ID])
);

CREATE TABLE [Borrowed_by] (
  [Member_ID] INT NOT NULL,
  [Book_ID] INT NOT NULL,
  [Issue] DATETIME NOT NULL,
  [Return_date] DATETIME NOT NULL,
  [Due_date] DATETIME NOT NULL
);

CREATE INDEX [FK] ON  [Borrowed_by] ([Member_ID], [Book_ID]);

CREATE TABLE [Published_by] (
  [Book_ID] INT NOT NULL,
  [Publisher_ID] INT NOT NULL
);
CREATE INDEX [FK] ON  [Published_by] ([Book_ID], [Publisher_ID]);


-- 13 insert statment 

INSERT INTO Book VALUES (1,'Dr/reda','Database',50.00,1);
INSERT INTO Book VALUES (2,'Dr/ossama','probability',40.50,1);
INSERT INTO Book VALUES (3,'Dr/mai','web programming',35.99,1);
INSERT INTO Book VALUES (4,' Dr/diana','system analysis',20.70,1);
INSERT INTO Book VALUES (5,'Dr/osama','data structure',100.50,1);
INSERT INTO Member VALUES(1,'barakat','kafr,egypt','normal','2019-9-10','2020-9-10');
INSERT INTO Member VALUES(2,'ahmed hossam','alex,egypt','premium','2019-8-6','2020-8-6');
INSERT INTO Member VALUES(3,'mostafa mohamed','cairo,egypt','normal','2019-9-10','2020-9-10');
INSERT INTO Member VALUES(4,'ahmed mohamed','alex,egypt','premium','2019-9-6','2020-9-6');
INSERT INTO Borrowed_by VALUES(1,2,'2020-12-12','2020-12-20','2020-12-25');
INSERT INTO Publisher VAlUES(1,'amirica','maxuil');
INSERT INTO Publisher VAlUES(2,'england','emillia');
INSERT INTO Published_by VALUES(1,1);


-- 3 select using subquery

SELECT * 
   FROM Publisher 
   WHERE Publisher_ID IN (SELECT Publisher_ID 
         FROM Publisher 
         WHERE Name = 'maxuil') ;
SELECT * 
   FROM Member 
   WHERE Member_ID IN (SELECT Member_ID
         FROM Member 
         WHERE Member_ID = 1) ;
SELECT * 
   FROM Member 
   WHERE Address IN (SELECT Address 
         FROM Member 
         WHERE Address = 'alex,egypt') ;


-- 2 select statments using count and group functions

SELECT MemberShip_type, COUNT(*)  'count'
FROM Member 
GROUP BY MemberShip_type;
SELECT Title, COUNT(*) 'count'
FROM Book 
GROUP BY Title;


-- 5 update statments

UPDATE Book
SET Price = 140.99
WHERE Book_ID = 1;
UPDATE Book
SET Price = 90.99
WHERE Book_ID = 4;
UPDATE Book
SET Price = 100.99
WHERE Book_ID = 2;
UPDATE Member
SET Name = 'barakat',MemberShip_type='premium'
WHERE Member_ID = 1;
UPDATE Member
SET Expire_date= '2021-10-8'
WHERE Member_ID = 2;


-- 5 delete statments

DELETE FROM Book WHERE Book_ID= 1;
DELETE FROM Book WHERE Book_ID= 2;
DELETE FROM Book WHERE Book_ID= 4;
DELETE FROM Member WHERE Member_ID= 2;
DELETE FROM Member WHERE Member_ID= 3;

-- 5 select statements using different joins

SELECT Member.Member_ID, Member.Name
FROM Member
INNER JOIN Borrowed_by ON Member.Member_ID=Member.Member_ID;
SELECT Member.Member_ID, Member.Name
FROM Member
LEFT JOIN Borrowed_by ON Member.Member_ID=Member.Member_ID;
SELECT Member.Member_ID, Member.Name
FROM Member
RIGHT JOIN Borrowed_by ON Member.Member_ID=Member.Member_ID;
SELECT Member.Member_ID, Member.Name
FROM Member
FULL JOIN Borrowed_by ON Member.Member_ID=Member.Member_ID;
SELECT Publisher.Publisher_ID, Publisher.Name
FROM Publisher
INNER JOIN Book ON Publisher.Publisher_ID=Publisher.Publisher_ID;

-- Questions answers 

SELECT FIRST_VALUE(Name) over(ORDER BY name) from member;
SELECT FIRST_VALUE(Name) over(ORDER BY name) from Publisher;
SELECT First_VALUE(Book_ID) over(ORDER BY Due_date) from Borrowed_by;
SELECT LAST_VALUE(Name) over(ORDER BY name) from member;
SELECT LAST_VALUE(Name) over(ORDER BY name) from Publisher;
SELECT Last_VALUE(Book_ID) over(ORDER BY Due_date) from Borrowed_by;
SELECT COUNT(Publisher_ID) AS NumberOfMembers FROM Publisher;
SELECT COUNT(Book_ID) AS NumberOfMembers FROM Borrowed_by;
SELECT COUNT(Member_ID) AS NumberOfMembers FROM Borrowed_by;
SELECT COUNT(Member_ID) AS NumberOfMembers FROM member;
SELECT COUNT(Book_ID) AS NumberOfBooks FROM Book;
SELECT SUM(Price) AS TotalPrices FROM Book;
SELECT MAX(Price) AS MaxPrices FROM Book;
SELECT MIN(Price) AS MaxPrices FROM Book;
SELECT AVG(Price) AS AvgPrices FROM Book;
SELECT LOWER(Title) from Book;
SELECT upper(Title) from Book;
SELECT LOWER(Name) from Publisher;
SELECT upper(Name) from Publisher;
SELECT GETDATE();