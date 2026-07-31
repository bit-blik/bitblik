## {app} — často kladené otázky

### Všeobecné otázky

#### Čo je {app}?

{app} je slobodný softvér s otvoreným zdrojovým kódom na P2P výmenu Bitcoinu za **výber hotovosti z bankomatu bez karty** na {country} — cez **Tatra banku, Slovenskú sporiteľňu a VÚB**.\
Základná myšlienka je:
- vybrať hotovosť v ktoromkoľvek slovenskom bankomate jednorazovým kódom „výber bez karty", zaplateným Bitcoinom
- kúpiť Bitcoin generovaním a predajom takýchto výberových kódov

#### Prečo ďalší P2P nástroj? Prečo nie RoboSats, Bisq či Hodl Hodl?

Tie escrow služby sú výborné na väčšie a dlhodobejšie obchody. {app} slúži na **rýchly výber hotovosti z bankomatu** za Bitcoin, ktorý držíš. Celá výmena zvyčajne trvá pár minút.
- **Makeri** predávajú Bitcoin (hotovosť vyberajú v bankomate).
- **Takeri** kupujú Bitcoin (kód generujú vo svojej bankovej appke).

#### Ktoré banky sú podporované a ako si vyberiem banku?

Slovensko je jeden trh (**{app}**) obsluhovaný jedným koordinátorom, pokrývajúci **Tatra banku, Slovenskú sporiteľňu a VÚB**. **Banku vyberá maker pri vytváraní ponuky** — on stojí pri bankomate danej banky, takže kód funguje len v bankomatoch tej banky. Taker vidí banku ponuky ako odznak a berie len ponuky banky, ktorej appku má.

#### Ako dlho platí kód? Prečo sa líši podľa banky?

Každá banka má vlastnú platnosť kódu na výber bez karty:
- **Tatra banka: 20 minút**
- **Slovenská sporiteľňa: 15 minút**
- **VÚB: 3 minúty**

Okno VÚB je veľmi krátke, preto pri VÚB ponuke by mal byť taker už pri (alebo veľmi blízko) VÚB bankomatu skôr, než rezervuje. Appka zobrazuje zostávajúci čas odpočtom.

#### Ako funguje escrow proces?

1.  **Vytvorenie ponuky (Maker):** Maker vytvorí ponuku, zvolí sumu vo fiate **a banku**.
2.  **Zafinancovanie escrow (Maker):** Maker zaplatí Lightning „hold invoice" na sumu v Bitcoine. Tým sa Bitcoin uzamkne u koordinátora, no zatiaľ sa neprevedie.
3.  **Prijatie ponuky (Taker):** Taker prijme ponuku, vygeneruje **{code} na výber bez karty** vo svojej bankovej appke (pre danú banku) a odošle ho koordinátorovi.
4.  **Výber hotovosti (Maker):** Maker dostane {code} a zadá ho v **bankomate danej banky**, čím vyberie hotovosť — v rámci platnosti banky.
5.  **Zaťaženie (Taker):** Suma sa takerovi odpíše z účtu, keď maker vyberie.
6.  **Potvrdenie (Maker):** Maker v {app} potvrdí, že výber prebehol.
7.  **Uvoľnenie Bitcoinu (Koordinátor):** Po potvrdení makera koordinátor vyrovná hold invoice a uvoľní uzamknutý Bitcoin na Lightning adresu/faktúru takera.

#### Ako sa takeri dozvedia o nových ponukách?

Takeri sa môžu pripojiť do kanálov (SimpleX, Matrix, Telegram, Signal) a dostávať upozornenia. Kanály môžu byť **spoločné (všetky banky)** alebo **per-banka** — pripoj sa do kanálov bánk, ktoré vieš obslúžiť. Keď maker zafinancuje ponuku, koordinátor ju pošle do príslušných kanálov s odkazom na prijatie v {app}.

#### Čo je {code}?

