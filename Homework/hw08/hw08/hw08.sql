CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;


-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT name, size from dogs as a, sizes as b where b.min < a.height and a.height <= b.max;


-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child from parents, dogs where name = parent order by height desc;


-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT "REPLACE THIS LINE WITH YOUR SOLUTION";

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT a.name || " and " || b.name || " are " || b.size || " siblings" 
    from size_of_dogs as a, size_of_dogs as b, parents as c, parents as d where a.size = b.size and a.name = c.child and b.name = d.child and c.parent = d.parent and a.name < b.name;


-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height, n);

-- Add your INSERT INTOs here
insert into stacks_helper select a.name || ", " || b.name || ", " || c.name || ", " || d.name, a.height + b.height + c.height + d.height as total_height, d.height, 4
  from dogs as a, dogs as b, dogs as c, dogs as d
  where total_height > 170 and a.height < b.height and b.height < c.height and c.height < d.height order by total_height;


CREATE TABLE stacks AS
  SELECT dogs, stack_height from stacks_helper;

