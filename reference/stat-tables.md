# Stat Tables v0.1 ([G] game-config export)

Source: game-config export from the installed v1.02.00 community-edition copy (`reference/files/*.csv`), provided 2026-09-08. Numeric stats only — encyclopedia prose is excluded per `ip-triage.md`, and internal-only columns (record IDs, family/link IDs, string-DLL IDs, picture IDs, rank-name variants) are dropped. The CSVs remain canonical for anything not tabulated here.

Name policy: unit names below are OBSERVABLE REFERENCE LABELS for traceability, must-replace per `ip-triage.md`. Only the numbers are specced.

Side: A = Alliance, E = Empire. ResearchOrder 0 = available at start. Units are deliberately NOT interpreted here — see `gameplay-inventory.md` and the parity spec for behavior.

## 1. Fighters (8)

| Side | RefinedMaterialCost | MaintenanceCost | ResearchOrder | ResearchDifficulty | UprisingDefense | Detection | ShieldStrength | SubLightEngine | Maneuverability | Hyperdrive | HyperdriveIfDamaged | TurbolaserFore | IonCannonFore | LaserCannonFore | TurbolaserAft | IonCannonAft | LaserCannonAft | TurbolaserPort | IonCannonPort | LaserCannonPort | TurbolaserStarboard | IonCannonStarboard | LaserCannonStarboard | TurbolaserRange | IonCannonRange | LaserCannonRange | TurbolaserAttackStrength | IonCannonAttackStrength | LaserCannonAttackStrength | OverallAttackStrength | Torpedoes | TorpedoesRange | SquadronSize | BombardmentDefense | Name |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A | 5 | 4 | 3 | 24 | 0 | 15 | 5 | 11 | 8 | 60 | 0 | 0 | 0 | 5 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 12 | 0 | 0 | 5 | 5 | 0 | 0 | 12 | 0 | A-wing |
| A | 7 | 8 | 5 | 50 | 0 | 15 | 9 | 7 | 3 | 60 | 0 | 0 | 6 | 8 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 18 | 20 | 0 | 6 | 8 | 14 | 12 | 7 | 12 | 2 | B-wing |
| A | 5 | 4 | 0 | 0 | 0 | 15 | 5 | 8 | 5 | 60 | 0 | 0 | 0 | 8 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 12 | 0 | 0 | 8 | 8 | 4 | 7 | 12 | 1 | X-wing |
| A | 5 | 4 | 0 | 0 | 0 | 12 | 5 | 8 | 4 | 60 | 0 | 0 | 3 | 5 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 12 | 12 | 0 | 3 | 5 | 8 | 8 | 7 | 12 | 2 | Y-wing |
| E | 3 | 3 | 0 | 0 | 0 | 12 | 0 | 9 | 5 | 0 | 0 | 0 | 0 | 5 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 12 | 0 | 0 | 5 | 5 | 0 | 0 | 12 | 0 | TIE Fighter |
| E | 3 | 3 | 3 | 24 | 0 | 20 | 0 | 10 | 8 | 0 | 0 | 0 | 0 | 8 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 12 | 0 | 0 | 8 | 8 | 0 | 0 | 12 | 0 | TIE Interceptor |
| E | 3 | 3 | 1 | 8 | 0 | 12 | 0 | 7 | 4 | 0 | 0 | 0 | 3 | 5 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 12 | 12 | 0 | 3 | 5 | 8 | 8 | 7 | 12 | 2 | TIE Bomber |
| E | 5 | 7 | 8 | 50 | 0 | 25 | 5 | 8 | 6 | 60 | 0 | 0 | 0 | 10 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 12 | 0 | 0 | 10 | 10 | 10 | 10 | 12 | 1 | TIE Defender |

## 2. Capital ships (30)

