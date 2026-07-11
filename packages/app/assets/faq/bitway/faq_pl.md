## FAQ {app}

### Pytania ogólne

#### Czym jest {app}?

{app} to wolne i otwarte oprogramowanie zaprojektowane, aby ułatwić wymianę Bitcoina na kody {code} w modelu peer-to-peer — skupione na płaceniu w **bankomatach (Multibanco)** w kraju {country}.\
Główna idea to:
- wydawanie Bitcoina w dowolnym bankomacie Multibanco, który akceptuje płatność {code}
- kupowanie Bitcoina poprzez generowanie i sprzedaż kodów {code}

#### Po co kolejne narzędzie P2P? Dlaczego nie użyć istniejących, jak RoboSats, Bisq czy Hodl Hodl?

Te usługi depozytowe (escrow) P2P są znakomite i powinny być używane do większych i długoterminowych transakcji. {app} natomiast jest pomyślany jako szybka metoda płatności kodami {code} w **bankomatach (Multibanco)**, gdzie możesz wypłacić gotówkę lub opłacić rachunki posiadanym Bitcoinem.
Cały proces wymiany nie powinien zająć więcej niż kilka minut, w zależności od tego, jak szybko takerzy zauważą nową ofertę i zdołają niezwłocznie dostarczyć oraz potwierdzić kod {code}.
- **Makerzy** to użytkownicy, którzy chcą sprzedać Bitcoina.
- **Takerzy** to użytkownicy, którzy chcą kupić Bitcoina.

#### Jak działa proces depozytowy (escrow)?

Proces zwykle przebiega w następujących krokach:
1.  **Utworzenie oferty (Maker):** Maker tworzy ofertę, określając kwotę fiat, za którą chce otrzymać kod {code}.
2.  **Finansowanie escrow (Maker):** Maker opłaca „hold invoice" sieci Lightning na określoną kwotę Bitcoina. Blokuje to Bitcoina u koordynatora, ale jeszcze go nie przekazuje.
3.  **Przyjęcie oferty (Taker):** Taker znajduje odpowiadającą mu ofertę i ją przyjmuje, następnie generuje kod {code} w swojej aplikacji bankowej i przesyła go do koordynatora.
4.  **Płatność fiat (Maker):** Maker otrzymuje kod {code} i wprowadza go w **bankomacie Multibanco**, aby zrealizować płatność lub wypłatę gotówki.
5.  **Potwierdzenie {code} (Taker):** Taker otrzymuje powiadomienie z aplikacji bankowej, aby potwierdzić płatność {code}.
6.  **Potwierdzenie płatności (Maker):** Maker potwierdza w systemie {app}, że otrzymał płatność {code}.
7.  **Uwolnienie Bitcoina (Koordynator):** po potwierdzeniu Makera koordynator używa tajnego preimage, aby „rozliczyć" (settle) hold invoice. To działanie uwalnia zablokowanego Bitcoina na podany przez Takera adres lub fakturę Lightning.

#### Skąd takerzy dowiadują się o nowych ofertach?

Takerzy mogą zarejestrować się na kilku komunikatorach (SimpleX, Matrix, Telegram, Signal), aby otrzymywać powiadomienia o nowych ofertach.
Za każdym razem, gdy Maker opłaci hold invoice, tworząc nową ofertę, koordynator wysyła wiadomość na wszystkie kanały powiadomień ze szczegółami oferty i linkiem do aplikacji {app}, gdzie można ją przyjąć.

#### Czym jest {code}?

{code} to mobilny system płatności używany w kraju {country}. Umożliwia dokonywanie płatności za pomocą kodu o długości {codeLength} cyfr generowanego przez aplikację bankową, który można wprowadzić bezpośrednio w bankomacie Multibanco. W {app} takerzy używają {code}, aby płacić makerom za Bitcoina.

#### Czym są „hold invoices" sieci Lightning?

Hold invoices to szczególny rodzaj faktury Lightning. Gdy hold invoice zostaje opłacona przez Makera (sprzedawcę Bitcoina), środki nie są od razu rozliczane. Zamiast tego są „przetrzymywane" przez węzeł Lightning koordynatora. Środki są naprawdę uwalniane (rozliczane) na rzecz odbiorcy (Takera) dopiero po ujawnieniu tajnego „preimage". Jeśli preimage nie zostanie ujawnione w określonym czasie lub jeśli faktura zostanie wprost anulowana, środki wracają do płacącego (Makera). To rdzeń mechanizmu escrow {app}.

