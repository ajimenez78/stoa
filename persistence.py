import sqlite3
from typing import List
from dataclasses import field
from model import *
from enum import Enum

class VIRTUE_IDS(Enum):
    WISDOM = 1
    JUSTICE = 2
    TEMPLANCE = 3
    COURAGE = 4

class Persistence:
    def __init__(self, db_name: str = 'database/stoic_quest.db'):
        self.con = sqlite3.connect(db_name)
        self.cursor = self.con.cursor()
        self.virtue_names = {}

    def kill(self):
        self.con.close()

    def get_quotes(self) -> List[Quote]:
        rows = self.cursor.execute('SELECT quote, author FROM quote').fetchall()
        return [Quote(quote=row[0], author=row[1]) for row in rows]
    
    def get_random_quote(self) -> Quote:
        row = self.cursor.execute('SELECT quote, author FROM quote ORDER BY RANDOM() LIMIT 1;').fetchone()
        return Quote(quote=row[0], author=row[1])
    
    def get_random_challenge(self) -> Challenge:
        challenge_row = self.cursor.execute('SELECT challenge_id, title, description, difficulty, reward_points FROM challenge ORDER BY RANDOM() LIMIT 1;').fetchone()
        virtues_row = self.cursor.execute('SELECT virtue_id FROM increments WHERE challenge_id=?', (challenge_row[0],)).fetchall()
        target_virtues = [virtue_id[0] for virtue_id in virtues_row]
        return Challenge(title=challenge_row[1], description=challenge_row[2], difficulty=challenge_row[3], target_virtues=target_virtues, reward_points=challenge_row[4])
    
    def create_player(self, name: str) -> Player:
        row = self.cursor.execute('INSERT INTO philosopher(name, level, total_experience) VALUES (?,0,1) RETURNING philosopher_id', (name,)).fetchone()
        philosopher_id = row[0]
        self.cursor.execute('INSERT INTO has (philosopher_id, virtue_id, points, level) VALUES (?, ?, 0, 1)', (philosopher_id,VIRTUE_IDS.WISDOM.value,))
        self.cursor.execute('INSERT INTO has (philosopher_id, virtue_id, points, level) VALUES (?, ?, 0, 1)', (philosopher_id,VIRTUE_IDS.JUSTICE.value,))
        self.cursor.execute('INSERT INTO has (philosopher_id, virtue_id, points, level) VALUES (?, ?, 0, 1)', (philosopher_id,VIRTUE_IDS.TEMPLANCE.value,))
        self.cursor.execute('INSERT INTO has (philosopher_id, virtue_id, points, level) VALUES (?, ?, 0, 1)', (philosopher_id,VIRTUE_IDS.COURAGE.value,))
        self.con.commit()
        virtues = {VIRTUE_IDS.WISDOM.value: Virtue(virtue_id=VIRTUE_IDS.WISDOM.value, points=0, level=1),
                   VIRTUE_IDS.JUSTICE.value: Virtue(virtue_id=VIRTUE_IDS.JUSTICE.value, points=0, level=1),
                   VIRTUE_IDS.TEMPLANCE.value: Virtue(virtue_id=VIRTUE_IDS.TEMPLANCE.value, points=0, level=1),
                   VIRTUE_IDS.COURAGE.value: Virtue(virtue_id=VIRTUE_IDS.COURAGE.value, points=0, level=1)}
        return Player(philosopher_id=row[0], name=name, level=0, total_experience=0, virtues=virtues, badges=[], journal=[])
    
    def get_player(self, philosopher_id: int) -> Player:
        philosopher_row = self.cursor.execute('SELECT name, level, total_experience FROM philosopher WHERE philosopher_id=?', (philosopher_id,)).fetchone()
        virtues_row = self.cursor.execute('SELECT virtue_id, points, level FROM has WHERE philosopher_id=?', (philosopher_id,)).fetchall()
        virtues = {}
        for virtue in virtues_row:
            if virtue[0] == VIRTUE_IDS.WISDOM.value:
                virtues[VIRTUE_IDS.WISDOM.value] = Virtue(virtue_id=virtue[0], points=virtue[1], level=virtue[2])
            elif virtue[0] == VIRTUE_IDS.JUSTICE.value:
                virtues[VIRTUE_IDS.JUSTICE.value] = Virtue(virtue_id=virtue[0], points=virtue[1], level=virtue[2])
            elif virtue[0] == VIRTUE_IDS.TEMPLANCE.value:
                virtues[VIRTUE_IDS.TEMPLANCE.value] = Virtue(virtue_id=virtue[0], points=virtue[1], level=virtue[2])
            elif virtue[0] == VIRTUE_IDS.COURAGE.value:
                virtues[VIRTUE_IDS.COURAGE.value] = Virtue(virtue_id=virtue[0], points=virtue[1], level=virtue[2])
        badges_row = self.cursor.execute('SELECT badge_id FROM owns WHERE philosopher_id=?', (philosopher_id,)).fetchall()
        badges = [badge[0] for badge in badges_row]
        journal_row = self.cursor.execute('SELECT entry FROM journal WHERE philosopher_id=?', (philosopher_id,)).fetchall()
        journal = [entry[0] for entry in journal_row]
        return Player(philosopher_id=philosopher_id, name=philosopher_row[0], level=philosopher_row[1], total_experience=philosopher_row[2], virtues=virtues, badges=badges, journal=journal)

    def virtue_name_from_id(self, virtue_id: int) -> str:
        if self.virtue_names.get(virtue_id):
            return self.virtue_names[virtue_id]
        else:
            self.virtue_names[virtue_id] = self.cursor.execute('SELECT name FROM virtue WHERE virtue_id=?', (virtue_id,)).fetchone()[0]
            return self.virtue_names[virtue_id]