| Side | RefinedMaterialCost | MaintenanceCost | ResearchOrder | ResearchDifficulty | UprisingDefense | Detection | ShieldStrength | SubLightEngine | Maneuverability | Hyperdrive | HyperdriveIfDamaged | TurbolaserFore | IonCannonFore | LaserCannonFore | TurbolaserAft | IonCannonAft | LaserCannonAft | TurbolaserPort | IonCannonPort | LaserCannonPort | TurbolaserStarboard | IonCannonStarboard | LaserCannonStarboard | TurbolaserRange | IonCannonRange | LaserCannonRange | TurbolaserAttackStrength | IonCannonAttackStrength | LaserCannonAttackStrength | OverallAttackStrength | Hull | TractorBeamPower | TractorBeamRange | GravityWellProjector | InterdictionStrength | BombardmentModifier | DamageControl | WeaponRechargeRate | ShieldRechargeRate | FighterCapacity | TroopCapacity | Name |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A | 92 | 70 | 2 | 24 | 42 | 10 | 300 | 4 | 2 | 60 | 100 | 60 | 40 | 0 | 60 | 40 | 0 | 120 | 60 | 0 | 120 | 60 | 0 | 50 | 35 | 0 | 360 | 200 | 0 | 560 | 2400 | 2 | 20 | 0 | 0 | 2 | 50 | 18 | 15 | 3 | 1 | Mon Calamari Cruiser |
| A | 30 | 30 | 0 | 0 | 15 | 10 | 200 | 3 | 1 | 80 | 120 | 15 | 0 | 0 | 0 | 0 | 0 | 30 | 0 | 0 | 30 | 0 | 0 | 35 | 0 | 0 | 75 | 0 | 0 | 75 | 1200 | 1 | 20 | 0 | 0 | 1 | 5 | 6 | 10 | 0 | 0 | Bulk Cruiser |
| A | 60 | 60 | 7 | 60 | 30 | 15 | 600 | 5 | 2 | 80 | 120 | 70 | 50 | 0 | 0 | 0 | 0 | 120 | 40 | 0 | 120 | 40 | 0 | 60 | 35 | 0 | 310 | 130 | 0 | 440 | 1400 | 0 | 0 | 0 | 0 | 2 | 30 | 16 | 30 | 0 | 0 | Assault Frigate |
| A | 34 | 35 | 1 | 12 | 15 | 30 | 300 | 3 | 2 | 80 | 120 | 80 | 0 | 60 | 0 | 0 | 60 | 40 | 0 | 30 | 40 | 0 | 30 | 60 | 0 | 17 | 160 | 0 | 180 | 340 | 600 | 1 | 20 | 0 | 0 | 1 | 20 | 12 | 15 | 2 | 0 | Nebulon-B Frigate |
| A | 32 | 29 | 0 | 0 | 10 | 10 | 200 | 2 | 1 | 80 | 120 | 0 | 0 | 30 | 0 | 0 | 0 | 0 | 0 | 60 | 0 | 0 | 60 | 0 | 0 | 17 | 0 | 0 | 150 | 150 | 900 | 0 | 0 | 0 | 0 | 0 | 5 | 4 | 10 | 6 | 0 | Alliance Escort Carrier |
| A | 14 | 23 | 0 | 0 | 7 | 20 | 200 | 6 | 3 | 80 | 0 | 0 | 0 | 120 | 0 | 0 | 90 | 0 | 0 | 120 | 0 | 0 | 120 | 0 | 0 | 17 | 0 | 0 | 450 | 450 | 500 | 0 | 0 | 0 | 0 | 1 | 10 | 8 | 10 | 0 | 0 | Corellian Corvette |
| A | 10 | 12 | 0 | 0 | 3 | 5 | 100 | 2 | 2 | 100 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 30 | 0 | 0 | 30 | 0 | 0 | 17 | 0 | 0 | 60 | 60 | 360 | 0 | 0 | 0 | 0 | 0 | 5 | 2 | 5 | 0 | 2 | Medium Transport |
| A | 24 | 22 | 0 | 0 | 6 | 1 | 200 | 1 | 1 | 90 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 600 | 0 | 0 | 0 | 0 | 0 | 5 | 0 | 10 | 0 | 6 | Bulk Transport |
| A | 10 | 23 | 4 | 48 | 5 | 30 | 200 | 10 | 4 | 80 | 160 | 0 | 0 | 90 | 0 | 0 | 90 | 0 | 0 | 150 | 0 | 0 | 150 | 0 | 0 | 25 | 0 | 0 | 480 | 480 | 300 | 0 | 0 | 0 | 0 | 0 | 20 | 10 | 10 | 0 | 0 | Corellian Gunship |
| A | 44 | 33 | 0 | 0 | 19 | 10 | 200 | 3 | 1 | 80 | 180 | 40 | 0 | 0 | 20 | 0 | 0 | 70 | 0 | 0 | 70 | 0 | 0 | 60 | 0 | 0 | 200 | 0 | 0 | 200 | 1200 | 0 | 0 | 0 | 0 | 1 | 10 | 7 | 10 | 1 | 2 | Alliance Dreadnaught |
| A | 42 | 37 | 6 | 70 | 17 | 10 | 300 | 4 | 1 | 70 | 140 | 10 | 0 | 60 | 0 | 0 | 90 | 20 | 0 | 90 | 20 | 0 | 90 | 50 | 0 | 17 | 50 | 0 | 330 | 380 | 1400 | 1 | 20 | 4 | 100 | 1 | 30 | 8 | 15 | 0 | 0 | CC-7700 Frigate |
| A | 248 | 175 | 11 | 100 | 110 | 10 | 1100 | 3 | 2 | 60 | 100 | 600 | 200 | 0 | 120 | 80 | 0 | 300 | 150 | 0 | 300 | 150 | 0 | 70 | 40 | 0 | 1320 | 580 | 0 | 1900 | 3000 | 6 | 20 | 0 | 0 | 4 | 40 | 80 | 60 | 10 | 4 | Bulwark Battlecruiser |
| A | 66 | 55 | 8 | 80 | 34 | 10 | 600 | 4 | 2 | 80 | 120 | 40 | 40 | 0 | 40 | 0 | 0 | 80 | 80 | 0 | 80 | 80 | 0 | 60 | 40 | 0 | 240 | 200 | 0 | 440 | 1840 | 1 | 20 | 0 | 0 | 2 | 25 | 16 | 30 | 6 | 3 | Liberator Cruiser |
| A | 58 | 53 | 9 | 80 | 28 | 10 | 600 | 6 | 2 | 60 | 100 | 60 | 40 | 0 | 40 | 0 | 0 | 120 | 40 | 0 | 120 | 40 | 0 | 75 | 35 | 0 | 340 | 120 | 0 | 460 | 1200 | 1 | 20 | 0 | 0 | 1 | 35 | 16 | 30 | 0 | 1 | CC-9600 Frigate |
| A | 136 | 90 | 10 | 100 | 62 | 10 | 800 | 4 | 1 | 60 | 100 | 120 | 60 | 0 | 60 | 60 | 0 | 200 | 200 | 0 | 200 | 200 | 0 | 65 | 40 | 0 | 580 | 520 | 0 | 1100 | 2200 | 2 | 20 | 0 | 0 | 2 | 45 | 40 | 20 | 4 | 2 | Dauntless Cruiser |
| E | 70 | 60 | 9 | 80 | 34 | 10 | 600 | 4 | 2 | 80 | 120 | 120 | 60 | 0 | 80 | 0 | 0 | 40 | 40 | 0 | 40 | 40 | 0 | 60 | 60 | 0 | 280 | 140 | 0 | 420 | 1600 | 3 | 20 | 0 | 0 | 1 | 10 | 18 | 30 | 1 | 0 | Strike Cruiser |
| E | 14 | 30 | 2 | 28 | 7 | 30 | 300 | 6 | 3 | 80 | 140 | 0 | 0 | 150 | 0 | 0 | 150 | 0 | 0 | 150 | 0 | 0 | 150 | 0 | 0 | 17 | 0 | 0 | 600 | 600 | 500 | 0 | 0 | 0 | 0 | 0 | 20 | 10 | 15 | 0 | 0 | Lancer Frigate |
| E | 40 | 34 | 6 | 70 | 16 | 30 | 600 | 4 | 1 | 80 | 100 | 10 | 0 | 90 | 0 | 0 | 0 | 20 | 10 | 60 | 20 | 10 | 60 | 50 | 35 | 17 | 50 | 20 | 210 | 280 | 1200 | 0 | 0 | 4 | 100 | 0 | 10 | 7 | 15 | 0 | 0 | Interdictor Cruiser |
| E | 26 | 24 | 0 | 0 | 13 | 20 | 200 | 6 | 2 | 60 | 120 | 5 | 0 | 60 | 5 | 0 | 60 | 15 | 0 | 90 | 15 | 0 | 90 | 50 | 0 | 17 | 40 | 0 | 300 | 340 | 1000 | 1 | 20 | 0 | 0 | 1 | 30 | 6 | 10 | 0 | 0 | Carrack Light Cruiser |
| E | 68 | 44 | 0 | 0 | 30 | 10 | 200 | 3 | 1 | 60 | 140 | 120 | 0 | 0 | 0 | 0 | 0 | 100 | 0 | 0 | 100 | 0 | 0 | 50 | 0 | 0 | 320 | 0 | 0 | 320 | 1800 | 2 | 20 | 0 | 0 | 4 | 20 | 12 | 10 | 2 | 2 | Victory Destroyer |
| E | 112 | 71 | 0 | 0 | 47 | 10 | 300 | 4 | 1 | 80 | 100 | 100 | 100 | 0 | 40 | 40 | 0 | 60 | 40 | 0 | 60 | 40 | 0 | 50 | 35 | 0 | 260 | 220 | 0 | 480 | 2750 | 3 | 20 | 0 | 0 | 2 | 30 | 20 | 15 | 6 | 3 | Imperial Star Destroyer |
| E | 282 | 170 | 11 | 100 | 120 | 5 | 1200 | 2 | 1 | 80 | 110 | 500 | 200 | 0 | 150 | 100 | 0 | 300 | 200 | 0 | 300 | 200 | 0 | 70 | 40 | 0 | 1250 | 700 | 0 | 1950 | 5000 | 6 | 20 | 0 | 0 | 3 | 20 | 70 | 60 | 12 | 9 | Super Star Destroyer |
| E | 12 | 29 | 5 | 40 | 5 | 1 | 300 | 8 | 3 | 50 | 100 | 0 | 0 | 150 | 0 | 0 | 0 | 0 | 0 | 60 | 0 | 0 | 60 | 0 | 0 | 25 | 0 | 0 | 270 | 270 | 320 | 0 | 0 | 0 | 0 | 0 | 10 | 10 | 15 | 0 | 1 | Assault Transport |
| E | 584 | 600 | 0 | 0 | 250 | 5 | 2000 | 1 | 0 | 80 | 140 | 1400 | 400 | 0 | 1400 | 400 | 0 | 1400 | 400 | 0 | 1400 | 400 | 0 | 60 | 40 | 0 | 5600 | 1600 | 0 | 7200 | 25000 | 15 | 24 | 0 | 0 | 15 | 60 | 180 | 100 | 24 | 18 | Death Star |
| E | 10 | 10 | 0 | 0 | 3 | 1 | 100 | 2 | 1 | 80 | 140 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 300 | 0 | 0 | 0 | 0 | 0 | 5 | 0 | 5 | 0 | 2 | Galleon |
| E | 72 | 63 | 7 | 80 | 34 | 10 | 600 | 4 | 2 | 60 | 140 | 120 | 40 | 0 | 80 | 40 | 0 | 80 | 40 | 0 | 80 | 40 | 0 | 60 | 35 | 0 | 360 | 160 | 0 | 520 | 1800 | 2 | 20 | 0 | 0 | 5 | 25 | 16 | 30 | 2 | 0 | Victory II Star Destroyer |
| E | 158 | 99 | 10 | 100 | 70 | 10 | 800 | 4 | 1 | 60 | 100 | 200 | 200 | 0 | 60 | 20 | 0 | 120 | 80 | 0 | 120 | 80 | 0 | 70 | 40 | 0 | 500 | 380 | 0 | 880 | 3000 | 3 | 20 | 0 | 0 | 2 | 35 | 40 | 20 | 6 | 3 | Imperial II Star Destroyer |
| E | 15 | 20 | 4 | 24 | 5 | 4 | 200 | 3 | 1 | 80 | 140 | 0 | 0 | 0 | 0 | 0 | 30 | 0 | 0 | 30 | 0 | 0 | 30 | 0 | 0 | 17 | 0 | 0 | 90 | 90 | 400 | 0 | 0 | 0 | 0 | 0 | 5 | 1 | 10 | 0 | 3 | Star Galleon |
| E | 34 | 30 | 0 | 0 | 11 | 4 | 200 | 3 | 1 | 80 | 140 | 0 | 0 | 30 | 0 | 0 | 30 | 0 | 0 | 60 | 0 | 0 | 60 | 0 | 0 | 17 | 0 | 0 | 180 | 180 | 1000 | 0 | 0 | 0 | 0 | 0 | 5 | 4 | 10 | 6 | 0 | Imperial Escort Carrier |
| E | 44 | 33 | 0 | 0 | 19 | 10 | 200 | 3 | 1 | 80 | 180 | 40 | 0 | 0 | 20 | 0 | 0 | 70 | 0 | 0 | 70 | 0 | 0 | 60 | 0 | 0 | 200 | 0 | 0 | 200 | 1200 | 0 | 0 | 0 | 0 | 1 | 10 | 7 | 10 | 1 | 2 | Imperial Dreadnaught |