---

### Bezpieczeństwo i ryzyka

#### Jak zabezpieczone są moje środki w Bitcoinie jako Makera (sprzedawcy)?

Jako Maker masz Bitcoina zablokowanego przez hold invoice. Koordynator posiada preimage niezbędne do rozliczenia tej faktury. System jest zaprojektowany tak, aby rozliczyć (uwolnić Bitcoina do Takera) dopiero *po* tym, jak potwierdzisz, że otrzymałeś płatność fiat ({code}) od Takera. Jeśli Taker nie zapłaci lub pojawi się problem, hold invoice zostaje anulowana, a Bitcoin wraca pod kontrolę Twojego węzła LN.

#### Jak jestem chroniony jako Taker (kupujący), gdy wysyłam płatność {code}?

Jako Taker Twoją główną ochroną jest to, że Maker już zablokował swojego Bitcoina w hold invoice u koordynatora *zanim* zostaniesz poproszony o wysłanie płatności {code}. Jeśli Maker potwierdzi otrzymanie Twojego {code}, system jest zaprojektowany, aby automatycznie uwolnić Bitcoina do Ciebie. Istnieje ryzyko, jeśli Maker fałszywie zaprzeczy, że otrzymał Twój {code}. (Zobacz „Spory").

#### Co się stanie, jeśli Maker nie potwierdzi mojej płatności {code}, mimo że ją wysłałem?

To scenariusz konfliktu. (Zobacz „Spory")

#### Co się stanie, jeśli Taker dostarczy kod {code}, ale faktycznie nie dokona płatności?

Jako Maker nie powinieneś potwierdzać otrzymania płatności, dopóki środki fiat nie znajdą się faktycznie na Twoim koncie. Jeśli Taker nie zapłaci po dostarczeniu kodu {code}, nie potwierdzasz, a oferta prawdopodobnie wygaśnie lub będzie mogła zostać anulowana. Hold invoice zabezpieczająca Twojego Bitcoina zostanie ostatecznie anulowana, zwracając Ci środki.

#### Co, jeśli kod {code} dostarczony przez Takera jest nieważny lub wygaśnie?

Jeśli Maker spróbuje użyć kodu {code} w bankomacie i to się nie powiedzie, transakcja nie może być kontynuowana. Taker może potrzebować dostarczyć nowy kod albo oferta może zostać anulowana.

#### Jakie są ryzyka korzystania z tego protokołu?

- **Ryzyko kontrahenta:** głównym ryzykiem jest to, że druga strona nie zachowa się uczciwie (np. Taker nie zapłaci po tym, jak Maker zablokuje BTC, albo Maker nie potwierdzi płatności po tym, jak Taker zapłaci). Mechanizm hold invoice łagodzi to, ale nie eliminuje, zwłaszcza wokół etapu płatności fiat.
- **Zaufanie do koordynatora:** ufasz oprogramowaniu koordynatora {app} i jego operatorom, że:
  -   bezpiecznie zarządzają preimage hold invoice.
  -   poprawnie uruchamiają rozliczenia lub anulowania zgodnie z przebiegiem procesu.
  -   niezawodnie prowadzą usługę.
- **Problemy węzła LN:** zarówno węzeł LN koordynatora, jak i ewentualnie węzły użytkowników (przy własnym hostingu i bezpośredniej interakcji) muszą być online i sprawne. Problemy z węzłami LN mogą opóźnić lub skomplikować transakcje.
- **Problemy systemu {code}:** problemy z samym systemem płatności {code} są poza kontrolą {app}. Ich rozwiązanie musi przebiegać przez bank Takera lub dostawcę {code}.
- **Błędy oprogramowania:** jak w każdym oprogramowaniu, istnieje ryzyko błędów w kliencie lub koordynatorze {app}, które mogłyby prowadzić do pomyłek lub utraty środków. Oprogramowanie jest otwarte, więc użytkownicy mogą je audytować, co jednak wymaga wiedzy technicznej.
- **Prywatność:** Twoje klucze publiczne są przechowywane przez koordynatora. Szczegóły transakcji również są zapisywane w bazie danych. **Dla lepszej prywatności powinieneś generować nową parę kluczy dla każdej transakcji.**

#### Czy koordynator jest powierniczy (custodial)?

Koordynator nie jest powierniczy w tradycyjnym sensie dla *ostatecznego* rozliczenia Bitcoina do Takera, ponieważ wypłaca na fakturę Takera. Jednak w okresie escrow środki Makera są zablokowane w hold invoice, którą koordynator może rozliczyć (używając preimage) lub zlecić jej anulowanie. Istnieje więc tymczasowy element kontroli koordynatora nad zablokowanymi środkami. Zarówno Maker, jak i Taker ufają, że koordynator uwolni te środki zgodnie z protokołem.

#### Co motywuje Makera do uczciwego działania?

Maker już zablokował swojego Bitcoina w hold invoice sieci Lightning, zanim otrzyma kod {code}. Tworzy to silną motywację, aby uczciwie sfinalizować transakcję:

- **Jeśli Maker potwierdzi otrzymanie ważnej płatności {code}:** koordynator rozlicza hold invoice, uwalniając Bitcoina do Takera. Maker otrzymuje swoje fiat — wszyscy są zadowoleni.
- **Jeśli Maker fałszywie zaprzeczy otrzymaniu ważnej płatności {code}:** Taker może otworzyć spór i dostarczyć dowody bankowe potwierdzające dokonanie płatności. Jeśli koordynator orzeknie na korzyść Takera, hold invoice zostaje mimo to rozliczona, a Maker traci swojego Bitcoina bez odwołania.
- **Jeśli Maker porzuci transakcję lub przestanie odpowiadać:** koordynator może rozliczyć fakturę na korzyść Takera (jeśli istnieją dowody płatności) lub, w niejasnych przypadkach, utrzymać środki zablokowane do rozstrzygnięcia sporu.

Hold invoices mają ograniczone okno ważności (zwykle kilka godzin), więc Maker nie może zwlekać w nieskończoność. Musi albo uczciwie sfinalizować transakcję, albo ryzykować utratę Bitcoina w procedurze rozstrzygania sporów.

Ponieważ Bitcoin jest przetrzymywany w hold invoice sieci Lightning, Maker (sprzedawca) ma motywację do uczciwego działania. Bez dowodów przeciwnych faktura nie zostanie zwrócona Makerowi.

#### Co motywuje Takera do uczciwego działania?

Taker wchodzi do transakcji dopiero po tym, jak Maker już zablokował Bitcoina w hold invoice. Choć chroni to Takera przed Makerem, który mógłby nie mieć środków, także Taker ma silne motywacje do uczciwego działania:

- **Jeśli Taker dostarczy ważny kod {code} i potwierdzi płatność:** Maker otrzymuje fiat, potwierdza odbiór, a koordynator uwalnia Bitcoina do Takera. Wszyscy są zadowoleni.
- **Jeśli Taker dostarczy nieważny lub wygasły kod {code}:** Maker nie może zrealizować płatności w bankomacie i nie potwierdza odbioru. Transakcja się nie udaje, a Bitcoin Makera jest zwracany przez anulowanie hold invoice. Taker nie otrzymuje nic.
- **Jeśli Taker fałszywie twierdzi, że zapłacił:** w sporze Taker musi dostarczyć dowody bankowe potwierdzające, że płatność {code} została pobrana z jego konta. Bez takich dowodów koordynator anuluje hold invoice po 48 godzinach, zwracając Bitcoina Makerowi. Taker nic nie zyskuje i marnuje czas wszystkich.
- **Jeśli Taker porzuci transakcję po zarezerwowaniu oferty:** oferta ostatecznie wygasa lub zostaje anulowana, a Bitcoin Makera zwrócony. Taker nic nie zyskuje.

Ponieważ Taker musi dostarczyć weryfikowalne dowody w każdym sporze, nie istnieje realna droga do oszukańczego zdobycia Bitcoina. Nieuczciwy Taker zdoła jedynie zmarnować czas — swój, Makera i koordynatora.

> **Uwaga:** w przyszłości planowany jest system kaucji (bond) dla takerów, który doda karę finansową dla takerów marnujących czas koordynatora niepoważnymi sporami lub porzuconymi transakcjami.

#### Co motywuje koordynatora do uczciwego działania?

Koordynator musi podać klucz Nostr (profil), który użytkownicy mogą oznaczyć, aby zgłosić złe doświadczenia z danym koordynatorem. Zanim wybierzesz konkretnego koordynatora, sprawdź jego reputację na Nostr. Ze względu na odporny na cenzurę charakter Nostr każdy może zalewać lub publikować fałszywe zgłoszenia, więc używaj klienta korzystającego z Web of Trust, aby ocenić wiarygodność zgłoszeń każdego użytkownika. Najlepiej wybierz koordynatora o dobrej reputacji w Twojej społeczności Bitcoin lub wśród zaufanych znajomych. Ostatecznie to Ty, użytkownik tego oprogramowania, odpowiadasz za wybór koordynatora o dobrej reputacji. To nie jest platforma ani usługa i nie ponosimy odpowiedzialności za działania żadnego koordynatora.

---

### Opłaty i kwestie techniczne

#### Czy są jakieś opłaty za korzystanie z {app}?

Każdy koordynator ustala własne opłaty, zarówno dla makerów, jak i takerów. Są one wyświetlane w aplikacji klienckiej, zanim oferta zostanie utworzona lub przyjęta.

#### Co się stanie, jeśli płatność Lightning (wypłata do Takera) się nie powiedzie?

Jeśli koordynator próbuje opłacić fakturę Lightning Takera i to się nie uda (np. węzeł Takera offline, brak trasy), transakcja może wejść w ten stan. Taker może potrzebować dostarczyć nową fakturę lub rozwiązać problemy ze swoją konfiguracją Lightning.

#### Co, jeśli jako Maker chcę anulować ofertę po jej sfinansowaniu, ale zanim Taker ją przyjmie?

Możesz anulować hold invoice, a Bitcoin powinien wrócić do Twojego portfela LN. Zwykle jest to możliwe, dopóki oferta jest jeszcze w stanie `funded`, a nie `reserved` czy dalej.

#### Dlaczego aplikacje mobilne nie są dystrybuowane w Google Play Store lub Apple App Store?
Te platformy to nie są zwykłe rynki; to ogrodzone ogrody rządzone przez korporacyjnych strażników, którzy sprawują absolutną władzę nad tym, jakie oprogramowanie użytkownicy mogą instalować. Ten scentralizowany model tworzy pojedynczy punkt awarii i wąskie gardło dla cenzury. Aplikacje promujące technologie chroniące prywatność, kontrowersyjne wypowiedzi polityczne lub alternatywne modele ekonomiczne mogą być — i często są — usuwane wedle wyłącznego uznania właścicieli platformy, tłumiąc innowacje i swobodną wymianę idei.

### Spory

Jeśli maker i taker nie zgadzają się co do statusu płatności lub jeśli występują problemy z transakcją, oferta wchodzi w stan `conflict`, w którym każda strona musi dostarczyć dowody, aby koordynator rozstrzygnął spór ręcznie.

> ⚠️ **Ważne:** każdy koordynator może mieć inne wymagania i/lub procedurę rozstrzygania sporów, więc sprawdź dokumentację koordynatora lub skontaktuj się z nim bezpośrednio, aby mieć pewność.

#### Jakiego rodzaju dowodów może ode mnie jako Makera ogólnie wymagać koordynator?
Jeśli kod {code}, którego próbowałeś użyć w bankomacie Multibanco, był nieważny lub wygasł, powinieneś dostarczyć dowód nieudanej próby płatności. Może to obejmować:
- paragon z nieważnym kodem {code} wydrukowany przez bankomat.
- zrzut ekranu lub wydruk nieudanej próby płatności w bankomacie

#### Jakiego rodzaju dowodów może ode mnie jako Takera ogólnie wymagać koordynator?

Jeśli Maker zaprzecza, że otrzymał Twoją płatność {code}, powinieneś udowodnić, że płatność {code} została pomyślnie pobrana z Twojego konta bankowego. Zwykle będzie to potwierdzenie płatności z Twojej aplikacji bankowej ze szczegółami transakcji {code}, w tym kwotą i znacznikiem czasu.

## Wsparcie

W sprawie wsparcia koordynatora lub problemów z ofertami czy sporami skontaktuj się bezpośrednio z operatorem koordynatora przez Nostr DM;
jego profil jest dostępny przez link do warunków korzystania w aplikacji klienckiej {app}.
