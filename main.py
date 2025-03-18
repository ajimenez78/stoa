import random
from typing import List
from model import *
from persistence import Persistence

class Stoa:  # Renombrar la clase principal
    def __init__(self):
        self.challenges = self._generate_challenges()
        self.persistence = Persistence()
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
        quote = self.persistence.get_random_quote()
        return f"{quote['quote']} - {quote['author']}"

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
    game = Stoa()  # Cambiar todas las referencias de StoicQuest a Stoa
    
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

    print("\nGracias por jugar Stoa. Hasta luego!")  # Actualizar el mensaje de despedida
    game.persistence.kill()

if __name__ == "__main__":
    main()
