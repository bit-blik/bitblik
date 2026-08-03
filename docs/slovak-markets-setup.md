# BitBlik — slovenské banky: návod na spustenie a testovanie

Ako rozbehnúť a otestovať BitBlik pre **výber hotovosti z bankomatu bez karty**
cez slovenské banky (**Tatra banka, Slovenská sporiteľňa, VÚB**), za Lightning
sats. Návod je pre bežných používateľov aj pre operátorov koordinátora.

---

## 1. Ako to funguje (prehľad)

BitBlik je P2P burza: jedna strana dá **Lightning sats**, druhá **hotovosť z
bankomatu**. Slovenský trh (**Bitvýber**) kopíruje model MB WAY (Portugalsko) —
výber z bankomatu bez karty jednorazovým **6‑miestnym kódom**, ktorý je
**zdieľateľný tretej osobe** a funguje **len v bankomatoch danej banky**.

Slovensko je **jeden trh** (`sk`, wire tag `Bitvyber`) obsluhovaný **jedným
koordinátorom**, ktorý pokrýva Tatra banku, Slovenskú sporiteľňu aj VÚB. **Banku
vyberá maker pri vytváraní ponuky** — on stojí pri bankomate danej banky, takže
sieť bankomatov je vlastnosťou ponuky. Každá banka má vlastnú platnosť kódu
(Tatra 20 min, SLSP 15 min, VÚB 3 min); jeden flow obsluhuje všetky. Kód z Tatra
banky funguje len v Tatra bankomatoch, atď., takže taker berie len ponuky banky,
ktorej appku má.

### Dve roly a tok peňazí (ATM výber)

| Rola | Čo robí | Čo potrebuje | Výsledok |
|------|---------|--------------|----------|
| **Taker** (predáva hotovosť za sats) | Vo svojej bankovej appke vygeneruje „výber bez karty" kód a zadá ho do BitBliku | Účet + mobilná appka v TB/SLSP/VÚB; Lightning adresa na príjem | Z účtu sa mu odpíše suma (keď maker vyberie), **dostane sats** |
| **Maker** (kupuje hotovosť za sats) | Uzamkne sats v hold invoice, fyzicky príde k bankomatu danej banky a **zadá kód** | Lightning peňaženka so sats; **fyzický prístup k bankomatu tej banky** (účet v nej NETREBA) | Z bankomatu **dostane hotovosť**, jeho sats idú takerovi |

**Dôležité pre makera:** vyberaj ponuky tej banky, ktorej bankomat máš po
ruke (kód inej banky ti v cudzom bankomate nepôjde).

Stavy ponuky: `created → funded → reserved → blikReceived → blikSentToMaker →
makerConfirmed → settled → takerPaid`.

---

## 2. Pre bežných používateľov (appka)

### 2.1 Získanie appky

**A) Hotové APK (odporúčané) — Android.** Podpísaný release build je priamo v
tomto repozitári v priečinku [`dist/`](../dist):

| Súbor | Pre koho | Veľkosť |
|-------|----------|---------|
| [`dist/bitblik-sk-0.8.3-arm64-v8a.apk`](../dist/bitblik-sk-0.8.3-arm64-v8a.apk) | bežné moderné telefóny | ~44 MB |

Odkazy na stiahnutie:
- **gittr web**: <https://gittr.space/npub14agaq4fme4mxnre3ex5r85nzt2sguf58887pqce0tj60g9cyp25sacnlr0/bitblik-sk-support>
  → priečinok `dist/` → `bitblik-sk-0.8.3-arm64-v8a.apk`
- **git clone (Nostr, ngit)**:
  ```bash
  git clone nostr://npub14agaq4fme4mxnre3ex5r85nzt2sguf58887pqce0tj60g9cyp25sacnlr0/bitblik-sk-support
  # APK: bitblik-sk-support/dist/bitblik-sk-0.8.3-arm64-v8a.apk
  ```
