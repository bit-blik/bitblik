# Tatra banka — SELL Lightning for cash at an ATM

For the person who wants **cash from a Tatra banka ATM** in exchange for their
Lightning. You do **not** need a Tatra banka account — you only type a code at
the ATM. (In BitBlik you are the **maker/seller**.)

> ⚠️ See the ToS/legal note in [README](README.md#-important--dôležité-upozornenie).

---

## EN

### You need
- The BitBlik SK app (Tatra banka market selected).
- A Lightning wallet with enough sats to lock for the trade (+ small fee).
- To be **near a Tatra banka ATM** and online when the buyer is ready.

### Steps
1. **Open BitBlik.** On **first launch** pick **Tatra banka** 🇸🇰 in the market
   picker (to change it later: **Settings → Country / Payment System**).
   `[APP: first-launch market picker → Tatra banka]`
2. **Create a sell offer** (role: *Sell / get cash*). Choose the **amount in €**
   (ATM-dispensable: 10/20/30/50/100/200) and confirm your premium/fee.
   ![Create Offer — ATM category, € presets, Tatra banka koordinátor](screenshots/sell-create-offer-atm.png)
3. **Fund the hold invoice** from your Lightning wallet — this locks your sats
   (they're only captured after you collect the cash). Wait for a taker.
   `[APP: "1. Create Offer > 2. Wait for Taker > 3. Use code"]`
4. When a buyer takes it, BitBlik shows **"Code received!"** with a **6-digit
   code** (e.g. `020 539`) and a validity countdown (**20 min**).
   `[APP: offer details, 6-digit code + "Copy" + ATM instructions]`
5. **Go to any Tatra banka ATM** (do not insert a card):
   1. Press **any physical button beside the screen** to start the cardless flow.
   2. Type the **6-digit code**.
   3. The ATM dispenses the **exact amount** set in the offer (no amount entry).
6. **Collect the cash**, then press **"Confirm successful payment"** in BitBlik.
   The locked sats are released to the buyer. Done.
   `[APP: "Confirm successful payment" button]`

### Tips
- The code is valid **20 minutes** — be at the ATM before you accept.
- Tatra ATMs only. No card, no PIN — the code is the only credential.
- If the code expires or the ATM rejects it, use **"Invalid code"** in BitBlik so
  the buyer isn't charged.

**Official ATM step reference (Tatra app "Výsledok" screen):** go to a Tatra
banka ATM → press any button beside the screen → enter the code.
Bank image (app+ATM flow): https://fony.sk/sites/fony.sk/files/media/obr/2014/tb_vyber_bankomat.jpg

---

## SK

### Čo potrebuješ
- Appku BitBlik SK (zvolený trh **Tatra banka**).
- Lightning peňaženku s dostatkom sats na uzamknutie (+ malý poplatok).
- Byť **pri bankomate Tatra banky** a online, keď je kupujúci pripravený.

### Postup
1. **Otvor BitBlik.** Pri **prvom spustení** vyber v zozname trhov **Tatra banka**
   🇸🇰 (neskôr zmeníš cez **Settings → Country / Payment System**).
   `[APP: výber trhu pri prvom spustení → Tatra banka]`
2. **Vytvor ponuku na predaj** (rola: *Predať / dostať hotovosť*). Zvoľ **sumu v
   €** (bankomatové: 10/20/30/50/100/200) a potvrď premium/poplatok.
   `[APP: formulár sumy, € tlačidlá]`
3. **Zaplať hold faktúru** z Lightning peňaženky — tým sa tvoje sats uzamknú
   (stiahnu sa až po výbere hotovosti). Počkaj na protistranu.
   `[APP: „1. Vytvor ponuku > 2. Čakaj na takera > 3. Použi kód"]`
4. Keď niekto ponuku prijme, BitBlik zobrazí **„Kód prijatý!"** so **6-miestnym
   kódom** (napr. `020 539`) a odpočtom platnosti (**20 min**).
   `[APP: detail ponuky, 6-miestny kód + „Kopírovať" + inštrukcie]`
5. **Choď k ľubovoľnému bankomatu Tatra banky** (nevkladaj kartu):
   1. Stlač **ľubovoľné tlačidlo vedľa obrazovky** (spustí bezkartový výber).
   2. Zadaj **6-miestny kód**.
   3. Bankomat vydá **presnú sumu** z ponuky (sumu už nezadávaš).
6. **Vyber hotovosť** a v BitBliku stlač **„Potvrdiť úspešnú platbu"**. Uzamknuté
   sats sa uvoľnia kupujúcemu. Hotovo.
   `[APP: tlačidlo „Potvrdiť úspešnú platbu"]`

### Tipy
- Kód platí **20 minút** — buď pri bankomate skôr, než ponuku prijmeš.
- Len bankomaty Tatra banky. Bez karty a PIN-u — stačí kód.
- Ak kód vyprší alebo ho bankomat odmietne, použi **„Neplatný kód"**, aby
  kupujúcemu nič nestrhlo.
