## Why

In the Gimnasio screen, increasing font size scales up the top Progress Panel (level bar, mentor hint, 2x2 virtue grid), consuming a large portion of the vertical screen real estate. Making the progress panel collapsible allows users to collapse the detailed virtue breakdown to maximize vertical space for Practices, Challenges, and Minigames.

## What Changes

- Add an interactive collapse/expand toggle button (`▼`/`▲`) on the Progress Panel header in `Dungeons/gym.tscn`.
- When collapsed, hide the 2x2 Virtue Grid and Level Hint Label while keeping a compact Level summary and Level Bar visible.
- When expanded, reveal the full 2x2 Virtue Grid and Level Hint Label.
- Update `Dungeons/Scripts/gym.gd` to handle toggle presses, animate or switch visibility, and update font scaling across toggle controls.

## Capabilities

### New Capabilities
- `gym/collapsible-progress-panel`: Defines collapsible/accordion behavior for the Gimnasio top progress panel to optimize vertical space on high font scales.

## Impact

- **UI Scenes**: `Dungeons/gym.tscn` (Header toggle button and progress panel layout).
- **Scripts**: `Dungeons/Scripts/gym.gd` (toggle signal handling and visibility state).
