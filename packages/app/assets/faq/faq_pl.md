## Najczęściej zadawane pytania BitBlik
### Pytania ogólne
#### Czym jest BitBlik?
BitBlik to darmowe oprogramowanie o otwartym kodzie źródłowym, zaprojektowane w celu ułatwienia wymiany Bitcoin na kody BLIK.\
Podstawowa idea polega na:
- płaceniu Bitcoin wszędzie tam, gdzie akceptowana jest płatność BLIK
- kupowaniu Bitcoin poprzez generowanie i sprzedawanie kodów BLIK
#### Dlaczego kolejne narzędzie P2P? Dlaczego nie używać istniejących jak RoboSats, Bisq czy Hodl Hodl?
Chociaż te usługi escrow P2P są doskonałe i powinny być używane do większych i długoterminowych transakcji, Bitblik ma być używany jako szybka metoda płatności wykorzystująca kody BLIK w miejscach/sytuacjach, gdzie jest to odpowiednie, takich jak samoobsługowe sklepy, restauracje, zakupy online, a nawet bankomaty.
Cały proces wymiany nie powinien trwać dłużej niż kilka minut, w zależności od tego, jak szybko takers zauważą nową ofertę i będą w stanie szybko dostarczyć i potwierdzić kod BLIK.
- **Makers** to użytkownicy chcący sprzedać Bitcoin.
- **Takers** to użytkownicy chcący kupić Bitcoin.
#### Jak działa proces escrow?
Proces generalnie przebiega według następujących kroków:
1.  **Tworzenie oferty (Maker):** Maker tworzy ofertę, określając kwotę fiat, za którą chce otrzymać kod BLIK, oraz równoważną kwotę Bitcoin.
2.  **Finansowanie Escrow (Maker):** Maker płaci "hold invoice" Lightning Network za określoną kwotę Bitcoin. To blokuje Bitcoin u koordynatora, ale jeszcze go nie przekazuje.
3.  **Akceptacja oferty (Taker):** Taker znajduje ofertę, która mu odpowiada i ją akceptuje, następnie generuje kod BLIK w swojej aplikacji bankowej i przesyła go do koordynatora.
4.  **Płatność Fiat (Maker):** Maker otrzymuje kod BLIK i wprowadza go w terminalu płatniczym lub na stronie e-commerce.
5.  **Potwierdzenie BLIK (Taker):** Taker otrzyma powiadomienie ze swojej aplikacji bankowej o potwierdzenie płatności BLIK.
6.  **Potwierdzenie płatności (Maker):** Maker potwierdza w systemie BitBlik, że otrzymał płatność BLIK.
6.  **Uwolnienie Bitcoin (Koordynator):** Po potwierdzeniu przez Maker, koordynator używa sekretnego preimage do "rozliczenia" hold invoice. Ta akcja uwalnia zablokowany Bitcoin na podany przez Taker adres Lightning lub invoice.
#### Jak takers dowiadują się o nowych ofertach?
Takers mogą zarejestrować się w kilku kanałach komunikacyjnych ([SimpleX](https://simplex.chat/contact#/?v=2-7&smp=smp%3A%2F%2Fu2dS9sG8nMNURyZwqASV4yROM28Er0luVTx5X1CsMrU%3D%40smp4.simplex.im%2FjwS8YtivATVUtHogkN2QdhVkw2H6XmfX%23%2F%3Fv%3D1-3%26dh%3DMCowBQYDK2VuAyEAsNpGcPiALZKbKfIXTQdJAuFxOmvsuuxMLR9rwMIBUWY%253D%26srv%3Do5vmywmrnaxalvz6wi3zicyftgio6psuvyniis6gco6bp6ekl4cqj4id.onion&data=%7B%22groupLinkId%22%3A%22hCkt5Ph057tSeJdyEI0uug%3D%3D%22%7D), [Matrix](https://matrix.to/#/#bitblik-offers:matrix.org), [Telegram](https://t.me/+xSktv2JukXUxYmEx), [Signal](https://signal.group/#CjQKIGcFyMrwHN1UPB57IhdkGmz23_64AhyIU5oBaZufe2hcEhCltosTHbc9ROywT0KETJbk)), aby otrzymywać powiadomienia o nowych ofertach.
Kiedy tylko Maker zapłaci hold invoice, aby utworzyć nową ofertę, koordynator wyśle wiadomość do wszystkich kanałów powiadomień ze szczegółami oferty i linkiem do aplikacji BitBlik, gdzie mogą zaakceptować ofertę.

#### Czym są "hold invoices" Lightning Network?

Hold invoices to specjalny typ faktury Lightning. Kiedy hold invoice jest opłacany przez Maker (sprzedawcy Bitcoin), środki nie są natychmiast rozliczone. Zamiast tego są "trzymane" przez węzeł LN koordynatora. Środki są rzeczywiście uwalniane (rozliczane) do odbiorcy (Taker) tylko wtedy, gdy ujawniony zostanie sekretny "preimage". Jeśli preimage nie zostanie ujawniony w określonym czasie lub jeśli faktura zostanie wyraźnie anulowana, środki są zwracane płatnikowi (Maker). To jest podstawa mechanizmu escrow BitBlik.

---
### Bezpieczeństwo i ryzyko
#### Jak moje środki Bitcoin są zabezpieczone jako Maker (sprzedawca)?
Jako Maker, twój Bitcoin jest zablokowany poprzez hold invoice. Koordynator ma preimage wymagany do rozliczenia tego invoice. System jest zaprojektowany tak, aby rozliczyć (uwolnić twój Bitcoin do Taker) *tylko po tym*, jak potwierdzisz, że otrzymałeś płatność fiat (BLIK) od Taker. Jeśli Taker nie zapłaci lub jeśli wystąpi problem, hold invoice może zostać anulowany, a Bitcoin powinien zostać zwrócony (minus ewentualne opłaty routingu Lightning za nieudaną próbę hold).
#### Jak jestem chroniony jako Taker (kupujący), jeśli wyślę płatność BLIK?
Jako Taker, twoja główna ochrona polega na tym, że Maker już zablokował swój Bitcoin w hold invoice u koordynatora *zanim* zostaniesz poproszony o wysłanie płatności BLIK. Jeśli Maker potwierdzi otrzymanie twojego BLIK, system jest zaprojektowany tak, aby automatycznie uwolnić Bitcoin dla ciebie. Ryzyko polega na tym, że Maker fałszywie zaprzeczy otrzymaniu twojego BLIK. (Zobacz "Spory").
#### Co się dzieje, jeśli Maker nie potwierdzi mojej płatności BLIK, mimo że ją wysłałem?
To jest scenariusz konfliktu.
(Zobacz "Spory")
#### Co się dzieje, jeśli Taker poda kod BLIK, ale faktycznie nie dokona płatności?
Jako Maker, nie powinieneś potwierdzać otrzymania płatności, dopóki środki fiat rzeczywiście nie znajdą się na twoim koncie. Jeśli Taker nie zapłaci po podaniu kodu BLIK, nie potwierdziłbyś, a oferta prawdopodobnie wygaśnie lub będzie możliwa do anulowania. Hold invoice zabezpieczający twój Bitcoin ostatecznie zostanie anulowany, zwracając ci środki.
#### Co jeśli kod BLIK podany przez Taker jest nieprawidłowy lub wygasa?
System pozwala na status `invalidBlik`. Jeśli Maker próbuje użyć kodu BLIK i się nie powiedzie, transakcja nie może zostać przeprowadzona. Taker może potrzebować podać nowy kod lub oferta może zostać anulowana.
#### Jakie są ryzyka związane z korzystaniem z tej usługi?
- **Ryzyko kontrahenta:** Główne ryzyko to brak uczciwości drugiej strony (np. Taker nie płaci po tym, jak Maker zablokuje BTC, lub Maker nie potwierdza płatności po tym, jak Taker zapłaci). Mechanizm hold invoice zmniejsza to ryzyko, ale go nie eliminuje, szczególnie w odniesieniu do płatności fiat.
- **Zaufanie do koordynatora:** Ufasz oprogramowaniu koordynatora BitBlik i jego operatorom, że:
  -   Bezpiecznie zarządzają preimages hold invoice.
  -   Poprawnie uruchamiają rozliczenia lub anulowania na podstawie przepływu procesu.
  -   Niezawodnie obsługują usługę.
- **Problemy z węzłem LN:** Zarówno węzeł LN koordynatora, jak i potencjalnie węzły LN użytkowników (jeśli są self-hosted i bezpośrednio współdziałają) muszą być online i działać. Problemy z węzłami LN mogą opóźnić lub skomplikować transakcje.
- **Problemy z systemem BLIK:** Problemy z samym systemem płatności BLIK są poza kontrolą BitBlik. Rozwiązanie takich problemów musi być obsługiwane przez bank Taker lub dostawcę BLIK.
- **Błędy oprogramowania:** Jak w przypadku każdego oprogramowania, istnieje ryzyko błędów w kliencie BitBlik lub koordynatorze, które mogą prowadzić do błędów lub utraty środków. Oprogramowanie ma otwarty kod źródłowy, więc użytkownicy mogą je audytować, ale wymaga to wiedzy technicznej.
- **Prywatność:** Twoje klucze publiczne są przechowywane przez koordynatora. Szczegóły transakcji są również przechowywane w bazie danych. Dla lepszej prywatności powinieneś generować nową parę kluczy dla każdej transakcji.
#### Czy koordynator jest custodialny?
Koordynator nie jest custodialny w tradycyjnym sensie dla *końcowego* rozliczenia Bitcoin dla Taker, ponieważ wypłaca na invoice Taker. Jednak podczas okresu escrow, środki Maker są zablokowane w hold invoice, którą koordynator ma moc rozliczyć (używając preimage) lub polecić anulowanie. Więc istnieje tymczasowy element kontroli przez koordynatora nad zablokowanymi środkami. Zarówno Maker, jak i Taker ufają koordynatorowi, że uwolni te środki zgodnie z protokołem.

#### Co motywuje Makera do uczciwego działania?

Maker zablokował już swoje Bitcoin w fakturze `hold invoice` przed otrzymaniem kodu BLIK. To tworzy silną motywację do uczciwego dokończenia transakcji:

- **Jeśli Maker potwierdzi otrzymanie ważnej płatności BLIK:** Koordynator rozlicza fakturę, uwalniając Bitcoin dla Takera. Maker otrzymuje swoje fiat—wszyscy są zadowoleni.
- **Jeśli Maker fałszywie zaprzeczy otrzymaniu ważnej płatności BLIK:** Taker może otworzyć spór i dostarczyć dowód bankowy potwierdzający, że płatność została dokonana. Jeśli koordynator przyzna rację Takerowi, faktura zostanie rozliczona mimo wszystko, a Maker traci swoje Bitcoin bez możliwości odwołania.
- **Jeśli Maker porzuci transakcję lub przestanie odpowiadać:** Koordynator może rozliczyć fakturę na korzyść Takera (jeśli istnieje dowód płatności) lub, w niejednoznacznych przypadkach, utrzymać środki zablokowane do czasu rozwiązania sporu.

Faktury hold mają ograniczony czas ważności (zazwyczaj kilka godzin), co oznacza, że Maker nie może przeciągać sprawy w nieskończoność. Musi albo uczciwie sfinalizować transakcję, albo ryzykuje utratę swoich Bitcoinów w procesie rozwiązywania sporów.

Bitcoiny zablokowane w fakturze hold sieci Lightning motywują Makera (sprzedającego) do uczciwego działania. Bez dowodów potwierdzających jego rację faktura nie zostanie zwolniona z powrotem do Makera.


#### Co motywuje Takera do uczciwego działania?

Taker przystępuje do transakcji dopiero po tym, jak Maker zablokował już Bitcoin w fakturze typu `hold invoice`. Chociaż chroni to Takera przed Makerem, który może nie mieć środków, Taker również ma silne motywacje do uczciwego działania:

- **Jeśli Taker poda ważny kod BLIK i potwierdzi płatność:** Maker otrzymuje fiat, potwierdza odbiór, a koordynator uwalnia Bitcoin dla Takera. Wszyscy są zadowoleni.
- **Jeśli Taker poda nieważny lub wygasły kod BLIK:** Maker nie może dokończyć płatności i nie potwierdzi odbioru. Transakcja nie dochodzi do skutku, a Bitcoin Makera jest zwracany przez anulowanie faktury. Taker nie otrzymuje nic.
- **Jeśli Taker fałszywie twierdzi, że zapłacił:** W sporze Taker musi dostarczyć dowód bankowy potwierdzający, że płatność BLIK została pobrana z jego konta. Bez takiego dowodu koordynator anuluje fakturę po 48 godzinach, zwracając Bitcoin Makerowi. Taker nic nie zyskuje i marnuje czas wszystkich.
- **Jeśli Taker porzuci transakcję po zarezerwowaniu oferty:** Oferta w końcu wygasa lub zostaje anulowana, a Bitcoin Makera jest zwracany. Taker nic nie zyskuje.

Ponieważ Taker musi dostarczyć weryfikowalne dowody w każdym sporze, nie ma realnej drogi do oszukańczego zdobycia Bitcoin. Nieuczciwy Taker jedynie marnuje czas—swój własny, Makera i koordynatora.

> **Uwaga:** System kaucji dla Takerów jest planowany do przyszłej implementacji, który doda finansową karę dla Takerów marnujących czas koordynatora błahymi sporami lub porzuconymi transakcjami.

#### Co motywuje koordynatora do uczciwego działania?
Aby zostać zaakceptowanym jako koordynator BitBlik przez oprogramowanie klienta, koordynator musi podać klucz nostr (profil), który użytkownicy mogą tagować i zgłaszać złe doświadczenia z danym koordynatorem. Przed wyborem konkretnego koordynatora sprawdź jego reputację na Nostr. Biorąc pod uwagę odporność na censurę Nostr, każdy może zalać lub zamieścić nieprawidłowe raporty, więc użyj klienta, który używa Web of Trust do określenia reputacji raportów każdego użytkownika. Najlepiej wybierz koordynatora, który ma dobrą reputację w twojej społeczności Bitcoin. Ostatecznie, ty jako użytkownik tego oprogramowania jesteś odpowiedzialny za koordynatora, którego wybierzesz. To nie jest platforma ani usługa i nie bierzemy odpowiedzialności za działania żadnego koordynatora.

---
### Opłaty i kwestie techniczne
#### Czy są jakieś opłaty za korzystanie z BitBlik?
Każdy koordynator ustala swoje opłaty, zarówno dla makers, jak i dla takers. Są one wyświetlane w aplikacji klienckiej, zanim oferta zostanie utworzona lub przyjęta.
#### Co się dzieje, jeśli płatność Lightning (wypłata do Taker) się nie powiedzie?
Jeśli koordynator próbuje zapłacić invoice Lightning Taker i się nie powiedzie (np. węzeł Taker offline, brak trasy), transakcja może wejść w ten stan. Taker może potrzebować podać nowy invoice lub rozwiązać problemy z konfiguracją Lightning.
#### Co jeśli ja, jako Maker, chcę anulować moją ofertę po sfinansowaniu, ale przed akceptacją przez Taker?
Możesz anulować hold invoice, a Bitcoin powinien zostać zwrócony do twojego portfela LN. To jest zazwyczaj możliwe, jeśli oferta jest nadal w stanie `funded` i nie jest jeszcze `reserved` lub dalej.
#### Dlaczego aplikacje mobilne nie są dystrybuowane w google play store i apple app store?
Te platformy to nie tylko marketplace; to walled gardens rządzone przez korporacyjnych strażników, którzy sprawują absolutną władzę nad tym, jakie oprogramowanie użytkownicy mogą instalować. Ten scentralizowany model tworzy pojedynczy punkt awarii i wąskie gardło dla censury. Aplikacje promujące technologie zwiększające prywatność, kontrowersyjne wypowiedzi polityczne lub alternatywne modele ekonomiczne mogą być i często są usuwane według wyłącznego uznania właścicieli platform, tłumiąc innowacje i swobodną wymianę idei.

### Spory
Jeśli zarówno maker, jak i taker nie zgadzają się co do statusu płatności lub jeśli są problemy z transakcją, oferta wchodzi w stan `conflict`, w którym każda strona musi dostarczyć dowody dla koordynatora do ręcznego rozwiązania sporu.

> ⚠️ **Ważne:** Każdy koordynator może mieć inne wymagania i/lub procedury rozwiązywania sporów, dlatego zapoznaj się z dokumentacją danego koordynatora lub skontaktuj się z nim bezpośrednio, aby uzyskać szczegółowe informacje.

#### Jakie dowody mogą być ogólnie wymagane ode mnie jako Maker’a przez koordynatora?

Jeśli kod BLIK, którego próbowałeś użyć w terminalu płatniczym lub na stronie e-commerce, był nieprawidłowy lub wygasł, powinieneś dostarczyć dowód nieudanej próby płatności. Może to obejmować:
- wydruk z terminala płatniczego lub bankomatu z informacją o nieprawidłowym kodzie BLIK 
- potwierdzenia z nieudaną próbą płatności na stronie e-commerce

#### Jakie dowody mogą być ogólnie wymagane ode mnie jako Taker’a przez koordynatora?

Jeśli Maker zaprzecza, że otrzymał Twoją płatność BLIK, powinieneś dostarczyć dowód, że płatność BLIK została skutecznie pobrana z Twojego konta bankowego. Zazwyczaj będzie to potwierdzenie płatności z aplikacji bankowej, zawierające szczegóły transakcji BLIK, w tym kwotę i znacznik czasu.

## Wsparcie
Dla błędów/problemów po stronie klienta: 
- [Github issues](https://github.com/bit-blik/client/issues)

W przypadku wsparcia koordynatora lub problemów z ofertami lub sporami, skontaktuj się bezpośrednio z operatorem koordynatora za pomocą wiadomości DM na Nostr, 
jego profil jest dostępny poprzez link do warunków korzystania w aplikacji klienckiej BitBlik.