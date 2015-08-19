-- Requires the contents of file states.sql to be loaded first.
.read states.sql

-- Tables in states.sql:
--   states(state):       US States + DC - HI - AK
--   landlocked(state):   Table of landlocked (not adjacent to ocean) states
--   adjacencies(s1, s2): States that are adjacent to each other

create table california as
  select * from adjacencies where s1 = 'CA';

-- Finds lengths of possible paths between two states
create table distances as
  with
    distance(start, end, hops) as (
      select s1,s2, from adjacencies union
      select path.start, hop.s2, path.hops+1
        from distance as path, adjacencies as hop
        where path.end = hop.s1 and
          path.hops < 15
    )
  select * from distance;

create table three_hops as
  select end from distances where start = "CA" and hops = 3;