## 3. Troops (10)

| Side | RefinedMaterialCost | MaintenanceCost | ResearchOrder | ResearchDifficulty | UprisingDefense | Detection | BombardmentDefense | AttackStrength | DefenseStrength | Name |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A | 8 | 6 | 0 | 0 | 5 | 15 | 5 | 6 | 3 | Alliance Fleet Regiment |
| A | 6 | 3 | 0 | 0 | 5 | 10 | 5 | 3 | 5 | Alliance Army Regiment |
| A | 3 | 1 | 1 | 12 | 3 | 35 | 2 | 1 | 4 | Sullustan Regiment |
| A | 10 | 8 | 3 | 60 | 6 | 20 | 4 | 8 | 4 | Wookiee Regiment |
| A | 6 | 4 | 2 | 40 | 5 | 20 | 9 | 2 | 8 | Mon Calamari Regiment |
| E | 9 | 6 | 0 | 0 | 6 | 25 | 6 | 6 | 6 | Stormtrooper Regiment |
| E | 7 | 5 | 0 | 0 | 5 | 20 | 2 | 5 | 3 | Imperial Fleet Regiment |
| E | 6 | 3 | 0 | 0 | 5 | 15 | 5 | 3 | 5 | Imperial Army Regiment |
| E | 9 | 8 | 1 | 46 | 5 | 5 | 2 | 8 | 2 | War Droid Regiment |
| E | 12 | 8 | 2 | 66 | 8 | 30 | 6 | 8 | 8 | Dark Trooper Regiment |

