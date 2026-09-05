# Reference Capture Pack

Source of truth for the clean-room rebuild. Everything in the parity spec
must trace back to material in this folder — no guessing from memory.

## Layout

- `videos/` — full playthrough recordings (unedited preferred).
- `screenshots/` — one shot per distinct screen/state (title, menus, HUD,
  pause, game over, each level/scene type).
- `sessions/` — dated notes per capture session (use `_template.md`).
- `gameplay-inventory.md` — the mechanics catalog (the main deliverable).
- `input-map.md` — every input and what it does in every game state.

## Capture checklist (per session)

- [ ] Record unedited video with game audio (target 10–20 min per session).
- [ ] Screenshot every distinct screen, including transitions and edge states.
- [ ] Log every button/key press and its on-screen effect, per game state.
- [ ] Time the feel numbers: movement speed, attack cooldowns, enemy spawn
      intervals, timers, transition durations.
- [ ] Note enemy / level / scoring rules as observed (counts, patterns,
      thresholds) — describe behavior, never extract assets.
- [ ] Write up `sessions/YYYY-MM-DD-session-NN.md` before the details fade.

## Naming

- Videos: `YYYY-MM-DD-session-NN-description.mp4`
- Screenshots: `YYYY-MM-DD-screen-name.png`
- Large binaries stay local-only; never commit videos to git. Commit the
  notes, inventory, input map, and screenshots (small files only).

## Rules

- Observation only: no decompiling, no ripping art/audio/fonts from the
  playable copy. Screenshots and recordings are reference, not ship assets.
- Every inventory claim needs a pointer to the video timestamp or screenshot
  that proves it. Unproven entries stay in `sessions/`, not the inventory.

## Sign-off gate (blocks the parity spec)

Step 1 is done when ALL of these hold — not before:

- [ ] Every mechanic in `gameplay-inventory.md` has BOTH a video timestamp
      and a written rule. Any mechanic missing either blocks spec sign-off.
- [ ] `input-map.md` covers every game state (gameplay, menus, pause,
      game over) with no empty cells marked "unknown".
- [ ] `screenshots/` holds every distinct screen/state; `videos/` holds at
      least one full unedited playthrough with game audio.
- [ ] No videos committed to git (notes, inventory, input map, and small
      screenshots only).
- [ ] Someone who knows the original has reviewed the inventory against
      the playable copy; mismatches return to capture, not to code.
