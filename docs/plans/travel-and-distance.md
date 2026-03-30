# Travel And Distance

Status: baseline locked for worldbuilding and prototype planning. Fine detail can change later, but the core rule should remain stable.

## Core Rule
Distance in the Hollow is relational, not metric.

Two places are near when the laws binding them currently agree that they are near. Two places are far when those laws do not. A traveler does not cross distance by spending time moving through it. A traveler crosses distance by establishing or maintaining the right relation.

## Travel Thesis
Walking still matters, but footsteps alone do not guarantee arrival.

The player should feel that movement is a negotiation with reality. To go somewhere, you must satisfy the route's law. If the law changes, the route changes even if the visible geometry looks the same.

## The Five Route Authorities

### 1. Witness
A path may open only if the traveler is being correctly observed, remembered, or acknowledged by the place itself.

Example:
A bridge remains crossable only while both towers at its ends are actively naming the traveler in matching bells.

### 2. Claim
A route may exist because a person, house, shrine, institution, oath, or grief currently has rightful authority over both ends.

Example:
A sealed stair becomes traversable only to those carrying a burial claim tied to the chamber below.

### 3. Weight
Routes bend according to burden. This includes literal mass, but also debt, mourning, vow-pressure, hunger, and obligation.

Example:
A causeway sinks toward whoever bears the heavier unresolved grief.

### 4. Naming
Some destinations are reachable only if the traveler can be recognized under the correct name, title, relation, or role.

Example:
A gate may open for "daughter," refuse "stranger," and wound anyone traveling under a false title.

### 5. Orientation
Above, below, inward, outward, before, and after are situational rather than absolute. A path can require a specific orientation relation to a place rather than a compass heading.

Example:
To reach a shrine, the traveler must approach from the side where the shrine still considers them "awaited," even if that direction appears physically upside down.

## Distance States

### Held Near
Places are stably near because their relation is continuously maintained by ritual, institution, or architecture.

Playable meaning:
Reliable routes inside settlements. These are the closest thing to ordinary roads.

### Remembered Near
Places are near because of mutual memory, habit, or repeated traversal.

Playable meaning:
Shortcut routes that open only if the traveler has already formed a relationship with both ends.

### Claimed Near
Places become near because some authority currently binds them.

Playable meaning:
Restricted routes opened by carrying a token, permission, oath, corpse-mark, marriage cord, or witness seal.

### Weighted Near
Places become near because the traveler or location carries enough burden to drag them together.

Playable meaning:
Dangerous routes that open under stress, grief, fear, or ritual load.

### Severed Far
Places can be visibly close while functionally unreachable because no valid relation joins them.

Playable meaning:
A ledge ten steps away may be farther than a tower suspended across the void.

## Player-Facing Travel Loop

### 1. Read
Identify which route authority currently matters.

Signals can include:
- bell patterns
- witness marks
- shifting inscriptions
- weight tilt in the environment
- name echoes or role responses

### 2. Qualify
Gain the relation needed to travel.

This may require:
- carrying the right token
- being named correctly
- entering under a vow
- increasing or shedding burden
- securing a witness

### 3. Cross
Traverse while preserving the route's condition.

Examples:
- stay within a bell cadence
- remain in line of witness
- do not drop the carried weight
- do not answer to the wrong name
- keep two linked objects in balance

### 4. Arrive Or Break
If the relation holds, arrival resolves immediately. If it breaks, the traveler is rerouted, suspended, split from the path, or deposited into a less stable relation-zone.

## Playable Route Types

### Sequence Roads
The safest routes, maintained by repetitive public ritual. These feel closest to roads but can still fail if Sequence collapses.

### Witness Bridges
Temporary paths sustained only while active observers or place-eyes acknowledge the traveler.

### Claim Stairs
Routes opened by legal, familial, funerary, or institutional authority.

### Weight Currents
Flowing routes through void or hanging seas that pull travelers according to burden.

### Name Doors
Passages that care less about body and more about who the world currently accepts you to be.

## First Prototype Authority

### Selected Authority
Witness.

### Why Witness Comes First
- it is the clearest first proof that relation has physical authority
- it is readable in motion through sightlines, bells, lanterns, and observer states
- it makes the player's stability depend on being held in the world by others, which expresses the Hollow's emotional premise directly
- it is easier to prototype cleanly than claim, weight, naming, or orientation while still feeling strange

Detailed readability rules for Witness travel are defined in `witness-feedback.md`.
The institution that governs public witness is defined in `witness-institution.md`.

### Prototype Area Concept
The Vigil Span.

The Vigil Span is a chain of suspended landings, hollow piers, bell frames, and gaze-towers hanging below the Sea Beneath the Last Stair. The visible geometry looks almost stable, but most of its bridges exist only while the traveler is being correctly witnessed from paired observation points.

When witness aligns, the route holds. When witness breaks, the bridge does not necessarily shatter. It becomes relationally false. The traveler may stop arriving where they appear to be going.

### Core Prototype Rule
The dominant movement question in the first area is not "Where is the path?" but "Who or what is holding this path true for me right now?"

### Prototype-Specific Route Behaviors
- paired bell-eyes must agree on the traveler for certain bridges to remain near
- some paths open only while a witness lantern is actively naming the traveler
- blind zones do not always block movement; they reroute it toward whatever relation currently claims the traveler most strongly
- hostile or damaged witnesses can hold a route open in the wrong way, causing misarrival instead of simple failure
- sanctioned Vigil routes should feel safer and more legible than private or hostile witness routes

### What The Prototype Must Teach
- being seen is a physical condition, not just narrative atmosphere
- settlements survive because public witness is organized and maintained
- solitude and broken recognition are traversal dangers, not only emotional themes
- players can distinguish weak witness, false witness, and lost witness before punishment lands

### Secondary Authorities In The First Area
Witness should dominate, but two secondary authorities should appear lightly so the system does not feel one-note:

- Sequence Road for baseline settlement coherence
- one Name Door or Weight Current as a contrast case

## Failure States During Travel

### Route Collapse
The path no longer recognizes the current relation and simply ceases to connect.

### Misarrival
The traveler arrives at the place that matches their actual relation rather than their intended destination.

### Split Passage
Part of the traveler reaches the destination while some anchored trait, memory, or wound remains behind.

### Drift
The traveler is caught in unclaimed void and begins losing singularity until re-anchored by witness or claim.

## Rules For Settlements
- Stable settlements must maintain public Sequence Roads at all times.
- Important buildings should visibly advertise what kind of travel law governs access.
- Ports, shrines, courts, and burial sites should specialize in different route authorities.
- Social status should affect mobility because claim and naming affect access directly.

## Rules For Level Design
- Every level should contain at least one visibly impossible but rule-coherent route.
- Shortest-looking path should not always be the nearest playable path.
- Route logic should be legible enough to learn, but strange enough to stay memorable.
- Traversal puzzles should be about relation, not generic lock-and-key design with surreal art on top.

## Prototype Baseline
The first playable prototype should include these three route types:

1. one stable Sequence Road
2. multiple Witness Bridges as the dominant traversal challenge
3. one Name Door or Weight Current

This is enough to prove whether Hollow traversal feels mechanically unique.

## Design Rule
If a travel segment can be described using ordinary platformer, dungeon, or overworld logic without mentioning relation, it is not yet Hollow travel.