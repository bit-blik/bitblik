## {app} — často kladené otázky

### Všeobecné otázky

#### Čo je {app}?

{app} je slobodný softvér s otvoreným zdrojovým kódom na P2P výmenu Bitcoinu za platby kódom {code}.\
Základná myšlienka je:
- platiť Bitcoinom všade, kde sa akceptuje platba {code}
- kúpiť Bitcoin generovaním a predajom kódov {code}

#### Prečo ďalší P2P nástroj? Prečo nie RoboSats, Bisq či Hodl Hodl?

Tie escrow služby sú výborné na väčšie a dlhodobejšie obchody. {app} slúži ako rýchla platobná metóda kódom {code} tam, kde sa to hodí — samoobslužné pokladne, reštaurácie, online nákupy, aj bankomaty. Celá výmena zvyčajne trvá pár minút, podľa toho, ako rýchlo takeri zbadajú novú ponuku a poskytnú a potvrdia kód {code}.
- **Makeri** predávajú Bitcoin.
- **Takeri** kupujú Bitcoin.

#### Ako funguje escrow proces?

1.  **Vytvorenie ponuky (Maker):** Maker vytvorí ponuku a určí sumu vo fiate, za ktorú chce dostať kód {code}.
2.  **Zafinancovanie escrow (Maker):** Maker zaplatí Lightning „hold invoice" na sumu v Bitcoine. Tým sa Bitcoin uzamkne u koordinátora, no zatiaľ sa neprevedie.
3.  **Prijatie ponuky (Taker):** Taker nájde ponuku, prijme ju, vygeneruje kód {code} vo svojej bankovej appke a odošle ho koordinátorovi.
4.  **Platba fiatom (Maker):** Maker dostane kód {code} a zadá ho v platobnom termináli alebo na e-shope.
5.  **Potvrdenie {code} (Taker):** Taker dostane z bankovej appky výzvu na potvrdenie platby {code}.
6.  **Potvrdenie platby (Maker):** Maker v {app} potvrdí, že platbu {code} prijal.
7.  **Uvoľnenie Bitcoinu (Koordinátor):** Po potvrdení makera koordinátor pomocou tajného preimage vyrovná hold invoice a uvoľní uzamknutý Bitcoin na Lightning adresu/faktúru takera.

#### Ako sa takeri dozvedia o nových ponukách?

Takeri sa môžu prihlásiť do kanálov (SimpleX, Matrix, Telegram, Signal) a dostávať upozornenia. Keď maker zaplatí hold invoice a vytvorí ponuku, koordinátor pošle správu do všetkých kanálov s detailmi ponuky a odkazom na {app}, kde ju možno prijať.

#### Čo je {code}?

{code} je mobilný platobný systém používaný v krajine {country}. Umožňuje platiť {codeLength}-miestnym kódom vygenerovaným v bankovej appke, ktorý sa dá zadať priamo na termináli alebo e-shope. V {app} takeri používajú {code} na platbu makerom za Bitcoin.

#### Čo sú Lightning „hold invoice"?

Hold invoice je špeciálna Lightning faktúra. Keď ju maker (predávajúci Bitcoin) zaplatí, prostriedky sa hneď nevyrovnajú — „drží" ich Lightning uzol koordinátora a uvoľnia sa až po odhalení tajného „preimage". Ak sa neodhalí včas alebo sa faktúra zruší, prostriedky sa vrátia makerovi. To je jadro escrow mechanizmu {app}.

---

### Bezpečnosť a riziká

#### Ako je môj Bitcoin chránený ako Maker (predávajúci)?

Tvoj Bitcoin je uzamknutý cez hold invoice. Koordinátor má preimage potrebný na jej vyrovnanie. Systém je navrhnutý tak, aby vyrovnal (uvoľnil Bitcoin takerovi) **až po** tom, čo potvrdíš prijatie platby {code}. Ak taker nezaplatí, hold invoice sa zruší a Bitcoin sa vráti tvojmu uzlu.

#### Ako som chránený ako Taker (kupujúci)?

Maker už uzamkol Bitcoin v hold invoice **skôr**, než ťa systém požiada o platbu {code}. Keď maker potvrdí prijatie tvojej platby {code}, Bitcoin sa ti uvoľní automaticky. Riziko je, ak maker nepravdivo poprie prijatie tvojej platby {code} — viď „Spory".

#### Čo ak je kód {code} neplatný alebo vyprší?

Ak sa maker pokúsi použiť kód {code} a zlyhá, transakcia nemôže pokračovať. Taker možno bude musieť poskytnúť nový kód, alebo sa ponuka zruší.

#### Aké sú riziká protokolu?

