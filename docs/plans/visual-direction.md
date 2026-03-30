# Visual Direction

## Purpose
Lock a render and art-direction policy that fits the Hollow's appeal without drifting into generic anime 3D or flat prestige-fantasy realism.

## Core Decision
The Hollow should be 2D-first, non-photoreal, silhouette-driven, and emotionally stylized.

For the prototype and early production, treat this as pure 2D, not 2.5D.

Pixel, painted pastel, or mixed 2D approaches are all acceptable.
Photoreal or strongly volumetric 3D should be avoided unless the result is so distinct that it could not be mistaken for a normal anime game or fantasy action title.

## Render Policy

### Preferred Default
Layered 2D illustration with strong silhouette separation, void-heavy contrast, and pastel-muted color accents.

This supports:
- character obsession through readable silhouettes and props
- impossible geometry without realism fighting it
- route-state changes that can feel graphic and immediate
- bell halos, shadows, and lantern light as iconic motifs

### Acceptable Production Lanes

#### 1. Pastel Illustration Lane
Soft painted surfaces, sharp silhouette control, and limited depth.

Best for:
- portraits
- key art
- story scenes
- atmosphere-heavy exploration

#### 2. Pixel And Portrait Lane
Gameplay environments and sprites can use high-quality pixel language if portraits, silhouettes, route effects, and state changes remain emotionally rich.

Best for:
- traversal prototypes
- route readability
- efficient production if scope tightens

#### 3. Mixed 2D Lane
Painterly backgrounds, sprite or cutout characters, layered FX, and flat compositing.

Best for:
- impossible spaces
- route distortion
- low-dimensional but expressive motion

### Restricted Lane
3D or 2.5D is only acceptable if it is aggressively flattened, stylized, and spatially strange.

Production rule:
do not use this lane for the first playable or early content production.

Requirements if used:
- no realistic materials or skin rendering
- no default cel-shaded anime look
- no "camera plus lighting equals style" shortcuts
- geometry must feel authored for the Hollow, not engine-default

If it cannot clear those bars, do not use it.

## Hard Avoids
- photoreal textures
- realistic lens effects as default flavor
- heavy volumetric depth that makes characters less iconic
- generic anime 3D game readability
- painterly realism that hides route state and silhouette cues

## Color Script

### Base World Palette
- void black
- chalk white
- pale ash lavender
- washed sea-mint
- dim rose-pink
- tarnished halo gold

### Sanctioned Witness Palette
- pale ivory
- cooled gold
- controlled blue-white light
- aligned shadow edges

### Keeping Palette
- wrong warm pink
- bruised plum
- black-red lantern flare
- off-cyan shadow seam
- broken gold rather than clean gold

The world should feel pastel enough to be seductive, but never sugary. Black depth and wrong light must keep the sweetness dangerous.

## Character Rendering Rules
- every important role must read in silhouette before facial detail matters
- halos, veils, lantern rigs, route scars, and shadow states must be visible from medium distance
- costumes should favor iconic layering over realistic fabric complexity
- faces should carry strong emotional readability without realism becoming the main appeal

## Environment Rendering Rules
- perspective can be bent, inverted, or flattened if route law remains readable
- Earth-like architectural realism should lose to Hollow-specific image power
- every area should have at least one instantly memorable impossible shape
- route truth must be legible from shape, light, and rhythm, not only from interface overlays

## Motion Direction
- use limited but intentional animation rather than chasing fluid realism
- route failure should read through silhouette shifts, shadow lag, bell rhythm breaks, and light behavior
- impact comes from timing and contrast, not from physically realistic interpolation

## UI Direction
- UI should feel like route marks, witness glyphs, and bell notation, not generic fantasy frames
- minimal systemic overlays only
- if the UI is prettier than the world-state cues, the balance is wrong

## Design Rule
If the Hollow looks technically impressive but less memorable than a still frame of its characters, the visual direction is wrong.

If 3D complexity slows iteration or weakens route readability, reject it immediately and stay in pure 2D.