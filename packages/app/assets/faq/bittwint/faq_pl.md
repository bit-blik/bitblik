## FAQ {app}

### Pytania ogólne

#### Czym jest {app}?

{app} to wolne i otwarte oprogramowanie zaprojektowane, aby ułatwić wymianę Bitcoina na płatności {code} w modelu peer-to-peer — używane w kraju {country}.\
Główna idea to:
- płacenie Bitcoinem wszędzie tam, gdzie akceptowana jest płatność {code}
- kupowanie Bitcoina poprzez opłacanie kodów {code} w imieniu kogoś, kto wydaje Bitcoina

#### Po co kolejne narzędzie P2P? Dlaczego nie użyć istniejących, jak RoboSats, Bisq czy Hodl Hodl?

Te usługi depozytowe (escrow) P2P są znakomite i powinny być używane do większych i długoterminowych transakcji. {app} natomiast jest pomyślany jako szybka metoda płatności kodami {code}, w miejscach/sytuacjach, w których to pasuje, takich jak kasy samoobsługowe, restauracje, zakupy online, a nawet bankomaty.
Cały proces wymiany nie powinien zająć więcej niż kilka minut, w zależności od tego, jak szybko takerzy zauważą nową ofertę i zdołają niezwłocznie opłacić oraz potwierdzić kod {code}.
- **Makerzy** to użytkownicy, którzy chcą sprzedać Bitcoina.
- **Takerzy** to użytkownicy, którzy chcą kupić Bitcoina.

#### Kto dostarcza kod {code} — Maker czy Taker?

Kod {code} dostarcza **Maker**. Przy płatności {code} kod jest pokazywany płacącemu przez terminal lub kasę sprzedawcy, więc Maker (który jest u sprzedawcy i wydaje Bitcoina) odczytuje ten kod {code} i podaje go z góry przy tworzeniu oferty. **Taker następnie wpisuje ten kod {code} w swojej aplikacji {code}** i go opłaca. Kod zawsze wędruje więc od Makera do Takera, a obciążane jest konto Takera.

#### Jak działa proces depozytowy (escrow)?

Proces zwykle przebiega w następujących krokach:
1.  **Utworzenie oferty (Maker):** Maker u sprzedawcy odczytuje pokazany mu kod {code} (na terminalu płatniczym lub przy kasie) i tworzy ofertę zawierającą ten kod {code}, określając kwotę fiat do zapłaty.
2.  **Finansowanie escrow (Maker):** Maker opłaca „hold invoice" sieci Lightning na określoną kwotę Bitcoina. Blokuje to Bitcoina u koordynatora, ale jeszcze go nie przekazuje.
3.  **Przyjęcie oferty (Taker):** Taker znajduje odpowiadającą mu ofertę i ją przyjmuje. Koordynator ujawnia wtedy Takerowi kod {code} Makera.
4.  **Płatność fiat (Taker):** Taker wpisuje kod {code} w swojej aplikacji {code} i go opłaca. Obciąża to konto Takera i realizuje płatność do sprzedawcy.
5.  **Zgłoszenie płatności (Taker):** po opłaceniu Taker oznacza kod {code} jako opłacony w aplikacji {app}.
6.  **Potwierdzenie płatności (Maker):** Maker weryfikuje u sprzedawcy, że płatność {code} przeszła, i potwierdza ją w systemie {app}.
7.  **Uwolnienie Bitcoina (Koordynator):** po potwierdzeniu Makera koordynator używa tajnego preimage, aby „rozliczyć" (settle) hold invoice. To działanie uwalnia zablokowanego Bitcoina na podany przez Takera adres lub fakturę Lightning.

#### Skąd takerzy dowiadują się o nowych ofertach?

