## Purpose

Ensures font scaling calculations in the Gimnasio screen remain proportional and non-compounding when practice cards are rebuilt or when navigating back from practice details.

## ADDED Requirements

### Requirement: Unscaled Base Font Size Retrieval
The font scaling system MUST retrieve the unscaled base font size from controls even if a theme font size override is currently applied.

#### Scenario: Caching base font size for overridden control
- **WHEN** `_cache_base_font_sizes()` processes a control with an active `font_size` theme override
- **THEN** it temporarily removes the override to read the true theme base font size before re-applying the scaled override

### Requirement: Clean Practice List Navigation on Completion
When returning to the practice list screen after completing a practice, the practice list view SHALL restore a clean layout without progress panel expansion or list scroll offsets.

#### Scenario: Returning to practice list upon practice completion
- **WHEN** the user marks a daily practice as completed
- **THEN** `_show_practice_list()` resets `PracticeScroll` vertical scroll position to 0 and maintains proper font scaling across all rebuilt cards
