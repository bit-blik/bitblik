## FAQ {app}

### Domande generali

#### Cos'è {app}?

{app} è un software libero e open source progettato per facilitare lo scambio peer-to-peer di Bitcoin contro pagamenti {code} — usato in {country}.\
L'idea di fondo è:
- pagare in Bitcoin ovunque sia accettato il pagamento {code}
- comprare Bitcoin pagando codici {code} per conto di chi sta spendendo Bitcoin

#### Perché un altro strumento P2P? Perché non usare quelli esistenti come RoboSats, Bisq o Hodl Hodl?

Questi servizi di deposito a garanzia (escrow) P2P sono eccellenti e andrebbero usati per scambi più grandi e a lungo termine. {app}, invece, è pensato come metodo di pagamento rapido tramite codici {code}, in luoghi/situazioni adatti come casse self-service, ristoranti, acquisti online e persino sportelli bancomat.
L'intero processo di scambio non dovrebbe richiedere più di un paio di minuti, a seconda di quanto rapidamente i taker notano la nuova offerta e riescono a pagare e confermare prontamente il codice {code}.
- **Maker**: utenti che vogliono vendere Bitcoin.
- **Taker**: utenti che vogliono comprare Bitcoin.

#### Chi fornisce il codice {code}, il Maker o il Taker?

È il **Maker a fornire il codice {code}**. Nel pagamento {code} il codice viene mostrato al pagante dal terminale o dalla cassa del commerciante; il Maker (che si trova dal commerciante e sta spendendo Bitcoin) legge quel codice {code} e lo fornisce in anticipo al momento di creare l'offerta. Il **Taker inserisce poi quel codice {code} nella propria app {code}** e lo paga. Il codice viaggia quindi sempre dal Maker al Taker, ed è il conto del Taker a essere addebitato.

#### Come funziona il processo di escrow?

Il processo segue generalmente questi passaggi:
1.  **Creazione dell'offerta (Maker):** un Maker presso il commerciante legge il codice {code} che gli viene mostrato (sul terminale di pagamento o alla cassa) e crea un'offerta contenente quel codice {code}, indicando l'importo fiat da pagare.
2.  **Finanziamento dell'escrow (Maker):** il Maker paga una "hold invoice" della rete Lightning per l'importo di Bitcoin indicato. Questo blocca il Bitcoin presso il coordinatore senza però trasferirlo ancora.
3.  **Accettazione dell'offerta (Taker):** un Taker trova un'offerta di suo gradimento e la accetta. Il coordinatore rivela quindi al Taker il codice {code} del Maker.
4.  **Pagamento fiat (Taker):** il Taker inserisce il codice {code} nella propria app {code} e lo paga. Questo addebita il conto del Taker e regola il pagamento verso il commerciante.
5.  **Segnalazione del pagamento (Taker):** una volta pagato, il Taker contrassegna il codice {code} come saldato nell'app {app}.
6.  **Conferma del pagamento (Maker):** il Maker verifica presso il commerciante che il pagamento {code} sia andato a buon fine e lo conferma nel sistema {app}.
7.  **Rilascio del Bitcoin (Coordinatore):** dopo la conferma del Maker, il coordinatore usa la preimage segreta per "settlare" la hold invoice. Questa azione rilascia il Bitcoin bloccato verso l'indirizzo o la fattura Lightning fornita dal Taker.

#### Come vengono informati i taker delle nuove offerte?

I taker possono registrarsi su diversi canali di messaggistica (SimpleX, Matrix, Telegram, Signal) per ricevere notifiche sulle nuove offerte.
Ogni volta che un Maker paga la hold invoice per creare una nuova offerta, il coordinatore invia un messaggio a tutti i canali di notifica con i dettagli dell'offerta e un link all'app {app} dove può essere accettata.

#### Cos'è {code}?

{code} è un sistema di pagamento mobile usato in {country}. Per pagare si inserisce un codice di {codeLength} cifre nell'app {code}, che addebita il conto bancario del pagante. In {app}, il Maker fornisce il codice {code} e il Taker lo paga nella propria app {code} per comprare il Bitcoin del Maker.

#### Per quanto tempo è valido un codice {code}?