Takerzy mogą zarejestrować się na kilku komunikatorach (SimpleX, Matrix, Telegram, Signal), aby otrzymywać powiadomienia o nowych ofertach.
Za każdym razem, gdy Maker opłaci hold invoice, tworząc nową ofertę, koordynator wysyła wiadomość na wszystkie kanały powiadomień ze szczegółami oferty i linkiem do aplikacji {app}, gdzie można ją przyjąć.

#### Czym jest {code}?

{code} to mobilny system płatności używany w kraju {country}. Aby zapłacić, wpisuje się w aplikacji {code} kod o długości {codeLength} cyfr, co obciąża konto bankowe płacącego. W {app} Maker dostarcza kod {code}, a Taker opłaca go w swojej aplikacji {code}, aby kupić Bitcoina Makera.

#### Jak długo ważny jest kod {code}?

Kod {code} jest ważny tylko przez około {validity} minut. Z powodu tak krótkiej ważności Taker musi wpisać i opłacić kod w swojej aplikacji {code} niezwłocznie po przyjęciu oferty. Jeśli kod wygaśnie przed opłaceniem, Maker może dostarczyć nowy kod {code}, aby transakcja mogła być kontynuowana.

#### Czym są „hold invoices" sieci Lightning?

Hold invoices to szczególny rodzaj faktury Lightning. Gdy hold invoice zostaje opłacona przez Makera (sprzedawcę Bitcoina), środki nie są od razu rozliczane. Zamiast tego są „przetrzymywane" przez węzeł Lightning koordynatora. Środki są naprawdę uwalniane (rozliczane) na rzecz odbiorcy (Takera) dopiero po ujawnieniu tajnego „preimage". Jeśli preimage nie zostanie ujawnione w określonym czasie lub jeśli faktura zostanie wprost anulowana, środki wracają do płacącego (Makera). To rdzeń mechanizmu escrow {app}.

---

### Bezpieczeństwo i ryzyka

#### Jak zabezpieczone są moje środki w Bitcoinie jako Makera (sprzedawcy)?

Jako Maker masz Bitcoina zablokowanego przez hold invoice. Koordynator posiada preimage niezbędne do rozliczenia tej faktury. System jest zaprojektowany tak, aby rozliczyć (uwolnić Bitcoina do Takera) dopiero *po* tym, jak potwierdzisz, że płatność {code} przeszła. Jeśli Taker nie zapłaci lub pojawi się problem, hold invoice zostaje anulowana, a Bitcoin wraca pod kontrolę Twojego węzła LN.

#### Jak jestem chroniony jako Taker (kupujący), gdy opłacam kod {code}?