## 4. Facilities — Defense (6)

| Side | RefinedMaterialCost | MaintenanceCost | ResearchOrder | ResearchDifficulty | BombardmentDefense | AttackStrength | ShieldStrength | Name |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| AE | 4 | 4 | 0 | 0 | 5 | 2000 | 0 | KDY-150 |
| AE | 7 | 7 | 0 | 0 | 4 | 800 | 0 | LNR Series I |
| AE | 12 | 12 | 0 | 0 | 2 | 0 | 40 | GenCore Level I |
| E | 25 | 20 | 3 | 24 | 1 | 0 | 0 | Death Star Shield |
| AE | 10 | 4 | 4 | 40 | 3 | 5000 | 0 | LNR Series II |
| AE | 20 | 7 | 6 | 40 | 3 | 0 | 80 | GenCore Level II |

## 4. Facilities — Manufacturing (6)

| Side | RefinedMaterialCost | MaintenanceCost | ResearchOrder | ResearchDifficulty | BombardmentDefense | ProcessingRate | Name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| AE | 20 | 13 | 0 | 0 | 2 | 4 | Orbital Shipyard |
| AE | 10 | 10 | 0 | 0 | 3 | 4 | Training Facility |
| AE | 10 | 10 | 0 | 0 | 3 | 4 | Construction Yard |
| AE | 20 | 20 | 5 | 60 | 2 | 2 | Advanced Shipyard |
| AE | 10 | 10 | 1 | 24 | 4 | 2 | Advanced Training Facility |
| AE | 10 | 10 | 2 | 40 | 4 | 2 | Advanced Construction Yard |

## 4. Facilities — Production (2)

| Side | RefinedMaterialCost | MaintenanceCost | ResearchOrder | ResearchDifficulty | BombardmentDefense | ProcessingRate | Name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| AE | 20 | 0 | 0 | 0 | 5 | 5 | Mine |
| AE | 20 | 0 | 0 | 0 | 2 | 5 | Refinery |

## 5. Special forces (9)

| Side | RefinedMaterialCost | MaintenanceCost | DiplomacyBase | DiplomacyVariance | EspionageBase | EspionageVariance | CombatBase | CombatVariance | LeadershipBase | LeadershipVariance | LoyaltyBase | LoyaltyVariance | MissionId | Name |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A | 1 | 1 | 0 | 0 | 55 | 0 | 20 | 0 | 50 | 0 | 100 | 0 | 1 | Guerrillas |
| A | 2 | 1 | 0 | 0 | 60 | 0 | 55 | 0 | 0 | 0 | 100 | 0 | 2 | Infiltrators |
| A | 2 | 1 | 0 | 0 | 40 | 0 | 30 | 0 | 0 | 0 | 100 | 0 | 4 | Longprobe Y-wing Recon Team |
| A | 1 | 1 | 0 | 0 | 70 | 0 | 0 | 0 | 0 | 0 | 100 | 0 | 8 | Bothan Spies |
| E | 1 | 1 | 0 | 0 | 30 | 0 | 10 | 0 | 0 | 0 | 100 | 0 | 256 | Imperial Probe Droid |
| E | 1 | 1 | 0 | 0 | 60 | 0 | 5 | 0 | 0 | 0 | 100 | 0 | 512 | Imperial Espionage Droid |
| E | 2 | 1 | 0 | 0 | 55 | 0 | 55 | 0 | 50 | 0 | 100 | 0 | 1024 | Imperial Commandos |
| E | 2 | 1 | 0 | 0 | 55 | 0 | 70 | 0 | 0 | 0 | 100 | 0 | 2048 | Noghri Death Commandos |
| E | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 100 | 0 | 4096 | Bounty Hunters |