Un codice {code} è valido solo per circa {validity} minuti. Per questa breve durata, il Taker deve inserire e pagare il codice nella propria app {code} tempestivamente dopo aver accettato l'offerta. Se il codice scade prima di essere pagato, il Maker può fornire un nuovo codice {code} affinché lo scambio possa proseguire.

#### Cosa sono le "hold invoice" della rete Lightning?

Le hold invoice sono un tipo particolare di fattura Lightning. Quando una hold invoice viene pagata dal Maker (venditore di Bitcoin), i fondi non vengono regolati subito. Vengono invece "trattenuti" dal nodo Lightning del coordinatore. I fondi vengono realmente rilasciati (regolati) al destinatario (Taker) solo quando viene rivelata una "preimage" segreta. Se la preimage non viene rivelata entro un certo tempo, o se la fattura viene esplicitamente annullata, i fondi tornano al pagante (Maker). Questo è il cuore del meccanismo di escrow di {app}.

---

### Sicurezza & Rischi

#### Come sono protetti i miei fondi Bitcoin come Maker (venditore)?

Come Maker, il tuo Bitcoin è bloccato tramite una hold invoice. Il coordinatore possiede la preimage necessaria a settlare questa fattura. Il sistema è progettato per settlare (rilasciare il tuo Bitcoin al Taker) solo *dopo* che hai confermato che il pagamento {code} è andato a buon fine. Se il Taker non paga, o in caso di problema, la hold invoice viene annullata e il Bitcoin torna sotto il controllo del tuo nodo LN.

#### Come sono protetto come Taker (acquirente) quando pago un codice {code}?

Come Taker, la tua protezione principale è che il Maker ha già bloccato il proprio Bitcoin in una hold invoice presso il coordinatore *prima* che il codice {code} ti venga rivelato e tu lo paghi. Se il Maker conferma il pagamento {code}, il sistema è progettato per rilasciarti automaticamente il Bitcoin. Esiste un rischio se il Maker nega falsamente che il pagamento {code} sia andato a buon fine. (Vedi "Controversie").

#### Cosa succede se il Maker non conferma il mio pagamento {code} anche se l'ho pagato?

È uno scenario di conflitto. Nota che se il Maker resta in silenzio, l'offerta viene confermata automaticamente a favore del Taker dopo un timeout. (Vedi "Controversie")

#### Cosa succede se il Taker accetta l'offerta ma non paga effettivamente il codice {code}?

Come Maker, non dovresti confermare il pagamento finché i fondi {code} non sono effettivamente passati presso il commerciante. Se il Taker non paga il codice {code}, non confermi, e la prenotazione scade — l'offerta torna nel pool aperto oppure la hold invoice viene annullata così che il tuo Bitcoin ti venga restituito.

#### Cosa succede se il codice {code} fornito dal Maker è invalido o scade prima che il Taker lo paghi?

Se il Taker non può pagare il codice {code} perché è invalido o scaduto, la prenotazione decade. Il Maker può fornire un nuovo codice {code} affinché lo scambio prosegua, oppure l'offerta può essere annullata.

#### Quali sono i rischi nell'usare questo protocollo?

- **Rischio di controparte:** il rischio principale è che l'altra parte non agisca onestamente (es. il Taker non paga dopo che il Maker ha bloccato i BTC, o il Maker non conferma il pagamento dopo che il Taker ha pagato). Il meccanismo della hold invoice mitiga questo rischio ma non lo elimina, specie riguardo alla parte del pagamento fiat.
- **Fiducia nel coordinatore:** ti affidi al software coordinatore di {app} e ai suoi operatori affinché:
  -   gestiscano in modo sicuro le preimage delle hold invoice.
  -   attivino correttamente settlement o annullamenti in base al flusso del processo.
  -   gestiscano il servizio in modo affidabile.
- **Problemi del nodo LN:** sia il nodo LN del coordinatore sia eventualmente i nodi degli utenti (se auto-ospitati e in interazione diretta) devono essere online e operativi. Problemi con i nodi LN possono ritardare o complicare le transazioni.
- **Problemi del sistema {code}:** i problemi del sistema di pagamento {code} stesso sono fuori dal controllo di {app}. La loro risoluzione deve avvenire tramite la banca del Taker o il fornitore {code}.
- **Bug del software:** come ogni software, il client o il coordinatore {app} può contenere bug che potrebbero causare errori o perdita di fondi. Essendo open source, gli utenti possono verificarlo, ma ciò richiede competenze tecniche.
- **Privacy:** le tue chiavi pubbliche sono conservate dal coordinatore. Anche i dettagli delle transazioni sono salvati nel database. **Per una migliore privacy dovresti generare una nuova coppia di chiavi per ogni transazione.**

