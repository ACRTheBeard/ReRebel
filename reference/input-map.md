# Input Map v0.2 (docs + LP-mining + owner tests)

Status: keyboard reference transcribed from the bundled README
(`sessions/2026-09-05-session-01.md`); corroboration from 35 LP episodes
(`sessions/2026-09-05-session-02.md` = A, `2026-09-06-session-03.md` = E)
and owner testing (2026-09-06). Tiers: [D] docs only, [T] effect seen in
LP (control unseen), [O] owner-confirmed/tested. Mouse is the primary
device in all footage — zero verifiable key presses in 35 episodes, and
the player testifies to "lack of hotkeys... a lot of clicking" (A-Ep 4).

## Strategic layer

| Action | Key | Notes |
|--------|-----|-------|
| Quick exit (no confirm) | Ctrl-X | Alt-F4 exits WITH confirmation |
| Game options | F1 | |
| Planetary finder | F2 | GIDs: agent menu family, see below |
| Fleet/ship finder | F3 | |
| Troop finder | F4 | |
| Personnel finder | F5 | |
| Message window | F6 | [T] window used on camera both sides (key unseen): arrivals, maintenance, Emperor reports |
| Encyclopedia | F7 | [T] opened + used on camera both sides (key unseen): stat comparison, lore |
| Scroll lists | Cursor keys | |
| Cycle entries (messages, encyclopedia) | Arrow keys | |
| Accept / activate selection | Enter | Also dismisses mis-centered pause dialog after task-switch |
| Cancel / close window | ESC | Also first recovery key on black screen / freeze |
| Cycle through windows | Ctrl-Tab / Ctrl-Shift-Tab | |
| Close all windows | Alt-W | |
| Game speed + / − | Alt-+ / Alt-− | [O] owner-confirmed 2026-09-08 (docs specify numpad — main-row keys unconfirmed) |
| Pause | Alt-P | [O] owner-confirmed 2026-09-08 ([T] pause effect also seen 3× in footage) |
| Compose chat message | Alt-Y | Multiplayer |
| View index | Alt-I | |
| Status | Alt-S | |
| Mission | Alt-M | |
| Build ships | Alt-B | |
| Build troops | Alt-T | |
| Build facilities | Alt-F | |
| Galaxy overview | Alt-O | |
| Game objectives | Alt-H | |
| Manage garrisons | Alt-G | [T] garrison management + C-3PO delegation seen (key unseen) |
| Manage production | Alt-U | [T] production screen managed on camera (key unseen) |
| Translate counterpart | Alt-V | |
| Agent advice | Alt-A | |
| GID: popular support | Alt-1 | [O] owner-confirmed 2026-09-08; label seen on map screenshots |
| GID: uprising | Alt-2 | [O] owner-confirmed 2026-09-08 |
| GID: idle fleets | Alt-3 | [O] owner-confirmed 2026-09-08 |
| GID: active fleets | Alt-4 | [O] owner-CORRECTED 2026-09-08 (docs said "enroute fleets") |
| GID: idle personnel | Alt-5 | [O] owner-confirmed 2026-09-08 |
| GID: active personnel | Alt-6 | [O] owner-confirmed 2026-09-08 |
| GID: idle shipyard | Alt-7 | [O] owner-confirmed 2026-09-08 |
| GID: idle troop training | Alt-8 | [O] owner-confirmed 2026-09-08 (docs: "idle training facilities") |
| GID: idle construction yards | Alt-9 | [O] owner-confirmed 2026-09-08 (docs: "idle construction") |

GID = galactic display filters (per README grouping).

Owner scope note (live play, 2026-09-08) [O]: the 12 keys above
(speed ×2, GID ×9, pause) are the ONLY working hotkeys the owner
could trigger. Every other docs-listed key in the table above
(F1–F7, the Alt-letter family, Ctrl-Tab, Alt-W, etc.) is UNCONFIRMED
in live play — treat all [D]-only rows as doubtful until tested.

## Tactical battles

Owner corrections applied 2026-09-06 (source: owner's knowledge of the
original; footage confirmation still pending per the README gate).

