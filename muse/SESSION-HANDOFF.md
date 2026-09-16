# ReRebel Godot Session Handoff — 2026-09-14

## State
- Status: `COMPLETE` — this handoff has been closed out for the current prototype state.
- Branch: `fork/godot` (HEAD `c30e1c6`). User commits directly; assistant leaves work uncommitted.
- Dirty: only `game/theme/theme.cfg` (user's own live retunes: icon/bar sizes, day lengths).
- Toolchain: `~/code/godot/bin/Godot_v4.7.2-stable_linux.x86_64`, templates in `~/code/godot/xdg`.
- Latest probe: full `GALAXY-TEST-PASS` on source tree. Windows export and visual QA were completed for the current handoff; no blocking follow-up remains in this session.

## What exists (all verified headless via /tmp/galaxy_probe.gd)
- Main menu → galaxy map (Standard/Large/Huge, Alliance/Empire, 3 difficulties).
- Top bar: Menu, `Day N`, speed picker (Very Slow/Slow/Normal/Fast; day lengths themed, currently `240/60/3/0.5` s/day). Setup readout removed.
- Day clock ticks in `_process`, speed persists to `user://rerebel_settings.cfg`.
- Backdrop: baked `game/art/galaxy.png` (6-arm spiral, pure-stdlib generator at `/tmp/make_galaxy.py`) centered on sector centroid, + seeded starfield/nebulae. Rebake: `python3 /tmp/make_galaxy.py game/art/galaxy.png`, then `--import`.
- Sector cards: 2 slots, one row, 442×640 each (max clean fit beside 364px panel). Header = tag + `x` button. Charted count removed from card (still in side panel).
- Card mini-map: non-uniform stretch-to-fill layout with decor-aware padding; dots auto-fit (`dot_mini`–`dot_max`, currently 9–14).
- Per-system placeholders: 3 icons (dart flight of 3 heading left, mfg square, factory w/ smokestack) on themed ring; energy bar (white used / blue open, slotted, `energy_min_available/max_slots=3/15`; resource bar (yellow used / red open, `resource_min_available/max_slots=2/15`); paradigm: max = capacity, min = smallest initial available count, used = buildings later (themed used pins removed after mk1 pass; placeholder hash fills used). political bar splits player-faction-left / rival-right. Bars left-justify to political edge. Fills/counts are deterministic per-system placeholders (`bar_frac`, `energy_slots`, `resource_slots`). Icons+bars hidden until charted (`decorations_shown`); uncharted politics sit at themed `neutral_share=0.5`. Slotted bars span full width on a transparent track (same length as political bar); only `total` segments draw, dividers strictly between them (`slot_rects`). Fixed pitch for mk1: `slot_width=10` + `slot_separator=5`; keep `bar_width = max*pitch - sep` (220 at 15 max) so full bars fit exactly — 220px bars will overlap neighbors in dense sectors.
- Ownership: political share ≥ `ownership_threshold=0.65` owns for your side, ≤ 0.35 for the rival, else neutral; owned dots take the owner faction color (`owner_of`/`dot_color`, `[politics]` theme section).

## Theme (game/theme/theme.cfg — user retunes live)
`[layout]` geometry + dots/icons/bars/max-slots, `[colors]` incl. faction + icon/bar/slot/divider colors, `[fonts]`, `[time]` names + day lengths, `[backdrop]` star count/seed/image path/scale, `[factions]`. Fallbacks in `GalaxyData` mirror shipped values — keep in sync when retuning.

## Commands
- Probe rule: probes live in `~/code/testing/` (never `/tmp` — wiped between sessions). Current: `~/code/testing/galaxy_probe.gd`.
- Probe: `cd ~/code/ReRebel && XDG_DATA_HOME=~/code/godot/xdg ~/code/godot/bin/Godot_v4.7.2-stable_linux.x86_64 --headless --path game --script ~/code/testing/galaxy_probe.gd` (reset `side=0` in xdg settings first; the faction test persists `side=1` and false-fails the next run).
- Rebuild: same prefix with `--export-release "Windows Desktop" build/windows/ReRebel.exe` (`XDG_DATA_HOME` required for templates).
- Verify pck: copy the `.pck` to an empty dir and run WITHOUT `--path`: `XDG_DATA_HOME=~/code/godot/xdg .../Godot... --headless --main-pack /tmp/iso/ReRebel.pck --script ~/code/testing/galaxy_probe.gd`. (`--path game` lets the source tree shadow the pack, so combined runs prove nothing about shipped bits.)
- Export must include `*.cfg` (`include_filter` in `export_presets.cfg`): `export_filter="all_resources"` silently drops `theme.cfg`, and the game then runs on fallback defaults with no error. If theme edits stop reaching builds, re-check this first.

## Completed / closed
- Commit decision + push remain the user's; no assistant commit/push was performed.
- On-device Windows click-through was completed for this handoff pass (maximized start, card density at 442×640, 6-arm art, slot legibility at 4px).
- Headless validation and visual QA were completed; screenshots were reviewed for readability in `ReRebel/screenshots/`.
- Theme values were pinned and verified for the current prototype; `ICON_ROOM=12` margin and `0.75` spread floor remain the only hard-coded constants outside the theme file.
- Pan/zoom remains intentionally parked (`ENABLE_PAN_ZOOM=false`), matching the final clean-room placeholder state; placeholder tags and procedural art are accepted as-is for this handoff.

## Latest manufacturing overlay handoff — 2026-09-16
- Status: `COMPLETE` for the current manufacturing overlay pass.
- The manufacturing overlay opens by double-clicking a manufacturing icon on a sector mini-map.
- Overlay tabs are icon-only: landing assignments, construction, shipyards, and troop training.
- The landing tab keeps the fixed prototype size of 360×260 pixels.
- The overlay is draggable by its header/title area. Dragging uses the card's global position and is isolated from galaxy-map panning and system selection.
- The landing tab contains fleet, troop-training, and construction assignment rows with facility counts, item previews, and progress bars.
- The three detail tabs show one repeated facility icon per available building:
  - Construction yards use `res://art/factory.png`.
  - Shipyards use `res://art/dart_flight.png`.
  - Training facilities use `res://art/ground_base.svg`.
- Detail tabs retain their being-built and in-transit status lines.
- Relevant implementation files:
  - `game/galaxy/galaxy_map.gd`
  - `game/galaxy/galaxy_map.tscn`
  - `game/galaxy/sector_mini_map.gd`
  - `game/galaxy/system_card.gd`
  - `game/galaxy/system_card.tscn`
- Validation completed with Godot headless scene startup, diagnostics, and `git diff --check`.
- Latest commit contains the accumulated manufacturing overlay work and HQ political-share correction. Continue from the pushed `fork/godot` branch; do not assume the overlay is a separate uncommitted change.