- **git clone (HTTPS bridge)**:
  ```bash
  git clone https://gitnostr.com/npub14agaq4fme4mxnre3ex5r85nzt2sguf58887pqce0tj60g9cyp25sacnlr0/bitblik-sk-support.git
  ```

Inštalácia + overenie integrity: viď [`dist/README.md`](../dist/README.md).
Appka sa otvorí rovno na trhu **Slovensko (Bitvýber)**; banku vyberá maker pri ponuke.

**B) Build zo zdrojáku** (iOS/desktop/web alebo vlastná úprava) — viď sekcia 4.

### 2.2 Výber trhu
V appke: **Settings → Country / Payment System** → vyber **🇸🇰 Slovensko
(Bitvýber)**. Tým sa prepne mena na **EUR** a dĺžka kódu na 6. Banku tu už
nevyberáš — **maker ju volí pri každej ponuke** a taker ju vidí ako odznak pri
ponuke v zozname.

### 2.3 Lightning peňaženka
Pripoj peňaženku cez **NWC** (Nostr Wallet Connect) — napr. Alby Go:
**Wallet → Connect (NWC)** a naskenuj/prilep connection string.
- Maker potrebuje sats na zaplatenie hold invoice.
- Taker potrebuje Lightning adresu / peňaženku na príjem sats.

### 2.4 Taker (predaj hotovosti za sats)
1. Nájdi ponuku pre svoju banku v zozname ponúk.
2. Rezervuj ju a **vo svojej bankovej appke vygeneruj „výber z bankomatu bez
   karty"** (6‑miestny kód).
3. Kód zadaj v BitBliku (submit). Kód **odovzdávaš makerovi** — ten ho zadá v
   bankomate; z tvojho účtu sa suma odpíše a **dostaneš sats**.
4. Kód má obmedzenú platnosť (SLSP 15 min, Tatra 20 min) — koordinuj s makerom.

### 2.5 Maker (nákup hotovosti za sats)
1. **Create offer** → suma v EUR, kategória ATM, **vyber banku**, ktorej
   bankomat máš po ruke (Tatra banka / SLSP / VÚB). Banka je fixná pre ponuku;
   prednastavené sumy sa prispôsobia bankomatovým nominálom danej banky.
2. Zaplať **hold invoice** zo svojej Lightning peňaženky (sats sa uzamknú).
3. Počkaj, kým taker odovzdá kód (`blikReceived`), a **vyzdvihni kód** v appke.
4. Choď k **bankomatu danej banky**, zvoľ výber bez karty / mobilom a **zadaj
   6‑miestny kód** — dostaneš hotovosť.
5. V appke daj **confirm payment** → koordinátor vyplatí takerovi tvoje sats.
   Ak kód v bankomate nefungoval, daj **mark BLIK invalid** (ponuka sa znova
   ponúkne inému).

---

## 3. Pre operátora koordinátora (jeden pre všetky slovenské banky)

Slovensko = **jedno nasadenie koordinátora** (`PAYMENT_SYSTEM=sk`) obsluhujúce
všetky banky. Klienti ho nájdu na spoločných discovery relayoch a filtrujú podľa
`payment_system`, takže netreba nič extra na strane discovery. Operátor môže
voliteľne obmedziť obsluhované banky cez `BANKS=tatrabanka,slsp` (nenastavené =
všetky tri).

### 3.1 Požiadavky
- **Lightning node**: LND (`admin.macaroon` + `tls.cert`) alebo NWC connection s
  právom `make_hold_invoice`.
- Server s Dockerom + Docker Compose.
- Postgres (súčasť compose).

### 3.2 Setup
```bash
git clone nostr://npub14agaq4fme4mxnre3ex5r85nzt2sguf58887pqce0tj60g9cyp25sacnlr0/bitblik-sk-support
# alebo z GitHub upstreamu + aplikuj tento fork
cd packages/coordinator
cp docker-compose.example.yml docker-compose.yml
```

