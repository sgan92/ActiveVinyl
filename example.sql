CREATE TABLE characters (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  tv_id INTEGER,

  FOREIGN KEY(tv_id) REFERENCES tv(id)
);

CREATE TABLE tv (
  id INTEGER PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  showType_id INTEGER,

  FOREIGN KEY(showType_id) REFERENCES tv(id)
);

CREATE TABLE showTypes (
  id INTEGER PRIMARY KEY,
  showType VARCHAR(255) NOT NULL
);

INSERT INTO
  showTypes (id, showType)
VALUES
  (1, "Thriller"), (2, "Comedy");

INSERT INTO
  tv (id, name, tv_id)
VALUES
  (1, "Orphan Black", 1),
  (2, "How I Met Your Mother", 2),
  (3, "Friends", 2),
  (4, "Breaking Bad", 1);

INSERT INTO
  characters (id, name, tv_id)
VALUES
  (1, "Walter White", 4),
  (2, "Jesse Pinkman", 4),
  (3, "Sarah Manning", 1),
  (4, "Alison Hendrix", 1),
  (5, "Chandler Bing", 3),
  (6, "Phoebe Buffay", 3),
  (7, "Barney Stinson", 2)
