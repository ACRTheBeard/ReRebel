# Parity Spec v0.1 DRAFT (NOT frozen — step-1 gate unsigned)

Source: `gameplay-inventory.md` v0.2 + `input-map.md` v0.2 (35 LP
episodes mined, transcript-level) + owner corrections 2026-09-06.
Companions: `version-check.md`, `ip-triage.md`.

Provenance tags: [T] transcript-level (footage confirmation still
required), [O] owner knowledge/test, [D] bundled docs, [W] web source.
Anything tagged [T] may change at footage review; timings are
provisional until checked against the playable copy.

Name policy: all proper names below are OBSERVABLE REFERENCE LABELS
for traceability to the inventory, and every one of them is
must-replace per `ip-triage.md`. The rebuild ships new names, art,
audio, and prose; only the mechanics are specced here.

## 1. Core loop

Two-layer strategy on a day clock. On the galactic layer the player
manages planets, production, fleets, personnel, and research; battles
resolve in a pausable real-time tactical view [T] (A-Ep 2/3, E-Ep 1).
Campaigns run up to ~800 days [T] (A-Ep 8 1:21); starting sectors are
randomized every game [T] (E-Ep 1 6:21). Faction asymmetry: the Empire
presses early to deny a Rebel foothold [T] (E-Ep 1 2:49); the Alliance
plays an outward support race over a "couple hundred days" opening
[T] (A-Ep 1 4:30).

## 2. Sides and victory

- Alliance wins by holding Coruscant AND capturing Palpatine AND
  Vader simultaneously; the endgame is Luke capturing both leaders in
  one shot (failure = captured). Rebel HQ relocates but is
  permanently removed if conquered [T] (A-Ep 1 3:09, A-Ep 12 13:51).
- Empire wins by destroying the Rebel HQ (first capture destroys it;
  never retaken) AND capturing Mon Mothma AND Luke — all three
  observed closing in the finale [T] (E-Ep 1 2:15, E-Ep END).
- Scoring: UNMAPPED — no scoring observed in 35 episodes. OPEN gap;
  the spec cannot freeze scoring until capture or manual lookup.

## 3. Entities and systems

- Planets: loyalty colors (blue neutral / green Imperial / red
  Alliance); joining transfers resources [T] (A-Ep 1 2:25). Unexplored
  Rim systems: recon probe/fleet, then colonize; colonies feed core
  production; Rim-hunt endgame ~100 days; Rebel HQ hidden from Empire
  [T] (E-Ep 1). Liberation flips cascade across neighboring worlds
  [T] (A-Ep 2 0:20). Uprisings: civilians vs unreinforced garrisons;
  NO building during uprising; occupation (troops + general +
  diplomat) flips in ~2 weeks [T] (A-Ep 2/7/13). Low support leaks
  resources to the Empire (smuggling) [T] (A-Ep 7 3:35). Blockade
  halts ALL building and traps stationed personnel [T] (A-Ep 13 1:37,
  E-Ep 7 13:53). Bombardment kills troops/production but civilian
  casualties cost support, and stripping infrastructure may NOT flip
  neutrals [T] (A-Ep 11 11:56). Energy slots cap buildings (~12
  observed) [T] (A-Ep 1 14:08).
- Facilities: shipyards, training, construction yards, refineries,
  mines, shields, batteries, ion cannons, leveled gen-cores.
  Construction yards multiply build speed ~2–3× [T]; advanced
  facilities cost more for ~2× speed [T] (A-Ep 5 5:02). IMMOBILE once
  built [O]; NO in-place upgrade — scrap + rebuild only [T] (A-Ep 7).
  Orbital yards are vulnerable [T] (A-Ep 8 15:28); sabotage starves
  production lines [T] (A-Ep 7 1:29).
- Production/resources: mine/refinery output managed on camera [T]
  (A-Ep 9 8:04); refined materials gate manufacturing [D]; changing
  build quantity forfeits progress [D+T] (A-Ep 11 5:57); two
  simultaneous builds save ~4 days [T] (E-Ep 2 19:44). Maintenance
  upkeep exists; unpaid shortfalls trigger auto-scrapping, including
  by the advisor [T] (E-Ep 12 8:16, A-Ep 11 17:30).
