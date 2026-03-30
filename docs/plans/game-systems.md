# Game Systems

## Purpose
Turn the Hollow from a strong setting into a genuinely fun game with its own mechanical identity.

## Genre Position
- Real-time relational route-action adventure.
- District-based progression with revisits, mastery routes, and consequence-bearing narrative states.
- Not a visual novel with movement.
- Not a conventional combat RPG with Hollow terminology laid on top.
- Not a pure puzzle game where story and play can be separated cleanly.

## Fun Promise
The game should feel fun because the player is constantly doing risky, stylish, high-consequence things:

- reading whether the world is holding them correctly
- carrying unstable truth across impossible space
- choosing between safe lawful routes and tempting wrong ones
- reaching places they should not reach by exploiting false success
- dealing with the social and emotional damage their route choices caused
- returning to old spaces with new techniques and seeing them play differently

If the game is only impressive when explained, the systems are failing.

## Music And Catharsis Integration
Music should not decorate the action from outside. It should reinforce the route state the player is actively holding or losing.

### Required Rules
- major emotional peaks should preserve player agency during the musical swell
- route truth should influence musical behavior so correct, thinning, wrong, and lost states feel different in the hands as well as in the ears
- the score should track role, bond, and witness condition, not only location
- the first slice must prove that one crossing can feel emotionally large before the player fully understands the setting

### Chapter Climax Rule
At least one chapter-defining climax should feel playable at peak intensity rather than handing the emotional high point to a non-interactive cutscene.

Prototype control and slice decisions are defined in `control-and-slice.md`.
Starter tuning values and prototype scene layout are defined in `prototype-tuning.md` and `godot-prototype-structure.md`.

## Core Loop

### 1. Read
The player identifies what currently governs passage.

Questions the player should ask:
- what is holding this route true right now?
- is this path Held True, Thinning, Held Wrong, or Lost?
- who wants me to arrive, and where do they want me to arrive as?

### 2. Prepare
The player commits to a route plan.

This can include:
- choosing a sanctioned or illegal method
- selecting a route instrument or relation token
- deciding whether to risk misarrival for speed, secrecy, or access
- choosing which person, institution, or household to rely on

### 3. Cross
The player performs the route in motion.

This is the core fun layer. Crossing should feel active and tense rather than automatic.

### 4. Resolve
Arrival produces a real state.

Possible results:
- correct arrival
- wrong arrival
- split arrival
- marked but usable arrival
- drift exposure
- altered standing with the Common Vigil, a household, or a kept bond

### 5. Revisit
The world remembers how the player crossed.

Spaces, routes, and people should respond differently on return.

## Loop Tiers

### 5 To 20 Seconds | Crossing Beat
Read a route, commit, and preserve truth long enough to reach the next hold point.

### 1 To 5 Minutes | Encounter
Solve a route problem, a hostile witness problem, a rescue problem, or a wrong-home problem.

### 15 To 40 Minutes | District Sweep
Open safe routes, exploit risky ones, rescue or return key people, and alter who can hold the area true.

### 3 To 4 Hours | Chapter
Learn one new authority or one new way to abuse an existing authority, then revisit earlier assumptions through it.

### 20 To 30 Hours | First Clear
Layer route authorities, relationships, and major consequence states until the player can intentionally bend the Hollow instead of just surviving it.

## Primary Player Verbs
- read
- face
- carry
- answer
- knot
- cut
- call
- misarrive
- return

These should matter more than menu choices.

## Core Systems Architecture

### 1. Route State System
Every traversable path belongs to one or more route authorities.

Current authority order for the game:
1. Witness
2. Naming
3. Weight
4. Claim
5. Orientation

Every route also has a local truth state:
- Held True
- Thinning
- Held Wrong
- Lost

The player reads this through environment, sound, body distortion, and route behavior.

### 2. Crossing Control System
Crossing is not ordinary locomotion. It is maintained passage.

The player's active route actions should include:

#### Face
Present the self correctly to the current route authority.

Examples:
- stay inside a tower's line of witness
- align to the correct bell phrase
- approach under the right answer-name

#### Carry
Transport an active relation across unstable space.

Examples:
- relay witness lantern light between piers
- move with a burden that keeps a route near
- keep a called name live through a blind ward

#### Answer
Declare who the world should treat the player as for a short interval.

Examples:
- answer as courier, guest, kin, accused, or returned
- trigger different route responses at doors, bells, households, or shrines

#### Knot
Create a temporary local truth.

Examples:
- bind a room, ledge, bell frame, or pier segment long enough to cross
- leave a short-term anchor for a later recovery
- tie a rescue target into a stable relation for extraction

#### Cut
Intentionally sever a safe public relation.

Examples:
- break sanctioned witness to access a wrong route
- detach from a lawful arrival to avoid being claimed
- deny a hostile call before it resolves

#### Call
Force or answer a return event.

Examples:
- answer a lawful return to stabilize
- use a backcall to reach forbidden space
- choose which call wins when two homes conflict

### 3. Route Instruments And Loadout
The player should not level up through raw stats. The player should build a route kit.

