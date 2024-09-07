/*
SQL Scrpit to Create TestBank tables for questions and answers
*/

USE nal36

--Create Question Table and insert data
IF OBJECT_ID('dbo.TestBankQuestions',N'U') IS NOT NULL
	BEGIN
		DROP TABLE TestBankAnswers;
		DROP TABLE TestBankQuestions;

		CREATE TABLE TestBankQuestions (
			QuestionID int Primary Key
			,Question varchar(500) NOT NULL
		);
	END
ELSE 
	BEGIN
		CREATE TABLE TestBankQuestions (
			QuestionID int Primary Key
			,Question varchar(500) NOT NULL
		);
	END

INSERT INTO TestBankQuestions (QuestionID, Question) VALUES (1,'What does the SQL SELECT statement do?')
INSERT INTO TestBankQuestions (QuestionID, Question) VALUES (2,'Which SQL keyword is used to sort the result-set?')
INSERT INTO TestBankQuestions (QuestionID, Question) VALUES (3,'What is the purpose of the JOIN clause in SQL?')
;

SELECT * FROM TestBankQuestions;

--Create Answers Table and insert data
IF OBJECT_ID('dbo.TestBankAnswers', N'U') IS NOT NULL
	BEGIN
		DROP TABLE TestBankAnswers;
			
		CREATE TABLE TestBankAnswers (
			AnswerID int Primary Key
			,Answer varchar(100) NOT NULL
			,CorrectAnswer bit NOT NULL
			,QuestionID int NOT NULL
		);
	END
ELSE
	BEGIN
		CREATE TABLE TestBankAnswers (
			AnswerID int Primary Key
			,Answer varchar(100) NOT NULL
			,CorrectAnswer bit NOT NULL
			,QuestionID int NOT NULL
		);
	END

INSERT INTO TestBankAnswers(AnswerID, Answer, CorrectAnswer, QuestionID) VALUES (1,'Deletes data from a table',0,1)
INSERT INTO TestBankAnswers(AnswerID, Answer, CorrectAnswer, QuestionID) VALUES (2,'Inserts data into a table',0,1)
INSERT INTO TestBankAnswers(AnswerID, Answer, CorrectAnswer, QuestionID) VALUES (3,'Retrieves data from a table',1,1)
INSERT INTO TestBankAnswers(AnswerID, Answer, CorrectAnswer, QuestionID) VALUES (4,'Updates data in a table',0,1)
INSERT INTO TestBankAnswers(AnswerID, Answer, CorrectAnswer, QuestionID) VALUES (5,'SORT BY',0,2)
INSERT INTO TestBankAnswers(AnswerID, Answer, CorrectAnswer, QuestionID) VALUES (6,'ORDER BY',1,2)
INSERT INTO TestBankAnswers(AnswerID, Answer, CorrectAnswer, QuestionID) VALUES (7,'GROUP BY',0,2)
INSERT INTO TestBankAnswers(AnswerID, Answer, CorrectAnswer, QuestionID) VALUES (8,'ARRANGE BY',0,2)
INSERT INTO TestBankAnswers(AnswerID, Answer, CorrectAnswer, QuestionID) VALUES (9,'To combine rows from two or more tables based on a related column',1,3)
INSERT INTO TestBankAnswers(AnswerID, Answer, CorrectAnswer, QuestionID) VALUES (10,'To remove duplicate rows from a result set',0,3)
INSERT INTO TestBankAnswers(AnswerID, Answer, CorrectAnswer, QuestionID) VALUES (11,'To create a new table',0,3)
INSERT INTO TestBankAnswers(AnswerID, Answer, CorrectAnswer, QuestionID) VALUES (12,'To delete rows from a table',0,3);

ALTER TABLE TestBankAnswers
ADD CONSTRAINT FK_QuestionID
FOREIGN KEY(QuestionID) REFERENCES TestBankQuestions(QuestionID);

SELECT * FROM TestBankAnswers;

--See TestBank Questions and Answers together
SELECT Question, Answer, CorrectAnswer
FROM TestBankQuestions Q 
Left Join TestBankAnswers A on Q.QuestionID = A.QuestionID;