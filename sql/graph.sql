/*******************************************************************************
* Name        : erpel/sql/graph.sql                                            *
* Author      : M.E.Rosner                                                     *
* E-Mail      : marty[at]rosner[dot]io                                         *
* Version     : 0.0.01                                                         *
* Copyright   : Copyright (C) 2020, 2021 M.E.Rosner; Berlin; Germany           *
* Description : An Enterprise Ressource Planning Notation and Tool Kit         *
* URL         : https://github.com/exo-mer/2021-financial-ERPEL                *
*******************************************************************************/

-- VARIANT A.
-- each combination of node pairs
-- 1 : 1 uniquely (1,3); (1,2) but not other (1,3)!
-- one edge per pair only
DROP TABLE IF EXISTS edges;
DROP TABLE IF EXISTS nodes;
CREATE TABLE nodes(	nid	INTEGER PRIMARY KEY,		-- node id
			val	INTEGER,			-- value (1,2,3) use precision to add decimal (pre	INTEGER; i.e. .23)
			lab	TEXT,				-- node label
			typ	TEXT,				-- node type (float, int, char)
			des	TEXT);				-- description

CREATE TABLE edges(	one	INTEGER NOT NULL,		-- node one
			two	INTEGER NOT NULL,		-- node two
			lab	TEXT,				-- edge label
			PRIMARY KEY (one, two),			-- primary key using one and two
			FOREIGN KEY(one) REFERENCES nodes(nid),	-- foreign key one
			FOREIGN KEY(two) REFERENCES nodes(nid));-- foreign key two

INSERT INTO nodes VALUES (1, 8888,'a', 'int', 'A node having a default value 8888 and label a');
INSERT INTO nodes VALUES (2, 2222,'b', 'float', 'A node having a default value 2222 and label b');
INSERT INTO nodes VALUES (3, 4444,'c', 'int', 'A node having a default value 4444 and label c');

INSERT INTO edges VALUES (1, 3, 'add');


-- VARIANT B.
-- adding an edge id too
-- N : M edges for each node pair are possible
-- edges are (1,3); (1,3); (1,3) - n-times
-- but: chances for duplicates
DROP TABLE IF EXISTS edges;
DROP TABLE IF EXISTS nodes;
CREATE TABLE nodes(	nid	INTEGER PRIMARY KEY,		-- node id
			val	INTEGER,			-- value (1,2,3) use precision to add decimal (pre	INTEGER; i.e. .23)
			lab	TEXT,				-- node label
			typ	TEXT,				-- node type (float, int, char)
			des	TEXT);				-- description

CREATE TABLE edges(	eid	INTEGER PRIMARY KEY,		-- edge id
			one	INTEGER NOT NULL,		-- node one
			two	INTEGER NOT NULL,		-- node two
			lab	TEXT,				-- edge label
			-- PRIMARY KEY (one, two),			-- primary key using one and two
			FOREIGN KEY(one) REFERENCES nodes(nid),	-- foreign key one
			FOREIGN KEY(two) REFERENCES nodes(nid));	-- foreign key two

INSERT INTO nodes VALUES (1, 8888,'a', 'int', 'A node having a default value 8888 and label a');
INSERT INTO nodes VALUES (2, 2222,'b', 'float', 'A node having a default value 2222 and label b');
INSERT INTO nodes VALUES (3, 4444,'c', 'int', 'A node having a default value 4444 and label c');

INSERT INTO edges VALUES (1, 1, 3, 'add');
INSERT INTO edges VALUES (2, 1, 3, 'sub');
INSERT INTO edges VALUES (4, 1, 3, 'add');			-- duplicate / clone of eid 1
INSERT INTO edges VALUES (3, 1, 2, 'sub');


-- VARIANT C.
-- design not having an edge id (eid)
-- saving one column, more strict
-- every edge has to have a label, but empty text is possible
DROP TABLE IF EXISTS edges;
DROP TABLE IF EXISTS nodes;
CREATE TABLE nodes(	nid	INTEGER PRIMARY KEY,		-- node id
			val	INTEGER,			-- value (1,2,3) use precision to add decimal (pre	INTEGER; i.e. .23)
			lab	TEXT,				-- node label
			typ	TEXT,				-- node type (float, int, char)
			des	TEXT);				-- description

CREATE TABLE edges(	one	INTEGER NOT NULL,		-- node one
			two	INTEGER NOT NULL,		-- node two
			lab	TEXT,				-- edge label
			PRIMARY KEY (one, two, lab),		-- primary key using one and two
			FOREIGN KEY(one) REFERENCES nodes(nid),	-- foreign key one
			FOREIGN KEY(two) REFERENCES nodes(nid));-- foreign key two

INSERT INTO nodes VALUES (1, 8888,'a', 'int', 'A node having a default value 8888 and label a');
INSERT INTO nodes VALUES (2, 2222,'b', 'float', 'A node having a default value 2222 and label b');
INSERT INTO nodes VALUES (3, 4444,'c', 'int', 'A node having a default value 4444 and label c');

INSERT INTO edges VALUES (1, 3, 'add');
INSERT INTO edges VALUES (1, 3, 'sub');
INSERT INTO edges VALUES (1, 3, 'mul');
INSERT INTO edges VALUES (1, 2, 'sub');
INSERT INTO edges VALUES (1, 2, '');


-- remove tables
DROP TABLE IF EXISTS edges;
DROP TABLE IF EXISTS nodes;

-- one might want to go for VARIANT C.