## 6. Characters — Major (6)

Base/Variance pairs are the attribute roll range.

| Side | MaintenanceCost | DiplomacyBase | DiplomacyVariance | EspionageBase | EspionageVariance | ShipDesignBase | ShipDesignVariance | TroopTrainingBase | TroopTrainingVariance | FacilityDesignBase | FacilityDesignVariance | CombatBase | CombatVariance | LeadershipBase | LeadershipVariance | LoyaltyBase | LoyaltyVariance | JediProbability | IsKnownJedi | JediLevelBase | JediLevelVariance | CanBeAdmiral | CanBeCommander | CanBeGeneral | IsUnableToBetray | IsJediTrainer | Name |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A | 0 | 100 | 0 | 10 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 10 | 0 | 100 | 0 | 100 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | Mon Mothma |
| A | 0 | 120 | 0 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 50 | 0 | 70 | 0 | 100 | 0 | 100 | 0 | 10 | 0 | 0 | 0 | 0 | 1 | 0 | Leia Organa |
| A | 0 | 50 | 0 | 50 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 90 | 0 | 70 | 0 | 100 | 0 | 100 | 1 | 50 | 0 | 1 | 1 | 1 | 1 | 1 | Luke Skywalker |
| A | 0 | 10 | 0 | 100 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 100 | 0 | 90 | 0 | 100 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 0 | Han Solo |
| E | 0 | 30 | 0 | 20 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 50 | 0 | 100 | 0 | 100 | 0 | 100 | 1 | 150 | 0 | 0 | 0 | 0 | 1 | 0 | Emperor Palpatine |
| E | 0 | 40 | 0 | 50 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 100 | 0 | 100 | 0 | 100 | 0 | 100 | 1 | 120 | 0 | 1 | 1 | 1 | 1 | 1 | Darth Vader |

## 6. Characters — Minor (54)

Base/Variance pairs are the attribute roll range.