Vygeneruj Nostr kľúč pre koordinátora (každá inštancia má vlastný):
```bash
# napr. cez nak:
nak encode nsec `nak key generate`
```
a vlož ho do `NOSTR_PRIVATE_KEY`.

### 3.3 Kľúčová konfigurácia (`docker-compose.yml`)
```yaml
    environment:
      # --- Lightning ---
      LND_HOST: <YOUR_LND_IP_HOST>          # alebo NWC_URI: <nwc s make_hold_invoice>
      # --- DB ---
      DB_HOST: postgres
      DB_PORT: 5432
      DB_USER: user
      DB_PASSWORD: password
      DB: test_sk                           # samostatná databáza pre SK trh
      # --- Trh (jedno nasadenie obsluhuje všetky slovenské banky) ---
      PAYMENT_SYSTEM: sk
      # Voliteľné: obmedz banky (nenastavené = tatrabanka + slsp + vub).
      # BANKS: tatrabanka,slsp
      # CURRENCIES sa odvodí na EUR z trhu (netreba nastavovať).
      # sk always runs on the YAML flow engine (flow sk_atm.yml)
      # automaticky. Platnosť kódu je PER BANKA (Tatra 20 / SLSP 15 / VÚB 3 min)
      # a rieši sa z banky ponuky cez $code_validity — netreba nastavovať.
      # RESERVATION_SECONDS a FUNDED_EXPIRY_SECONDS sa pri generickom flow čítajú
      # z sk_atm.yml, takže tieto hodnoty sú len informatívne.
      RESERVATION_SECONDS: 120
      FUNDED_EXPIRY_SECONDS: 1800
      TAKER_CHARGED_AUTO_CONFIRM_SECONDS: 3600
      # --- Limity a poplatky ---
      MIN_AMOUNT_SATS: 1000
      # 912000 sats ≈ 500 € = max bezkartový výber (jednorazový kód) TB/SLSP/VÚB.
      # Cap je v sats, EUR hodnota kolíše s BTC kurzom — pri väčšom pohybe prehodnoť.
      MAX_AMOUNT_SATS: 912000
      MAKER_FEE: 0.25
      TAKER_FEE: 0.75
      # --- Identita a relaye ---
      NAME: Bitvýber koordinátor
      ICON_URL: https://.../icon.png
      NOSTR_PRIVATE_KEY: <TVOJ NSEC>
      NOSTR_RELAYS: wss://relay.primal.net,wss://nos.lol,wss://relay.damus.io
      FRONTEND_DOMAIN: <tvoja doména alebo test.bitblik.app>
```
LND súbory pripoj cez volumes (`./tls.cert`, `./admin.macaroon`), ako v example.
Databázu `test_sk` vytvor na hostiteľskom postgrese (`CREATE DATABASE test_sk;`);
tabuľky si koordinátor vytvorí sám pri štarte.

`sk_atm.yml` je súčasťou obrazu (Dockerfile kopíruje `flows/*.yml` do `/app/flows`
a nastaví `FLOW_DIR`), takže netreba nič extra.

### 3.3.1 (Voliteľné) komunitné kanály — odkazy na pripojenie
Koordinátor inzeruje odkazy, cez ktoré sa takeri pripoja do skupín. Trhové
(spoločné) aj per-banka. Per-banka odkaz vidí taker len pri danej banke:
```yaml
      # Spoločné (fallback pre banku bez vlastného odkazu):
      TELEGRAM_CHANNEL_LINK: https://t.me/bitvyber_sk
      MATRIX_CHANNEL_LINK:   https://matrix.to/#/#bitvyber-sk:matrix.org
      SIMPLEX_CHANNEL_LINK:  https://simplex.chat/contact#/...
      SIGNAL_CHANNEL_LINK:   https://signal.group/#...
      # Per-banka (<MESSENGER>_CHANNEL_LINK_<BANKA>):
      TELEGRAM_CHANNEL_LINK_TATRABANKA: https://t.me/bitvyber_tatra
      TELEGRAM_CHANNEL_LINK_SLSP:       https://t.me/bitvyber_slsp
      TELEGRAM_CHANNEL_LINK_VUB:        https://t.me/bitvyber_vub
      # ...to isté pre MATRIX_/SIMPLEX_/SIGNAL_ podľa potreby.
```

