# Version / Platform / Scope Check (web research, 2026-09-06)

Status: web-sourced reference for the parity spec. Provenance per
claim: [W] = named public web source below (not footage, not the
playable copy); [O] = owner report 2026-09-08. LP patch identity
is now CLOSED (owner-confirmed 1.01-or-1.02, immaterial — see
below); playable copy baselined as the 25th Anniversary community
edition (map delta vs footage baseline still unmapped).

## Patch: 1.01 is the last official update; "1.02" is community packaging [W]

- PCGamingWiki's Rebellion page says the "1.01 Update … updates the
  game to the latest version" — LucasArts stopped at 1.01.
  (https://www.pcgamingwiki.com/wiki/Star_Wars:_Rebellion)
- `REBEXE.EXE (1.02)` is the community/GOG-era executable: the
  swrebellion.net Rebellion Update page ships 1.02 builds bundled with
  dgVoodoo2/DirectX wrappers, and the x64-installer notes reference
  `REBEXE.EXE (1.02)`.
  (https://swrebellion.net/files/file/260-rebellion-update/)
- Working assumption: the user's "v1.02 copy" (Steam/GOG install) is
  the 1.01 game + community 1.02 compatibility executable, NOT a
  LucasArts gameplay patch. No 1.01 gameplay changelog with
  observable in-game differences surfaced, so no inventory claim
  currently hinges on patch level.
- Self-identification [O] (2026-09-08): the community edition's
  game-options footer prints "Version: 1.02.00"
  (`screenshots/2026-09-08-strategic-options.png`). So "1.02" is
  confirmed as the edition's own version string, whatever its
  lineage.

## LP patch identity: CLOSED (owner-confirmed, immaterial) [O]

The mined playthrough footage is v1.01 or v1.02. Both versions are
essentially bug-fix patches with no gameplay differences, so no
inventory or parity-spec claim hinges on which of the two the series
ran. The Windows-side REBEXE/title-screen check is therefore dropped
— nothing observable depends on it.

## Playable copy: 25th Anniversary community edition [O]

The owner's playable copy is the 25th Anniversary community edition,
not the 1.01/1.02 baseline the footage was recorded on. Owner report:
the edition changed the map somewhat, but gameplay and goals are
unchanged.
- Parity-spec implication: mechanics, victory conditions, timing,
  and UI-flow claims transfer directly from the footage baseline to
  the playable copy. Map-specific claims (starting sectors, Rim
  layout, planet placement) do NOT transfer silently — verify each
  against the community edition and note edition deltas.
- Map delta, first evidence 2026-09-08 [O]
  (`screenshots/standard-map-alliance/`): Standard-map Alliance
  game, days 2–16, 10 sector panels captured (Deep Core, Core
  Worlds North, Mid Rim North, Mandalorian Space, Sith Worlds,
  Crossroads, Inner Rim, Bothan Space, Outer Rim South, Outer Rim
  West). Sector panels carry up/down scroll arrows + X close;
  planets show portrait + segmented loyalty bars (red/green
  splits visible, e.g. Jakku, Fondor, Coruscant).
- Map delta CONFIRMED 2026-09-08 [W+G], full report in
  `map-baseline.md` (baseline = Prima guide Appendix A via
  Internet Archive OCR). SECTORS: zero overlap — all 20 originals
  (Abrion, Atrivis, Corellian, Sesswenna…) replaced by 20
  geographic sectors (Deep Core, Mandalorian Space, Sith Worlds…).
  SYSTEMS: 38 kept, ~160 removed, ~162 added. All suspects
  confirmed as additions: "Earth", Mandalorian Space, Sith Worlds
  (Moraband, Dromund Kaas, Ziost), sequel-era names (Jakku,
  Takodana, Hosnian Prime, Ahch-to, Exegol…), plus prequel/
  animated/TOR/Legends deep cuts. Probable renames: Abregado →
  Abregado-rae, Calamari → Mon Cala, Yavin → Yavin 4 + Yavin
  Prime. None of the added content may be treated as original.

## Min PC spec, 1998 box [W]

Windows 95, Pentium 90 MHz, 16 MB RAM, 53 MB disk, DirectX
5.0-compatible video, 16-bit sound card, 4x CD-ROM — per the System
requirements table on PCGamingWiki (same page as above). Steam's listed
minimum is a modern-Windows shim, not parity-relevant.

## Consoles: none, ever [W]

Windows-only game (Wikipedia categories: Windows games, Windows-only
games; platform infobox = Windows).
(https://en.wikipedia.org/wiki/Star_Wars:_Rebellion_(video_game))
"First console family" is therefore N/A — parity-spec scope is PC only.
No Mac port either (open-rebellion README: "never got a Mac port").

## Multiplayer scope: 2-player DirectPlay head-to-head [W]

- PCGamingWiki multiplayer table: 2 players; original matchmaking was
  MSN Gaming Zone (shut down).
- Registry entries for the game carry a DirectPlay application GUID
  (`{015962A0-F183-11d1-B390-006008B0AB18}`, File `REBEXE.EXE`).
- Community plays today via GameRanger / direct IP (GameFAQs
  Win7/Vista guide).
- Parity-spec implication: multiplayer = 2-player Alliance-vs-Empire
  online; no skirmish-vs-AI mode observed in 35 episodes.
- Owner multiplayer rules [O] (2026-09-08): plays like the regular
  game except (1) NO pause in multiplayer, (2) a single game speed is
  chosen for the whole match. Mechanics otherwise transfer from
  single-player; these two deltas are the only multiplayer-specific
  rules recorded.

## Scenario editor: not shipped; community tools only [W]

No official scenario editor came with the game. RebEd (classic fan
editor; https://swrebellion.net/forums/topic/9611-rebed-installation-procedures/)
and StarWarsRebellionEditor.NET (25th Anniversary;
https://github.com/MetasharpNet/StarWarsRebellionEditor.NET) are
fan-built. Scenario editing is OUT of parity scope; moddability is a
community-added extra, not original behavior.
