# ROUTE//EU · Design

## Idé
Et stramt arbejdsværktøj. Lys, neutral flade, én blå accent og tynde linjer, ligesom en kodeeditor. Skriften er **IBM Plex Sans** med tabel-tal overalt. Koden står i **IBM Plex Mono**. EU-stjerneringen er logoet og står i accentfarven.

På en computer passer alt på én skærm uden at rulle.

## Fanen og favicon
Fanen hedder **Oliver & Idas oplæg** på alle sider. Faviconet er et accentblåt felt med 12 hvide stjerner. Begge står øverst i `index.html`.

## Regler
- **Én accent:** blå (`--accent`) bruges kun til primær knap, valgt fane/bane, færdig-status, førerpladsen og logoet. Rød og orange er signaler, ikke pynt: kun fejl/slet og "sidder fast".
- **Hjørner:** `--r` (2 px) på alt med en kant. Paneler er flader uden hjørner.
- **Linjer, ikke skygger:** paneler skilles med 1 px linjer. Kun det, der svæver (vinder-boksen, fejlboksen), har `--shadow-float`.
- **Hierarki:** det vigtigste er klart størst: titlen på login, banens navn, scoreboardets point. Etiketter er 12 px versaler i `--text-3`.
- **Afstande:** kun `--s-1` … `--s-8` (4/8/12/16/24/32/48/64).
- **Ingen pynt:** ingen gradienter, prikgitter, emojis eller ikoner i cirkler.
- **Bevægelse:** én kort indgang, lastbilen, konfetti ved levering og pulsen på PAUSE.

## Variabler (øverst i `<style>` i `index.html`)

| Variabel | Bruges til |
|---|---|
| `--bg` / `--surface` / `--surface-2` | Side og felter / paneler / hover |
| `--line` / `--line-strong` | Streger / kanter på knapper og felter |
| `--text` / `--text-2` / `--text-3` | Primær, sekundær og hjælpetekst |
| `--accent`, `--accent-hover`, `--on-accent` | Accent og tekst på accent |
| `--warn` / `--bad` | Sidder fast / fejl og slet (`--ok` peger på accenten) |
| `--code-*` | Syntaksfarver i editoren |
| `--map-*` | Alle farver på kortet (canvas læser dem ved start) |
| `--font-ui` / `--font-mono` | Skrift |
| `--fs-*`, `--w-*` | Skriftstørrelser og -vægte |
| `--s-1` … `--s-8` | Afstande |
| `--r`, `--bw`, `--bw-mark`, `--h-*`, `--mark-*` | Hjørner, linjer, højder, logostørrelser |

## Skift til de endelige farver
1. Ret `--accent` og `--accent-hover`. Hold kontrasten mod hvid på mindst 4,5:1.
2. Vil I have et andet kort, så ret `--map-hue`, `--map-land-s`, `--map-land-l` og `--map-road`.
3. Vil I bruge AAU's skrift, så skift `--font-ui` og linket til Google Fonts øverst i filen.
4. Kortboksens padding må højst være 20 px, fordi `layout()` i scriptet trækker 40 px fra bredden.
