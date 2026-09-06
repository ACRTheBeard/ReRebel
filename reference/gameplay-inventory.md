# Gameplay Inventory v0.2 (promoted from playthrough mining, NOT signed off)

Status: promoted from third-party playthrough transcription
(`sessions/2026-09-05-session-02.md` = Alliance 16 eps, A-Ep N;
`sessions/2026-09-06-session-03.md` = Empire 19 eps, E-Ep N).
Full video URLs live in those files; citations below are episode +
timestamp. Provenance per row: [T] = auto-caption transcript level
(footage confirmation still required by the gate), [O] = owner
knowledge/test, [D] = bundled docs. Manual still unread.

## Core loop

Two-layer strategy, confirmed on camera both sides: manage planets,
fleets, production, personnel, and research on a galactic layer, then
resolve battles in pausable real-time tactical view (A-Ep 2/3, E-Ep 1).
Faction asymmetry: the Empire "wants to move fast" to deny a Rebel
foothold [T] (E-Ep 1 2:49); the Alliance plays an outward build game
with a "couple hundred days" opening support race [T] (A-Ep 1 4:30).
Full campaigns run "up to like 800 some days" [T] (A-Ep 8 1:21).
Starting sectors are randomized every game [T] (E-Ep 1 6:21).

## Entities

