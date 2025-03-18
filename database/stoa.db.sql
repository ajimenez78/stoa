BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Badge" (
	"badge_id"	INTEGER NOT NULL UNIQUE,
	"description"	TEXT,
	PRIMARY KEY("badge_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Challenge" (
	"challenge_id"	INTEGER NOT NULL UNIQUE,
	"title"	VARCHAR(100) NOT NULL,
	"description"	TEXT NOT NULL,
	"difficulty"	INTEGER NOT NULL,
	"reward_points"	INTEGER NOT NULL,
	"rewards_with"	INTEGER,
	PRIMARY KEY("challenge_id" AUTOINCREMENT),
	FOREIGN KEY("rewards_with") REFERENCES "Badge"("badge_id")
);
CREATE TABLE IF NOT EXISTS "Has" (
	"philosopher_id"	INTEGER,
	"virtue_id"	INTEGER,
	"points"	INTEGER NOT NULL DEFAULT 0,
	"level"	INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY("philosopher_id","virtue_id"),
	FOREIGN KEY("philosopher_id") REFERENCES "Philosopher"("philosopher_id"),
	FOREIGN KEY("virtue_id") REFERENCES "Virtue"("virtue_id")
);
CREATE TABLE IF NOT EXISTS "Increments" (
	"challenge_id"	INTEGER,
	"virtue_id"	INTEGER,
	PRIMARY KEY("challenge_id","virtue_id"),
	FOREIGN KEY("challenge_id") REFERENCES "Challenge"("challenge_id"),
	FOREIGN KEY("virtue_id") REFERENCES "Virtue"("virtue_id")
);
CREATE TABLE IF NOT EXISTS "Journal" (
	"entry_id"	INTEGER NOT NULL UNIQUE,
	"philosopher_id"	INTEGER NOT NULL,
	"entry"	TEXT,
	PRIMARY KEY("entry_id" AUTOINCREMENT),
	FOREIGN KEY("philosopher_id") REFERENCES "Philosopher"("philosopher_id")
);
CREATE TABLE IF NOT EXISTS "Owns" (
	"philosopher_id"	INTEGER NOT NULL,
	"badge_id"	INTEGER NOT NULL,
	PRIMARY KEY("philosopher_id","badge_id"),
	FOREIGN KEY("badge_id") REFERENCES "Badge"("badge_id"),
	FOREIGN KEY("philosopher_id") REFERENCES "Philosopher"("philosopher_id")
);
CREATE TABLE IF NOT EXISTS "Philosopher" (
	"philosopher_id"	INTEGER NOT NULL UNIQUE,
	"current_challenge"	INTEGER,
	"name"	VARCHAR(100),
	"level"	INTEGER NOT NULL,
	"total_experience"	INTEGER NOT NULL,
	PRIMARY KEY("philosopher_id" AUTOINCREMENT),
	FOREIGN KEY("current_challenge") REFERENCES "Challenge"("challenge_id")
);
CREATE TABLE IF NOT EXISTS "Quote" (
	"quote"	TEXT NOT NULL,
	"author"	VARCHAR(100),
	"quote_id"	INTEGER NOT NULL UNIQUE,
	PRIMARY KEY("quote_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Virtue" (
	"virtue_id"	INTEGER NOT NULL UNIQUE,
	"name"	VARCHAR(15) NOT NULL UNIQUE,
	"description"	TEXT,
	PRIMARY KEY("virtue_id")
);
INSERT INTO "Badge" ("badge_id","description") VALUES (1,'Maestro bondadoso');
INSERT INTO "Challenge" ("challenge_id","title","description","difficulty","reward_points","rewards_with") VALUES (1,'Gratitud Diaria','Escribe 3 cosas por las que estás agradecido hoy',1,10,NULL),
 (2,'Control Estoico','Identifica 3 situaciones fuera de tu control hoy',2,15,NULL),
 (3,'Acto de Bondad','Realiza un acto de bondad sin esperar nada a cambio',3,20,1);
INSERT INTO "Has" ("philosopher_id","virtue_id","points","level") VALUES (1,1,0,0),
 (1,2,0,0),
 (1,3,0,0),
 (1,4,0,0);
INSERT INTO "Increments" ("challenge_id","virtue_id") VALUES (1,1),
 (1,3),
 (2,3),
 (2,4),
 (3,2),
 (3,4);
INSERT INTO "Philosopher" ("philosopher_id","current_challenge","name","level","total_experience") VALUES (1,NULL,'Zeno',0,0);
INSERT INTO "Quote" ("quote","author","quote_id") VALUES ('No son las cosas las que nos perturban, sino nuestra opinión sobre ellas.','Epicteto',1),
 ('Vivimos en la brevedad del tiempo, y nuestro mundo es pequeño.','Marco Aurelio',2),
 ('Lo que nos hace infelices es nuestra opinión sobre las cosas, no las cosas en sí.','Séneca',3);
INSERT INTO "Virtue" ("virtue_id","name","description") VALUES (1,'Sabiduría',NULL),
 (2,'Justicia',NULL),
 (3,'Templanza',NULL),
 (4,'Coraje',NULL);
COMMIT;
