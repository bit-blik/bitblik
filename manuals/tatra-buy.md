# Tatra banka — BUY Lightning (generate a code)

For a **Tatra banka account holder** who wants to buy Lightning. You generate a
cardless-withdrawal code in the Tatra app; the seller collects the cash at a
Tatra ATM and your account is debited. (In BitBlik you are the **taker/buyer**.)

> ⚠️ See the ToS/legal note in [README](README.md#-important--dôležité-upozornenie).

---

## EN

### You need
- A Tatra banka account + the **Tatra banka mobile app** (Internet Banking active).
- The BitBlik SK app (Tatra banka market) and a Lightning wallet/address to receive.

### Steps
1. **BitBlik → Tatra banka** market (picked on first launch; switch in **Settings → Country / Payment System**). Browse open **sell offers** and **take** one
   whose € amount you want (10/20/30/50/100/200). (Add a receiving Lightning
   wallet first in **Wallet settings**.)
   ![Buy flow — offer list](screenshots/buy-offer-list.png)
2. BitBlik asks for your **6-digit Tatra code**. Now open the **Tatra banka app**:
   1. On the login screen tap **„Výber z bankomatu"**, authenticate.
   2. Choose the account, enter the **same € amount** as the offer.
   3. Tap **„Skontrolovať"** → confirm. The **„Výsledok"** screen shows a
      **6-digit code** valid **20 minutes**. `[bank: tb_vyber_bankomat.jpg]`
3. **Type that 6-digit code into BitBlik** and submit. `[APP: "Submit code" / Enter 6-digit]`
4. Wait while the **seller withdraws the cash** at a Tatra ATM (your account is
   debited for that amount). `[APP: "Waiting for maker…"]`
5. When they confirm, you **receive the Lightning** to your wallet. Done. `[APP: "Get paid"]`

### Tips
- Generate the code **only after taking the offer** — it lives 20 min.
- The € amount in the Tatra app **must match** the offer amount exactly.
- Cancel the pending withdrawal in the Tatra app if the trade fails.

Bank reference — generate code (app "Výber z bankomatu"): presets
10/20/30/50/100/200 €, „Skontrolovať" → 6-digit code, „Platný do" +20 min.
Image: https://fony.sk/sites/fony.sk/files/media/obr/2014/tb_vyber_bankomat.jpg

---

## SK

### Čo potrebuješ
- Účet v Tatra banke + **mobilnú appku Tatra banka** (aktívny Internet Banking).
- Appku BitBlik SK (trh Tatra banka) a Lightning peňaženku/adresu na prijatie.

### Postup
1. **BitBlik → Tatra banka** (pri prvom spustení vyber tento trh; neskôr v **Settings → Country / Payment System**). Prezri otvorené **ponuky na predaj** a **prijmi**
   tú so sumou v €, ktorú chceš. `[APP: zoznam ponúk, prijať]`
2. BitBlik si vypýta tvoj **6-miestny Tatra kód**. Otvor **appku Tatra banka**:
   1. Na prihlasovacej obrazovke ťukni **„Výber z bankomatu"**, over sa.
   2. Zvoľ účet a zadaj **rovnakú sumu v €** ako ponuka.
   3. **„Skontrolovať"** → potvrď. Obrazovka **„Výsledok"** ukáže **6-miestny
      kód** platný **20 minút**. `[bank: tb_vyber_bankomat.jpg]`
3. **Zadaj tento 6-miestny kód do BitBliku** a odošli. `[APP: zadanie 6-miestneho kódu]`
4. Počkaj, kým **predávajúci vyberie hotovosť** pri Tatra bankomate (z tvojho
   účtu sa suma odpíše). `[APP: „Čaká sa na makera…"]`
5. Po potvrdení **dostaneš Lightning** do peňaženky. Hotovo. `[APP: „Get paid"]`

### Tipy
- Kód generuj **až po prijatí ponuky** — platí 20 minút.
- Suma v € v Tatra appke sa **musí presne zhodovať** so sumou ponuky.
- Ak obchod zlyhá, čakajúci výber v Tatra appke zruš.