- Ships: hyperspace travel with arrival notices; damage slows ships;
  damaged ships self-repair over time, faster at shipyards [T].
  Shields block assault landings [T] (E-Ep 2 4:03); shield recharge
  observed [T] (E-Ep 15 7:50). Task forces need 2+ ships to split
  [D]; forces numbered to at least Fleet 16 [T] (A-Ep 14 2:54).
  Reference stat points (all provisional [T]): Corvette ≈ 4 fighters;
  gunship/Corvette 200 shields; Nebulon B ~300 shields; Victory SD
  gains shields + ion cannon but LOSES troop capacity; ISD2 54 days.
  Transports: bulk 6 troops (96 days), medium 2 troops (40 days),
  Medusa 2 troops pure colonizer (cannot fight), assault transport
  capacity 1, Liberator hybrid 6 fighters + 3 troops. CC-7700
  gravity-well frigate blocks retreat for BOTH sides [T] (A-Ep 11).
- Troops/garrisons: fleet vs army regiments with visible stats
  (maintenance, attack, defense, bombardment-survival, covert
  detection); fleet regiments better and ride capitals as ship
  security [T] (A-Ep 2, E-Ep 12). Garrison need drops 4→3 as loyalty
  rises [T] (E-Ep 6 15:14); massed troops suppress uprisings [T].
- Personnel: missions are diplomacy, espionage, sabotage, destroy,
  recruit, abduction/assassination (combat), uprising, and hero-only
  Death-Star kill/sabotage. Success keys off the matching attribute
  (numeric levels ~90–107 observed) [T] (E-Ep 8 2:19, E-Ep 1 4:15).
  Agents return to origin after missions [T] (A-Ep 2 6:25);
  order-then-send sequencing matters [T] (A-Ep 3 0:49); abort incl.
  mass-abort exists [T] (A-Ep 3, A-Ep 14). Outcomes: success /
  fail-retry / captured / injured / killed [T]; escape ends captivity
  [T] (A-Ep 9 4:01); rescue contemplated but unobserved. Detection
  ratings are read pre-capture (e.g. Han 10) [T] (E-Ep 7 13:36).
  Stacking (diplomacy ×6), decoys, espionage cells, and pairing
  constraints observed [T] (A-Ep 11/13).
- Force system: ranking trainee → student → knight; Vader contact
  awakens sensitivity and buffs all stats; sensitives detect each
  other and endanger missions; Luke grows per Vader/Emperor "close
  call" unless captured; Knight-tier Luke trains candidates; Dagobah
  journey returns him stronger; premature Luke-vs-Emperor is a
  "guaranteed loss" [T] (A-Ep 4/10/12/14/15 + README [D]).
- Bounty hunters: low-chance recurring attacks on high-value agents;
  capturable after failed sabotage [T] (A-Ep 9, A-Ep 14).
- Emperor aura: Palpatine boosts everyone's leadership from the
  capital [T] (E-Ep 7 16:08).
- Death Star (Empire): strategic cost very high (2336-day early
  projection vs half-year actual late); caps 24 fighters / 18 troops;
  shield research exists; arm/fire/recharge tactical controls per docs
  [D]; NEVER built in series (declined twice); threatened only by
  Alliance hero kill/sabotage mission [T] (E-Ep 2/5/14/15).
- Advisor (C-3PO role): delegable garrison supervision, training
  management, production stewardship incl. turn-off; different voice
  per side; DOWNSIDE specced — auto-scraps own ships to cover
  maintenance shortfalls [T] (A-Ep 7, E-Ep 1/12/END).

## 4. Rules (binding unless tagged)

- Facilities immobile [O]. No mid-battle saves (only) [O].
- Fleets may retreat to hyperspace mid-battle, both sides; the
  gravity-well frigate blocks ALL retreat [T].
- Hyperspace blackout: no messages/commands to in-transit units until
  arrival [T] (E-Ep END 14:23).
- Fleet with ships under construction cannot assault/bombard — split
  or wait [D]. Builds stall until resources arrive [D].
- Assault rule: a shields-vs-assault threshold EXISTS; the player's
  "three" guess was disproven on camera — exact number OPEN [T]
  (E-Ep 15 2:01).