Jako Taker Twoją główną ochroną jest to, że Maker już zablokował swojego Bitcoina w hold invoice u koordynatora *zanim* kod {code} zostanie Ci ujawniony i go opłacisz. Jeśli Maker potwierdzi płatność {code}, system jest zaprojektowany, aby automatycznie uwolnić Bitcoina do Ciebie. Istnieje ryzyko, jeśli Maker fałszywie zaprzeczy, że płatność {code} przeszła. (Zobacz „Spory").

#### Co się stanie, jeśli Maker nie potwierdzi mojej płatności {code}, mimo że ją opłaciłem?

To scenariusz konfliktu. Zauważ, że jeśli Maker milczy, oferta zostaje automatycznie potwierdzona na korzyść Takera po upływie limitu czasu. (Zobacz „Spory")

#### Co się stanie, jeśli Taker przyjmie ofertę, ale faktycznie nie opłaci kodu {code}?

Jako Maker nie powinieneś potwierdzać płatności, dopóki środki {code} faktycznie nie przejdą u sprzedawcy. Jeśli Taker nie opłaci kodu {code}, nie potwierdzasz, a rezerwacja wygasa — oferta wraca do otwartej puli lub hold invoice zostaje anulowana, tak że Twój Bitcoin do Ciebie wraca.

#### Co, jeśli kod {code} dostarczony przez Makera jest nieważny lub wygaśnie, zanim Taker go opłaci?

Jeśli Taker nie może opłacić kodu {code}, bo jest nieważny lub wygasł, rezerwacja przepada. Maker może dostarczyć nowy kod {code}, aby transakcja mogła być kontynuowana, albo oferta może zostać anulowana.

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

Maker już zablokował swojego Bitcoina w hold invoice sieci Lightning, zanim Taker opłaci kod {code}. Tworzy to silną motywację, aby uczciwie sfinalizować transakcję:

- **Jeśli Maker potwierdzi ważną płatność {code}:** koordynator rozlicza hold invoice, uwalniając Bitcoina do Takera. Zakup Makera jest opłacony — wszyscy są zadowoleni.
- **Jeśli Maker fałszywie zaprzeczy ważnej płatności {code}:** Taker może otworzyć spór i dostarczyć dowody bankowe potwierdzające dokonanie płatności. Jeśli koordynator orzeknie na korzyść Takera, hold invoice zostaje mimo to rozliczona, a Maker traci swojego Bitcoina bez odwołania. Zauważ też, że jeśli Maker po prostu milczy, transakcja zostaje automatycznie potwierdzona na korzyść Takera po upływie limitu czasu.
- **Jeśli Maker porzuci transakcję lub przestanie odpowiadać:** koordynator może rozliczyć fakturę na korzyść Takera (jeśli istnieją dowody płatności) lub, w niejasnych przypadkach, utrzymać środki zablokowane do rozstrzygnięcia sporu.

Hold invoices mają ograniczone okno ważności (zwykle kilka godzin), więc Maker nie może zwlekać w nieskończoność. Musi albo uczciwie sfinalizować transakcję, albo ryzykować utratę Bitcoina w procedurze rozstrzygania sporów.

Ponieważ Bitcoin jest przetrzymywany w hold invoice sieci Lightning, Maker (sprzedawca) ma motywację do uczciwego działania. Bez dowodów przeciwnych faktura nie zostanie zwrócona Makerowi.

#### Co motywuje Takera do uczciwego działania?

Taker wchodzi do transakcji dopiero po tym, jak Maker już zablokował Bitcoina w hold invoice. Choć chroni to Takera przed Makerem, który mógłby nie mieć środków, także Taker ma silne motywacje do uczciwego działania:

- **Jeśli Taker opłaci kod {code} i zgłosi go jako opłacony:** zakup Makera przechodzi, Maker to potwierdza, a koordynator uwalnia Bitcoina do Takera. Wszyscy są zadowoleni.
- **Jeśli Taker nie może zapłacić, bo kod {code} jest nieważny lub wygasł:** transakcja nie może się zakończyć. Maker dostarcza nowy kod albo oferta zostaje anulowana, a Bitcoin Makera zwrócony przez anulowanie hold invoice. Taker nie otrzymuje nic.
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
Jeśli twierdzisz, że płatność {code} nie przeszła, powinieneś dostarczyć dowód nieudanej płatności u sprzedawcy. Może to obejmować:
- paragon lub komunikat terminala pokazujący, że płatność {code} nie została zrealizowana.
- zrzut ekranu nieudanej płatności przy kasie lub na stronie e-commerce

#### Jakiego rodzaju dowodów może ode mnie jako Takera ogólnie wymagać koordynator?

Jeśli Maker zaprzecza, że Twoja płatność {code} przeszła, powinieneś udowodnić, że płatność {code} została pomyślnie pobrana z Twojego konta bankowego. Zwykle będzie to potwierdzenie płatności w Twojej aplikacji {code} ze szczegółami transakcji, w tym kwotą i znacznikiem czasu.

## Wsparcie

W sprawie wsparcia koordynatora lub problemów z ofertami czy sporami skontaktuj się bezpośrednio z operatorem koordynatora przez Nostr DM;
jego profil jest dostępny przez link do warunków korzystania w aplikacji klienckiej {app}.
