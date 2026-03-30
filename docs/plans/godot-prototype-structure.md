# Godot Prototype Structure

## Purpose
Translate the first slice design into a scene and script structure that can be prototyped cleanly in Godot 4.

## Scope
This structure only covers the first playable proof:
- movement and Focus
- Relay Lantern carrying
- witness route state changes
- one deliberate wrong-route branch
- Yun's first wrong-home setpiece
- one changed revisit

## Project Principle
Build the prototype around route state readability first.

Do not begin with:
- full narrative framework
- inventory sprawl
- generalized combat
- full save/load architecture
- every future route authority

## Recommended Scene Breakdown

### Root Slice Scene
`VigilSpanSlice.tscn`

Suggested tree:

```text
Node2D VigilSpanSlice
  Node2D World
  Node2D RouteGeometry
  Node2D WitnessSources
  Node2D InteractiveProps
  Node2D NPCActors
  Node SetpieceDirector
  CanvasLayer UI
  Node AudioDirector
  Node DebugTools
```

## Core Reusable Scenes

### Player
`PlayerLune.tscn`

Root:
- `CharacterBody2D`

Children:
- sprite and shadow presentation
- focus cue controller
- carry anchor point
- interaction detector
- route state reader

Main responsibilities:
- movement
- quick-step
- focus state
- carry state
- split recovery state
- action dispatch for Answer, Knot, Cut, and Call

### Relay Lantern
`RelayLantern.tscn`

Root:
- `Node2D`

Children:
- lantern visual
- tether `Line2D`
- source detector `Area2D`
- audio cue node

Main responsibilities:
- maintain current witness source
- calculate tether cleanliness
- notify route segments when the tether state changes

### Witness Source
`WitnessSource.tscn`

Variants:
- lawful bell-eye
- portable lawful anchor
- private wrong-source anchor
- hostile witness source later

Main responsibilities:
- expose lawful or false witness profile
- provide cadence signature
- define visibility cone or field

### Route Segment
`WitnessRouteSegment.tscn`

Main responsibilities:
- track Held True, Thinning, Held Wrong, and Lost
- read input from witness sources and lantern tether
- expose route cues to visuals, collision, and music

### Hold Point
`HoldPoint.tscn`

Main responsibilities:
- restore coherence
- end Split Recovery early
- provide safe retether or Knot interactions

### Return Conflict Controller
`ReturnConflictController.tscn`

Main responsibilities:
- manage phase transitions in Yun's setpiece
- watch player arrival state
- trigger spatial Call windows
- publish the final resolution state

## Suggested Script Modules

### `player_controller.gd`
Movement, state switching, quick-step, input buffering.

### `focus_reader.gd`
Transforms raw route information into readable local cues for the player.

### `relay_lantern.gd`
Owns tether math, source switching, and wrong-source capture timing.

### `witness_source.gd`
Base behavior for lawful, false, and later hostile witnesses.

### `route_segment.gd`
Decides local route truth and forwards it to collision, audio, and FX.

### `split_recovery.gd`
Applies the deterministic recovery penalties and resolves them on hold, Knot, or Call.

### `slice_state.gd`
Tracks suspicion, arrival mode, Frayed Bell Thread ownership, and revisit flags for the slice only.

### `return_conflict_director.gd`
Runs Yun's setpiece as a gameplay phase machine rather than a cinematic script.

### `music_director.gd`
Layers lawful, thinning, wrong, and conflict motifs from route state and setpiece phase.

## Data To Keep Simple
The prototype should use lightweight data resources or dictionaries for:
- route thresholds
- witness source profiles
- answer roles
- one-slice consequence flags

Do not build a universal data-driven content pipeline yet.

## Implementation Order

### 1. Player Readability Pass
- move
- quick-step
- Focus
- basic route cue rendering

### 2. Relay Lantern Pass
- carry state
- tether line
- lawful anchor retether
- Thinning and Lost transitions

### 3. Wrong-Route Pass
- false source field
- Held Wrong lock-in
- misarrival pocket
- Frayed Bell Thread reward

### 4. Setpiece Pass
- Yun centerline logic
- spatial Call windows
- resolution states

### 5. Revisit Pass
- suspicion-dependent route changes
- altered NPC responses
- optional mastery path

## Debug Requirements
The prototype needs temporary debug visibility for:
- witness cones
- tether length
- route state
- wrong-source capture timer
- Split Recovery timer
- suspicion state

These can be ugly. They are for tuning, not shipping.

## Anti-Overbuild Rule
If a system is not needed to prove the first 20-minute slice, stub it or cut it for now.

The prototype only needs enough architecture to answer one question clearly:
is active witness crossing fun?