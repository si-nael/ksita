# Master Plan

Status: world-first phase. The world law is locked enough to develop further, but story, protagonist, and vertical slice narrative remain intentionally unstarted.

## Working Title
Project Glass Choir

## Core Goal
Build a fantasy game whose world feels impossible, singular, and instantly magnetic enough to support favorite characters, dangerous pairings, and long-term obsession.

The current focus is not plot. It is establishing a world that can generate plot, character appeal, and mystery without borrowing familiar skeletons.

Genre target: a real-time relational route-action adventure whose strongest qualities survive because of play, not in spite of it.

Emotional benchmark: playable catharsis, mythic long-form heartbreak, and elegant recontextualization should all be treated as design targets, not optional polish.

## Locked World Decisions
- The world is a void called the Hollow.
- Its physics are independent of time.
- The representative place is the Sea Beneath the Last Stair.
- Travel and distance are relational rather than metric.
- The first prototype area will be dominated by Witness-based travel.
- Witness feedback will be diegetic-first, with a subtle systemic fallback for readability.
- Public witness is regulated by the Common Vigil.
- Tone direction should favor a subculture-facing, character-hook-first presentation rather than dusty classical fantasy or overt social commentary.
- Sequence is created through the Five Turns: Facing, Carrying, Knotting, Returning, and Veiling.
- Illegal private witness exists as Counterwitness, usually called Keeping.
- Witness is both a local traversal state and a broader narrative standing.
- The first major character-focused conflict should be built around Returning.
- Death culminates in becoming Unkept, not simply in bodily stoppage.
- Visual direction is 2D-first and non-photoreal; pixel or pastel are both acceptable, but realistic or generic 3D rendering is not.
- Prototype and early production should stay in pure 2D; 2.5D or 3D experiments are out of scope until the route systems already work.
- Lune is the first perspective anchor.
- The first arc should feel seductive-tragic before it feels openly predatory.
- The project should target roughly 20 to 30 hours for a first clear and 60 to 80 hours for full completion; extra hours must come from optionality, mastery, and replay rather than a bloated single route.
- The project must prove itself as a game of active route reading, risky traversal, and consequence-bearing systems rather than as a visual novel with premium worldbuilding.
- The main systems architecture is defined in `game-systems.md` and should guide future slice and chapter planning.
- Emotional targets for gameplay, music, tragedy, and reveal design are defined in `emotional-targets.md`.
- The first concrete control scheme and slice flow are defined in `control-and-slice.md`.
- The current prototype tuning, first setpiece script, and Godot scene layout are defined in `prototype-tuning.md`, `yun-first-wrong-home-setpiece.md`, and `godot-prototype-structure.md`.

## World Pillars

### 1. Void, Not Terrain
The world must not read like a planet with fantasy decoration. Important places should feel suspended, inverted, impossible, or relationally assembled.

### 2. Relation Over Chronology
Change must happen because relations are altered, not because time advances. This should affect movement, architecture, life cycles, danger, and ritual.

### 3. Sequence Is Artificial Survival
People need rituals to maintain usable order in an achronal reality. Society should visibly depend on these practices.

### 4. Beauty Must Come From Impossible Coherence
The strongest awe should come from places that should not hold together but do.

### 5. Intimacy Must Be Physically Dangerous
Love, grief, neglect, memory, and witness should be able to deform routes, bodies, and settlement stability.

### 6. Character Magnetism Is A Worldbuilding Requirement
The world should naturally create roles, looks, titles, and contradictions that make people want to dig into characters, not just admire the setting.

## Design Demands
- Every major place must be impossible on Earth.
- Every major system must prove that physics is independent of time.
- Every social institution should exist partly to keep people and places coherent.
- Every future relationship design should exploit the fact that stable identity depends on witness and relation.
- Every traversal rule should force the player to qualify for a route rather than merely locate it.
- Every major traversal failure should be legible before it becomes punitive.
- Every institution should be simultaneously necessary for survival and intolerable in what it asks of people.
- Every major world concept should be able to produce at least one compelling role, relic, or pair dynamic.
- World explanation should usually arrive through people, not detached thesis-style exposition.
- Sequence should generate scene types, favorite roles, and forbidden private rituals rather than just calendar logic.
- Every chapter should contain at least one player-owned contradiction that cannot be solved by dialogue alone.
- Traversal, social consequence, and relationship fallout should be mechanically entangled rather than separated into game sections and story sections.

## What Remains Unlocked
- protagonist
- plot
- cast
- confrontation structure
- chapter count
- the main illegal witness subculture's exact aesthetics and internal factions

## First Character Baseline
The first major role cluster should be the Returning conflict bundle defined in `returning-role-cluster.md`.

The first named seed set should be the five-character bundle defined in `first-cast-seeds.md`.

## Production Direction

### Recommended Starting Stack
- Engine: Godot 4
- Language: GDScript for early speed
- Target: PC first
- Presentation: pure 2D first, with strong authored transitions, impossible spatial staging, and non-photoreal rendering

### Scope Policy
- See `playtime-and-scope.md` for the current duration target and anti-filler rules.
- See `gameplay-identity.md` for the anti-visual-novel gameplay bar.
- See `game-systems.md` for the core loop, encounter types, progression structure, and fail-forward model.
- See `emotional-targets.md` for reference-feeling translation and anti-imitation rules.
- See `control-and-slice.md` for the first playable control baseline and encounter flow.
- See `prototype-tuning.md`, `yun-first-wrong-home-setpiece.md`, and `godot-prototype-structure.md` for prototype-ready implementation planning.

### Why This Direction
- The main risk is conceptual coherence, not rendering complexity.
- Fast iteration matters because the world law must be proven in playable form before story scale expands.

## Current Risks
- The void setting becomes vague if impossible places are not materially specific.
- Time-independent physics becomes a gimmick if it only appears in lore and not in traversal, danger, and daily life.
- The world becomes unreadable if relational law has no clear player-facing logic.
- The project drifts back toward Earth-like defaults unless each major place is aggressively non-terrestrial.
- The project becomes cold if system design outpaces character fascination.
- The target duration becomes destructive if the project tries to reach 80 hours through linear expansion instead of route depth, side obsession, and mastery.
- The project becomes passive if traversal, failure, and relationship consequence do not share the same systems.
- The project will miss its target if gameplay peaks, music peaks, and reveal peaks happen in separate disconnected layers.

## Immediate Next Moves
1. Refine the sanctioned-versus-illegal costume split into reusable outfit rules.
2. Decide whether hostile witness in the first arc should appear through a person, a place, or a relic.
3. Turn Lune, Iri, Nao, Yun, and Sera from seed sheets into relationship maps.
4. Draft the first playable scene sequence from Lune's POV.
5. Turn the first arc into a reusable chapter template that can scale toward the completionist target without filler.
6. Define the first mechanically innovative witness interactions that make the project feel unconvertible into a visual novel.
7. Tune the first control scheme and Relay Lantern encounter into a prototype-ready spec.
8. Implement the first wrong-home setpiece as a playable phase controller instead of a cinematic event.