#### Il coordinatore è custodiale?

Il coordinatore non è custodiale in senso tradizionale per il regolamento *finale* del Bitcoin al Taker, poiché paga verso la fattura del Taker. Tuttavia, durante il periodo di escrow, i fondi del Maker sono bloccati in una hold invoice che il coordinatore può settlare (con la preimage) o far annullare. Esiste quindi un elemento di controllo temporaneo del coordinatore sui fondi bloccati. Sia il Maker sia il Taker si fidano che il coordinatore rilasci questi fondi secondo il protocollo.

#### Cosa spinge il Maker ad agire onestamente?

Il Maker ha già bloccato il proprio Bitcoin in una hold invoice della rete Lightning prima che il codice {code} venga pagato dal Taker. Questo crea un forte incentivo a portare a termine lo scambio onestamente:

- **Se il Maker conferma un pagamento {code} valido:** il coordinatore settla la hold invoice e rilascia il Bitcoin al Taker. L'acquisto del Maker è pagato — tutti sono soddisfatti.
- **Se il Maker nega falsamente un pagamento {code} valido:** il Taker può aprire una controversia e fornire prove bancarie che dimostrano il pagamento. Se il coordinatore decide a favore del Taker, la hold invoice viene settlata comunque, e il Maker perde il proprio Bitcoin senza appello. Nota inoltre che se il Maker resta semplicemente in silenzio, lo scambio viene confermato automaticamente a favore del Taker dopo un timeout.
- **Se il Maker abbandona lo scambio o diventa irreperibile:** il coordinatore può settlare la fattura a favore del Taker (se esistono prove di pagamento) o, nei casi ambigui, mantenere i fondi bloccati fino alla risoluzione della controversia.

Le hold invoice hanno una finestra di validità limitata (di norma qualche ora), quindi il Maker non può temporeggiare indefinitamente. Deve concludere lo scambio onestamente o rischiare di perdere il proprio Bitcoin tramite la procedura di risoluzione delle controversie.

Con il Bitcoin trattenuto in una hold invoice della rete Lightning, il Maker (venditore) è incentivato ad agire onestamente. Senza prove contrarie, la fattura non verrà restituita al Maker.

#### Cosa spinge il Taker ad agire onestamente?

Il Taker entra nello scambio solo dopo che il Maker ha già bloccato Bitcoin in una hold invoice. Sebbene questo protegga il Taker da un Maker privo di fondi, anche il Taker ha forti incentivi ad agire onestamente:

- **Se il Taker paga il codice {code} e lo segnala come saldato:** l'acquisto del Maker va a buon fine, il Maker lo conferma, e il coordinatore rilascia il Bitcoin al Taker. Tutti sono soddisfatti.
- **Se il Taker non può pagare perché il codice {code} è invalido o scaduto:** lo scambio non può concludersi. Il Maker fornisce un nuovo codice oppure l'offerta viene annullata e il Bitcoin del Maker restituito tramite annullamento della hold invoice. Il Taker non riceve nulla.
- **Se il Taker afferma falsamente di aver pagato:** in una controversia, il Taker deve fornire prove bancarie che dimostrino l'addebito del pagamento {code} dal proprio conto. Senza tali prove, il coordinatore annulla la hold invoice dopo 48 ore e restituisce il Bitcoin al Maker. Il Taker non guadagna nulla e fa perdere tempo a tutti.
- **Se il Taker abbandona lo scambio dopo aver prenotato un'offerta:** l'offerta prima o poi scade o viene annullata, e il Bitcoin del Maker viene restituito. Il Taker non guadagna nulla.

Poiché il Taker deve fornire prove verificabili in ogni controversia, non esiste un modo praticabile per ottenere Bitcoin in modo fraudolento. Un Taker disonesto riesce solo a far perdere tempo — a sé stesso, al Maker e al coordinatore.

