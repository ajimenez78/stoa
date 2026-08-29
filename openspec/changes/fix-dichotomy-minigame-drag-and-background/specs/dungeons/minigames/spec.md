## Purpose

Defines requirements for interactive minigames and drag-and-drop mechanics in the Gym section.

## ADDED Requirements

### Requirement: Interactive minigame mouse filtering and drag-and-drop
Minigames loaded into `minigame_host` SHALL preserve interactive mouse filter modes (`MOUSE_FILTER_STOP` or `MOUSE_FILTER_PASS`) on all cards and drop targets, enabling touch and mouse drag-and-drop interactions.

#### Scenario: Dragging situation cards into drop zones
- **WHEN** the player drags a situation card over a drop zone in "Dicotomía de control"
- **THEN** the situation card receives drag events, the drop zone highlights cleanly with solid visibility, and dropping evaluates the situation correctly