| Entity | Behavior observed | Counts / limits | Source |
|--------|-------------------|-----------------|--------|
| Fleets / ships | Hyperspace travel; arrivals announced in message window; damage slows ships [D]; damaged ships self-repair over time, faster at shipyards (8/10 progress shown) [T] (A-Ep 5 3:13, E-Ep 12 4:03); shields block assault landings [T] (E-Ep 2 4:03); shield recharge observed [T] (E-Ep 15 7:50) | Task forces need 2+ ships to split [D]; forces numbered to at least Fleet 16 [T] (A-Ep 14 2:54); named task forces 1–2 used in orders [T] (A-Ep 10 4:42) | README notes + session mining |
| Transports | Bulk: 6 troops, most cost-effective (A-Ep 7 11:43, A-Ep 10 2:10); medium: 2 troops, 40 days; bulk: 96 days (A-Ep 7 11:43); Medusa: 2 troops, CANNOT fight — pure colonizer (E-Ep 1 9:03); assault transports: capacity 1, cheap, laser-armed (E-Ep 10 1:21); Liberator cruiser: 6 fighters + 3 troops, transport/carrier hybrid (A-Ep 13 3:02) | See Timing | Session mining [T] |
| Capital ships | Corvette ≈ 4 TIE fighters (A-Ep 10 1:38); gunship & Corvette: 200 shields, gunship a straight upgrade (A-Ep 8 18:13); Nebulon B: ~300 shields, 80 turbolasers fwd (E-Ep 12 5:47); Mon Cal Cruiser = early SD equivalent (A-Ep 5 13:07); Victory SD gains shields + ion cannon but LOSES troop capacity (E-Ep 13 2:24); ISD2: 54 days, "fantastic" (E-Ep 16 9:03); capitals hold fighter squadrons (E-Ep 6 8:52); single SD "a force to be reckoned with" (E-Ep 3 4:08) | Build times in Timing | Session mining [T] |
| Exotics | CC-7700 gravity-well frigate: no retreat for EITHER side while in-fleet (A-Ep 11 7:05); Lancer frigates valued, role unnarrated (E-Ep 11 3:15); assault frigates hold neither fighters nor troops (E-Ep 12 11:39); invasion fleets as a formation class (E-Ep 16 6:16) | — | Session mining [T] |
| Troops / garrisons | Fleet vs army regiments with visible stats (maintenance, attack, defense, bombardment-survival, covert detection); fleet better (A-Ep 2 3:43); stormtroopers early → dark troopers ("best troops," phenomenal attack) (A-Ep 5 7:42, A-Ep 13 0:15); Wookiees = offensive assault troops (A-Ep 8 19:28); Mon Cal regiments = best defense (A-Ep 7 3:16); cheap/weak regiments detect & foil ops (A-Ep 5 14:04); Noghri Death Commandos fail captures (E-Ep 4 1:12); fleet regiments ride capitals as ship security (E-Ep 12 2:10) | Garrison need 4→3 as loyalty rises (E-Ep 6 15:14); massed troops suppress uprisings (A-Ep 7 3:26) | Session mining [T] |
| Personnel / officers | Missions: diplomacy, espionage, sabotage, destroy, recruit, abduction (combat), assassination (combat), uprising, Death-Star kill/sabotage (heroes only); success keys off matching attribute (E-Ep 8 2:19); Emperor as diplomat, Pellaeon diplomacy 107, levels numeric 90/98 (E-Ep 1 4:15, E-Ep 3 0:55, E-Ep 7 16:24); return to origin after missions (A-Ep 2 6:25); order-then-send sequencing matters (A-Ep 3 0:49); abort incl. mass-abort (A-Ep 3 17:18, A-Ep 14 7:42); outcomes: success / fail-retry / captured / injured / killed (A-Ep 3 13:26, A-Ep 10 8:36); escape ends captivity (A-Ep 9 4:01); rescue contemplated, unobserved (A-Ep 5/6); Vader evades capture planet-to-planet (A-Ep 6 0:40); detection rating read pre-capture, e.g. Han 10 (E-Ep 7 13:36); blockade traps agents (E-Ep 7 13:53); decoys + espionage cells, diplomacy stacked ×6, pairing constraints (A-Ep 13 15:21, A-Ep 11 4:31) | Unmapped caps | Session mining [T] |
| Force system | Force ranking (trainee → student → knight); Vader contact awakens sensitivity, buffs all stats; sensitives detect each other and endanger missions (can't spy undetected, diplomacy up); Luke grows per Vader/Emperor "close call" unless captured (combat → best-in-game); Luke trains candidates as Knight; Dagobah journey returns him stronger; heritage reveal to Leia; Luke-vs-Emperor premature = "guaranteed loss" (A-Ep 4 1:00, A-Ep 10 12:23, A-Ep 12 13:51, A-Ep 14 0:23/8:51, A-Ep 15 0:14) | — | Session mining [T]; README Force notes [D] |
| Bounty hunters | Low-chance recurring attacks on high-value agents; capturable after failed sabotage (A-Ep 9 1:27, A-Ep 14 6:46) | — | Session mining [T] |
| Emperor aura | Palpatine boosts everyone's leadership from the capital (E-Ep 7 16:08) | — | Session mining [T] |
| Planets | Loyalty colors (blue neutral / green Imperial / red Alliance); joining transfers resources (A-Ep 1 2:25); Rim systems unexplored → recon probe/fleet → colonize (value varies); colonies feed core production (E-Ep 1 9:22); Rim-hunt endgame ~100 days (E-Ep 1 8:30); Rebel HQ hidden from Empire (E-Ep 1 8:37); liberation domino flips 6–7 worlds (A-Ep 2 0:20); uprisings: civilians vs unreinforced garrisons → join; suppression by troops; NO building during uprising; upkeep dodged by scrapping (A-Ep 2 0:28, A-Ep 7 6:29, A-Ep 11 17:30); occupation = troops + general + diplomat, ~2-week flip (A-Ep 7 3:06, A-Ep 13 15:26); low support → smuggling siphons to Empire (A-Ep 7 3:35); blockade halts ALL building (A-Ep 13 1:37, E-Ep 4 1:35); recapture window while still loyal (A-Ep 11 0:02); civilians die in bombardment, hurting support, and stripping infra may NOT flip neutral (A-Ep 11 11:56) | Energy slots cap buildings (~12 observed) (A-Ep 1 14:08, E-Ep 12 0:26); mined resources show yellow (A-Ep 1 14:19) | Session mining [T] |
| Facilities | Shipyards / training / construction yards + refineries, mines, shields, batteries, ion cannons, gen-cores (leveled); advanced cost more, ~2× speed (A-Ep 5 5:02); construction yards multiply build speed ~2–3× (A-Ep 1/2/5, E-Ep 4 4:50); IMMOBILE once built [O]; NO in-place upgrade — scrap + rebuild only (A-Ep 7 5:54/13:05); orbital yards vulnerable (A-Ep 8 15:28); sabotage starves production lines (A-Ep 7 1:29) | See Timing | Session mining [T] + owner [O] |
| C-3PO / advisor | Delegable: garrison supervision, training management, production stewardship (incl. turn-off); different voice per side; DOWNSIDE: auto-scraps own ships to cover maintenance shortfalls (A-Ep 7 0:30, E-Ep 1 10:58, E-Ep 12 8:16, E-Ep END 5:04) | — | Session mining [T] |
| Death Star (Empire) | Tactical controls per docs [D]; strategic: 2336-day projection early vs half-year actual late, very expensive; caps 24 fighters / 18 troops; shield research exists; NEVER built in series (player declines twice); Alliance-unique hero kill/sabotage mission threatens it; verdict "terrible... awesome" (E-Ep 2 14:47, E-Ep 5 20:09, E-Ep 14 5:26, E-Ep 15 5:34) | One fighter group at a time may attack it [D] | README [D] + sessions [T] |

## Rules & scoring

| Rule | Detail | Source |
|------|--------|--------|
| Win / lose (Alliance) | Hold Coruscant AND capture Palpatine AND Vader simultaneously; HQ relocates but is permanently removed if conquered; endgame = Luke capturing both leaders in one shot (failure = captured) | A-Ep 1 3:09, A-Ep 12 13:51 [T] |
| Win / lose (Empire) | Destroy Rebel HQ (first capture = destroyed, never retaken) AND capture Mon Mothma AND Luke; ALL THREE observed closing in the finale — HQ destroyed, Mothma resolved, Luke nabbed in transit ("victorious forever") | E-Ep 1 2:15, E-Ep END 10:05/11:47/21:35 [T] |
| Scoring | UNMAPPED (no scoring observed in 35 episodes) | — |
| Production forfeit | Changing quantity forfeits progress — corroborated by cancel discipline ("don't interrupt midway") | README [D]; A-Ep 11 5:57 [T] |
| Construction gating | Builds stall until resources arrive; refined materials gate manufacturing | README [D] |
| Attack readiness | Fleet with ships under construction cannot assault/bombard — split or wait | README [D] |
| No mid-battle saves | Saving blocked ONLY while a tactical battle is ongoing [O] | Owner correction |
| Facility immobility | Manufacturing/resource facilities cannot relocate [O] | Owner correction |
| Upkeep | Maintenance costs exist; unpaid shortfalls trigger auto-scrapping; uprising worlds scrapped preemptively | E-Ep 12 8:16, A-Ep 11 17:30 [T] |
| Research control | Branches: troop / ship / facility design (+ Death Star shields); "stop all research" available; polymaths cover all three | A-Ep 3/5/7, E-Ep 8/10 [T] |
| Retreat | Fleets may retreat to hyperspace mid-battle (both sides); gravity-well frigate blocks ALL retreat | A-Ep 2/3, A-Ep 11 7:05 [T] |
| Hyperspace blackout | No messages/commands to in-transit units until arrival (both series) | E-Ep END 14:23, E-Ep 11 7:17 [T] |
| Blockade effects | Halts all building; traps stationed personnel; interrupts en-route traffic | A-Ep 13 1:37, E-Ep 7 13:53/9:12 [T] |
| Bombardment | Kills troops/production; risks civilian casualties (support cost); batteries shoot back (~a ship per attempt); shields must be pierced first | A-Ep 3/8/11, E-Ep 15 7:50 [T] |
| Assault rule | A shields-vs-assault threshold EXISTS; player's "three" guess disproven on camera — number open | E-Ep 15 2:01 [T] |
| Parallel discount | Two simultaneous builds save ~4 days | E-Ep 2 19:44 [T] |
| Smuggling | Low-support worlds leak resources to the Empire | A-Ep 7 3:35 [T] |

## Levels / screens / flow

| Screen | Purpose | Transitions | Source |
|--------|---------|-------------|--------|
| Galaxy overview | Star-color map (blue/green/red), scroll/select/inspect | UNMAPPED | A-Ep 1 2:18 [T] |
| Finders + GIDs | Locate planets/fleets/troops/personnel; idle-facility/fleet indicators; support/uprising filters | UNMAPPED | README [D]; idle indicators observed A-Ep 2/4 [T] |
| Message window | Agent/mission/maintenance/Emperor reports; arrival notices; blockade-takeover lag [D] | UNMAPPED | README [D]; A-Ep 1 14:43, E-Ep 6 15:03, E-Ep 1 18:22 [T] |
| Encyclopedia | Full reference (planets/ships/lore); used for stat comparisons on camera, both series | UNMAPPED | A-Ep 14 2:14, E-Ep 6 14:59 [T] |
| Production screen | Mine/refinery output maximization, managed on camera | UNMAPPED | A-Ep 9 8:04 [T] |
| Save/load | Named slots, per-slot icon; NO prompt on exit [D]; blocked mid-battle [O]; save-wanted-but-blocked observed once | UNMAPPED | README [D]; E-Ep 6 6:11 [T] |
| Tactical view | Pausable real-time battle; targeting, two-sided retreat, orbital-domination → sabotage; task forces + fighter callouts voiced; observe mode + camera controls NOT covered (pause/camera/observe open) | UNMAPPED | A-Ep 2/3, A-Ep 11 9:46 [T] |
| New-game setup | Difficulty + map size; unskippable ~4-min briefing cutscene | UNMAPPED | A-Ep 1 0:40 [T] |

## Difficulty

Played: intermediate/medium (Alliance) and normal/medium (Empire); cross-series timing comparisons must note this. Campaigns ~800 days; clocks seen at day 300/304/612. Empire pressures early; assault-shields threshold unknown. Full difficulty list UNMAPPED (manual unread).

## UI flow

Mouse-driven throughout ("lack of hotkeys... a lot of clicking"; zero verifiable key presses in 35 episodes) (A-Ep 4 7:36). Drop-down/pop-up menus clicked; KNOWN BUG: windowed-mode popups position by monitor coordinates (E-Ep 2 4:47). No in-place facility upgrade (scrap + rebuild). Task-switch pause dialog per docs [D]. Pause menu + game options screens UNOBSERVED in either series.

## Audio cues

Observed on camera (transcript-level): "order acknowledged" + "task force two acknowledges"; fighter group reports ("Red/Green group reporting"); abort-confirmation with attitude ("send a complaint to the head office"); C-3PO maintenance/Emperor messages. Per-side voice resources exist — all audio recreated or licensed, never extracted. Full cue catalog still open.

## Timing / feel numbers

All [T] (transcript-level; confirm on screen before sign-off). Personnel travel: 88 / 39 / 4 / 3 days; rendezvous "in 4 days". Builds: X-wing 20; B-wing 18 (qty ambiguous); cruiser 92 / 38 (yard state differs); Nebulon B 14; Victory SD 48; refused 76 / 72; ISD2 54; Defenders 10; TIE 4 (estimate overruns); transports medium 40 / bulk 96; gen-core L1 12 / 6 / 4 + 4 transport; shield-gen 12; mine ~20 (guess); gunship 10 refined mats. Speedups: yards ~2–3×; advanced training ~2×; parallel −4d. Missions in days; briefing 4 min unskippable; Rim hunt ~100d; retreat-base saves ~60d hyperspace; armada ETA 7d. Campaigns ~800d.

## Out-of-scope observations

- Multiplayer (TCP/IP entry, lobbies, "awaiting opponent" states) exists in
  the original — v1 excludes it unless the user promotes it (plan non-goal).
- Bundled scenario editor exists — tooling, not a v1 feature.
- All Star Wars names, ships, characters, music: presumed replace (see
  session-01 IP finding); triage proper is step 2.
