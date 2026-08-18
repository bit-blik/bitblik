# Prima banka — BUY Lightning (generate a code)

For a **Prima banka account holder** (Peňaženka app) who wants to buy Lightning.
You generate a cardless-withdrawal code in Peňaženka; the seller collects the
cash at a Prima banka ATM and your account is debited. (In BitBlik:
**taker/buyer**.)

> ⚠️ See the ToS/legal note in [README](README.md#-important--dôležité-upozornenie).
>
> 📝 The in-app steps below follow Prima banka's own description of the feature
> and still need a pass against the live Peňaženka app — correct them (and drop
> this note) once someone has walked through it.

---

## EN

### You need
- A Prima banka account + the **Peňaženka** app.
- BitBlik SK (Slovakia market) + a Lightning wallet/address to receive.

### Steps
1. **BitBlik → Slovensko** (pick this market on first launch; later in
   **Settings → Country / Payment System**). **Take** a sell offer marked
   **Prima banka** with the € amount you want. `[APP: offer list, take offer]`
2. BitBlik asks for your **6-digit code**. In **Peňaženka**:
   1. Log in → pick the account → **„Výber z bankomatu"**.
   2. Enter the **same € amount** (max **€200** per code) and confirm.
   3. A **one-time code**, valid **30 min**, appears.
3. **Enter the code into BitBlik** and submit. `[APP: Enter 6-digit code]`
4. Wait while the **seller withdraws the cash** at a Prima banka ATM.
   `[APP: "Waiting…"]`
5. On confirmation you **receive Lightning**. Done. `[APP: "Get paid"]`

### Tips
- The 30-minute window is the longest of the four SK banks — you have room, but
  still generate the code after taking the offer. The amount must match.
- Per-withdrawal max **€200**, and **5 codes per day**. BitBlik will not let an
  offer over €200 be created for Prima banka.
- The code only works at **Prima banka** ATMs.

---

## SK

### Čo potrebuješ
- Účet v Prima banke + appku **Peňaženka**.
- BitBlik SK (trh Slovensko) + Lightning peňaženku/adresu na prijatie.

### Postup
1. **BitBlik → Slovensko** (pri prvom spustení vyber tento trh; neskôr v
   **Settings → Country / Payment System**). **Prijmi** ponuku na predaj
   označenú **Prima banka** so sumou v €, ktorú chceš.
   `[APP: zoznam ponúk, prijať]`
2. BitBlik si vypýta **6-miestny kód**. V **Peňaženke**:
   1. Prihlás sa → vyber účet → **„Výber z bankomatu"**.
   2. Zadaj **rovnakú sumu v €** (max **200 €** na jeden kód) a potvrď.
   3. Zobrazí sa **jednorazový kód**, platný **30 min**.
3. **Zadaj kód do BitBliku** a odošli. `[APP: zadanie kódu]`
4. Počkaj, kým **predávajúci vyberie hotovosť** pri bankomate Prima banky.
   `[APP: „Čaká sa…"]`
5. Po potvrdení **dostaneš Lightning**. Hotovo. `[APP: „Get paid"]`

### Tipy
- 30 minút je najdlhšie okno zo štyroch slovenských bánk — máš rezervu, ale kód
  aj tak generuj až po prijatí ponuky. Suma sa musí zhodovať.
- Max na výber **200 €** a **5 kódov denne**. Ponuku nad 200 € ti BitBlik pre
  Prima banku nedovolí vytvoriť.
- Kód funguje len v bankomatoch **Prima banky**.
