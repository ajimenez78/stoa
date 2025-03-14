import sqlite3
from typing import List, Dict
from dataclasses import dataclass

@dataclass
class Challenge:
    title: str
    description: str
    difficulty: int
    target_virtues: List[str]
    reward_points: int

con = sqlite3.connect('database/stoic_quest.db')
cursor = con.cursor()

quotes = [
    ('No son las cosas las que nos perturban, sino nuestra opinión sobre ellas.', 'Epicteto'),
    ('Vivimos en la brevedad del tiempo, y nuestro mundo es pequeño.', 'Marco Aurelio'),
    ('Lo que nos hace infelices es nuestra opinión sobre las cosas, no las cosas en sí.', 'Séneca')
]

cursor.execute('CREATE TABLE IF NOT EXISTS quotes (quote, author)')
cursor.execute('DELETE FROM quotes')
cursor.executemany("INSERT INTO quotes VALUES (?, ?)", quotes)

con.commit()

for row in cursor.execute('SELECT quote, author FROM quotes order by author'):
    print(row)

class Persistence:
    def __init__(self, db_name: str = 'stoic_quest.db'):
        self.con = sqlite3.connect(db_name)
        self.cursor = self.con.cursor()

    def kill(self):
        self.con.close()

    def get_quotes(self) -> List[Dict[str, str]]:
        rows = self.cursor.execute('SELECT quote, author FROM quotes').fetchall()
        return [{'quote': row[0], 'author': row[1]} for row in rows]
    
    def get_random_quote(self) -> Dict[str, str]:
        row = self.cursor.execute('SELECT quote, author FROM quotes ORDER BY RANDOM() LIMIT 1;').fetchone()
        return {'quote': row[0], 'author': row[1]}

con.close()