- **Riziko protistrany:** hlavné riziko je nepoctivosť druhej strany. Hold invoice ho zmierňuje, no neodstraňuje, najmä pri fiatovej platbe.
- **Dôvera v koordinátora:** dôveruješ koordinátorovi {app}, že bezpečne spravuje preimage, správne spúšťa vyrovnania/zrušenia a prevádzkuje službu spoľahlivo.
- **Problémy LN uzla:** uzol koordinátora (a prípadne tvoj) musí byť online.
- **Problémy systému {code}:** problémy so samotným {code} sú mimo {app} a rieš ich s bankou či poskytovateľom {code}.
- **Chyby softvéru:** ako pri každom softvéri; je open source a auditovateľný.
- **Súkromie:** verejné kľúče a detaily transakcií ukladá koordinátor. **Pre lepšie súkromie generuj nový pár kľúčov pre každú transakciu.**

#### Je koordinátor kustodiálny?

Počas escrow sú prostriedky makera uzamknuté v hold invoice, ktorú koordinátor vie vyrovnať alebo zrušiť — dočasná kontrola. Finálna výplata takerovi je nekustodiálna (na jeho faktúru). Obe strany dôverujú koordinátorovi, že dodrží protokol.

#### Čo motivuje makera konať poctivo?

Maker uzamkne Bitcoin **skôr**, než dostane kód {code}:
- Potvrdí prijatie platnej platby {code} → koordinátor uvoľní Bitcoin takerovi; maker dostane fiat.
- Nepravdivo poprie prijatie platnej platby {code} → taker otvorí spor s bankovým dôkazom; ak koordinátor rozhodne v prospech takera, faktúra sa aj tak vyrovná a maker príde o Bitcoin.
- Opustí/zdržiava → hold invoice má obmedzené okno, takže maker nemôže zdržiavať donekonečna.

#### Čo motivuje takera konať poctivo?

- Poskytne platný kód {code} a potvrdí platbu → obe strany spokojné.
- Poskytne neplatný/vypršaný kód {code} → maker nemôže dokončiť platbu a nepotvrdí; obchod zlyhá a Bitcoin makera sa vráti.
- Nepravdivo tvrdí, že zaplatil → v spore musí predložiť bankový dôkaz o odpísaní {code}; bez neho koordinátor po 48 hodinách zruší hold invoice a Bitcoin vráti makerovi.

Keďže taker musí predložiť overiteľný dôkaz, neexistuje reálna cesta podvodne získať Bitcoin.

> **Poznámka:** Plánuje sa systém zábezpeky (bond) pre takerov s postihom za zbytočne zdržaný čas koordinátora.

#### Čo motivuje koordinátora konať poctivo?

Koordinátor zverejní Nostr kľúč (profil), ktorý používatelia môžu tagovať a hlásiť skúsenosti. Pred použitím si over reputáciu koordinátora na Nostri (klientom s Web-of-Trust) a preferuj takého, ktorému dôveruje tvoja komunita. Za výber dôveryhodného koordinátora zodpovedáš ty; toto nie je platforma ani služba a za konanie koordinátorov nenesieme zodpovednosť.

---

### Poplatky a technické veci

#### Sú nejaké poplatky?

Každý koordinátor si určuje vlastné poplatky pre makera aj takera; zobrazujú sa v appke pred vytvorením/prijatím ponuky.

#### Čo ak Lightning výplata takerovi zlyhá?

Ak koordinátor nedokáže zaplatiť Lightning faktúru takera (uzol offline, bez trasy), taker poskytne novú faktúru alebo opraví svoje Lightning nastavenie a výplata sa zopakuje.

#### Môžem zrušiť ponuku po zafinancovaní, no pred prijatím takerom?

Áno — kým je ponuka ešte `funded` (nerezervovaná), zruš ju a Bitcoin sa vráti do tvojej Lightning peňaženky.

#### Prečo appky nie sú v Google Play či App Store?

Sú to uzavreté záhrady s korporátnymi vrátnikmi, ktorí môžu appky presadzujúce súkromie alebo alternatívnu ekonomiku kedykoľvek stiahnuť — jediný bod zlyhania a cenzúry.

---

### Spory

Ak sa maker a taker nezhodnú na stave platby, ponuka prejde do stavu `conflict`, v ktorom každá strana predloží dôkazy, ktoré koordinátor manuálne posúdi.

> ⚠️ **Dôležité:** Každý koordinátor môže mať iné požiadavky/postup pri sporoch — over si jeho dokumentáciu alebo ho kontaktuj priamo.

#### Aký dôkaz predložím ako Maker?

Ak bol kód {code} na termináli alebo e-shope neplatný alebo vypršaný, predlož dôkaz o neúspešnej platbe: účtenku o neplatnom kóde {code} z terminálu/bankomatu alebo screenshot neúspešného pokusu na e-shope.

#### Aký dôkaz predložím ako Taker?

Ak maker poprie prijatie tvojej platby {code}, predlož dôkaz, že bola úspešne odpísaná z tvojho účtu — zvyčajne účtenku z bankovej appky s detailmi transakcie {code}, sumou a časom.

## Podpora

Pre podporu koordinátora alebo spory kontaktuj prevádzkovateľa koordinátora priamo cez Nostr DM — jeho profil je dostupný cez odkaz na podmienky používania v {app}.
