/*
This script generates a Test and randomizes the question order
*/

USE nal36;

--Create temp table to prep the data prior to final output
IF OBJECT_ID('#TestPrep') IS NULL
	BEGIN
	CREATE TABLE #TestPrep (
		QuestionID int
		,Questions varchar(500)
		,AnswerID int
	)
	END;
ELSE
	BEGIN
	TRUNCATE TABLE #TestPrep
	END;

--Get Quesions and Answers and intset to test prep
INSERT INTO #TestPrep

SELECT
	QuestionID
	,Question
	,0 as AnswerID
FROM TestBankQuestions
UNION ALL
SELECT
	QuestionID
	,Answer
	,AnswerID
FROM TestBankAnswers 
ORDER BY 1,3;

--SELECT * FROM #TestPrep;

--Create random order for test output
IF OBJECT_ID('#OutputOrder') IS NULL
	BEGIN
	CREATE TABLE #OutputOrder (
		QuestionID int
	)
	END;
ELSE
	BEGIN
	TRUNCATE TABLE #OutputOrder
	END;

INSERT INTO #OutputOrder

SELECT DISTINCT	QuestionID FROM #TestPrep;

ALTER TABLE #OutputOrder
ADD RandNum int;

UPDATE #OutputOrder
SET RandNum = ABS(CHECKSUM(NEWID())) % 100 + 1; --Create random number between 1-100

--SELECT * FROM #OutputOrder;

--Create final temp table for test output
IF OBJECT_ID('#Test') IS NULL
	BEGIN
	CREATE TABLE #Test (
		QuestionID int
		,RankID int
		,MultipleChoiceQuestions varchar(500)
		,OutputOrder int
	)
	END;
ELSE
	BEGIN
	TRUNCATE TABLE #Test
	END;

INSERT INTO #Test

SELECT
	p.QuestionID
	,DENSE_RANK() OVER (PARTITION BY p.QuestionID ORDER BY p.QuestionID, p.AnswerID)
	,p.Questions
	,o.RandNum
FROM #TestPrep p
LEFT JOIN #OutputOrder o on p.QuestionID = o.QuestionID;

UPDATE #Test
SET MultipleChoiceQuestions = CASE
	WHEN RankID = 1 THEN MultipleChoiceQuestions
	ELSE
		CASE
			WHEN RankID = 2 THEN 'A. ' + MultipleChoiceQuestions
			WHEN RankID = 3 THEN 'B. ' + MultipleChoiceQuestions
			WHEN RankID = 4 THEN 'C. ' + MultipleChoiceQuestions
			WHEN RankID = 5 THEN 'D. ' + MultipleChoiceQuestions
		END
	END;


SELECT MultipleChoiceQuestions FROM #Test ORDER BY OutputOrder, RankID;

--Clean up Temp Tables
DROP TABLE #TestPrep;
DROP TABLE #OutputOrder;
DROP TABLE #Test;