| Side | MaintenanceCost | DiplomacyBase | DiplomacyVariance | EspionageBase | EspionageVariance | ShipDesignBase | ShipDesignVariance | TroopTrainingBase | TroopTrainingVariance | FacilityDesignBase | FacilityDesignVariance | CombatBase | CombatVariance | LeadershipBase | LeadershipVariance | LoyaltyBase | LoyaltyVariance | JediProbability | IsKnownJedi | JediLevelBase | JediLevelVariance | CanBeAdmiral | CanBeCommander | CanBeGeneral | IsUnableToBetray | IsJediTrainer | Name |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| A | 0 | 0 | 30 | 0 | 50 | 40 | 60 | 0 | 0 | 0 | 0 | 0 | 50 | 90 | 10 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 0 | 1 | 1 | 0 | Ackbar |
| A | 0 | 0 | 30 | 70 | 30 | 40 | 60 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 1 | 0 | Wedge Antilles |
| A | 0 | 70 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 40 | 60 | 70 | 30 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Lando Calrissian |
| A | 0 | 0 | 30 | 90 | 10 | 0 | 0 | 0 | 0 | 0 | 0 | 90 | 10 | 0 | 30 | 100 | 0 | 10 | 0 | 10 | 40 | 0 | 0 | 0 | 1 | 0 | Chewbacca |
| A | 0 | 70 | 30 | 0 | 50 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 50 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 0 | 1 | 0 | 0 | Jan Dodonna |
| A | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 40 | 60 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 20 | 0 | 10 | 40 | 0 | 0 | 1 | 0 | 0 | Crix Madine |
| A | 0 | 0 | 30 | 0 | 50 | 0 | 0 | 40 | 60 | 0 | 0 | 0 | 50 | 80 | 20 | 100 | 0 | 20 | 0 | 10 | 40 | 0 | 0 | 1 | 0 | 0 | Carlist Rieekan |
| A | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 20 | 0 | 20 | 30 | 1 | 1 | 1 | 0 | 0 | Afyon |
| A | 0 | 70 | 30 | 0 | 50 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 50 | 80 | 20 | 100 | 0 | 20 | 0 | 10 | 40 | 1 | 0 | 1 | 0 | 0 | Drayson |
| A | 0 | 80 | 20 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 0 | 30 | 100 | 0 | 20 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Borsk Fey'lya |
| A | 0 | 0 | 30 | 90 | 10 | 0 | 0 | 0 | 0 | 0 | 0 | 80 | 20 | 0 | 30 | 100 | 0 | 20 | 0 | 20 | 30 | 0 | 0 | 0 | 0 | 0 | Tura Raftican |
| A | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 20 | 0 | 10 | 40 | 0 | 1 | 1 | 0 | 0 | Bren Derlin |
| A | 0 | 0 | 30 | 80 | 20 | 0 | 0 | 0 | 0 | 0 | 0 | 80 | 20 | 80 | 20 | 100 | 0 | 20 | 0 | 10 | 40 | 1 | 0 | 1 | 0 | 0 | Garm Bel Iblis |
| A | 0 | 80 | 20 | 0 | 50 | 0 | 0 | 0 | 0 | 40 | 60 | 0 | 50 | 80 | 20 | 100 | 0 | 20 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Talon Karrde |
| A | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 20 | 0 | 10 | 40 | 0 | 1 | 1 | 0 | 0 | Narra |
| A | 0 | 0 | 30 | 80 | 20 | 0 | 0 | 0 | 0 | 0 | 0 | 80 | 20 | 80 | 20 | 100 | 0 | 20 | 0 | 10 | 40 | 1 | 0 | 1 | 0 | 0 | Huoba Neva |
| A | 0 | 0 | 30 | 90 | 10 | 0 | 0 | 0 | 0 | 0 | 0 | 90 | 10 | 0 | 30 | 100 | 0 | 20 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Page |
| A | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 20 | 0 | 30 | 20 | 1 | 1 | 0 | 0 | 0 | Syub Snunb |
| A | 0 | 0 | 30 | 0 | 50 | 40 | 60 | 40 | 60 | 40 | 60 | 0 | 50 | 90 | 10 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Adar Tallon |
| A | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 20 | 0 | 10 | 40 | 1 | 0 | 1 | 0 | 0 | Sarin Virgilio |
| A | 0 | 70 | 30 | 0 | 50 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 50 | 80 | 20 | 100 | 0 | 20 | 0 | 10 | 40 | 1 | 0 | 1 | 0 | 0 | Vanden Willard |
| A | 0 | 0 | 30 | 80 | 20 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 20 | 0 | 10 | 40 | 1 | 1 | 0 | 0 | 0 | Roget Jiriss |
| A | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 90 | 10 | 100 | 0 | 20 | 0 | 30 | 20 | 0 | 0 | 1 | 0 | 0 | Kaiya Andrimetrum |
| A | 0 | 0 | 30 | 80 | 20 | 0 | 0 | 0 | 0 | 0 | 0 | 80 | 20 | 0 | 30 | 100 | 0 | 20 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Mazer Rackus |
| A | 0 | 0 | 30 | 90 | 10 | 0 | 0 | 0 | 0 | 0 | 0 | 80 | 20 | 0 | 30 | 100 | 0 | 20 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Orrimaarko |
| A | 0 | 0 | 30 | 90 | 10 | 0 | 0 | 0 | 0 | 0 | 0 | 80 | 20 | 0 | 30 | 100 | 0 | 20 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Ma'w'shiye |
| E | 0 | 70 | 30 | 0 | 50 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 50 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Jerjerrod |
| E | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 0 | 1 | 0 | 0 | Ozzel |
| E | 0 | 70 | 30 | 0 | 50 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 50 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Piett |
| E | 0 | 0 | 30 | 0 | 50 | 0 | 0 | 40 | 60 | 0 | 0 | 0 | 50 | 90 | 10 | 100 | 0 | 10 | 0 | 10 | 40 | 0 | 0 | 1 | 0 | 0 | Veers |
| E | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Brandei |
| E | 0 | 0 | 30 | 0 | 50 | 0 | 0 | 40 | 60 | 0 | 0 | 0 | 50 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 0 | 0 | 1 | 0 | 0 | Covell |
| E | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Dorja |
| E | 0 | 70 | 30 | 0 | 50 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 50 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Bin Essada |
| E | 0 | 0 | 30 | 80 | 20 | 0 | 0 | 0 | 0 | 0 | 0 | 80 | 20 | 0 | 30 | 100 | 0 | 20 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Niles Ferrier |
| E | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Grammel |
| E | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 0 | 1 | 0 | 0 | Griff |
| E | 0 | 0 | 30 | 0 | 50 | 40 | 60 | 0 | 0 | 0 | 0 | 0 | 50 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 0 | 1 | 0 | 0 | Klev |
| E | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Needa |
| E | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Bane Nothos |
| E | 0 | 0 | 30 | 0 | 50 | 0 | 0 | 0 | 0 | 40 | 60 | 0 | 50 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 0 | 0 | 1 | 0 | 0 | Orlok |
| E | 0 | 70 | 30 | 0 | 50 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 50 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Pellaeon |
| E | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 90 | 10 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Screed |
| E | 0 | 0 | 30 | 0 | 50 | 40 | 60 | 0 | 0 | 0 | 0 | 70 | 30 | 100 | 30 | 100 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 0 | 0 | Thrawn |
| E | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Zuggs |
| E | 0 | 0 | 30 | 70 | 30 | 0 | 0 | 0 | 0 | 0 | 0 | 70 | 30 | 90 | 10 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Daala |
| E | 0 | 70 | 30 | 0 | 50 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 50 | 80 | 20 | 100 | 0 | 10 | 0 | 10 | 40 | 1 | 1 | 1 | 0 | 0 | Pter Thanas |
| E | 0 | 0 | 30 | 0 | 50 | 50 | 50 | 50 | 50 | 50 | 50 | 0 | 50 | 0 | 30 | 100 | 0 | 10 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Bevel Lemelisk |
| E | 0 | 0 | 30 | 90 | 10 | 0 | 0 | 0 | 0 | 0 | 0 | 80 | 20 | 0 | 30 | 100 | 0 | 10 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Shenir Rix |
| E | 0 | 0 | 30 | 90 | 10 | 0 | 0 | 0 | 0 | 0 | 0 | 80 | 20 | 0 | 30 | 100 | 0 | 10 | 0 | 30 | 20 | 0 | 0 | 0 | 0 | 0 | Noval Garaint |
| E | 0 | 0 | 30 | 80 | 20 | 0 | 0 | 0 | 0 | 0 | 0 | 80 | 20 | 0 | 30 | 100 | 0 | 10 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Garindan |
| E | 0 | 0 | 30 | 80 | 20 | 0 | 0 | 0 | 0 | 0 | 0 | 90 | 10 | 0 | 30 | 100 | 0 | 10 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Menndo |
| E | 0 | 0 | 30 | 80 | 20 | 0 | 0 | 0 | 0 | 0 | 0 | 90 | 10 | 0 | 30 | 100 | 0 | 10 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Labansat |
| E | 0 | 0 | 30 | 80 | 20 | 0 | 0 | 0 | 0 | 40 | 60 | 70 | 30 | 0 | 30 | 100 | 0 | 10 | 0 | 10 | 40 | 0 | 0 | 0 | 0 | 0 | Villar |

