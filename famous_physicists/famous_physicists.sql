/* top 10 physicists, their fields, and approaches */

-- table 1 has physicist names

CREATE TABLE physicists (id INTEGER PRIMARY KEY, name TEXT);

INSERT INTO physicists VALUES (1, 'Albert Einstein');
INSERT INTO physicists VALUES (2, 'Isaac Newton');
INSERT INTO physicists VALUES (3, 'James Clerk Maxwell');
INSERT INTO physicists VALUES (4, 'Niels Bohr');
INSERT INTO physicists VALUES (5, 'Werner Heisenberg');
INSERT INTO physicists VALUES (6, 'Galileo Galilei');
INSERT INTO physicists VALUES (7, 'Richard Feynman');
INSERT INTO physicists VALUES (8, 'Paul Dirac');
INSERT INTO physicists VALUES (9, 'Erwin Schrodinger');
INSERT INTO physicists VALUES (10, 'Ernest Rutherford');

-- table 2 has fields of physics

CREATE TABLE research_field (id INTEGER PRIMARY KEY, field TEXT);

INSERT INTO research_field VALUES (1, 'Classical Mechanics');
INSERT INTO research_field VALUES (2, 'Electrity & Magnetism');
INSERT INTO research_field VALUES (3, 'Quantum Mechanics');
INSERT INTO research_field VALUES (4, 'Relativistic Mechanics');
INSERT INTO research_field VALUES (5, 'Optics');
INSERT INTO research_field VALUES (6, 'Astrophysics');
INSERT INTO research_field VALUES (7, 'Statistical Mechanics');
INSERT INTO research_field VALUES (8, 'Nuclear Physics');
INSERT INTO research_field VALUES (9, 'Particle Physics');
INSERT INTO research_field VALUES (10, 'Condensed Matter Physics');


--table 3 has approaches to physics

CREATE TABLE approach (id INTEGER PRIMARY KEY, approaches TEXT);

INSERT INTO approach VALUES (1, 'Experimental');
INSERT INTO approach VALUES (2, 'Theoretical');

-- table 4 contains the ids of physicists, their fields of physics, and their approaches

CREATE TABLE physics_keys (id INTEGER PRIMARY KEY, physicist_key INTEGER, field_key INTEGER, approach_key INTEGER);

INSERT INTO physics_keys VALUES (1, 1, 1, 2);
INSERT INTO physics_keys VALUES (2, 1, 7, 2);
INSERT INTO physics_keys VALUES (3, 1, 4, 2);
INSERT INTO physics_keys VALUES (4, 1, 3, 2);
INSERT INTO physics_keys VALUES (5, 1, 10, 2);
INSERT INTO physics_keys VALUES (6, 1, 6, 2);

INSERT INTO physics_keys VALUES (7, 2, 1, 2);
INSERT INTO physics_keys VALUES (8, 2, 5, 2);
INSERT INTO physics_keys VALUES (9, 2, 5, 1);
INSERT INTO physics_keys VALUES (10, 2, 6, 2);

INSERT INTO physics_keys VALUES (11, 3, 2, 2);
INSERT INTO physics_keys VALUES (12, 3, 7, 2);
INSERT INTO physics_keys VALUES (13, 3, 6, 2);

INSERT INTO physics_keys VALUES (14, 4, 3, 2);

INSERT INTO physics_keys VALUES (15, 5, 3, 2);

INSERT INTO physics_keys VALUES (16, 6, 1, 1);
INSERT INTO physics_keys VALUES (17, 6, 1, 2);
INSERT INTO physics_keys VALUES (18, 6, 6, 1);
INSERT INTO physics_keys VALUES (19, 6, 6, 2);

INSERT INTO physics_keys VALUES (20, 7, 3, 2);
INSERT INTO physics_keys VALUES (21, 7, 9, 2);
INSERT INTO physics_keys VALUES (22, 7, 10, 2);

INSERT INTO physics_keys VALUES (23, 8, 3, 2);
INSERT INTO physics_keys VALUES (24, 8, 9, 2);

INSERT INTO physics_keys VALUES (25, 9, 3, 2);

INSERT INTO physics_keys VALUES (26, 10, 8, 1);

-- join all tables

SELECT physicists.name, research_field.field, approach.approaches
FROM physics_keys
LEFT OUTER JOIN physicists
ON physicists.id = physics_keys.physicist_key
LEFT OUTER JOIN research_field
ON physics_keys.field_key = research_field.id
LEFT OUTER JOIN approach
ON physics_keys.approach_key = approach.id;
