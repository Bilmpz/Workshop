# ROUTE//EU · v0.5

Workshop-spil til gymnasieklasser: eleverne skriver JavaScript, der kører en lastbil gennem Europa. 8 baner for begyndere, login med navn, live scoreboard til projektoren og et panel til studieambassadørerne.

## Filer

| Fil | Hvad |
|---|---|
| `index.html` | Hele appen (spil, scoreboard, panel) i én fil |
| `supabase-setup.sql` | Databasen: tabeller, adgang, underviser-PIN, live-opdatering |
| `DESIGN.md` | Design-variablerne (farver, skrift, form) |

## Opsætning (ca. 15 min)

### 1. Database (Supabase)
1. Opret et gratis projekt på supabase.com.
2. Åbn `supabase-setup.sql` og skift `SKIFT-MIG` til jeres PIN-kode (brug et ord, ikke 4 cifre).
3. Supabase → **SQL Editor → New query** → indsæt hele filen → **Run**.
4. Supabase → **Project settings → API**: kopiér **Project URL** og **anon public**-nøglen.
5. Udfyld `CONFIG` øverst i scriptet i `index.html`:

```js
const CONFIG={
  SUPABASE_URL:"https://DIT-PROJEKT.supabase.co",
  SUPABASE_ANON_KEY:"DIN-ANON-NØGLE",
  ADMIN_PIN:"2026",
  ROUND:"AAU"
};
```

`ADMIN_PIN` bruges kun uden Supabase. Med Supabase tjekkes PIN-koden i databasen.

### 2. Hosting (Vercel)
Kør i mappen med `index.html`:

```bash
npx vercel deploy --prod
```

Første gang spørger Vercel om login og projektnavn. Tryk Enter til resten. Linket til siden står til sidst.

## På dagen

| Hvem | Åbner |
|---|---|
| Eleverne | Linket → navn → Start |
| Projektoren | Linket + `#scoreboard` |
| Jer to | Linket + `#panel` → PIN |

- Skriv linket på tavlen. Fanen i browseren hedder "Oliver & Idas oplæg".
- **Pause:** tryk **Sæt pause** i panelet. Alle elever (og projektoren) får "PAUSE, KIG OP" på hele skærmen. Tryk **Fortsæt spillet** for at fortsætte.
- **Ny klasse:** tryk **Ryd runden** i panelet.
- **Fjern** i panelet sletter en enkelt spiller, fx test-spillere.
- Panelet sorterer, så dem der **sidder fast** (6+ forsøg eller over 6 min på samme bane) står øverst.

## Uden Supabase
Tom `SUPABASE_URL` betyder lokal tilstand: data deles kun mellem faner i samme browser. Godt til at teste, ikke til en klasse.

## Baner

Lavet til elever uden erfaring. Hver bane har én ny ting, en kort forklaring i almindeligt dansk ("Sådan virker det") og startkode, hvor kun den nye del mangler.

| # | Bane | Ny ting |
|---|---|---|
| 1 | Første tur | Kommandoer |
| 2 | Motorvejen | for-løkke (skift et tal) |
| 3 | Vejarbejde | while-løkke |
| 4 | Brennerpasset | if |
| 5 | Ringvejen | if / else |
| 6 | Optælling | variabel |
| 7 | Bompenge | switch (3 lande) |
| 8 | GDPR-transporten | og / ikke (&& og !) |

Bane 3–8 laver en ny rute ved hver kørsel, og koden testes på flere ruter. Efter 4 mislykkede forsøg kan man springe en bane over (0 point).

**Point:** 100 pr. bane, −10 pr. linje over par, −30 for hint, mindst 20.

## Kendte begrænsninger
- Anon-nøglen er offentlig. En elev med udviklerværktøjer kan i princippet ændre sin egen score (op til loftet på 1000). Sletning kræver PIN-koden.
- Hvis en spiller fjernes, mens eleven stadig spiller, dukker eleven op igen ved næste kørsel.
