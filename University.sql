DROP VIEW IF EXISTS Q5;
DROP VIEW IF EXISTS Q4;
DROP VIEW IF EXISTS Q3;
DROP TABLE IF EXISTS enrolls;
DROP TABLE IF EXISTS prereqs;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS modules;

CREATE TABLE modules (
  code  VARCHAR(10) PRIMARY KEY
);
CREATE TABLE students (
  matric VARCHAR(9) PRIMARY KEY
);
CREATE TABLE prereqs (
  code  VARCHAR(10) REFERENCES modules(code),
  need  VARCHAR(10) REFERENCES modules(code),
  PRIMARY KEY (code, need)
);
CREATE TABLE enrolls (
  matric VARCHAR(9)  REFERENCES students(matric),
  code   VARCHAR(10) REFERENCES modules (code)
);

INSERT INTO modules VALUES ('CS1010');
INSERT INTO modules VALUES ('CS1020');
INSERT INTO modules VALUES ('CS1231');
INSERT INTO modules VALUES ('CS2010');
INSERT INTO modules VALUES ('CS2030');
INSERT INTO modules VALUES ('CS2040');
INSERT INTO modules VALUES ('CS2100');
INSERT INTO modules VALUES ('CS2102');
INSERT INTO modules VALUES ('CS2103');
INSERT INTO modules VALUES ('CS3201');
INSERT INTO modules VALUES ('CS3223');
INSERT INTO modules VALUES ('CS4221');

INSERT INTO students VALUES ('A0000001A');
INSERT INTO students VALUES ('A0000002B');
INSERT INTO students VALUES ('A0000003C');
INSERT INTO students VALUES ('A0000004D');

INSERT INTO prereqs VALUES ('CS1020', 'CS1010');
INSERT INTO prereqs VALUES ('CS2010', 'CS1020');
INSERT INTO prereqs VALUES ('CS2030', 'CS1010');
INSERT INTO prereqs VALUES ('CS2040', 'CS1010');
INSERT INTO prereqs VALUES ('CS2100', 'CS1010');
INSERT INTO prereqs VALUES ('CS2102', 'CS1020');
INSERT INTO prereqs VALUES ('CS2102', 'CS1231');
INSERT INTO prereqs VALUES ('CS2103', 'CS2030');
INSERT INTO prereqs VALUES ('CS2103', 'CS2040');
INSERT INTO prereqs VALUES ('CS3201', 'CS2103');
INSERT INTO prereqs VALUES ('CS3223', 'CS2102');
INSERT INTO prereqs VALUES ('CS3223', 'CS2040');
INSERT INTO prereqs VALUES ('CS4221', 'CS3223');

INSERT INTO enrolls VALUES ('A0000001A', 'CS1010');
INSERT INTO enrolls VALUES ('A0000001A', 'CS1020');
INSERT INTO enrolls VALUES ('A0000001A', 'CS1231');
INSERT INTO enrolls VALUES ('A0000001A', 'CS2010');
INSERT INTO enrolls VALUES ('A0000001A', 'CS2100');

INSERT INTO enrolls VALUES ('A0000002B', 'CS1010');
INSERT INTO enrolls VALUES ('A0000002B', 'CS1020');
INSERT INTO enrolls VALUES ('A0000002B', 'CS1231');

INSERT INTO enrolls VALUES ('A0000003C', 'CS1010');
INSERT INTO enrolls VALUES ('A0000003C', 'CS1020');
INSERT INTO enrolls VALUES ('A0000003C', 'CS1231');
INSERT INTO enrolls VALUES ('A0000003C', 'CS2010');
INSERT INTO enrolls VALUES ('A0000003C', 'CS2100');
INSERT INTO enrolls VALUES ('A0000003C', 'CS2102');

INSERT INTO enrolls VALUES ('A0000004D', 'CS1010');



/* University 01 */
CREATE VIEW Q3(code) AS (
  WITH fulfils as (
    SELECT matric, code
    FROM students NATURAL JOIN enrolls 
    WHERE matric='A0000001A'
  )
  SELECT code FROM modules
  EXCEPT
  SELECT code 
  FROM
    ( 
      SELECT code FROM fulfils
      UNION
      SELECT code 
      FROM prereqs 
      WHERE 
          need NOT IN (
            SELECT code
            FROM fulfils
          )
    ) as s
);
SELECT * FROM Q3;



/* University 02 */
CREATE VIEW Q4 AS (
  WITH unfulfil AS (
    SELECT matric, need 
    FROM students, (
      SELECT need 
      FROM prereqs 
      WHERE code='CS2102'
    ) AS s
    EXCEPT
    SELECT matric, code FROM enrolls
  )
  SELECT matric 
  FROM students
  EXCEPT
  SELECT matric 
  FROM
  (
    SELECT matric 
    FROM unfulfil
    UNION
    SELECT matric 
    FROM enrolls 
    WHERE 
    	code='CS2102'
  ) AS s
);
SELECT * FROM Q4;



/* University 03 */
CREATE VIEW Q5 AS
  /* Your answer here */

SELECT * FROM Q5;
