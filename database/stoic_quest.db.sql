BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Challenge" (
	"challenge_id"	INTEGER NOT NULL UNIQUE,
	"title"	VARCHAR(100) NOT NULL,
	"description"	TEXT NOT NULL,
	"difficulty"	INTEGER NOT NULL,
	"reward_points"	INTEGER NOT NULL,
	PRIMARY KEY("challenge_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Quote" (
	"quote"	TEXT NOT NULL,
	"author"	VARCHAR(100),
	"quote_id"	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY("quote_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Philosopher" (
	"philosopher_id"	INTEGER NOT NULL UNIQUE,
	"current_challenge"	INTEGER,
	"name"	VARCHAR(100),
	"level"	INTEGER NOT NULL,
	"total_experience"	INTEGER NOT NULL,
	FOREIGN KEY("current_challenge") REFERENCES "Challenge"("challenge_id"),
	PRIMARY KEY("philosopher_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Journal" (
	"entry_id"	INTEGER NOT NULL UNIQUE,
	"philosopher_id"	INTEGER NOT NULL,
	"entry"	TEXT,
	FOREIGN KEY("philosopher_id") REFERENCES "Philosopher"("philosopher_id"),
	PRIMARY KEY("entry_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Badge" (
	"badge_id"	INTEGER NOT NULL UNIQUE,
	"description"	TEXT,
	PRIMARY KEY("badge_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Owns" (
	"philosopher_id"	INTEGER NOT NULL,
	"badge_id"	INTEGER NOT NULL,
	FOREIGN KEY("philosopher_id") REFERENCES "Philosopher"("philosopher_id"),
	FOREIGN KEY("badge_id") REFERENCES "Badge"("badge_id"),
	PRIMARY KEY("philosopher_id","badge_id")
);
CREATE TABLE IF NOT EXISTS "Virtue" (
	"virtue_id"	INTEGER NOT NULL UNIQUE,
	"name"	VARCHAR(15) NOT NULL UNIQUE,
	"description"	TEXT,
	PRIMARY KEY("virtue_id")
);
CREATE TABLE IF NOT EXISTS "Has" (
	"philosopher_id"	INTEGER,
	"virtue_id"	INTEGER,
	FOREIGN KEY("philosopher_id") REFERENCES "Philosopher"("philosopher_id"),
	FOREIGN KEY("virtue_id") REFERENCES "Virtue"("virtue_id"),
	PRIMARY KEY("philosopher_id","virtue_id")
);
CREATE TABLE IF NOT EXISTS "Increments" (
	"challenge_id"	INTEGER,
	"virtue_id"	INTEGER,
	FOREIGN KEY("challenge_id") REFERENCES "Challenge"("challenge_id"),
	FOREIGN KEY("virtue_id") REFERENCES "Virtue"("virtue_id"),
	PRIMARY KEY("challenge_id","virtue_id")
);
INSERT INTO "Quote" VALUES ('No son las cosas las que nos perturban, sino nuestra opinión sobre ellas.','Epicteto',1);
INSERT INTO "Quote" VALUES ('Vivimos en la brevedad del tiempo, y nuestro mundo es pequeño.','Marco Aurelio',2);
INSERT INTO "Quote" VALUES ('Lo que nos hace infelices es nuestra opinión sobre las cosas, no las cosas en sí.','Séneca',3);
COMMIT;
