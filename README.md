# SQL Challenge
## Goals
The goal of this project is to practice:

1. Data Modeling
2. Data Engineering
3. Data Analysis

by importing given csv files of employee data into an SQL database and sorting through the relevant data to find interesting relationships.

## Data Modeling
Looking at the headings for the csv files, I saw that unique employees and departments were identified with "emp_no" and "dept_no" respectively. Before creating the database, I wanted to make a schematic for what data is represented and how each table would be connected. This way, all the information is organized in my head before I start any coding.

Using QuickDBD, I created the following:
![ERD_QuickDBD.png](EmployeeSQL/ERD_QuickDBD.png)

The benefit of using a tool like QuickDBD is that I can quickly input simple, syntax-light code to create tables like
```
departments
---
dept_no varchar(4) PK
dept_name varchar(10)
```

and the tool will visually organize all that information. This way I can really focus on getting to know the data, which will make the actual coding process so much faster.

A nice bit about this tool in particular is that it can also export sample code to create the tables:

```
CREATE TABLE "departments" (
    "dept_no" varchar(4)   NOT NULL,
    "dept_name" varchar(30)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);
```

## Data Engineering
It seems to me that there is a complete list of departments with department numbers and a list of employees with employee numbers. Those numbers would be well suited to primary keys since, I assume, they are unique to each department or employee.

no primary key for dept emp because certain employees are in multiple departments

## Data Analysis
### List the following details of each employee:
-- employee number, last name, first name, gender, and salary.
```
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees as e
INNER JOIN salaries as s
ON e.emp_no = s.emp_no;
```

### List employees who were hired in 1986.
```
SELECT emp_no, first_name, last_name FROM employees WHERE hire_date LIKE '1986%';
```

### List the manager of each department with the following information:
-- department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
```
SELECT d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no
INNER JOIN employees as e
ON dm.emp_no = e.emp_no;
```

### List the department of each employee with the following information:
-- employee number, last name, first name, and department name.
```
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no;
```

### List all employees whose first name is "Hercules" and last names begin with "B."
```
SELECT * FROM employees WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
```

### List all employees in the Sales department, including their
-- employee number, last name, first name, and department name.
```
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_emp
    WHERE dept_no IN (
        SELECT dept_no
        FROM departments
        WHERE dept_name = 'Sales'
    )
);
```

### List all employees in the Sales and Development departments, including their
-- employee number, last name, first name, and department name.
```
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN departments as d
ON de.dept_no = d.dept_no
WHERE e.emp_no IN (
    SELECT emp_no
    FROM dept_emp
    WHERE dept_no IN (
        SELECT dept_no
        FROM departments
        WHERE dept_name = 'Sales' OR 'Development'
    )
);
```

### In descending order, list the frequency count of employee last names,
-- i.e., how many employees share each last name.
```
SELECT last_name, COUNT(last_name) as "Last Name Count" FROM employees GROUP BY last_name ORDER BY "Last Name Count" DESC;
```
