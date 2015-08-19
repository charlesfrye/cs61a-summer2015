-- Requires the contents of file states.sql to be loaded first.
.read states.sql

-- Tables in states.sql:
--   states(state):       US States + DC - HI - AK
--   landlocked(state):   Table of landlocked (not adjacent to ocean) states
--   adjacencies(s1, s2): States that are adjacent to each other

create table alphabetical_paths as
  with
    paths(s, n, last) as (
      select s1||','||s2,1,s2 from adjacencies where s2>s1 union
      select old.s||','||nxt.s2,old.n+1,nxt.s2
        from paths as old, adjacencies as nxt
        where nxt.s2 > old.last 
          and nxt.s1 = old.last
    )
  select s,n from paths order by -n;

-- Lengths of possible paths between two states that enter only
-- landlocked states along the way.
create table inland_distances as
  with
    inland(start, end, hops) as (
      select a.s1,l.state,1 from adjacencies as a, landlocked as l 
        where a.s2 = l.state union
      select paths.start, hop.s2, paths.hops+1
        from inland as paths, adjacencies as hop
          where hop.s1 = paths.end
            and hop.s2 in landlocked
            and paths.hops < 10
    )
  select start,end,hops from inland;

create table inland_distances as
  with
    inland(start, end, hops) as (
      select state, state, 0 from landlocked union
      select start, s2, hops + 1
        from inland, adjacencies, landlocked
        where end = s1 and s2 = state and hops < 8
    )
  select s1 as start, s2 as end, 2 as hops from adjacencies union
  select start.s1 as start, end.s2 as end, hops+2 as hops
    from adjacencies as start, adjacencies as end, inland
    where start.s2 = start and end.s1 = end;



    