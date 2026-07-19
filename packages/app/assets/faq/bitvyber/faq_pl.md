## FAQ {app}

### Pytania ogólne

#### Czym jest {app}?

{app} to wolne oprogramowanie open source do wymiany peer-to-peer Bitcoina na **wypłaty gotówki z bankomatu bez karty** w {country} — w **Tatra banka, Slovenská sporiteľňa i VÚB**.\
Podstawowa idea:
- wypłacić gotówkę w dowolnym bankomacie słowackiego banku jednorazowym kodem „wypłata bez karty", opłaconym Bitcoinem
- kupić Bitcoina, generując i sprzedając takie kody wypłaty

#### Po co kolejne narzędzie P2P? Czemu nie RoboSats, Bisq czy Hodl Hodl?

Te usługi escrow świetnie nadają się do większych, długoterminowych transakcji. {app} służy do **szybkiej wypłaty gotówki z bankomatu** za posiadane Bitcoiny. Cała wymiana zwykle trwa kilka minut.
- **Makerzy** sprzedają Bitcoina (wypłacają gotówkę w bankomacie).
- **Takerzy** kupują Bitcoina (generują kod w aplikacji swojego banku).

#### Które banki są obsługiwane i jak wybrać bank?

Słowacja to jeden rynek (**{app}**) obsługiwany przez jednego koordynatora, obejmujący **Tatra banka, Slovenská sporiteľňa i VÚB**. **Bank wybiera maker przy tworzeniu oferty** — to on stanie przy bankomacie danego banku, więc kod działa tylko w jego bankomatach. Takerzy widzą bank oferty jako plakietkę i biorą tylko oferty banku, którego aplikację mają.

#### Jak długo ważny jest kod? Dlaczego różni się dla banku?

Każdy bank ustala żywotność kodu wypłaty bez karty:
- **Tatra banka: 20 minut**
- **Slovenská sporiteľňa: 15 minut**
- **VÚB: 3 minuty**

Okno VÚB jest bardzo krótkie; przy ofercie VÚB taker powinien być już przy (lub bardzo blisko) bankomatu VÚB przed rezerwacją. Aplikacja pokazuje pozostały czas jako odliczanie.

#### Jak działa escrow?

1.  **Tworzenie oferty (Maker):** maker tworzy ofertę, wybierając kwotę fiat **i bank**.
2.  **Finansowanie escrow (Maker):** maker płaci lightningową „hold invoice" na kwotę w Bitcoinie. Blokuje to Bitcoiny u koordynatora bez ich przekazywania.
3.  **Przyjęcie oferty (Taker):** taker bierze ofertę, generuje **{code} wypłaty bez karty** w aplikacji swojego banku (dla tego banku) i wysyła go.
4.  **Wypłata gotówki (Maker):** maker otrzymuje {code} i wpisuje go w **bankomacie tego banku**, aby wypłacić gotówkę w oknie ważności.
5.  **Obciążenie (Taker):** kwota zostaje pobrana z konta takera, gdy maker wypłaci.
6.  **Potwierdzenie (Maker):** maker potwierdza w {app}, że wypłata się powiodła.
7.  **Zwolnienie Bitcoina (Koordynator):** po potwierdzeniu koordynator rozlicza hold invoice i zwalnia Bitcoiny na adres/fakturę Lightning takera.

#### Jak takerzy dowiadują się o nowych ofertach?

Takerzy mogą dołączyć do kanałów (SimpleX, Matrix, Telegram, Signal), by otrzymywać powiadomienia. Kanały mogą być **ogólne (wszystkie banki)** lub **per bank** — dołącz do kanałów banków, które możesz obsłużyć. Gdy maker sfinansuje ofertę, koordynator publikuje ją w odpowiednich kanałach z linkiem do przyjęcia w {app}.

#### Czym jest {code}?

