CREATE TABLE "departments" (
    "dept_no" varchar(4)  PRIMARY KEY NOT NULL,
    "dept_name" varchar(30)   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(4)   NOT NULL,
    "from_date" varchar(10)   NOT NULL,
    "to_date" varchar(10)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(4)    NOT NULL,
    "emp_no" int	NOT NULL,
    "from_date" varchar(10)   NOT NULL,
    "to_date" varchar(10)   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" int   PRIMARY KEY NOT NULL,
    "birth_date" varchar(10)   NOT NULL,
    "first_name" varchar(30)   NOT NULL,
    "last_name" varchar(30)   NOT NULL,
    "gender" varchar(1)   NOT NULL,
    "hire_date" varchar(10)   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" int   PRIMARY KEY NOT NULL,
    "salary" int   NOT NULL,
    "from_date" varchar(10)   NOT NULL,
    "to_date" varchar(10)   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" int   NOT NULL,
    "title" varchar(60)   NOT NULL,
    "from_date" varchar(10)   NOT NULL,
    "to_date" varchar(10)   NOT NULL
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


-- Exported/Adapted from QuickDBD: https://www.quickdatabasediagrams.com/
/*
departments
---
dept_no varchar(4) PK
dept_name varchar(30)

dept_emp
---
emp_no int FK - employees.emp_no
dept_no varchar(4) FK >- departments.dept_no
from_date varchar(10)
to_date varchar(10)

dept_manager
---
dept_no varchar(4) FK >- departments.dept_no
emp_no int FK - employees.emp_no
from_date varchar(10)
to_date varchar(10)

employees
---
emp_no int PK
birth_date varchar(10)
first_name varchar(30)
last_name varchar(30)
gender varchar(1)
hire_date varchar(10)

salaries
---
emp_no int PK FK - employees.emp_no
salary int
from_date varchar(10)
to_date varchar(10)

titles
---
emp_no int FK - employees.emp_no
title varchar(60)
from_date varchar(10)
to_date varchar(10)
*/