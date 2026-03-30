# Prototype Tuning

## Purpose
Set the first playable's starting values tightly enough to prototype, test, and tune without arguing from abstraction.

These values are not sacred. They are the first playable baseline.

## Tuning Philosophy
- readability over simulation
- correction over punishment
- speed with legibility
- fail-forward over instant reset
- deterministic feedback over random disruption

The player should feel pressured, not cheated.

## Movement Baseline

### Run Speed
- 280 px/s base

Why:
- fast enough to feel stylish
- slow enough for witness language to remain readable in an oblique 2D view

### Carry Speed
- 236 px/s while actively carrying the Relay Lantern or escorting a bound target

Why:
- visibly heavier than free movement
- not so slow that Carry feels like a punishment state

### Focus Speed
- 218 px/s while Focus is held

Why:
- enough slowdown to sell tension sharpening
- not enough slowdown to feel like pseudo-turn-based play

### Carry And Focus Combined
- 190 px/s

Why:
- this should feel strained and deliberate
- the player should want to use Focus in bursts rather than camp inside it forever

## Quick-Step Baseline

### Free State
- distance: 84 px
- duration: 0.15 s
- cooldown: 0.60 s
- invulnerability: none

### Carry State
- distance: 60 px
- duration: 0.17 s
- cooldown: 0.75 s
- invulnerability: none

### Rule
Quick-Step is a correction tool, not a dodge-roll identity mechanic.

It should:
- rescue a bad line
- clear a brief sight gap
- catch a falling route window

It should not:
- let the player brute-force hostile witness
- replace route reading with reflex spam

## Focus Baseline

### Entry And Exit
- enter clarity ramp: 0.08 s
- exit clarity decay: 0.05 s

### Readability Effects
- witness lines brighten by one full readability tier
- bell rhythm isolation rises immediately
- wrong-source harmonic offset becomes clearly audible
- body distortion becomes easier to parse at the silhouette edge

### Rule
Focus should be used often and briefly.

If players hold Focus for more than about 60 percent of a slice, it is too safe.
If players almost never use it outside tutorial prompts, it is too weak.

## Relay Lantern Baseline

### Tether Rules
- clean tether range: 224 px
- soft warning threshold: 196 px
- thinning from full occlusion begins after 0.30 s
- full Lost from uninterrupted occlusion occurs at 1.20 s
- wrong-source capture begins after 0.45 s inside an active false witness field

### Retether Rules
- anchor retether time: 0.18 s hold
- moving out early preserves no benefit

### Design Rule
The player should usually feel one clean correction opportunity before the route fully collapses.

## Thinning And Held Wrong Baseline

### Thinning Grace
- standard grace window: 1.25 s
- severe blind ward grace window: 0.90 s

### Held Wrong Lock-In
- if a false source remains stronger than the lawful source for 0.45 s, the crossing resolves as Held Wrong

### Rule
Held Wrong should feel tempting because it stabilizes differently, not because it simply fails more slowly.

## Split Recovery Baseline

### Base Duration
- 2.40 s

### Immediate Penalty Window
- first 0.65 s: Quick-Step unavailable

### Ongoing Penalties
- Focus only restores 70 percent of normal cue clarity
- answer timing windows shrink by about 0.15 s
- the player silhouette remains offset, reducing safe witness margin by roughly 15 percent

### Recovery Conditions
Any of these end Split Recovery early:
- reach a lawful hold point
- place a Knot successfully
- receive a successful lawful Call

### Rule
Split Recovery must feel scary and specific, but still readable. It should never randomize the player's controls.

## Frayed Bell Thread Baseline

### Use Limit
- once per encounter

### Effect
- extends a Thinning grace window by 0.75 s
- immediately clarifies damaged bell cadence while active

### Cost Expression
- no HP-style cost
- social cost appears through suspicion, dialogue tone, and route restriction in the changed revisit

## First Slice Timing Targets
- first movement input within 3 s
- first successful safe crossing within 45 s
- first meaningful Focus correction by minute 6
- first Carry-pressure sequence by minute 8
- first wrong-route temptation by minute 12
- first consequence-bearing setpiece by minute 20

## First Playtest Thresholds

### Keep As-Is If
- most new players understand Focus without a text explanation
- most new players fail the first Thinning sequence no more than once
- at least some players intentionally choose the wrong route on a second attempt

### Ease If
- more than one third of new players fail the first Carry sequence three times in a row
- players confuse Held Wrong with Lost during post-test explanation
- players stop using Quick-Step because cooldown feels too punitive

### Tighten If
- players brute-force crossings while ignoring Focus
- players hold the Relay Lantern with no meaningful tension
- players treat wrong-route capture as a free shortcut with no fear

## Design Rule
If tuning changes make the slice smoother but less legible, reject them.