## 7. Sectors (20)

| GalaxySize | XPosition | YPosition | Name |
| --- | --- | --- | --- |
| Huge | 492 | 604 | Mid Rim South |
| Huge | 372 | 67 | Outer Rim North |
| Standard | 311 | 631 | Outer Rim West |
| Standard | 332 | 412 | Deep Core |
| Standard | 508 | 185 | Mandalorian Space |
| Huge | 498 | 336 | Colonies |
| Standard | 468 | 736 | Outer Rim South |
| Huge | 462 | 444 | Core Worlds South |
| Large | 757 | 241 | Outer Rim East |
| Large | 776 | 138 | Tingel Arm |
| Large | 765 | 364 | Hutt Space |
| Large | 342 | 734 | Western Reaches |
| Standard | 632 | 314 | Crossroads |
| Standard | 344 | 173 | Mid Rim North |
| Standard | 741 | 546 | Bothan Space |
| Large | 107 | 356 | Unknown Regions |
| Standard | 407 | 308 | Core Worlds North |
| Standard | 574 | 478 | Inner Rim |
| Standard | 666 | 135 | Sith Worlds |
| Huge | 661 | 642 | Wild Space |

## 8. Systems (200, map-useful columns only)

Full rows (picture IDs etc.) live in `files/systems.csv`. SectorId joins to §7.

