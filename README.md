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
It seems to me that there is a complete list of departments with department numbers and a list of employees with employee numbers. Those numbers would be well suited to primary keys since, I assume, they are unique to each department or employee. This logic also applies to the salaries table as well; theoretically an employee should only have one salary, so each salary entry is tied to a unique employee number.

This is not true, however, for titles, managers, and departments. In the table of employees and their departments it is possible to have multiple entries with the same department represented (preventing us from using deptartment number as a primary key), and it is possible for employees to be part of multiple departments (preventing us from using employee number as a primary key). Managers are similar; it is possible for a manager to be part of multiple departments. Finally, a person can have multiple titles. Therefore in these three tables (titles, dept_manager, and dept_emp), there are no primary keys specified.

In terms of the data types, I wanted to specify the number of characters for the VARCHAR datatypes in order to optimize run times when querying. There are certain datasets that were ideal for this: 
1. All the dates had 10 characters in the form XXXX-XX-XX, so I could specify those as VARCHAR(10). 
2. Names were split into first and last, so I could safely assume that a last name or first name alone would not exceed 30 characters.
3. Gender identifiers were one letter, either M or F.
4. The department number was a mix of one letter and a number, but never exceeded 4 characters (as can be verified by the short list of all departments)

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

### List employee last names by count in descending order
SQL can do a lot more than just query for specific values in tables, it can operate on those specific entries looking for sum totals, averages, maximum values, minimum values, sort values, etc. As a demonstration, we can sort employee last names by their popularity by counting all entries of last names.

The "GROUP BY" statement is useful in this case as a way to aggregate data within a specific dataset (contrasted with "WHERE" statements which filter particular slices of a dataset). "ORDER BY" allows us to organize data in intuitive ways. It is useful to note that it does not jumble rows as it sorts the data.

```
SELECT last_name, COUNT(last_name) as "Last Name Count" FROM employees GROUP BY last_name ORDER BY "Last Name Count" DESC;
```

or in a more readable format:

```
SELECT last_name, COUNT(last_name) as "Last Name Count"
FROM employees
GROUP BY last_name
ORDER BY "Last Name Count" DESC;
```