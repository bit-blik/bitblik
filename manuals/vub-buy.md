# VÚB banka — BUY Lightning (generate a code)

For a **VÚB banka account holder** who wants to buy Lightning. You generate a
cardless code in VÚB Mobil Banking; the seller collects the cash at a VÚB ATM and
your account is debited. (In BitBlik: **taker/buyer**.)

> ⏱️ **VÚB codes are valid only 3 MINUTES.** Generate the code **only once the
> seller confirms they are standing at a VÚB ATM.** Much tighter than Tatra
> (20 min) / SLSP (15 min).
> ⚠️ See the ToS/legal note in [README](README.md#-important--dôležité-upozornenie).

---

## EN

### You need
- A VÚB account + the **VÚB Mobil Banking** app (you must be the cardholder of the
  chosen card — codes can't be generated on a card in someone else's name).
- BitBlik SK (VÚB market) + a Lightning wallet/address to receive.

### Steps
1. **BitBlik → VÚB banka** (pick this market on first launch; later in **Settings → Country / Payment System**). **Take** a sell offer with the € amount you want.
   `[APP: offer list, take offer]`
2. Agree a **Doba platnosti** with the seller before generating the code — the
   longer the walk to the ATM, the longer the window they need.
3. In **VÚB Mobil Banking**:
   1. On the **pre-login** screen tap **„Výber z bankomatu"**, then authenticate.
   2. Select your **card**, enter the **same € amount** as the offer, **confirm**.
   3. Set **„Doba platnosti"** — anywhere from **10 to 60 minutes**; BitBlik
      counts down from **10**, so pick 10 only if the seller is already at the
      ATM.
   4. A **6-digit one-time code** appears with that countdown. `[bank: VUB video 1ZscQMZbTME]`
4. **Immediately enter the code into BitBlik** and submit. `[APP: Enter 6-digit code]`
5. The seller withdraws the cash (your account debited); you **receive Lightning**.
   Done. `[APP: "Get paid"]`

### Tips
- BitBlik always assumes the **10-minute floor**, so anything you set above it
  is your own margin. Max **€500** per code, **5 codes/day**.
- If it expires, generate a new one (counts toward the 5/day limit).

---

## SK

### Čo potrebuješ
- Účet vo VÚB + appku **VÚB Mobil Banking** (musíš byť držiteľ zvolenej karty —
  kód sa nedá vygenerovať na karte na meno inej osoby).
- BitBlik SK (trh VÚB) + Lightning peňaženku/adresu na prijatie.

### Postup
1. **BitBlik → VÚB banka** (pri prvom spustení vyber tento trh; neskôr v **Settings → Country / Payment System**). **Prijmi** ponuku na predaj so sumou v €, ktorú chceš.
   `[APP: zoznam ponúk, prijať]`
2. S predávajúcim si vopred dohodni **dobu platnosti** — čím ďalej to má
   k bankomatu, tým dlhšie okno potrebuje.
3. Vo **VÚB Mobil Banking**:
   1. Na obrazovke **pred prihlásením** ťukni **„Výber z bankomatu"**, over sa.
   2. Zvoľ **kartu**, zadaj **rovnakú sumu v €** ako ponuka, **potvrď**.
   3. Nastav **„Dobu platnosti"** — od **10 do 60 minút**; BitBlik odpočítava
      od **10**, takže 10 voľ len vtedy, keď je predávajúci už pri bankomate.
   4. Zobrazí sa **6-miestny jednorazový kód** s týmto odpočtom.
      `[bank: VÚB video 1ZscQMZbTME]`
4. **Hneď zadaj kód do BitBliku** a odošli. `[APP: zadanie 6-miestneho kódu]`
5. Predávajúci vyberie hotovosť (z tvojho účtu sa odpíše); ty **dostaneš
   Lightning**. Hotovo. `[APP: „Get paid"]`

### Tipy
- BitBlik vždy počíta so **spodnou hranicou 10 minút**, takže čokoľvek nad ňu
  je tvoja rezerva. Max **500 €** na kód, **5 kódov/deň**.
- Ak vyprší, vygeneruj nový (počíta sa do limitu 5/deň).
