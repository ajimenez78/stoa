# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
- Stoa: "Un viaje interior" - A gamified application focused on teaching Stoic philosophy
- Purpose: Guide users through learning and practicing Stoicism in an RPG-like experience
- Transitioning from Python to Godot 4.4
- Python legacy code in `pythonLegacy/` directory
- Main Godot project files in root directory
- Target platforms: Android, iOS, and web

## Commands
- Run Python app: `python pythonLegacy/main.py`
- Run Godot project: Open project.godot in Godot Editor
- Lint Godot scripts: Use the built-in Godot script editor linting (F4 key)

## Code Style Guidelines
- **Python**:
  - Use 4-space indentation
  - Type hints for all functions and variables
  - Snake_case for functions/variables, PascalCase for classes
  - Use dataclasses for models
  - Use f-strings for string formatting
  - Import order: standard library → third-party → project modules
  - Organize imports alphabetically
  - Use SQLite for persistence with explicit connection handling
  - Prefer enums for constants

- **Godot**:
  - Follow GDScript style guidelines
  - Use CamelCase for classes, snake_case for variables/functions
  - Group exports by category
  - Use typed variables when possible
  - Create modular, reusable components
  - Use signal-based communication between objects
  - Implement the visual style: 2D vector art with minimalist design

## Database
- SQLite database in pythonLegacy/database/
- Explicit connection handling in persistence.py
- Store user progress, journal entries, and practice records

## Architecture
- Implement modular content system for adding new practices/challenges
- Follow "spiral" narrative structure with recurring cycles
- Use scene-based navigation (Stoa, Gym, Home)
- Implement virtue-based progression system (Justice, Wisdom, Courage, Temperance)