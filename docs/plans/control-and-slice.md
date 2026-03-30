# Control And Slice

## Purpose
Turn the Hollow's systems into a concrete first-playable control model and encounter flow.

Supporting prototype documents:
- `prototype-tuning.md`
- `yun-first-wrong-home-setpiece.md`
- `godot-prototype-structure.md`

## Chosen Prototype Format
- Fully real-time movement.
- Pure 2D oblique action view with authored camera framing.
- Short focus-hold state instead of full pause planning.
- Small action set with high contextual density.

## Why This Format Wins
- Real-time crossing preserves tension, style, and music-play synchronization.
- A focus-hold layer lets the player read route truth without turning the game into a turn-based tactics screen.
- An oblique 2D view keeps silhouettes strong while still showing witness lines, piers, bells, and upside-down spatial drama.
- The game stays readable and prototypeable in Godot without any 3D camera or 2.5D staging overhead.

## Camera Rule
The camera should not behave like a fully free exploration camera.

It should:
- follow Lune closely enough to preserve urgency
- widen during route crossings so witness sources and destinations stay visible together
- tighten during wrong-home moments so body distortion and route falseness read immediately
- shift into strong authored compositions for major setpiece bridges without taking control away

## Core Player States

### 1. Run State
Default traversal.

What the player can do:
- move freely
- quick-step
- interact or pick up route objects
- enter Focus

### 2. Focus State
Hold to attune to route truth.

Effects:
- movement slightly slows
- route cues intensify
- witness lines, bell cadence, and body distortion become easier to read
- action inputs become more precise and relation-aware
- music layers expose whether the route is holding cleanly, thinning, or resolving wrong

Focus should feel like tension sharpening, not time stopping.

### 3. Carry State
Triggered when Lune is actively relaying witness or escorting a bound target.

Effects:
- movement options narrow
- quick-step becomes shorter and riskier
- route failure matters immediately
- the player feels responsible for keeping a truth alive in motion

### 4. Split Recovery State
Short destabilized state after a bad crossing.

Effects:
- visual and audio desync
- one action becomes unreliable until corrected
- recovery requires reaching a hold point, knot, or lawful call rather than waiting passively

## Core Prototype Actions

### Move
Primary locomotion.

Rule:
Movement should feel fast enough to be stylish, but not so fast that witness language becomes unreadable.

### Quick-Step
A short burst used to cross sight gaps, escape hostile witness, or catch a falling route window.

Rule:
This is not a generic dodge roll. It is a desperate correction tool.

### Focus
Hold to read and refine route truth.

Rule:
Focus should be used constantly in short bursts, not as a rare detective mode.

### Carry Or Relay
Primary interact button.

Uses:
- take hold of a witness lantern
- relay sanctioned witness between anchors
- escort a marked target through a route
- lift a relation token or burden object

### Answer
Assert how the world should read Lune for a short interval.

Early prototype answers:
- courier
- sanctioned runner
- returning witness

Use:
- open name-sensitive crossings
- stabilize lawful infrastructure
- avoid being interpreted under the wrong role

### Knot
Create a short-lived local truth.

Use:
- anchor a pier edge
- mark a recovery point
- stabilize a rescue target
- hold a route long enough to reverse direction

### Cut
Sever a relation on purpose.

Use:
- refuse a hostile witness lock
- break a lawful line to access a wrong route
- drop a temporary hold before it becomes a trap

### Call
Contextual climax action rather than a permanently available spam input.

Use:
- answer a return
- force a lawful recall
- choose which call Lune supports in a conflict state

## Suggested Keyboard And Mouse Mapping
- movement: WASD
- quick-step: Shift
- focus: right mouse hold
- carry or interact: left mouse
- answer: Q
- knot: E
- cut: F
- call: Space during return conflicts or scripted call windows

## Suggested Controller Mapping
- movement: left stick
- quick-step: A
- focus: left trigger hold
- carry or interact: X
- answer: Y
- knot: B
- cut: right bumper
- call: A during return conflict windows

## First Portable Witness Mechanic