### 3.3.2 (Voliteľné) kam sa POSIELAJÚ notifikácie o nových ponukách
Notifikácia o ponuke s bankou ide do spoločného kanála **aj** do kanála danej
banky (oboje len ak je nastavené). Vyžaduje bota/CLI:
```yaml
      TELEGRAM_BOT_TOKEN: <token bota>
      TELEGRAM_CHAT_ID: -100_spolocny_chat            # spoločný cieľ
      TELEGRAM_CHAT_ID_TATRABANKA: -100_tatra_chat    # per-banka
      TELEGRAM_CHAT_ID_SLSP: -100_slsp_chat
      TELEGRAM_CHAT_ID_VUB: -100_vub_chat
      # Analogicky MATRIX_ROOM / MATRIX_ROOM_<BANKA>, SIGNAL_GROUP_ID / _<BANKA>,
      # SIMPLEX_GROUP / SIMPLEX_GROUP_<BANKA>.
```

### 3.4 Spustenie
```bash
docker compose build      # prvýkrát / po zmene kódu
docker compose up -d
docker compose logs -f bitblik-sk    # názov služby z compose (nie "coordinator")
```
V logu over:
- `FLOW ENGINE: GENERIC ENFORCING mode ACTIVE for method "sk" (flow=sk_atm, ...)`
- `Resolved discovery relays`
- `Published coordinator info event`

Po štarte koordinátor publikuje inzerciu (kind 15125, `payment_system=sk`,
`banks=tatrabanka,slsp,vub` + prípadné `<messenger>_channel_link[_<banka>]` tagy)
na discovery relaye. SK appka ho zaradí do jediného trhu **Slovensko (Bitvýber)**.

### 3.5 Discovery identita
SK trh používa **spoločnú Bitblik discovery identitu** (`kBitblikPubkeyHex`) —
netreba samostatný Nostr kľúč pre Slovensko. Koordinátor publikuje na
`NOSTR_RELAYS`; aby ho appka našla, tieto relaye sa musia prekrývať so SK
discovery sadou (spoločné bootstrap relaye). Vlastnú SK discovery identitu
netreba, iba ak by si chcel oddelenú discovery sadu alebo mute list.

---

## 4. Build appky so slovenskými trhmi

Potrebuješ **Flutter SDK** (Flutter 3.44.x / Dart ≥ 3.11), Android SDK a JDK 17.
Android release build vyžaduje **podpisový keystore** (`key.properties` alebo
`KEYSTORE` env — viď `packages/app/android/app/build.gradle.kts`).

```bash
cd packages/app
flutter pub get
# regeneruj i18n (voliteľné — SK názov krajiny je už dopatchovaný):
dart run slang
flutter analyze

# Android APK — default trh = Tatra banka (pri 1. spustení appka ukáže výber trhu):
flutter build apk --release \
  --flavor bitblik -t lib/main_bitblik.dart \
  --dart-define=PAYMENT_SYSTEM=sk
# menšie APK per architektúru (arm64 ~44 MB, armeabi ~40 MB, x86_64 ~47 MB):
flutter build apk --release --split-per-abi \
  --flavor bitblik -t lib/main_bitblik.dart \
  --dart-define=PAYMENT_SYSTEM=sk
# Web:
flutter build web   --dart-define=PAYMENT_SYSTEM=sk
# Desktop (linux):
flutter run -d linux --flavor bitblik -t lib/main_bitblik.dart \
  --dart-define=PAYMENT_SYSTEM=sk
```
Výstup APK: `build/app/outputs/flutter-apk/`.

