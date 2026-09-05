# Gameplay Inventory v0.1 (seeded from docs, NOT signed off)

Status: seeded from bundled-docs inspection
(`sessions/2026-09-05-session-01.md`). All rows paraphrased from the
README gameplay notes; manual unread, no live play yet. Nothing here
counts toward the sign-off gate until backed by video + written rule.

## Core loop

DRAFT (needs play/video): two-layer strategy — manage planets, fleets,
production, and personnel on a galactic statis/advisory layer, then
resolve battles in a pausable real-time tactical view.

## Entities

| Entity | Behavior observed | Counts / limits | Source |
|--------|-------------------|-----------------|--------|
| Fleets / ships | Travel via hyperspace; arrival shown by engine flames; each ship has a hyperdrive rating (lower = faster); damaged hyperdrive (mismatched current/max rating, red X in fleet view) slows the ship | Task forces need 2+ ships to split | README gameplay notes (hyperspace, red X, hyperdrive rating, task force) |
| Troops / garrisons | Managed per planet (finder + garrison screen exist) | Unmapped | README keyboard map |
| Personnel / officers | Run missions; Force-capable ones gain Force points per mission toward higher Force ranking; Leadership (not combat rating) gates General rank | Unmapped | README gameplay notes (Force growth, officer rank) |
| Planets | Have loyalty; uncolonized rim systems ignore distant events; blockades are a transitory step into assault/bombard; undefended planets fall quickly | Unmapped | README gameplay notes (blockade, loyalty) |
| Death Star (Empire) | Tactical superweapon: arm via panel fire button, right-click a ship to fire, charge indicator gates re-fire; cannot target fighters or planets | One fighter group at a time may attack it | README gameplay notes + errata (Death Star controls, fighter attack) |

## Rules & scoring

| Rule | Detail | Source |
|------|--------|--------|
| Production | Changing the quantity being built forfeits all progress on that item — finish the run first, then order more | README gameplay notes |
| Construction gating | Anything may be ordered, but builds (incl. manufacturing facilities, which need refined materials) stall until resources arrive | README gameplay notes |
| Attack readiness | A fleet with any ship still under construction cannot assault or bombard — split completed ships into a new fleet or wait | README gameplay notes |
| Win / lose conditions | UNMAPPED (needs manual/play) | — |
| Scoring | UNMAPPED (needs manual/play) | — |

## Levels / screens / flow

| Screen | Purpose | Transitions | Source |
|--------|---------|-------------|--------|
| Galaxy overview | Strategic map (Alt-O) | UNMAPPED | README keyboard map |
| Finders (planet/fleet/troop/personnel) | Locate objects (F2–F5) | UNMAPPED | README keyboard map |
| Message window | Agent reports (F6); blockade-takeover messages can lag behind events | UNMAPPED | README keyboard map + notes |
| Encyclopedia | In-game reference (F7) | UNMAPPED | README keyboard map |
| Save/load | Named slots, per-slot save icon; NO save prompt on exit | UNMAPPED | README general notes |
| Tactical view | Pausable real-time battle, observe mode, status text header | UNMAPPED | README errata/notes |

## Difficulty

UNMAPPED (needs manual/play).

## UI flow

UNMAPPED beyond the screens above (needs play).

## Audio cues

UNMAPPED (needs play). Voice resources exist per side — all ship audio
will be recreated or licensed, never extracted.

## Timing / feel numbers

UNMAPPED (needs play/video with timestamps).

## Out-of-scope observations

- Multiplayer (TCP/IP entry, lobbies, "awaiting opponent" states) exists in
  the original — v1 excludes it unless the user promotes it (plan non-goal).
- Bundled scenario editor exists — tooling, not a v1 feature.
- All Star Wars names, ships, characters, music: presumed replace (see
  session-01 IP finding); triage proper is step 2.