### Chosen Mechanic
Relay Lantern.

### Definition
Lune carries a sanctioned witness lantern between bell anchors so a route remains Held True long enough to cross.

### Why It Works
- immediately readable
- visibly active rather than passive
- easy to sync with music and route state
- strong enough to remain useful later while still being prototype-friendly

### Core Behavior
- the lantern forms a live relation tether to the last stable witness source
- if line-of-witness is preserved, the tether remains clean and the route holds
- if the tether is occluded or stretched too far, the route enters Thinning
- if the lantern catches a competing witness source, the route can resolve into Held Wrong instead of simply failing

### Player Skill Expression
- maintaining sightlines while moving quickly
- deciding when to retether versus push forward
- intentionally passing close to the wrong source to bend the route for a different outcome

## First Deliberate Misarrival Reward

### Chosen Reward
Frayed Bell Thread.

### What It Is
An optional route instrument obtained only if the player deliberately accepts a beautiful wrong crossing in the first slice.

### Benefit
- once per encounter, the player can stabilize a Thinning route for a brief extra beat by matching a damaged cadence
- this creates early mastery value instead of making the wrong route a pure story collectible

### Cost
- Common Vigil standing in the area becomes more suspicious
- at least one early scene with Iri or Sera reads Lune as less cleanly lawful

### Why This Reward Is Correct
- it proves Held Wrong is strategically useful
- it ties route experimentation to social consequence
- it rewards curiosity with real play value, not only text

## First Slice Loop

### Minute 0 To 2 | Cold Open Run
Lune is already in motion with a Relay Lantern active.

Goals:
- teach movement, focus, and carrying without stopping the game
- let the player feel stylish immediately
- let the score swell while the player is still in control

### Minute 2 To 5 | Sanctioned Baseline
The player crosses one safe Witness Bridge and one Sequence Road.

Goals:
- show what clean lawful witness feels and sounds like
- establish that correct crossings are satisfying, not only stressful

### Minute 5 To 8 | First Thinning Recovery
The lantern tether starts fraying across a blind ward.

Goals:
- teach Focus use under pressure
- teach retethering and short-term correction
- show that route loss is telegraphed

### Minute 8 To 12 | Carry Encounter
The player must relay the lantern across a chain of piers while quick-stepping through partial occlusion.

Goals:
- make Carry State feel like real labor
- prove the route system is fun before full narrative explanation

### Minute 12 To 15 | Wrong Light Temptation
A competing witness source answers from Nao's side of the space.

Player choice:
- stay lawful and arrive cleanly
- bend toward the wrong source and misarrive on purpose

### Minute 15 To 17 | Misarrival Pocket
If the player takes the wrong route, they reach a private ledge, hear a backcall trace, and obtain the Frayed Bell Thread.

Goals:
- reward daring with a real tool
- let Keeping feel intimate before it feels monstrous

### Minute 17 To 20 | Return Conflict Setpiece
The player rejoins the main route as Yun's split state begins.

Goals:
- make the opening sequence mechanically playable
- let Call appear as a limited high-stakes input
- ensure arrival state affects how the scene resolves

### Minute 20 Plus | Changed Revisit
The player moves back through a now-changed section of the Vigil Span.

Changes can include:
- stricter public witness
- different route permissions
- altered dialogue and suspicion
- an easier or harder optional mastery line depending on whether the player took the wrong route

## First Slice Success Test
- the player understands movement and Focus in under one minute
- the first Carry encounter feels good before the story fully lands
- the player can tell why Held Wrong is tempting
- the wrong route provides both a mechanical reward and a social cost
- the return setpiece feels like gameplay, not a disguised cutscene
- the music peak happens while the player is still responsible for keeping the route alive

## Next Prototype Decisions
1. Validate the starting numbers in `prototype-tuning.md` through hands-on playtest.
2. Script and phase Yun's first wrong-home event from `yun-first-wrong-home-setpiece.md`.
3. Build the minimal scene stack from `godot-prototype-structure.md`.
4. Tune the changed revisit so suspicion and wrong-route reward both matter immediately.