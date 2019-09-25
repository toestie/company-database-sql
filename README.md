# SQL Challenge
## Goals
The goal of this project is to practice:

1. Data Modeling
2. Data Engineering
3. Data Analysis

by importing given csv files of employee data into an SQL database and sorting through some relevant data.

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

## Data Analysis