| Name | SectorId | XPosition | YPosition |
| --- | --- | --- | --- |
| Shadda-Bi-Boran | 20 | 517 | 688 |
| Malastare | 20 | 516 | 652 |
| Pax | 20 | 537 | 639 |
| D'Qar | 20 | 536 | 680 |
| Naboo | 20 | 536 | 661 |
| Yag'Dhul | 20 | 499 | 631 |
| Thyferra | 20 | 516 | 613 |
| Farstine | 20 | 555 | 669 |
| Wroona | 20 | 518 | 634 |
| Ghorman | 20 | 497 | 611 |
| Dantooine | 21 | 416 | 132 |
| Sernpidal | 21 | 434 | 89 |
| Lah'Mu | 21 | 435 | 125 |
| Jaemus | 21 | 396 | 124 |
| Muunilinst | 21 | 396 | 145 |
| Dubrillion | 21 | 416 | 112 |
| Mortis | 21 | 402 | 74 |
| Kalee | 21 | 376 | 129 |
| Ord Trasi | 21 | 427 | 149 |
| Bescane | 21 | 384 | 104 |
| Ajan Kloss | 24 | 513 | 200 |
| Mandalore | 24 | 571 | 247 |
| Celanon | 24 | 571 | 205 |
| Vinsoth | 24 | 552 | 195 |
| Taris | 24 | 552 | 242 |
| Agamar | 24 | 533 | 192 |
| Dathomir | 24 | 552 | 217 |
| Corsin | 24 | 537 | 269 |
| Ithor | 24 | 523 | 233 |
| Concord Dawn | 24 | 561 | 265 |
| Kef Bir | 22 | 321 | 678 |
| Cyphar | 22 | 363 | 676 |
| Sullust | 22 | 374 | 699 |
| Endor | 22 | 340 | 671 |
| Bakura | 22 | 316 | 656 |
| Karfeddion | 22 | 348 | 697 |
| Rattatak | 22 | 323 | 638 |
| Belsavis | 22 | 355 | 715 |
| Dolla | 22 | 335 | 715 |
| Takodana | 22 | 346 | 642 |
| Empress Teta | 23 | 392 | 420 |
| Tython | 23 | 393 | 439 |
| Jakku | 23 | 349 | 488 |
| Wellspring of Life | 23 | 389 | 458 |
| Jedha | 23 | 344 | 419 |
| Byss | 23 | 362 | 461 |
| Rakata Prime | 23 | 338 | 460 |
| Fondor | 23 | 395 | 496 |
| Abregado-rae | 23 | 375 | 484 |
| N'Zoth | 23 | 372 | 423 |
| Neimoidia | 25 | 530 | 401 |
| Commenor | 25 | 554 | 410 |
| Delaya | 25 | 503 | 375 |
| Kuat | 25 | 510 | 394 |
| Cato Neimoidia | 25 | 534 | 420 |
| Tirahnn | 25 | 539 | 343 |
| Carida | 25 | 518 | 354 |
| Hapes | 25 | 561 | 365 |
| Balmorra | 25 | 530 | 382 |
| Taanab | 25 | 561 | 346 |
| Bith | 26 | 487 | 764 |
| Crait | 26 | 531 | 743 |
| Kabal | 26 | 529 | 766 |
| Sorgan | 26 | 499 | 820 |
| Dagobah | 26 | 503 | 802 |
| Utapau | 26 | 522 | 806 |
| Triton | 26 | 506 | 766 |
| Sluis Van | 26 | 500 | 784 |
| Mustafar | 26 | 473 | 792 |
| Eriadu | 26 | 493 | 746 |
| Duro | 27 | 499 | 451 |
| Nubia | 27 | 505 | 474 |
| Bestine IV | 27 | 467 | 528 |
| Hosnian Prime | 27 | 495 | 497 |
| Tralus | 27 | 467 | 473 |
| Exodeen | 27 | 525 | 484 |
| Devaron | 27 | 472 | 509 |
| Corellia | 27 | 486 | 469 |
| Talus | 27 | 476 | 451 |
| Quarzite | 27 | 492 | 525 |
| Sy Myrth | 28 | 770 | 282 |
| Saleucami | 28 | 766 | 302 |
| Sriluur | 28 | 799 | 325 |
| Voss | 28 | 802 | 248 |
| Ossus | 28 | 782 | 255 |
| Tund | 28 | 820 | 313 |
| Dennogra | 28 | 794 | 293 |
| Boonta | 28 | 779 | 321 |
| Iego | 28 | 807 | 273 |
| Belderone | 28 | 762 | 259 |
| Bonadan | 29 | 821 | 144 |
| Pakuuni | 29 | 830 | 185 |
| Quermia | 29 | 790 | 179 |
| Lothal | 29 | 839 | 222 |
| Florn | 29 | 810 | 179 |
| Zygerria | 29 | 781 | 158 |
| Dellalt | 29 | 810 | 217 |
| Mon Cala | 29 | 833 | 203 |
| Cantonica | 29 | 801 | 152 |
| Raxus | 29 | 801 | 198 |
| Quesh | 30 | 801 | 421 |
| Kessel | 30 | 803 | 381 |
| Boz Pity | 30 | 779 | 371 |
| Sleheyron | 30 | 786 | 402 |
| Nar Shaddaa | 30 | 798 | 445 |
| Nal Hutta | 30 | 778 | 448 |
| Honoghr | 30 | 807 | 400 |
| Formos | 30 | 827 | 384 |
| Eadu | 30 | 827 | 404 |
| Toydaria | 30 | 770 | 429 |
| Gerrenthum | 31 | 404 | 748 |
| Nevarro | 31 | 358 | 796 |
| Bespin | 31 | 385 | 758 |
| Hoth | 31 | 385 | 776 |
| Anoat | 31 | 366 | 768 |
| Terminus | 31 | 384 | 817 |
| Polis Massa | 31 | 404 | 814 |
| Isde Naha | 31 | 404 | 784 |
| Lutrillia | 31 | 366 | 750 |
| Lotho Minor | 31 | 347 | 741 |
| Randon | 32 | 687 | 386 |
| Kijimi | 32 | 676 | 339 |
| Zeltros | 32 | 637 | 390 |
| Trandosha | 32 | 660 | 360 |
| Kashyyyk | 32 | 680 | 362 |
| Anaxes | 32 | 669 | 321 |
| Onderon | 32 | 639 | 355 |
| Wobani | 32 | 695 | 329 |
| Umbara | 32 | 657 | 379 |
| Ruusan | 32 | 667 | 398 |
| Yaga Minor | 33 | 371 | 185 |
| Mygeeto | 33 | 391 | 180 |
| Ansion | 33 | 349 | 239 |
| Keitum | 33 | 358 | 220 |
| Earth | 33 | 390 | 226 |
| Glee Anselm | 33 | 356 | 257 |
| Ord Mantell | 33 | 406 | 253 |
| Borosk | 33 | 380 | 204 |
| Iridonia | 33 | 377 | 246 |
| Kaller | 33 | 400 | 197 |
| Rishi | 34 | 780 | 593 |
| Kamino | 34 | 761 | 602 |
| Gamorr | 34 | 801 | 576 |
| Teth | 34 | 804 | 553 |
| Circumtore | 34 | 776 | 554 |
| Ryloth | 34 | 765 | 625 |
| Bothawui | 34 | 767 | 573 |
| Smuggler's Run | 34 | 785 | 630 |
| Scarif | 34 | 799 | 607 |
| Nexus Ortai | 34 | 747 | 578 |
| The Redoubt | 35 | 168 | 379 |
| Ilum | 35 | 146 | 382 |
| Lwhekk | 35 | 125 | 439 |
| Parnassos | 35 | 148 | 363 |
| Nagi | 35 | 113 | 421 |
| Exegol | 35 | 119 | 371 |
| Ahch-to | 35 | 160 | 422 |
| Zonama Sekot | 35 | 143 | 401 |
| Csilla | 35 | 119 | 390 |
| Zakuul | 35 | 135 | 421 |
| Chandrila | 36 | 431 | 353 |
| Sissubo | 36 | 450 | 365 |
| Skako Minor | 36 | 458 | 386 |
| Palanhi | 36 | 413 | 334 |
| Tepasi | 36 | 469 | 368 |
| Coruscant | 36 | 423 | 392 |
| Esseles | 36 | 469 | 343 |
| Wor Tandell | 36 | 413 | 372 |
| Brentaal IV | 36 | 450 | 347 |
| Shili | 36 | 462 | 315 |
| Mimban | 37 | 603 | 505 |
| Chardaan | 37 | 581 | 539 |
| Gamor | 37 | 593 | 560 |
| Vandor | 37 | 633 | 556 |
| Pasaana | 37 | 607 | 528 |
| Denon | 37 | 579 | 520 |
| Milagro | 37 | 613 | 562 |
| Daalang | 37 | 637 | 511 |
| Manaan | 37 | 595 | 485 |
| Makeb | 37 | 636 | 531 |
| Maridun | 38 | 691 | 219 |
| Rhen Var | 38 | 718 | 219 |
| Yavin Prime | 38 | 675 | 200 |
| Moraband | 38 | 703 | 172 |
| Mirial | 38 | 700 | 143 |
| Ziost | 38 | 720 | 152 |
| Dromund Kaas | 38 | 724 | 171 |
| Telos IV | 38 | 680 | 142 |
| Felucia | 38 | 729 | 200 |
| Yavin 4 | 38 | 671 | 182 |
| Christophsis | 39 | 668 | 682 |
| Tatooine | 39 | 705 | 677 |
| Lok | 39 | 686 | 721 |
| Trask | 39 | 714 | 706 |
| Nelvaan | 39 | 668 | 701 |
| Rodia | 39 | 698 | 652 |
| Savareen | 39 | 689 | 695 |
| Mon Gazza | 39 | 667 | 649 |
| Socorro | 39 | 667 | 726 |
| Geonosis | 39 | 724 | 677 |