> **Nota:** è previsto per il futuro un sistema di cauzione (bond) per i taker, che aggiungerà una penale economica per i taker che fanno perdere tempo al coordinatore con controversie pretestuose o scambi abbandonati.

#### Cosa spinge il coordinatore ad agire onestamente?

Il coordinatore deve fornire una chiave Nostr (profilo) che gli utenti possono taggare per segnalare cattive esperienze con un dato coordinatore. Prima di scegliere un coordinatore specifico, verifica la sua reputazione su Nostr. Data la natura resistente alla censura di Nostr, chiunque può inondare o pubblicare segnalazioni false; usa quindi un client che sfrutta una Web of Trust per determinare l'affidabilità delle segnalazioni di ciascun utente. Scegli preferibilmente un coordinatore con buona reputazione nella tua comunità Bitcoin o tra i tuoi amici fidati. In definitiva, sei tu, utente di questo software, il responsabile della scelta di un coordinatore di buona reputazione. Questa non è una piattaforma né un servizio e non ci assumiamo alcuna responsabilità per le azioni di un coordinatore.

---

### Commissioni & Aspetti tecnici

#### Ci sono commissioni per usare {app}?

Ogni coordinatore stabilisce le proprie commissioni, sia per i maker sia per i taker. Vengono mostrate nell'applicazione client prima che un'offerta venga creata o accettata.

#### Cosa succede se un pagamento Lightning (versamento al Taker) fallisce?

Se il coordinatore tenta di pagare la fattura Lightning del Taker e fallisce (es. nodo del Taker offline, nessuna rotta), la transazione può entrare in questo stato. Il Taker potrebbe dover fornire una nuova fattura o risolvere problemi con la propria configurazione Lightning.

#### Cosa succede se, come Maker, voglio annullare la mia offerta dopo averla finanziata ma prima che un Taker la accetti?

Puoi annullare la hold invoice, e il Bitcoin dovrebbe tornare nel tuo portafoglio LN. Di norma è possibile finché l'offerta è ancora nello stato `funded` e non ancora `reserved` o più avanti.

#### Perché le app mobili non sono distribuite su Google Play Store o Apple App Store?
Queste piattaforme non sono semplici mercati; sono giardini recintati governati da guardiani aziendali che esercitano autorità assoluta su quale software gli utenti possono installare. Questo modello centralizzato crea un singolo punto di guasto e un collo di bottiglia per la censura. Le app che promuovono tecnologie per la privacy, discorsi politici controversi o modelli economici alternativi possono essere, e spesso sono, rimosse a totale discrezione dei proprietari della piattaforma, soffocando l'innovazione e il libero scambio di idee.

### Controversie

Se maker e taker sono in disaccordo sullo stato del pagamento o se ci sono problemi con la transazione, l'offerta entra in uno stato di `conflict`, in cui ciascuna parte deve fornire prove affinché il coordinatore risolva la controversia manualmente.

> ⚠️ **Importante:** ogni coordinatore può avere requisiti e/o procedure di risoluzione delle controversie diversi; verifica quindi la documentazione del coordinatore o contattalo direttamente per esserne sicuro.

#### Che tipo di prova potrebbe generalmente essermi richiesta come Maker dal coordinatore?
Se sostieni che il pagamento {code} non è andato a buon fine, dovresti fornire prova del pagamento fallito presso il commerciante. Ad esempio:
- ricevuta o messaggio del terminale che mostra che il pagamento {code} non è stato completato.
- screenshot del pagamento fallito alla cassa o sul sito e-commerce

#### Che tipo di prova potrebbe generalmente essermi richiesta come Taker dal coordinatore?

Se il Maker nega che il tuo pagamento {code} sia andato a buon fine, dovresti dimostrare che il pagamento {code} è stato effettivamente addebitato sul tuo conto bancario. Sarà tipicamente una ricevuta di pagamento nella tua app {code} con i dettagli della transazione, inclusi importo e data/ora.

## Supporto

Per il supporto del coordinatore o problemi con offerte o controversie, contatta direttamente l'operatore del coordinatore tramite DM Nostr;
il suo profilo è accessibile tramite il link ai termini d'uso nell'app client {app}.
