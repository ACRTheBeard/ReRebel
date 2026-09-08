# Version / Platform / Scope Check (web research, 2026-09-06)

Status: web-sourced reference for the parity spec. Provenance per
claim: [W] = named public web source below (not footage, not the
playable copy). Resolves three handoff open questions; one item
(LP patch identity) stays open pending a Windows-side check.

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

## LP patch identity: STILL OPEN (needs Windows side)

Transcripts never show a version string, so the series patch cannot be
read from mining. To close: (1) check REBEXE properties/version on the
playable copy; (2) one title-screen screenshot — record whether any
version string is printed on title/menu; (3) check the LP uploader's
video descriptions for GOG-vs-disc notes.

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

## Scenario editor: not shipped; community tools only [W]

No official scenario editor came with the game. RebEd (classic fan
editor; https://swrebellion.net/forums/topic/9611-rebed-installation-procedures/)
and StarWarsRebellionEditor.NET (25th Anniversary;
https://github.com/MetasharpNet/StarWarsRebellionEditor.NET) are
fan-built. Scenario editing is OUT of parity scope; moddability is a
community-added extra, not original behavior.
