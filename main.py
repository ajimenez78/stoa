import random
from typing import List
from model import *

class StoicQuest:
    def __init__(self):
        self.challenges = self._generate_challenges()
        self.stoic_quotes = [
            "No son las cosas las que nos perturban, sino nuestra opinión sobre ellas. - Epicteto",
            "Vivimos en la brevedad del tiempo, y nuestro mundo es pequeño. - Marco Aurelio",
            "Lo que nos hace infelices es nuestra opinión sobre las cosas, no las cosas en sí. - Séneca"
        ]
        self.running = True

    def _generate_challenges(self) -> List[Challenge]:
        return [
            Challenge(
                title="Gratitud Diaria", 
                description="Escribe 3 cosas por las que estás agradecido hoy", 
                difficulty=1, 
                target_virtues=['Sabiduría', 'Templanza'], 
                reward_points=10
            ),
            Challenge(
                title="Control Estoico", 
                description="Identifica 3 situaciones fuera de tu control hoy", 
                difficulty=2, 
                target_virtues=['Coraje', 'Templanza'], 
                reward_points=15
            ),
            Challenge(
                title="Acto de Bondad", 
                description="Realiza un acto de bondad sin esperar nada a cambio", 
                difficulty=3, 
                target_virtues=['Justicia', 'Coraje'], 
                reward_points=20
            )
        ]

    def create_player(self, name: str) -> Player:
        return Player(name=name)

    def select_random_challenge(self) -> Challenge:
        return random.choice(self.challenges)

    def complete_challenge(self, player: Player, challenge: Challenge):
        # Increase virtue points
        for virtue_name in challenge.target_virtues:
            player.virtues[virtue_name].points += challenge.reward_points
            player.virtues[virtue_name].level = 1 + player.virtues[virtue_name].points // 50

        # Increase total experience
        player.total_experience += challenge.reward_points
        player.level = 1 + player.total_experience // 100

        # Add badge if it's an important challenge
        if challenge.difficulty >= 3:
            badge = f"Maestro de {challenge.title}"
            if badge not in player.badges:
                player.badges.append(badge)

    def add_journal_entry(self, player: Player, reflection: str):
        player.journal.append(reflection)

    def get_stoic_quote(self) -> str:
        return random.choice(self.stoic_quotes)

    def show_player_status(self, player: Player):
        print(f"\n--- Estado de {player.name} ---")
        print(f"Nivel: {player.level}")
        print(f"Experiencia Total: {player.total_experience}")
        
        print("\nVirtudes:")
        for name, virtue in player.virtues.items():
            print(f"{name}: Nivel {virtue.level} (Puntos: {virtue.points})")
        
        print("\nInsignias:")
        for badge in player.badges:
            print(badge)

def main():
    game = StoicQuest()
    
    # Create player
    player = game.create_player("Filosofo en Entrenamiento")
    
    # Example game loop
    while game.running:
        
        # Show stoic quote
        print("\nReflexión estoica del día:")
        print(game.get_stoic_quote())
    
        # Show player status
        game.show_player_status(player)

        # Select and show challenge
        challenge = game.select_random_challenge()
        print(f"\nDesafío del día: {challenge.title}")
        print(challenge.description)

        completion = input('¿Has completado el desafío? (s/n/q): ')
        if completion.lower() == 's':
            game.complete_challenge(player, challenge)
            reflection = input('¿Qué aprendiste sobre el desafío? ')
            game.add_journal_entry(player,
                    f"Hoy completé el desafío: {challenge.title}. Aprendí que... {reflection}")
        elif completion.lower() == 'q':
            game.running = False

    print("\nGracias por jugar Stoic Quest. Hasta luego!")

if __name__ == "__main__":
    main()
