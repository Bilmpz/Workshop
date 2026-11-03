# ROUTE//EU · Design v0.5

## Idé
Et europæisk vejskilt. EU-blå flader, gul vejstribe som eneste accent, hvid skiltekant, skarpe hjørner. Skriften er **Overpass**, bygget på de skrifter, man bruger på motorvejsskilte. Koden står i **Overpass Mono**.

Fladen er delt op med tynde streger som en kodeeditor, i stedet for svævende afrundede kort. På en computer passer alt på én skærm uden at rulle.

## Fanen og favicon
Fanen hedder **Oliver & Idas oplæg** på alle sider. Faviconet er et skiltblåt felt med hvid kant og EU's 12 stjerner. Begge står øverst i `index.html`.

## Regler
- **Én accent:** gul bruges kun til den primære knap, den nuværende bane, målet, førerpladsen og point.
- **Skarpe kanter:** 3 px på knapper og felter, 0 på paneler. Ingen piller. Status vises som en lille firkant + versaler.
- **Store kontraster i skrift:** overskrifter i vægt 900 og stramt spatieret, etiketter i 11 px mono med versaler. Intet midt imellem.
- **Ingen pynt:** ingen gradienter, skygger eller ikoner i cirkler. Den eneste baggrundsdetalje er et svagt prikgitter bag kortet.
- **Bevægelse:** én kort indgang (paneler glider 6 px op), lastbilens animation og konfetti ved levering. Intet andet.

## Variabler (øverst i `<style>` i `index.html`)

| Variabel | Nu | Bruges til |
|---|---|---|
| `--ink` | `#102A6E` | Dybeste flade: bag kortet, felter, streger mellem paneler |
| `--surface` | `#173689` | Paneler |
| `--surface-2` | `#1F44A0` | Hover på knapper |
| `--sign` | `#2356D8` | Klar skiltblå: login-skiltet, pause-skærmen, målet på kortet |
| `--line` / `--line-strong` | `#2C4DA8` / `#4566C4` | Streger / kanter på knapper og felter |
| `--text` / `--text-2` / `--text-3` | hvid → dæmpet | Primær, sekundær og hjælpetekst |
| `--yellow` / `--yellow-ink` | `#FFCC00` / `#06102A` | Accent / tekst på gul |
| `--ok` / `--warn` / `--bad` | grøn / orange / rød | I gang / sidder fast / fejl |
| `--code-*` | | Farver i kode-editoren |
| `--map-hue` | `222` | Terrænets farvetone (0–360) |
| `--map-land-l` | `21` | Terrænets lyshed i procent (højere = lysere kort) |
| `--map-road`, `--map-edge`, `--map-package` | | Vej, vejkant, pakker |
| `--font-ui` / `--font-mono` | Overpass / Overpass Mono | Skrift |
| `--r` | `3px` | Hjørner på knapper og felter |

## Skift til de endelige farver
1. Ret `--ink`, `--surface`, `--surface-2` til jeres blå toner (fra mørkest til lysest) og `--sign` til skiltblå.
2. Ret `--yellow`.
3. Hold `--text` tydelig på `--surface` (kontrast mindst 4,5:1).
4. Vil I bruge AAU's skrift, så skift `--font-ui` og linket til Google Fonts øverst i filen.
