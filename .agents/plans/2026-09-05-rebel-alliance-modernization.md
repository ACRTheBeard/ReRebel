## Goal
Modernize Rebel Alliance as a PC / console remake that preserves the original gameplay feel with refreshed visuals and current tech, rebuilt clean-room from the playable game without original source.

## Success Criteria
- A playable PC build reproduces the core loop of the original (as captured from the playable game) with refreshed art, audio, input, and resolution support.
- Same-gameplay parity is demonstrable side-by-side against captured reference footage / notes for core mechanics.
- Project builds from a clean checkout with a documented export path for PC, with console targets scoped as a follow-up.
- No original binaries, ripped assets, or unclear-IP material ship in the remake.

## Context And Current Facts
- User goal: modernize a videogame called Rebel Alliance; user confirmed: have playable game but no source; goal is same gameplay with refreshed look and tech; target is PC / console.
- Starting point: fresh GitHub repo `ACRTheBeard/ReRebel` (empty at time of cloning, no commits). There is no existing code, spec, or asset to reuse.
- External lookup: web search for "Rebel Alliance videogame" returned only Star Wars-related results (e.g., Star Wars Rebellion / Rebel Assault), no distinct public game under that exact name to copy scope from. Scope must therefore be defined from the user's playable copy.
- Implication of no source: port / refactor is not possible; the viable path is observation-driven reimplementation (record, specify, rebuild, compare).

## Constraints And Non-goals
- Constraints: preserve gameplay feel; target PC first, console second; start from observation only, not from decompilation or asset ripping.
- Non-goals: no direct port of original binaries; no expanded sequel features in v1; no mobile or web targets in v1; no multiplayer / online services in v1 unless the original already has them and capture proves it.
- Legal constraint: original title, characters, music, and art must be treated as needing clearance or replacement until ownership is confirmed.

## Key Decisions
- Rebuild strategy: clean-room remake specified from captured gameplay, not binary reuse or decompilation. Reason: no source exists and binary reuse blocks refreshed tech and console distribution. Rejected: patching / wrapping the old binary, because it cannot deliver refreshed rendering, input, and maintainability.
- Scope control: v1 is parity + refresh only; new modes, levels, or systems are deferred. Reason: user chose same gameplay, and feature expansion without a reference multiplies design and validation cost.
- Default engine: Godot for the v1 PC rebuild, with final lock-in after gameplay capture and vertical slice. Reason: Godot documents an editor-to-export workflow for PC distribution including export presets and PC distribution notes, which fits a small-team parity remake starting from scratch ([source](https://docs.godotengine.org/en/stable/tutorials/export/exporting_projects.html)), and its introductory docs frame it as a general-purpose engine to learn via its editor and core concepts ([source](https://docs.godotengine.org/en/stable/getting_started/introduction/index.html)). Rejected for v1: naming no other engine now and adding engine bake-off later only if the vertical slice fails performance or console-path needs.
- Reference-first workflow: no production art / code scale-up until a written gameplay spec and reference pack exist. Reason: without source, the spec is the contract.

## Recommended Approach
1. Capture the truth: record full playthroughs, catalog mechanics, controls, screens, difficulty, audio cues, and timing from the playable copy.
2. Freeze a parity spec: one short design doc plus a reference pack (videos, screenshots, input maps, asset inventory marked keep / replace / recreate).
3. Prove the path: one small vertical slice in Godot (one representative scene or level + input + export to PC) following its documented export workflow.
4. Rebuild to parity behind feature flags, comparing regularly against reference captures.
5. Harden and release for PC; scope console targets only after PC parity passes.

## Work Plan
1. Reference capture pack: install / run playable copy, record videos, screenshot every screen, log inputs, timings, enemy / level / scoring rules. Dependency: access to playable copy. Output: `reference/` folder + gameplay inventory.
2. IP and asset triage: list title, names, art, audio, fonts; mark owned vs must-replace; decide working title policy and replacement art direction. Dependency: step 1.
3. Parity spec v0.1: core loop, controls, entities, rules, difficulty, UI flow, audio cues, out-of-scope list. Dependency: steps 1-2.
4. Tech bootstrap: new Godot project, repo layout, build / export preset for PC, placeholder content. Dependency: step 3 for slice choice. Validation target for engine lock-in.
5. Vertical slice: one playable slice with final-feel input and timing, exported PC build. Dependency: step 4. Go / no-go gate for full rebuild.
6. Full rebuild to parity: scenes, systems, UI, audio replacements, settings, saves, accessibility (remappable input, resolution, volume). Dependency: step 5 approval.
7. Polish and compatibility pass: performance budget, controller support, crash / edge handling, packaging. Dependency: step 6.
8. Console scoping (follow-up): requirements, certification impact, and port plan only after PC parity. Dependency: step 7.

## Validation Plan
- Reference completeness check (manual): every mechanic in the inventory has video + written rule; missing entries block spec sign-off.
- Spec review (manual): side-by-side play of original vs spec description by someone who knows the original; mismatches return to capture.
- Vertical-slice gate (manual + build): fresh-checkout PC export via the documented Godot export menu / preset flow produces a runnable build; slice timing and input feel judged against reference video. Highest-risk validation: this gate, because it locks engine and feel before scale-up.
- Parity checks per system (manual): scripted playthrough checklist per build; any deviation from spec is a bug.
- Release candidate check (manual): clean-machine install, full playthrough, controller + keyboard, windowed / fullscreen, min-spec performance, save / load, no placeholder or ripped assets.

## Risks / Rollback
- Feel drift without source: mitigated by reference videos and timing logs; rollback is to re-capture and tighten spec, not to patch code blindly.
- IP / asset risk from recreating a game with a similar name and content: mitigated by early triage and replacement assets; do not ship extracted originals.
- Scope creep into remake-plus-features: mitigated by parity-spec freeze and deferred list.
- Console certification underestimated: mitigated by keeping console as a scoped follow-up after PC ships; no rollback needed because PC remains shippable.
- Engine lock-in wrong: mitigated by small vertical slice as the last cheap exit before full rebuild.

## Open Questions
- What genre, perspective, and approximate length is the original (levels, enemies, systems) so the slice can be sized?
- Can you share 10-20 minutes of unedited gameplay video plus the full input map to seed the reference pack?
- Who owns the Rebel Alliance name, code rights, art, and music, and what replacement direction is acceptable?
- What minimum PC spec and which console family matter first after PC?

## Sources
- [Godot introduction](https://docs.godotengine.org/en/stable/getting_started/introduction/index.html)
- [Godot exporting projects](https://docs.godotengine.org/en/stable/tutorials/export/exporting_projects.html)
