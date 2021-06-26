-- ----------------------------
--  https://napier.sqlzoo.net/wiki/DDL_Student_Records
-- ----------------------------

/*
   The database is intended to record the grades of students studying modules 
    at a University.
   There are a number of students, identified by a matric number.
   A typical student is Daniel Radcliffe who has matric number 40001010 and DoB 1989-07-23
   There are a number of modules, identified by a module code it also has a module name.
   A typical module is HUF07101 - Herbology.
   Each student studies many modules and will get a result for each.
   Each module is studied by many students.
*/

-- CREATE student
CREATE TABLE `student`
(
   `matric_no`     CHAR(8),
   `first_name`    VARCHAR(50) NOT NULL,
   `last_name`     VARCHAR(50) NOT NULL,
   `date_of_birth` DATE,
   PRIMARY KEY (`matric_no`)
);

-- Add some students to the database
INSERT INTO student VALUES ('40001010', 'Daniel', 'Radcliffe', '1989-07-23');
INSERT INTO student VALUES ('40001011', 'Emma',   'Watson',    '1990-04-15');
INSERT INTO student VALUES ('40001012', 'Rupert', 'Grint',     '1988-10-24');

-- CREATE module
CREATE TABLE `module`
(
   `module_code`  CHAR(8),
   `module_title` VARCHAR(50) NOT NULL,
   `level`        INT         NOT NULL,
   `credits`      INT         NOT NULL DEFAULT 20,
   PRIMARY KEY (`module_code`)
);

-- Add some modules
INSERT INTO module(module_code, module_title, level) 
VALUES ('HUF07101', 'Herbology', 7);

INSERT INTO module(module_code, module_title, level) 
VALUES ('SLY07102', 'Defence Against the Dark Arts', 7);

INSERT INTO module(module_code, module_title, level) 
VALUES ('HUF08102', 'History of Magic', 8);
                    
-- CREATE registration
CREATE TABLE `registration`
(
   `matric_no`   CHAR(8),
   `module_code` CHAR(8),
   `result`      DECIMAL(4, 1),
   PRIMARY KEY (`matric_no`, `module_code`),
   FOREIGN KEY (`matric_no`)   REFERENCES `student`(`matric_no`),
   FOREIGN KEY (`module_code`) REFERENCES `module`(`module_code`)
);

-- Add some data
INSERT INTO registration VALUES ('40001010', 'SLY07102', 90);
INSERT INTO registration VALUES ('40001010', 'HUF07101', 40);
INSERT INTO registration VALUES ('40001010', 'HUF08102', null);

INSERT INTO registration VALUES ('40001011', 'SLY07102', 99);
INSERT INTO registration VALUES ('40001011', 'HUF08102', null);

INSERT INTO registration VALUES ('40001012', 'SLY07102', 20);
INSERT INTO registration VALUES ('40001012', 'HUF07101', 20);

-- Run some queries
SELECT student.last_name, 
       student.first_name,
       result, 
       CASE WHEN registration.result <= 39 THEN 'F'
            WHEN registration.result >= 70 THEN 'M'
            ELSE 'P'
       END AS grade
FROM registration
JOIN student ON registration.matric_no   = student.matric_no
JOIN module  ON registration.module_code = module.module_code
WHERE registration.module_code = 'SLY07102';                                        