| Action | Key | Notes |
|--------|-----|-------|
| Select task force 1–8 | 1–8 | Owner-confirmed: number row loosely corresponds to task-force numbers |
| Attack nearest target of selected unit's type | Space | Fighter or capital ship |
| Follow camera, task force 1–8 | F1–F8 | |
| Follow camera, fighter group Red–Gold | F9–F12 | Owner-tested: F9–F12 adjust the camera but do NOT select the fighter group; group selection itself is mouse-only |
| Pan tactical view | Directional buttons | Owner: pans like a map view (cf. docs numpad rotate/tilt rows below — reconcile with footage) |
| Center view on selection (leaves follow) | Enter or center clickable button | Owner-confirmed: both Enter and the on-screen center button center on the selected ship, selection, or fighter group |
| Data display window arrows | Tab / Shift-Tab | |
| Rotate camera left / right | Numpad left / right | |
| Tilt camera up / down | Numpad up / down | |
| Zoom in | Numpad PgUp or + | |
| Zoom out | Numpad PgDn or − | |
| Toggle follow camera | Numpad . | |
| Memorize camera position | Numpad Home | |
| Return to memorized position / leave follow | Numpad End | |
| Death Star: arm laser | Fire button on Death Star panel | Cursor becomes target; left-click empty space cancels |
| Death Star: fire at ship | Right-click target | Fighters and planets NOT targetable; must recharge between shots |

## Menus / pause / game over

Mostly unmapped — capture from play. Known: save/load uses named slots
with a save icon per slot; exit does NOT prompt to save [D]; saves used
on camera repeatedly [T]; saving blocked mid-battle [O]. Pause menu +
game options screens UNOBSERVED in either series. Victory/defeat ends
UNOBSERVED (Empire finale closed with "victorious forever" narration,
no end screen shown) [T].
Start screen mapped from owner screenshots 2026-09-08 (community
edition) [O]: difficulty selector top-left (Novice / Intermediate /
Expert hover tooltips); map-size selector center ("Standard Game"
shown, other sizes unmapped); "Load a Saved Game" control top-center;
"Start Game as Alliance" control bottom-right (Empire-side counterpart
unmapped); A/G/C letters shown beside Admiral/General/Commander
(presumed hotkeys, effect unverified); mission/research categories
listed across the top bar (Diplomacy, Recruitment, Jedi Trainer,
Espionage, Ship Research, Combat, Troop Training, Leadership, Facility
Research); "25th Anniv. Update / Accurate" edition label bottom-right.
Second batch 2026-09-08 [O]: map sizes = Standard / Large / Huge
Galaxy (center-selector hovers); "Start Game as Empire" control
(center-left); "Credits" (right); "Play Head to Head" multiplayer
entry (bottom-left, red bars); "Exit" (bottom-right). Start screen
now fully mapped — no open controls there.
Galaxy overview (Alliance, `screenshots/standard-map-alliance/`)
[O]: sector hover prints the sector name on the map; clicking a
sector opens its panel (left or right side) with up/down scroll
arrows + X close; GID filter label prints top-center ("Popular
Support" green, "Idle Fleets" red). Day clock + resource counters
run across the top bar.
Strategic pause OBSERVED 2026-09-08 [O]
(`screenshots/2026-09-08-strategic-pause-resume-dialog.png`):
Alt-P pops a "Resume Game Play?" dialog with a checkmark confirm
button. Tactical pause state = red "Battle Paused" text over the
frozen view [O] (`alliance-battle/2026-09-08-tactical-*.png`).
Game options MAPPED 2026-09-08 [O] (`2026-09-08-strategic-
options*.png`, `alliance-battle/2026-09-08-battle-options-*.png`,
identical layout both layers): Saved Games slots (numbered +
named, side-icon per slot), Sound Options (Play Music On/Off +
sliders), Tactical Display Options (Show Starfield / Planet /
Pyrotechnics, Use High Detail Models, Display Holocube — all
On/Off); footer buttons "Restart the Game" and "Return to the
Command Center"; footer prints "Version: 1.02.00".
Tactical controls observed [O] (same battle shots): "Withdraw
From Battle" button (top-right panel); formation buttons incl.
"Hammer" and "Left Hook"; Navigation Point Set 1/2 buttons;
ship data panel (name, Task Force assignment, shield-strength
bars, crew portraits, target + tactics line, e.g. "Attacking
Judicator / Tactics: Stand Off"); bottom navball camera
controller; top-row task-force tabs.

## Notes

- Keyboard AND mouse required (per original min spec); no joystick mentioned.
- Task-switching is Alt-Tab with a recommendation to visit Options first.
- Corroboration tiers ([D]/[T]/[O]) are per-row above; anything unmarked
  is docs-only and still needs a live-play or footage source.
