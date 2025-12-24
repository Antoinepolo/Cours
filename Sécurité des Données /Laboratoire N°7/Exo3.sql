SELECT TOP 100 * FROM users ORDER BY nom DESC, prenom DESC, age ASC;

CREATE INDEX users_name ON users(nom DESC);
CREATE INDEX users_prenom ON users(prenom DESC);
CREATE INDEX users_age ON users(age ASC);

DROP INDEX users_name ON users;
DROP INDEX users_prenom ON users;
DROP INDEX users_age ON users;

CREATE INDEX users_infos ON users(nom DESC, prenom DESC, age ASC);