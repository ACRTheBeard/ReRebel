# IP and Asset Triage v0.1 DRAFT (step 2, ahead of gate)

Status: draft under the working assumption REPLACE EVERYTHING. Step 1
gate is NOT signed off (screenshots empty, user review pending), so
rows may move only in one direction on new evidence: replace -> keep
requires written ownership/clearance proof per item. Until then,
nothing original ships.

Provenance: entity examples come from `gameplay-inventory.md` v0.2
(session mining [T]); verdicts are policy [D], not footage.

## Working-title policy

- Working title is `ReRebel`. No `Star Wars`, `Rebellion`, `Supremacy`,
  Lucasfilm, or Disney marks in repo names, code identifiers, asset
  filenames, or UI text.
- Final title TBD after clearance; the parity spec will use
  functional placeholders (e.g. SIDE-A / SIDE-B, CAPITAL-1) wherever
  an original name appears in a rule.

## Triage

| Asset class | Examples in inventory v0.2 | Verdict | Replacement direction |
|-------------|---------------------------|---------|----------------------|
| Game title / brand | "Star Wars: Rebellion" / "Supremacy", LucasArts logo | REPLACE | Working title only; final title needs clearance or a new mark |
| Faction / character names | Emperor, Vader, Han, Pellaeon, Adar Tallon, Noghri, Wookiees, Mon Cal | REPLACE | Original dramatis personae; spec uses role labels (LEADER-A, AGENT-3), final names from new fiction |
| Ship / unit / installation names | ISD/Victory SD, Mon Cal Cruiser, Nebulon B, Corvette, TIEs, Death Star, CC-7700, Medusa | REPLACE | Same silhouette ROLE may be specced (carrier, gravity-well frigate); names, backstory, livery are new |
| Visual art | Ship renders, planet views, UI chrome, cutscene frames (photo/painting style) | REPLACE | Screenshots are reference only (README rule); all ship art is re-authored in a new style |
| Audio: score / music | In-game score (LP E13 muted for copyright is a reminder it is protected) | REPLACE | New score; no Williams-derived motifs |
| Audio: voice / SFX | Task-force callouts, abort voice line, UI voices | REPLACE | Re-record all VO; SFX recreated to match CUE timing, not waveform |
| Text / lore | Encyclopedia entries, ~4-min briefing cutscene script, message-window flavor | REPLACE | Rules data (stats, costs) re-expressed; all prose rewritten |
| Fonts / type | Unknown (no screenshots yet) | REPLACE, capture pending | Identify from screenshots; substitute with licensed/open fonts |
| Code / binaries | REBEXE.EXE 1.01/1.02, registry/DirectPlay plumbing | NEVER REUSE | Clean-room reimplementation only; no decompile, no binary wrap |

## Reference-use rule (unchanged from README)

Screenshots, recordings, and third-party LPs are observation sources
only. Nothing copied from them — pixels, audio, text, or binary —
enters the repo as a shippable asset.

## What could flip a row to KEEP

Written clearance for that exact item (license, assignment, or
ownership proof), recorded here with source and date. A Steam/GOG
purchase is a play license, not an asset license — it flips nothing.