- Bombardment: kills troops/production; batteries shoot back (~a ship
  per attempt); shields must be pierced first [T] (A-Ep 3/8/11,
  E-Ep 15).
- Research branches: troop / ship / facility design (+ Death Star
  shields); "stop all research" available; polymaths cover all three
  [T] (A-Ep 3/5/7, E-Ep 8/10).

## 5. Difficulty and setup

New-game setup offers difficulty + map size, then an unskippable ~4-min
briefing cutscene [T] (A-Ep 1 0:40). Played: intermediate/medium
(Alliance) and normal/medium (Empire) — cross-series timing
comparisons must note this. Full difficulty list UNMAPPED (manual
unread) — OPEN gap.

## 6. UI flow and screens

Galaxy overview (loyalty-color map, scroll/select/inspect); planet,
production, personnel, and fleet screens; finders + galactic-idle
filters (support/uprising/idle/enroute); message window
(agent/mission/maintenance/leader reports, arrival notices);
encyclopedia (planets/ships/lore, used for stat comparison on camera);
save/load with named slots and per-slot icons, NO prompt on exit [D],
blocked mid-battle [O]; tactical view (pausable real-time, targeting,
two-sided retreat, orbital-domination → sabotage, voiced callouts).
Transitions between most screens: UNMAPPED. Pause menu, game-options
screens, and victory/defeat end screens: UNOBSERVED in either series
(Empire finale closed on narration, no end screen) [T] — OPEN gaps.

## 7. Controls

Mouse-driven throughout ("lack of hotkeys... a lot of clicking"; zero
verifiable key presses in 35 episodes) [T] (A-Ep 4 7:36). Full tables
in `input-map.md` v0.2 (normative annex): strategic hotkeys (F1–F7
windows, Alt-letter actions, Alt-1–9 idle filters, Alt-numpad speed,
Alt-P pause); tactical select 1–8, Space attack-nearest, F1–F8 /
F9–F12 follow cameras with F9–F12 camera-only and fighter groups
mouse-only [O], Enter/center-button centers view, numpad rotate/tilt/
zoom, Death Star arm/fire/recharge. Reconciliations still OPEN:
numpad rotate vs pan buttons, pause/camera/observe coverage, and all
[D]-only rows need live-play or footage confirmation. KNOWN BUG (not
parity): windowed-mode popups position by monitor coordinates [T]
(E-Ep 2 4:47).

## 8. Audio cues (all recreated per triage — timing only is specced)

"Order acknowledged" / "task force two acknowledges"; fighter group
reports ("Red/Green group reporting"); abort-confirmation with
attitude; advisor maintenance/leader messages; per-side voice sets.
Full cue catalog still OPEN.

## 9. Timing / feel numbers (all provisional [T], §3–§4 values incl.)

Personnel travel 88/39/4/3 days; rendezvous "in 4 days". Builds:
X-wing 20; B-wing 18 (qty ambiguous); cruiser 92/38 (yard state
differs); Nebulon B 14; Victory SD 48; refused 76/72; ISD2 54;
Defenders 10; TIE 4 (estimate overruns); transports medium 40 / bulk
96; gen-core L1 12/6/4 + 4 transport; shield-gen 12; mine ~20 (guess);
gunship 10 refined mats. Yard speedup ~2–3× (footage confirmation
OPEN); advanced training ~2×; parallel −4d. Missions in days;
Rim hunt ~100d; retreat-base saves ~60d hyperspace; armada ETA 7d.

## 10. Out of scope for v1

- Multiplayer (exists in original: 2-player DirectPlay — plan
  non-goal unless promoted).
- Scenario editor (tooling, never a shipped feature).
- All original names, art, audio, prose (replace per `ip-triage.md`).
- New modes, levels, systems, mobile/web targets (plan non-goals).

## 11. Open gaps blocking a v1 freeze

Scoring; assault-vs-shields exact threshold; yard-speedup footage
confirmation; observe mode; pause/options screens; victory/defeat end
screens; full difficulty list; screen-to-screen transitions; full cue
catalog; LP patch identity (`version-check.md`); screenshots for every
screen/state; user review of inventory v0.2 vs the playable copy.
A claim graduates from this draft into the frozen spec only with
footage + written rule per the README gate.
