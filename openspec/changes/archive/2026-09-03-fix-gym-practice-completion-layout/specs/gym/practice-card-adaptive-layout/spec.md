## Purpose

Ensures practice card heights and layout dimensions are calculated smoothly and stably without layout jumps, compounding font scaling, or content clipping when returning to the practice list screen.

## ADDED Requirements

### Requirement: Stable Card Height Calculation Before Visibility
`MissionCard` SHALL calculate its required content minimum height using a realistic screen width fallback when instantiated inside an invisible container (`size.x <= 50`).

#### Scenario: Rebuilding cards while practice list is hidden
- **WHEN** practice cards are instantiated or updated while `practice_list` is hidden
- **THEN** `update_adaptive_minimum_size()` calculates `custom_minimum_size.y` using the viewport layout width rather than falling back to an unmeasured minimum height

### Requirement: Mathematical Base Font Size Recovery
The font scaling system MUST compute unscaled base font sizes (`override_size / scale_factor`) if a control already has a scaled theme override when `_cache_base_font_sizes()` is executed.

#### Scenario: Re-caching controls with active font scale
- **WHEN** `_cache_base_font_sizes()` processes a control with an active `font_size` override
- **THEN** it mathematically derives and caches the exact original base font size without compounding zoom across multiple rebuilds