Poznámky:
- `--dart-define=PAYMENT_SYSTEM=…` nastaví **default** trh (`tatrabanka` /
  `slsp` / `vub`; bez neho BLIK/Poľsko). Pri **prvom spustení** appka ukáže
  **výber trhu** (všetkých 5) — voľba sa uloží; neskôr sa dá zmeniť v
  **Settings → Country / Payment System**.
- Slovenské banky sa **netýkajú flavoru** — sú v `kPaymentSystems`, takže sú
  dostupné v každom `bitblik` builde.
- Podpísané prebuilty (arm64) sú v [`dist/`](../dist) — netreba buildovať.

---

## 5. Testovanie

### 5.1 Softvérový test end‑to‑end (bez reálneho bankomatu)
Koordinátor kód len **prenáša** — nevaliduje ho voči banke. Validácia je
fyzická (maker v bankomate). Preto sa celý softvérový tok dá otestovať s
**ľubovoľným 6‑miestnym kódom**; reálny bankový kód treba až pri reálnom výbere.

Najrýchlejšie cez **CLI** (maker) + druhé zariadenie/appku (taker):
```bash
# nájdi koordinátora daného trhu
bitblik coordinators list --health --json

# maker: vytvor ponuku (EUR), zaplať hold invoice zo svojej LN peňaženky
bitblik offer create --fiat 50 --coordinator <npub> --currency EUR --json

# taker (appka/druhý CLI): rezervuj a submitni 6-miestny kód (v teste hocijaký, napr. 123456)

# maker: čakaj na kód
bitblik offer get-blik --no-wait --json      # exit 0 = kód prišiel

# maker: potvrď (v reále až po výbere v bankomate)
bitblik offer confirm-payment
```
Overenie: stav prejde `settled → takerPaid`, takerovi prídu sats.

**Tipy na test:**
- Malé sumy, alebo LND na **signet/regtest** pre bezpečný test bez reálnych sats.
- `bitblik offer list --coordinator <npub> --json` ukáže verejné ponuky z relayov.

### 5.2 Reálny test s hotovosťou
1. Taker vygeneruje **reálny** „výber bez karty" kód vo svojej bankovej appke
   (TB/SLSP/VÚB) a zadá ho do BitBliku.
2. Maker s ním do **platnosti kódu** (15–20 min) príde k **bankomatu tej banky**
   a zadá ho → dostane hotovosť.
3. Maker potvrdí v appke → taker dostane sats.

---

## 6. Poznámky a limity
- **Nominály:** slovenské bankomaty bežne 10/20/50/100 € (€5 len Tatra/ČSOB).
  Sumy musia byť zložiteľné z týchto nominálov (napr. 30, 70, 500 áno; 15 nie).
- **VÚB platnosť kódu** je **3 min** (podľa FAQ na vub.sk) — veľmi tesné pre
  dvojicu, taker nech je pri bankomate skôr, než rezervuje. Jednoriadková zmena
  `BankSpec.validity` v `payment_system.dart`. Tatra 20 min, SLSP 15 min.
- **Limit banky:** cardless výber máva strop ~€500 na výber; drž sumy pod ním.
- **Discovery:** funguje cez spoločné bootstrap relaye aj s placeholder
  `kSlovakiaPubkeyHex`.
- **Komunitné linky:** appka pre neznámy trh zobrazuje default (poľské) linky —
  koordinátor ich vie prepísať cez `*_CHANNEL_LINK` env.

---

## 7. Zdroje / kód
- Trhy: `packages/core/lib/src/payment/payment_system.dart`
  (`kSlovakia` s per-bank `BankSpec` pre Tatra banku / SLSP / VÚB).
- Discovery kľúč: `packages/core/lib/src/constants/relays.dart`.
- Koordinátor: `packages/coordinator/README.md` + `docker-compose.example.yml`.
- CLI: `skills/bitblik/references/` (commands, workflow).
- Dizajn a plán: `docs/superpowers/specs/`, `docs/superpowers/plans/`.
