DROP VIEW IF EXISTS Q2;
DROP VIEW IF EXISTS Q1;
DROP TABLE IF EXISTS scheds;
DROP TABLE IF EXISTS flights;

CREATE TABLE flights (
  num   VARCHAR(10) PRIMARY KEY,
  src   VARCHAR(5) NOT NULL,
  dst   VARCHAR(5) NOT NULL
);
CREATE TABLE scheds (
  num     VARCHAR(10) REFERENCES flights(num),
  depart  DATE NOT NULL,
  cost    NUMERIC NOT NULL CHECK (cost > 0),
  PRIMARY KEY (num, depart)
);

INSERT INTO flights VALUES ('SQ609'  , 'ICN', 'SIN');
INSERT INTO flights VALUES ('GIA837' , 'SIN', 'CGK');
INSERT INTO flights VALUES ('SQ964'  , 'SIN', 'CGK');
INSERT INTO flights VALUES ('SQ600'  , 'SIN', 'ICN');
INSERT INTO flights VALUES ('KAL646' , 'SIN', 'ICN');
INSERT INTO flights VALUES ('CAL2761', 'TPE', 'CGK');
INSERT INTO flights VALUES ('CAL762' , 'CGK', 'TPE');
INSERT INTO flights VALUES ('CAL2762', 'CGK', 'TPE');
INSERT INTO flights VALUES ('EVA238' , 'CGK', 'TPE');
INSERT INTO flights VALUES ('KAL627' , 'ICN', 'CGK');
INSERT INTO flights VALUES ('GIA879' , 'ICN', 'CGK');

INSERT INTO scheds VALUES ('SQ609'  , '2020-10-02', 250);
INSERT INTO scheds VALUES ('GIA837' , '2020-10-02', 210);
INSERT INTO scheds VALUES ('SQ964'  , '2020-10-02', 235);
INSERT INTO scheds VALUES ('SQ600'  , '2020-10-02', 275);
INSERT INTO scheds VALUES ('KAL646' , '2020-10-02', 220);
INSERT INTO scheds VALUES ('CAL2761', '2020-10-02', 350);
INSERT INTO scheds VALUES ('CAL762' , '2020-10-02', 335);
INSERT INTO scheds VALUES ('CAL2762', '2020-10-02', 335);
INSERT INTO scheds VALUES ('EVA238' , '2020-10-02', 300);
INSERT INTO scheds VALUES ('KAL627' , '2020-10-02', 400);
INSERT INTO scheds VALUES ('GIA879' , '2020-10-02', 600);

INSERT INTO scheds VALUES ('SQ609'  , '2020-10-04', 261);
INSERT INTO scheds VALUES ('GIA837' , '2020-10-04', 221);
INSERT INTO scheds VALUES ('SQ964'  , '2020-10-04', 246);
INSERT INTO scheds VALUES ('SQ600'  , '2020-10-04', 286);
INSERT INTO scheds VALUES ('KAL646' , '2020-10-04', 231);
INSERT INTO scheds VALUES ('CAL2761', '2020-10-04', 361);
INSERT INTO scheds VALUES ('CAL762' , '2020-10-04', 346);
INSERT INTO scheds VALUES ('CAL2762', '2020-10-04', 346);
INSERT INTO scheds VALUES ('EVA238' , '2020-10-04', 311);
INSERT INTO scheds VALUES ('KAL627' , '2020-10-04', 411);
INSERT INTO scheds VALUES ('GIA879' , '2020-10-04', 611);

INSERT INTO scheds VALUES ('SQ609'  , '2020-10-06', 251);
INSERT INTO scheds VALUES ('GIA837' , '2020-10-06', 211);
INSERT INTO scheds VALUES ('SQ964'  , '2020-10-06', 236);
INSERT INTO scheds VALUES ('SQ600'  , '2020-10-06', 276);
INSERT INTO scheds VALUES ('KAL646' , '2020-10-06', 221);
INSERT INTO scheds VALUES ('CAL2761', '2020-10-06', 351);
INSERT INTO scheds VALUES ('CAL762' , '2020-10-06', 336);
INSERT INTO scheds VALUES ('CAL2762', '2020-10-06', 336);
INSERT INTO scheds VALUES ('EVA238' , '2020-10-06', 301);
INSERT INTO scheds VALUES ('KAL627' , '2020-10-06', 401);
INSERT INTO scheds VALUES ('GIA879' , '2020-10-06', 601);



/* Airline 01 */
CREATE VIEW Q1(flight, connecting) AS (
  SELECT F1.num AS flight, F2.num AS connecting 
  FROM flights F1, flights F2
  WHERE 
  	F1.src='ICN' AND
  	F2.dst='CGK' AND
  	F1.dst=F2.src 
);
SELECT * FROM Q1;



/* Airline 02 */
CREATE VIEW Q2 AS (
  WITH flight_info AS (
    SELECT num, src, dst, depart, cost
    FROM flights NATURAL JOIN scheds
  )
  SELECT 
    num AS flight, 
    depart AS flight_date, 
    NULL AS connecting, 
    NULL AS connecting_date,
    cost AS cost 
  FROM flight_info
  WHERE 
    src='ICN' AND
    dst='CGK'
  UNION
  SELECT 
    F1.num AS flight, 
    F1.depart AS flight_date, 
    F2.num AS connecting, 
    F2.depart AS connecting_date,
    F1.cost + F2.cost AS cost 
  FROM flight_info F1, flight_info F2
  WHERE 
    F1.src='ICN' AND
    F2.dst='CGK' AND
    date(F2.depart) - date(F1.depart) <= 2 AND
    date(F2.depart) >= date(F1.depart) AND
    F1.dst=F2.src
  ORDER BY cost
);
SELECT * FROM Q2;
