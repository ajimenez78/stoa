from dataclasses import dataclass, field
from typing import List, Dict

@dataclass
class Virtue:
    virtue_id: int
    points: int = 0
    level: int = 1

@dataclass
class Challenge:
    title: str
    description: str
    difficulty: int
    target_virtues: List[int]
    reward_points: int

@dataclass
class Quote:
    quote: str
    author: str

@dataclass
class Player:
    philosopher_id: int
    name: str
    virtues: Dict[int, Virtue]
    level: int = 1
    total_experience: int = 0
    badges: List[int] = field(default_factory=list)
    journal: List[str] = field(default_factory=list)
