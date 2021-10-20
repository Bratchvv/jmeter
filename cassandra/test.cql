-- 1
CREATE KEYSPACE test WITH replication = {'class': 'NetworkTopologyStrategy', 'replication_factor' : 2};

DESCRIBE KEYSPACE test;

DROP KEYSPACE test;

-- 2
CREATE KEYSPACE user WITH replication = {'class': 'NetworkTopologyStrategy', 'Mars': 3, 'Earth': '2'};

DESCRIBE KEYSPACE user;

USE user;

ALTER KEYSPACE user WITH replication = {'class': 'NetworkTopologyStrategy', 'Mars': 3, 'Earth': '3'};

DESCRIBE KEYSPACE user;

-- 3
CREATE TABLE users (
    email text PRIMARY KEY,
    userid uuid,
    first_name text,
    last_name text,
    age varint,
    is_active boolean
) WITH comment='Systems''s users';

INSERT INTO users (email, userid, first_name, last_name, age, is_active) VALUES ('bratchvv@gmail.com', 6ad182e2-2bfe-11ec-8d3d-0242ac130003, 'Vova', 'Bratchikov', 29, true);

SELECT * FROM users; -- УЖОООССС!!!!

SELECT * FROM users WHERE email='bratchvv@gmail.com';
SELECT * FROM users WHERE userid=6ad182e2-2bfe-11ec-8d3d-0242ac130003  ALLOW FILTERING; -- УЖОООССС!!!!


--4
CREATE TABLE user_posts (
  userid uuid,
  posted_year_month text,
  text text,
  title text,
  PRIMARY KEY (userid, posted_year_month)
) WITH comment='users''s posts' AND compaction = { 'class' : 'LeveledCompactionStrategy' };

INSERT INTO user_posts (userid, posted_year_month, text, title) VALUES (6ad182e2-2bfe-11ec-8d3d-0242ac130003, '2021_10', 'hello world!', 'Warning!');
INSERT INTO user_posts (userid, posted_year_month, text, title) VALUES (6ad182e2-2bfe-11ec-8d3d-0242ac130003, '2021_09', 'hello world prev!', 'Warning!');

SELECT * FROM user_posts; -- УЖОООССС!!!!
SELECT * FROM user_posts WHERE userid=6ad182e2-2bfe-11ec-8d3d-0242ac130003 ;


-- 5

CREATE TABLE user_history (
    machine inet,
    userid uuid,
    mtime timeuuid,
    action text,
    PRIMARY KEY ((machine, userid), mtime)
) WITH CLUSTERING ORDER BY (mtime DESC)  AND comment='users''s history' ;

INSERT INTO user_history (machine, userid, mtime, action) VALUES ('10.10.10.1', 6ad182e2-2bfe-11ec-8d3d-0242ac130003, 50554d6e-29bb-11e5-b345-feff819cdc9f, 'open folder');

SELECT * FROM user_history; -- УЖОООССС!!!!
SELECT * FROM user_history WHERE machine='10.10.10.1' and userid=6ad182e2-2bfe-11ec-8d3d-0242ac130003;


-- 6


-- 5
CREATE TABLE test_counter (
  id bigint,
  count counter,
  PRIMARY KEY (id)
);

DROP TABLE test_counter;

-- Counter 6
CREATE TABLE WebLogs (
  page_id uuid,
  page_name text,
  insertion_time timestamp,
  page_count counter,
  PRIMARY KEY ((page_id,page_name), insertion_time)
);
update weblogs set page_count = page_count + 1 where page_id =uuid() and page_name ='test.com' and insertion_time =dateof(now());
select * from weblogs ;


-- 7 list

CREATE TABLE plays_data (
   id text PRIMARY KEY,
   game text,
   players int,
   scores list<int> -- A list of integers
);

INSERT INTO plays_data (id, game, players, scores) VALUES ('123-afde', 'quake', 3, [17, 4, 2]);

select * from plays_data ;

UPDATE plays_data SET players = 5, scores = scores + [ 14, 21 ] WHERE id = '123-afde';

select * from plays_data ;

UPDATE plays_data SET players = 6, scores = [ 3 ] + scores WHERE id = '123-afde';

select * from plays_data ;

UPDATE plays_data SET scores = [ 3, 9, 4] WHERE id = '123-afde';

select * from plays_data ;

DELETE scores[1] FROM plays_data WHERE id = '123-afde';

select * from plays_data ;


--8 views

CREATE TABLE user_data (
  userid uuid,
  file_name timeuuid,
  action text,
  PRIMARY KEY ((machine, userid), mtime)
) WITH CLUSTERING ORDER BY (mtime DESC)  AND comment='users''s history' ;

INSERT INTO user_history (machine, userid, mtime, action) VALUES ('10.10.10.1', 6ad182e2-2bfe-11ec-8d3d-0242ac130003, 50554d6e-29bb-11e5-b345-feff819cdc9f, 'open folder');

SELECT * FROM user_history; -- УЖОООССС!!!!