Recommended slot model:
- one witness instrument
- one relation seal
- one knot or recovery tool
- one carried burden, token, or charm

Early examples:

#### Witness Lantern
Portable sanctioned witness. Strong, readable, public, and limited by line-of-sight.

Prototype-first version:
Relay Lantern.

#### Bell Thread
Lets the player restore or maintain cadence during Thinning crossings.

#### Answer Seal
Briefly asserts a held role or name to change how a route reads the player.

#### Knot Cord
Creates a temporary anchor or local checkpoint state that can also be abused for rescue, escape, or illegal hold.

Later chapters should add darker or riskier equivalents through Keeping, stolen halos, weight tokens, or wrong-home instruments.

### 4. Encounter Types
The game needs several repeatable encounter shapes so the campaign stays fun rather than merely novel.

#### Crossing Encounter
The player gets through a route while preserving or manipulating its truth.

#### Hostile Witness Encounter
An observer, tower, saint, or route-creature is holding the path in a damaging way. The player must blind, redirect, outrun, or misdeliver it.

#### Return Encounter
Two valid or half-valid homes conflict. The player must decide who gets called back, who gets left exposed, and what type of wrongness they are willing to allow.

#### Rescue Encounter
Someone is Marked, Split, Thinning, or drifting. The player must bind, carry, or return them before they become unusable.

#### Knot Breach Encounter
The player infiltrates or escapes a privately held space where ordinary public rules no longer apply.

#### Revisit Encounter
The player returns to a familiar area whose routes, permissions, and emotional geometry changed because of earlier actions.

### 5. Confrontation Model
The Hollow should not default to weapon combat as its identity.

Conflict should usually be won by:
- breaking line-of-witness
- forcing wrong recognition
- severing a claim
- making an enemy misarrive
- out-carrying a collapse
- choosing which truth to preserve under pressure

There can still be direct danger, pursuit, and impact. But the primary question should not be how fast the player drains HP. It should be whose relation holds.

### 6. State And Consequence Model
The game should run on layered state rather than a single morality meter.

#### Body Coherence
- Whole
- Marked
- Thinning
- Split
- Drift-Exposed
- Last Held

#### Public Standing
- Recognized
- Questioned
- Restricted
- Turned Away

#### Private Entanglement
- Unbound
- Marked By Keeping
- Kept
- Pair-Drifting

These should mostly appear through access, route response, scene response, and visible signs rather than giant HUD bars.

### 7. Fail-Forward Model
Failure should usually cost state, access, or relationship safety rather than only time.

Preferred fail states:
- misarrival to a dangerous but playable space
- social suspicion or route restriction
- partial Split requiring recovery
- rescue target worsening because of delay
- wrong-home consequence that changes later scenes
- district state changing because the player crossed badly

Hard reset should be the exception, used mainly for full drift loss, fatal hostile collapse, or deliberate retry.

### 8. Progression Model
Progression should come from fluency, tools, permission, and bonds rather than damage numbers.

Main progression axes:

#### Authority Fluency
Each major arc teaches a new route authority or a deeper abuse of one already known.

#### Role Licenses
The player earns access to higher-risk civic or illicit techniques associated with Hollow roles such as Lantern Runner, Knotkeeper, Return Singer, or Halo Thief.

#### Bond Techniques
Major character relationships should alter play.

Examples:
- a public ally stabilizes lawful routes
- a private keeper opens wrong-home shortcuts
- a split person creates unstable but valuable alternate paths
- a cold institution figure gives harsh but reliable corrections

Characters should change the world mechanically, not only narratively.

#### District Memory
Revisits should unlock because the player now understands how to read or abuse the district's route law differently.

### 9. Chapter Structure Rule
Each chapter should introduce one new play idea and remix at least two old ones.

Good chapter rhythm:
1. teach a new route behavior safely
2. stress it under pressure
3. tempt the player with an illegal or wrong version
4. force a consequence-bearing use
5. revisit an old space through the new logic

### 10. Completionist Structure
The 60-to-80-hour target should come from:
- mastery routes
- alternate arrival states
- optional relationship paths with mechanical differences
- achievement-linked challenge rules
- revisits that play differently because of late-game authority fluency
- endings shaped by route behavior and standing, not only dialogue flags

## Fun-First Rules
- Every chapter must contain at least one crossing that feels good even if the player skips the cutscenes.
- Every major mechanic must be enjoyable within about 30 seconds of hands-on use.
- Originality on paper is worthless if the action feels flat in motion.
- If a mechanic only becomes interesting after explanation, simplify or rebuild it.
- If a route problem can be solved while ignoring the route language, the encounter is underdesigned.
- If the biggest emotional payoff of a mechanic happens only after control is removed, the mechanic is underperforming.

## First Slice System Target
The first playable slice should prove these things at once:
- crossing a witness route is tense and stylish
- Thinning can be stabilized through player action
- Held Wrong can be used deliberately for gain
- one failure result changes the area instead of forcing a reload
- one character or institution reacts to a mechanical arrival state
- replaying the slice with better understanding produces a meaningfully different run

## Design Rule
If the game sounds more fun in a lore summary than it feels under the player's hands, rebuild the systems before expanding the story.