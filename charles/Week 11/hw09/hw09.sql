create table parents as
  select "abraham" as parent, "barack" as child union
  select "abraham"          , "clinton"         union
  select "delano"           , "herbert"         union
  select "fillmore"         , "abraham"         union
  select "fillmore"         , "delano"          union
  select "fillmore"         , "grover"          union
  select "eisenhower"       , "fillmore";

create table dogs as
  select "abraham" as name, "long" as fur, 26 as height union
  select "barack"         , "short"      , 52           union
  select "clinton"        , "long"       , 47           union
  select "delano"         , "long"       , 46           union
  select "eisenhower"     , "short"      , 35           union
  select "fillmore"       , "curly"      , 32           union
  select "grover"         , "short"      , 28           union
  select "herbert"        , "curly"      , 31;

create table sizes as
  select "toy" as size, 24 as min, 28 as max union
  select "mini",        28,        35        union
  select "medium",      35,        45        union
  select "standard",    45,        60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
create table size_of_dogs as
select name,size from dogs, sizes where height > min and height <=max;


-- All dogs with parents ordered by decreasing height of their parent
create table by_height as
    select c.name from dogs as c, dogs as p, parents as pedigree
      where p.name = pedigree.parent and c.name = pedigree.child
      order by p.height DESC;

-- Sentences about siblings that are the same size
create table sentences as
  with siblingPairs(kidA, kidB) as (
    select a.child, b.child from parents as a, parents as b
      where a.child < b.child and a.parent = b.parent
    )
select siblingPairs.kidA || " and " || siblingPairs.kidB ||" are " || a.size|| " siblings"
  from size_of_dogs as a, size_of_dogs as b, siblingPairs
    where a.name = siblingPairs.kidA and b.name = siblingPairs.kidB
    and a.size = b.size;


-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
create table stacks as
    with stacks(list,totHeight,lastHeight,count) as (
      select name,height,height,1 from dogs union
      select last.list ||", "|| next.name, last.totHeight + next.height,next.height,last.count+1
        from stacks as last, dogs as next
          where last.lastHeight < next.height
          and last.count <=3
      )
select list,totHeight from stacks where count = 4 and totHeight >= 170;


create table tallest as
  with decades(name,height,modulus) as (
    select name, height, max(height % 10) from dogs 
      group by height/10 having count(*)>1
    )
  select name,height from decades;

-- All non-parent relations ordered by height difference
create table non_parents as
select "REPLACE THIS LINE WITH YOUR SOLUTION";


