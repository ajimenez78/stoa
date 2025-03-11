from dataclasses import dataclass, field
from typing import List, Dict

@dataclass
class Virtue:
    name: str
    points: int = 0
    level: int = 1

@dataclass
class Challenge:
    title: str
    description: str
    difficulty: int
    target_virtues: List[str]
    reward_points: int

@dataclass
class Player:
    name: str
    level: int = 1
    total_experience: int = 0
    virtues: Dict[str, Virtue] = field(default_factory=lambda: {
        'Sabiduría': Virtue('Sabiduría'),
        'Coraje': Virtue('Coraje'),
        'Justicia': Virtue('Justicia'),
        'Templanza': Virtue('Templanza')
    })
    badges: List[str] = field(default_factory=list)
    journal: List[str] = field(default_factory=list)
