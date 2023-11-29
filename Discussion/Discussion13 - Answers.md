### 1 & 2

```sqlite
-- 背景代码
create table records as
   select 'Ben Bitdiddle' as name, 'Computer' as division, 'Wizard' as title, 60000 as salary, 'Oliver Warbucks' as supervisor union
   select 'Alyssa P Hacker'      , 'Computer'            , 'Programmer'     , 40000          , 'Ben Bitdiddle' union
   select 'Cy D Fect'            , 'Computer'            , 'Programmer'     , 35000          , 'Ben Bitdiddle' union
   select 'Lem E Tweakit'        , 'Computer'            , 'Technician'     , 25000          , 'Ben Bitdiddle' union
   select 'Louis Reasoner'       , 'Computer'            , 'Programmer Trainee'   ,  30000   , 'Alyssa P Hacker' union
   select 'Oliver Warbucks'      , 'Administration'      , 'Big Wheel'      , 150000         , 'Oliver Warbucks' union
   select 'Eben Scrooge'         , 'Accounting'          , 'Chief Accountant',  75000        , 'Oliver Warbucks' union
   select 'Robert Cratchet'      , 'Accounting'          , 'Scrivener'      , 18000          , 'Eben Scrooge';
```

###### 2.1

```sqlite
select name from records where supervisor = 'Oliver Warbucks';
```

###### 2.2

```sqlite
select * from records where supervisor = name;
```

###### 2.3

```sqlite
select name from records where salary > 50000 order by name;
```



### 3

```sqlite
-- 背景代码
create table meetings as
   select 'Accounting' as division, 'Monday' as day, '9am' as time union
   select 'Computer'              , 'Wednesday'    , '4pm' union
   select 'Administration'        , 'Monday'       , '11am' union
   select 'Administration'        , 'Wednesday'    , '4pm';
```

###### 3.1

```sqlite
select a.day, a.time from meetings as a, records as b where a.division = b.division and b.supervisor = 'Oliver Warbucks';
```

###### 3.2

```sqlite
select a.name from records as a, records as b where a.supervisor = b.name and a.division != b.division;
```

###### 3.3

```sqlite
select a.name, b.name from records as a, records as b, meetings as c, meetings as d
   where a.division = c.division and b.division = d.division and c.day = d.day and c.time = d.time and a.name < b.name;
```



###### 4.1

```sqlite
select supervisor, sum(salary) from records group by supervisor;
```

###### 4.2

```sqlite
select b.day from records as a, meetings as b where a.division = b.division
   group by b.day having count(*) < 5;
```

###### 4.3

```sqlite
select b.division from records as a, records as b
   where a.division = b.division and a.name < b.name
   group by b.division having a.salary + b.salary < 100000;
```



### 5

```sqlite
-- 背景代码
create table courses as
   select 'John DeNero' as professor, 'CS 61C' as course, 'Sp20' as semester union
   select 'John DeNero', 'CS 61A', 'Fa19' union
   select 'Dan Garcia', 'CS 61C', 'Sp19' union
   select 'John DeNero', 'CS 61A', 'Fa18' union
   select 'Dan Garcia', 'CS 10', 'Fa18' union
   select 'Josh Hug', 'CS 61B', 'Sp18' union
   select 'John DeNero', 'CS 61A', 'Sp18' union
   select 'John DeNero', 'CS 61A', 'Fa17' union
   select 'Paul Hilfinger', 'CS 61A', 'Fa17' union
   select 'Paul Hilfinger', 'CS 61A', 'Sp17' union
   select 'John DeNero', 'Data 8', 'Sp17' union
   select 'Josh Hug', 'CS 61B', 'Sp17' union
   select 'Satish Rao', 'CS 70', 'Sp17' union
   select 'Nicholas Weaver', 'CS 61C', 'Sp17' union
   select 'Gerald Friedland', 'CS 61C', 'Sp17';
```

###### 5.1

```sqlite
create table num_taught as
   select professor, course, count(*) as count from courses group by professor, course;
```

###### 5.2

```sqlite
select a.professor, b.professor, b.course from num_taught as a, num_taught as b
   where a.course = b.course and a.count = b.count and a.professor < b.professor;
```

###### 5.3

```sqlite
select a.professor, b.professor from courses as a, courses as b
   where a.professor < b.professor and a.course = b.course and a.semester = b.semester
   group by a.professor, b.professor having count(*) > 1;
```