{code} to jednorazowy **{codeLength}-cyfrowy kod wypłaty bez karty** („výber bez karty"), wygenerowany w aplikacji słowackiego banku. Pozwala wypłacić gotówkę z bankomatu tego banku bez karty. W {app} generuje go taker, a maker wpisuje w bankomacie.

#### Czym są lightningowe „hold invoice"?

Hold invoice to specjalna faktura Lightning. Gdy maker (sprzedający Bitcoina) ją opłaci, środki nie są od razu rozliczane — są „trzymane" przez węzeł Lightning koordynatora i zwalniane dopiero po ujawnieniu tajnego „preimage". Jeśli nie nastąpi to na czas lub faktura zostanie anulowana, środki wracają do makera. To rdzeń mechanizmu escrow {app}.

---

### Bezpieczeństwo i ryzyka

#### Jak zabezpieczone są moje Bitcoiny jako Maker (sprzedający)?

Twoje Bitcoiny są zablokowane przez hold invoice. Koordynator rozlicza ją (zwalnia Bitcoiny takerowi) **dopiero po** Twoim potwierdzeniu udanej wypłaty. Jeśli wypłata się nie powiedzie, hold invoice zostaje anulowana, a Bitcoiny wracają do Twojego węzła.

#### Jak jestem chroniony jako Taker (kupujący)?

Maker zablokował już Bitcoiny w hold invoice **zanim** wyślesz kod. Gdy maker potwierdzi wypłatę, Bitcoiny zostają Ci zwolnione automatycznie. Ryzyko istnieje, jeśli maker fałszywie zaprzeczy wypłacie po obciążeniu Twojego konta — patrz „Spory".

#### Co jeśli kod jest nieprawidłowy lub wygaśnie, zanim maker wypłaci?

Jeśli maker nie może wypłacić kodem (nieprawidłowy lub wygasły — najprawdopodobniej przy 3-minutowym oknie VÚB), transakcja z tym kodem nie może być kontynuowana. Maker oznacza go jako nieprawidłowy, oferta jest ponownie wystawiana, a taker może wysłać nowy kod lub anulować. Ponieważ kod szybko wygasa, uzgodnijcie czas i wybierzcie bank, którego bankomat maker szybko osiągnie.

#### Jakie są ryzyka protokołu?

- **Ryzyko kontrahenta:** druga strona nie działa uczciwie. Hold invoice to łagodzi, lecz nie eliminuje na etapie gotówki.
- **Zaufanie do koordynatora:** ufasz, że zarządza preimage i poprawnie rozlicza/anuluje.
- **Problemy węzła LN:** węzeł koordynatora (i ewentualnie Twój) musi być online.
- **Problemy banku:** problemy systemu wypłat bez karty są poza {app} i należy je rozwiązywać z bankiem.
- **Błędy oprogramowania:** jak w każdym oprogramowaniu; jest open source i audytowalne.
- **Prywatność:** klucze publiczne i szczegóły transakcji przechowuje koordynator. **Dla lepszej prywatności generuj nową parę kluczy dla każdej transakcji.**

#### Czy koordynator jest kustodialny?

Podczas escrow środki makera są zablokowane w hold invoice, którą koordynator może rozliczyć lub anulować — tymczasowa kontrola. Końcowa wypłata takerowi jest niekustodialna (na jego fakturę). Obie strony ufają, że koordynator przestrzega protokołu.

#### Co motywuje Makera do uczciwości?

Maker blokuje Bitcoiny **zanim** otrzyma kod:
- Potwierdzenie udanej wypłaty → koordynator zwalnia Bitcoiny takerowi; maker zatrzymuje gotówkę.
- Fałszywe zaprzeczenie udanej wypłacie → taker otwiera spór z dowodem bankowym; jeśli koordynator rozstrzygnie na korzyść takera, faktura i tak zostaje rozliczona, a maker traci Bitcoiny.
- Porzucenie/zwlekanie → hold invoice ma ograniczone okno, maker nie może zwlekać w nieskończoność.

#### Co motywuje Takera do uczciwości?

- Podanie ważnego kodu, który działa → wszyscy zadowoleni.
- Podanie nieprawidłowego/wygasłego kodu → maker nie może wypłacić, transakcja się nie udaje, Bitcoiny wracają, taker nic nie dostaje.
- Fałszywe twierdzenie o obciążeniu → bez dowodu bankowego koordynator anuluje hold invoice i zwraca Bitcoiny makerowi.

Ponieważ taker musi w sporze dostarczyć weryfikowalny dowód, nie ma realnej drogi, by oszukać makera.

> **Uwaga:** planowany jest system kaucji (bond) dla takerów, karzący za marnowanie czasu koordynatora.

#### Co motywuje koordynatora do uczciwości?

Koordynator publikuje klucz Nostr (profil), który użytkownicy mogą oznaczać, zgłaszając doświadczenia. Przed użyciem sprawdź reputację koordynatora na Nostr (klientem z Web-of-Trust) i preferuj takiego, któremu ufa Twoja społeczność. Za wybór wiarygodnego koordynatora odpowiadasz Ty; to nie jest platforma ani usługa i nie ponosimy odpowiedzialności za działania koordynatorów.

---

### Opłaty i kwestie techniczne

#### Czy są opłaty?

Każdy koordynator ustala własne opłaty maker i taker, pokazywane w aplikacji przed utworzeniem/przyjęciem oferty.

#### Jakie kwoty mogę wypłacić z bankomatu?

Słowackie bankomaty wydają banknoty **10 / 20 / 50 / 100 €**, więc kwota oferty musi być z nich składalna (np. 30, 70, 200 — tak; 15 — nie). Domyślne kwoty makera się do tego dostosowują. Limit wypłaty bez karty to zwykle ok. 500 € na wypłatę.

#### Co jeśli lightningowa wypłata do takera się nie powiedzie?

Jeśli koordynator nie może opłacić faktury Lightning takera (węzeł offline, brak trasy), taker podaje nową fakturę lub naprawia swoją konfigurację Lightning, po czym wypłata jest ponawiana.

#### Czy mogę anulować ofertę po jej sfinansowaniu, ale przed przyjęciem przez takera?

Tak — dopóki oferta jest jeszcze `funded` (niezarezerwowana), anuluj ją, a Bitcoiny wrócą do Twojego portfela Lightning.

#### Dlaczego aplikacji nie ma w Google Play ani App Store?

To ogrodzone ogrody z korporacyjnymi strażnikami, którzy mogą do woli usuwać aplikacje prywatnościowe lub alternatywnej ekonomii — pojedynczy punkt awarii i cenzury.

---

### Spory

Jeśli maker i taker nie zgadzają się co do wyniku, oferta przechodzi w stan `conflict`, a każda strona dostarcza dowody, które koordynator rozstrzyga ręcznie.

> ⚠️ **Ważne:** każdy koordynator może mieć inne wymagania/procedury dla sporów — sprawdź jego dokumentację lub skontaktuj się bezpośrednio.

#### Jakie dowody podam jako Maker?

Jeśli kod w bankomacie był nieprawidłowy lub wygasły: odmowa/wydruk z bankomatu lub zrzut/wydruk nieudanej próby wypłaty.

#### Jakie dowody podam jako Taker?

Jeśli maker zaprzecza wypłacie po obciążeniu Twojego konta: wyciąg/potwierdzenie z aplikacji bankowej z transakcją wypłaty bez karty, kwotą i znacznikiem czasu.

## Wsparcie

W sprawie wsparcia koordynatora lub sporów skontaktuj się z operatorem bezpośrednio przez DM Nostr — jego profil jest dostępny przez link do warunków użytkowania w {app}.
