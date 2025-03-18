import random
from model import *
from persistence import Persistence
import json

DATA_FILE = "data.json"

class Stoa:  # Renombrar la clase principal
    def __init__(self):
        self.persistence = Persistence()
        self.running = True

    def create_player(self, name: str) -> Player:
        return self.persistence.create_player(name=name)

    def select_random_challenge(self) -> Challenge:
        return random.choice(self.challenges)

    def complete_challenge(self, player: Player, challenge: Challenge):
        # Increase virtue points
        print(f"Completaste el desafío {challenge.title}! Recibes {challenge.reward_points} puntos de virtud.")
        for virtue_id in challenge.target_virtues:
            player.virtues[virtue_id].points += challenge.reward_points
            player.virtues[virtue_id].level = 1 + player.virtues[virtue_id].points // 50

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
        return f"{quote.quote} - {quote.author}"

    def show_player_status(self, player: Player):
        print(f"\n--- Estado de {player.name} ---")
        print(f"Nivel: {player.level}")
        print(f"Experiencia Total: {player.total_experience}")
        
        print("\nVirtudes:")
        for name, virtue in player.virtues.items():
            print(f"{self.persistence.virtue_name_from_id(name)}: Nivel {virtue.level} (Puntos: {virtue.points})")
        
        print("\nInsignias:")
        for badge in player.badges:
            print(badge)

def main():
    game = Stoa()  # Cambiar todas las referencias de StoicQuest a Stoa
    
    # Create player if it doesn't exist
    player = None
    try:
        with open(DATA_FILE, "r") as local_data:
            game_data = json.load(local_data)
            if game_data["player_id"]:
                player = game.persistence.get_player(game_data["player_id"])
                print(f"Bienvenido de nuevo, {player.name}!")
    except FileNotFoundError:
        pass

    if not player:
        name = input("¡Bienvenido a Stoic Quest! ¿Cómo te llamas? ")
        player = game.create_player(name=name)
        game_data = {"player_id": player.philosopher_id}
        with open(DATA_FILE, "w") as local_data:
            json.dump(game_data, local_data)
    
    # Example game loop
    while game.running:
        
        # Show stoic quote
        print("\nReflexión estoica del día:")
        print(game.get_stoic_quote())
    
        # Show player status
        game.show_player_status(player)

        # Select and show challenge
        challenge = game.persistence.get_random_challenge()
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
