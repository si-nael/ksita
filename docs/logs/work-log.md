# Work Log

## 2026-03-30

### Completed
- Defined a documentation structure for plans and logs.
- Established the initial emotional and mechanical direction for the game.
- Scoped a first vertical slice focused on proving the rewrite mechanic.
- Reframed the project to center a distinctive city-scale world whose infrastructure runs on filed memory.
- Added explicit originality guardrails and world-versus-character design priorities.
- Pivoted the project again toward mythic fantasy centered on true names, sacred law, and the Pale Tide.
- Added explicit twisted-relationship rules and a documented quality bar against cliche.
- Added five world-setting candidates so the project can choose a foundation before returning to story work.
- Marked the current draft world as provisional instead of treating it as locked.
- Locked a new selected world: the Hollow, a void with physics independent of time.
- Chose a non-terrestrial representative place: the Sea Beneath the Last Stair.
- Rebuilt the planning docs around world-first design and paused the older story-bound slice plan.
- Defined baseline traversal for the Hollow: distance is relational, routes are qualified, and travel failure can cause misarrival, collapse, split passage, or drift.
- Chose Witness as the dominant authority for the first prototype area and defined the Vigil Span as its baseline space.
- Defined witness feedback rules: diegetic-first readability, four witness states, and a no-permanent-meter policy.
- Defined the Common Vigil as the Hollow's witness-regulating institution and tied it to travel, legality, civic personhood, and exile.
- Added a subculture-facing tone direction and a character-appeal framework so the world reads as more magnetic and character-driven.
- Reframed the Common Vigil and core planning language to reduce social-commentary drift and strengthen role/faction appeal.
- Defined Sequence as a Five-Turn ritual relay with character-facing roles such as Bell Veils, Lantern Runners, Return Singers, and Last Lookers.
- Defined illegal witness as Keeping, including Backcall, Pair Knot, Shadow Share, False Halo, and Afterkeep.
- Defined death and disanchoring as a ladder from Marked to Unkept.
- Locked witness as both local traversal state and broader standing.
- Chose Returning as the first major character-conflict Turn.
- Built the first five-role character cluster around Returning and Keeping.
- Built the first named cast seed set: Iri, Nao, Yun, Lune, and Sera.
- Locked the visual direction as 2D-first and non-photoreal.
- Defined the Keeping scene's style split and internal currents.
- Chose Lune as the first POV anchor and defined the first arc as seductive-tragic.
- Wrote the first opening-sequence direction around Carrying, Returning, and the first wrong-home split.
- Locked the playtime policy: aim for roughly 20 to 30 hours on first clear and 60 to 80 hours for completionist play without padding the main route.
- Locked an anti-visual-novel gameplay rule set and restarted the vertical-slice plan around active route reading, risky traversal, and consequence-bearing failure.
- Wrote the first full game-systems architecture and made immediate hands-on fun a non-negotiable design filter.
- Translated the user's favorite reference feelings into Hollow-specific emotional targets instead of treating those works as structures to imitate.
- Chose the first control format: real-time oblique action with Focus, Relay Lantern carrying, deliberate misarrival reward, and a 20-minute slice flow.
- Wrote the first prototype-ready spec: starting tuning values, a fully playable Yun wrong-home setpiece, and a Godot scene breakdown for the slice.
- Built the first Godot implementation scaffold: project file, core scenes, state and route scripts, first slice world scene, and a playable wrong-home phase controller skeleton.
- Validated the newly created `.gd` and `.tscn` files with the editor diagnostics; no file-level errors were reported.
- Could not launch the project from the shell because no Godot executable is currently available in PATH.
- Validated the project against the user-provided Godot 4.6.1 executable; headless editor load completed successfully and the main scene could be started headlessly without immediate reported runtime errors.
- Fixed obvious first-use problems after user feedback: the player now starts with a live camera, the scene has visible landing shapes, controls are shown on screen, and Q/E/F actions produce persistent readable feedback instead of appearing to do nothing.
- Locked the project to a pure 2D early-production lane instead of leaving 2.5D or 3D as an open implementation temptation.
- Replaced the player-follow camera with a fixed slice camera and clamped movement to authored route lanes so the prototype stops feeling like an unframed sandbox.
- Implemented the changed revisit as three distinct return states: lawful is the easiest public walk back, wrong home now requires refreshing a Wrong Light echo before crossing the ward, and broken middle now forces an in-ward Knot to restitch the center long enough to pass.
- Revalidated the updated slice in Godot 4.6.1 headless editor mode; no new scene or script load errors were reported.
- Added dynamic world guidance instead of more camera tricks: the route glow now rewrites itself to the current goal, target labels pulse in-world, and revisit branches visually point to Start, Wrong Light, or the center fracture.
- Tuned failure readability during revisit by giving each outcome its own route-loss grace window and its own reset explanation, so failure teaches the branch rule instead of looking like a generic reset.
- Added a root `.gitignore` for `.godot/` and `*.import`, then verified through Git status that generated editor artifacts are being ignored.

### Next
- Tune Focus, Quick-Step, and Split Recovery into prototype-safe values.
- Tune the three changed-revisit branches so each one is readable on the first attempt and recoverable on failure.
- Turn the Godot scene breakdown into an actual folder and scene creation order when implementation starts.
- Launch and iterate the prototype once a Godot executable is available in the environment.
- Turn the first arc into a reusable 3-to-4-hour chapter template that can scale without filler.
- Turn the five cast seeds into bond maps and scene-specific secrets.
- Lock the first gameplay scene breakdown from Lune's POV.
- Decide what hostile witness looks like in the first arc.