{code} je jednorazový **{codeLength}-miestny kód na výber bez karty** („výber mobilom") vygenerovaný v appke slovenskej banky. Umožní vybrať hotovosť z bankomatu tej banky bez karty. V {app} ho generuje taker a maker ho zadá v bankomate.

#### Čo sú Lightning „hold invoice"?

Hold invoice je špeciálna Lightning faktúra. Keď ju maker (predávajúci Bitcoin) zaplatí, prostriedky sa hneď nevyrovnajú — „drží" ich Lightning uzol koordinátora a uvoľnia sa až po odhalení tajného „preimage". Ak sa neodhalí včas alebo sa faktúra zruší, prostriedky sa vrátia makerovi. To je jadro escrow mechanizmu {app}.

---

### Bezpečnosť a riziká

#### Ako je môj Bitcoin chránený ako Maker (predávajúci)?

Tvoj Bitcoin je uzamknutý cez hold invoice. Koordinátor ho vyrovná (uvoľní takerovi) **až** po tom, čo potvrdíš úspešný výber. Ak výber zlyhá, hold invoice sa zruší a Bitcoin sa vráti tvojmu uzlu.

#### Ako som chránený ako Taker (kupujúci)?

Maker už uzamkol Bitcoin v hold invoice **skôr**, než odošleš výberový kód. Keď maker potvrdí výber, Bitcoin sa ti uvoľní automaticky. Riziko je, ak maker nepravdivo poprie výber po tom, čo ti bola odpísaná suma — viď „Spory".

#### Čo ak je kód neplatný alebo vyprší skôr, než maker vyberie?

Ak maker nedokáže vybrať (neplatný alebo vypršaný kód — najpravdepodobnejšie pri 3-minútovom okne VÚB), obchod s tým kódom nepokračuje. Maker ho označí za neplatný, ponuka sa znova ponúkne a taker môže poslať nový kód alebo zrušiť. Keďže kód vyprší rýchlo, zladíte časovanie a zvoľte banku, ktorej bankomat maker rýchlo dosiahne.

#### Aké sú riziká protokolu?

- **Riziko protistrany:** druhá strana nekoná poctivo. Hold invoice ho zmierňuje, no neodstraňuje pri hotovostnej časti.
- **Dôvera v koordinátora:** dôveruješ koordinátorovi {app}, že spravuje preimage a správne vyrovná/zruší.
- **Problémy LN uzla:** uzol koordinátora (a prípadne tvoj) musí byť online.
- **Problémy banky:** problémy s výberom bez karty sú mimo {app} a rieš ich s bankou.
- **Chyby softvéru:** ako pri každom softvéri; je open source a auditovateľný.
- **Súkromie:** verejné kľúče a detaily transakcií ukladá koordinátor. **Pre lepšie súkromie generuj nový pár kľúčov pre každú transakciu.**

#### Je koordinátor kustodiálny?

Počas escrow sú prostriedky makera uzamknuté v hold invoice, ktorú koordinátor vie vyrovnať alebo zrušiť — dočasná kontrola. Finálna výplata takerovi je nekustodiálna (na jeho faktúru). Obe strany dôverujú koordinátorovi, že dodrží protokol.

#### Čo motivuje makera konať poctivo?

Maker uzamkne Bitcoin **skôr**, než dostane kód:
- Potvrdí úspešný výber → koordinátor uvoľní Bitcoin takerovi; maker si nechá hotovosť.
- Nepravdivo poprie úspešný výber → taker otvorí spor s bankovým dôkazom; ak koordinátor rozhodne v prospech takera, faktúra sa aj tak vyrovná a maker príde o Bitcoin.
- Opustí/zdržiava → hold invoice má obmedzené okno, takže maker nemôže zdržiavať donekonečna.

#### Čo motivuje takera konať poctivo?

- Poskytne platný kód a funguje → obe strany spokojné.
- Poskytne neplatný/vypršaný kód → maker nevyberie, obchod zlyhá, Bitcoin makera sa vráti, taker nedostane nič.
- Nepravdivo tvrdí zaťaženie → bez bankového dôkazu koordinátor zruší hold invoice a Bitcoin vráti makerovi.

Keďže taker musí v spore predložiť overiteľný dôkaz, neexistuje reálna cesta okradnúť makera.

> **Poznámka:** Plánuje sa systém zábezpeky (bond) pre takerov, ktorý pridá postih za zbytočne zdržaný čas koordinátora.

#### Čo motivuje koordinátora konať poctivo?

Koordinátor zverejní Nostr kľúč (profil), ktorý používatelia môžu tagovať a hlásiť skúsenosti. Pred použitím si over reputáciu koordinátora na Nostri (klientom s Web-of-Trust) a preferuj takého, ktorému dôveruje tvoja komunita. Za výber dôveryhodného koordinátora zodpovedáš ty; toto nie je platforma ani služba a za konanie koordinátorov nenesieme zodpovednosť.

---

### Poplatky a technické veci

#### Sú nejaké poplatky?

Každý koordinátor si určuje vlastné poplatky pre makera aj takera; zobrazujú sa v appke pred vytvorením/prijatím ponuky.

#### Aké sumy môžem vybrať z bankomatu?

Slovenské bankomaty vydávajú bankovky **10 / 20 / 50 / 100 €**, takže suma ponuky musí byť z nich zložiteľná (napr. 30, 70, 200 — áno; 15 — nie). Prednastavené sumy makera sa tomu prispôsobia. Strop výberu bez karty býva okolo €500 na výber.

#### Čo ak Lightning výplata takerovi zlyhá?

Ak koordinátor nedokáže zaplatiť Lightning faktúru takera (uzol offline, bez trasy), taker poskytne novú faktúru alebo opraví svoje Lightning nastavenie a výplata sa zopakuje.

#### Môžem zrušiť ponuku po zafinancovaní, no pred prijatím takerom?

Áno — kým je ponuka ešte `funded` (nerezervovaná), zruš ju a Bitcoin sa vráti do tvojej Lightning peňaženky.

#### Prečo appky nie sú v Google Play či App Store?

Sú to uzavreté záhrady s korporátnymi vrátnikmi, ktorí môžu appky presadzujúce súkromie alebo alternatívnu ekonomiku kedykoľvek stiahnuť — jediný bod zlyhania a cenzúry.

---

### Spory

Ak sa maker a taker nezhodnú na výsledku, ponuka prejde do stavu `conflict` a každá strana predloží dôkazy, ktoré koordinátor manuálne posúdi.

> ⚠️ **Dôležité:** Každý koordinátor môže mať iné požiadavky/postup pri sporoch — over si jeho dokumentáciu alebo ho kontaktuj priamo.

#### Aký dôkaz predložím ako Maker?

Ak bol kód v bankomate neplatný alebo vypršaný: odmietnutie/účtenka z bankomatu alebo screenshot/výtlačok neúspešného pokusu o výber.

#### Aký dôkaz predložím ako Taker?

Ak maker poprie výber po tom, čo ti bola odpísaná suma: výpis/účtenka z bankovej appky s transakciou výberu bez karty, so sumou a časom.

## Podpora

Pre podporu koordinátora alebo spory kontaktuj prevádzkovateľa koordinátora priamo cez Nostr DM — jeho profil je dostupný cez odkaz na podmienky používania v {app}.
