## FAQ {app}

### Domande generali

#### Cos'è {app}?

{app} è un software libero e open source progettato per facilitare lo scambio peer-to-peer di Bitcoin contro codici {code} — incentrato sul pagamento agli **sportelli bancomat (Multibanco)** in {country}.\
L'idea di fondo è:
- spendere Bitcoin a qualsiasi bancomat Multibanco che accetti il pagamento {code}
- comprare Bitcoin generando e vendendo codici {code}

#### Perché un altro strumento P2P? Perché non usare quelli esistenti come RoboSats, Bisq o Hodl Hodl?

Questi servizi di deposito a garanzia (escrow) P2P sono eccellenti e andrebbero usati per scambi più grandi e a lungo termine. {app}, invece, è pensato come metodo di pagamento rapido tramite codici {code} agli **sportelli bancomat (Multibanco)**, dove puoi prelevare contanti o pagare bollette con il Bitcoin che detieni.
L'intero processo di scambio non dovrebbe richiedere più di un paio di minuti, a seconda di quanto rapidamente i taker notano la nuova offerta e riescono a fornire e confermare prontamente il codice {code}.
- **Maker**: utenti che vogliono vendere Bitcoin.
- **Taker**: utenti che vogliono comprare Bitcoin.

#### Come funziona il processo di escrow?

Il processo segue generalmente questi passaggi:
1.  **Creazione dell'offerta (Maker):** un Maker crea un'offerta, indicando l'importo fiat per cui desidera ricevere un codice {code}.
2.  **Finanziamento dell'escrow (Maker):** il Maker paga una "hold invoice" della rete Lightning per l'importo di Bitcoin indicato. Questo blocca il Bitcoin presso il coordinatore senza però trasferirlo ancora.
3.  **Accettazione dell'offerta (Taker):** un Taker trova un'offerta di suo gradimento e la accetta, poi genera un codice {code} nella propria app bancaria e lo invia al coordinatore.
4.  **Pagamento fiat (Maker):** il Maker riceve il codice {code} e lo inserisce allo **sportello bancomat Multibanco** per completare il pagamento o il prelievo di contanti.
5.  **Conferma {code} (Taker):** il Taker riceve una notifica dalla propria app bancaria per confermare il pagamento {code}.
6.  **Conferma del pagamento (Maker):** il Maker conferma nel sistema {app} di aver ricevuto il pagamento {code}.
7.  **Rilascio del Bitcoin (Coordinatore):** dopo la conferma del Maker, il coordinatore usa la preimage segreta per "settlare" la hold invoice. Questa azione rilascia il Bitcoin bloccato verso l'indirizzo o la fattura Lightning fornita dal Taker.

#### Come vengono informati i taker delle nuove offerte?

I taker possono registrarsi su diversi canali di messaggistica (SimpleX, Matrix, Telegram, Signal) per ricevere notifiche sulle nuove offerte.
Ogni volta che un Maker paga la hold invoice per creare una nuova offerta, il coordinatore invia un messaggio a tutti i canali di notifica con i dettagli dell'offerta e un link all'app {app} dove può essere accettata.

#### Cos'è {code}?

{code} è un sistema di pagamento mobile usato in {country}. Consente di effettuare pagamenti tramite un codice di {codeLength} cifre generato dall'app bancaria, che può essere inserito direttamente a uno sportello bancomat Multibanco. In {app}, i Taker usano {code} per pagare i Maker in cambio di Bitcoin.

#### Cosa sono le "hold invoice" della rete Lightning?

Le hold invoice sono un tipo particolare di fattura Lightning. Quando una hold invoice viene pagata dal Maker (venditore di Bitcoin), i fondi non vengono regolati subito. Vengono invece "trattenuti" dal nodo Lightning del coordinatore. I fondi vengono realmente rilasciati (regolati) al destinatario (Taker) solo quando viene rivelata una "preimage" segreta. Se la preimage non viene rivelata entro un certo tempo, o se la fattura viene esplicitamente annullata, i fondi tornano al pagante (Maker). Questo è il cuore del meccanismo di escrow di {app}.

---

### Sicurezza & Rischi

#### Come sono protetti i miei fondi Bitcoin come Maker (venditore)?

Come Maker, il tuo Bitcoin è bloccato tramite una hold invoice. Il coordinatore possiede la preimage necessaria a settlare questa fattura. Il sistema è progettato per settlare (rilasciare il tuo Bitcoin al Taker) solo *dopo* che hai confermato di aver ricevuto il pagamento fiat ({code}) dal Taker. Se il Taker non paga, o in caso di problema, la hold invoice viene annullata e il Bitcoin torna sotto il controllo del tuo nodo LN.

#### Come sono protetto come Taker (acquirente) se invio un pagamento {code}?

Come Taker, la tua protezione principale è che il Maker ha già bloccato il proprio Bitcoin in una hold invoice presso il coordinatore *prima* che ti venga chiesto di inviare il pagamento {code}. Se il Maker conferma la ricezione del tuo {code}, il sistema è progettato per rilasciarti automaticamente il Bitcoin. Esiste un rischio se il Maker nega falsamente di aver ricevuto il tuo {code}. (Vedi "Controversie").

#### Cosa succede se il Maker non conferma il mio pagamento {code} anche se l'ho inviato?

È uno scenario di conflitto. (Vedi "Controversie")

#### Cosa succede se il Taker fornisce un codice {code} ma non effettua realmente il pagamento?

Come Maker, non dovresti confermare la ricezione del pagamento finché i fondi fiat non sono effettivamente sul tuo conto. Se il Taker non paga dopo aver fornito un codice {code}, non confermi, e l'offerta probabilmente scade o può essere annullata. La hold invoice che protegge il tuo Bitcoin verrà infine annullata, restituendoti i fondi.

#### E se il codice {code} fornito dal Taker è invalido o scade?

Se il Maker tenta di usare il codice {code} allo sportello bancomat e fallisce, la transazione non può proseguire. Il Taker potrebbe dover fornire un nuovo codice, oppure l'offerta può essere annullata.

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

Il Maker ha già bloccato il proprio Bitcoin in una hold invoice della rete Lightning prima di ricevere il codice {code}. Questo crea un forte incentivo a portare a termine lo scambio onestamente:

- **Se il Maker conferma la ricezione di un pagamento {code} valido:** il coordinatore settla la hold invoice e rilascia il Bitcoin al Taker. Il Maker riceve il suo fiat — tutti sono soddisfatti.
- **Se il Maker nega falsamente di aver ricevuto un pagamento {code} valido:** il Taker può aprire una controversia e fornire prove bancarie che dimostrano il pagamento. Se il coordinatore decide a favore del Taker, la hold invoice viene settlata comunque, e il Maker perde il proprio Bitcoin senza appello.
- **Se il Maker abbandona lo scambio o diventa irreperibile:** il coordinatore può settlare la fattura a favore del Taker (se esistono prove di pagamento) o, nei casi ambigui, mantenere i fondi bloccati fino alla risoluzione della controversia.

Le hold invoice hanno una finestra di validità limitata (di norma qualche ora), quindi il Maker non può temporeggiare indefinitamente. Deve concludere lo scambio onestamente o rischiare di perdere il proprio Bitcoin tramite la procedura di risoluzione delle controversie.

Con il Bitcoin trattenuto in una hold invoice della rete Lightning, il Maker (venditore) è incentivato ad agire onestamente. Senza prove contrarie, la fattura non verrà restituita al Maker.

#### Cosa spinge il Taker ad agire onestamente?

Il Taker entra nello scambio solo dopo che il Maker ha già bloccato Bitcoin in una hold invoice. Sebbene questo protegga il Taker da un Maker privo di fondi, anche il Taker ha forti incentivi ad agire onestamente:

- **Se il Taker fornisce un codice {code} valido e conferma il pagamento:** il Maker riceve il fiat, conferma la ricezione, e il coordinatore rilascia il Bitcoin al Taker. Tutti sono soddisfatti.
- **Se il Taker fornisce un codice {code} invalido o scaduto:** il Maker non può completare il pagamento allo sportello bancomat e non conferma la ricezione. Lo scambio fallisce, e il Bitcoin del Maker viene restituito tramite annullamento della hold invoice. Il Taker non riceve nulla.
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
Se il codice {code} che hai tentato di usare allo sportello bancomat Multibanco era invalido o scaduto, dovresti fornire prova del tentativo di pagamento fallito. Ad esempio:
- ricevuta del codice {code} invalido stampata dal bancomat.
- screenshot o stampa del tentativo di pagamento fallito al bancomat

#### Che tipo di prova potrebbe generalmente essermi richiesta come Taker dal coordinatore?

Se il Maker nega di aver ricevuto il tuo pagamento {code}, dovresti dimostrare che il pagamento {code} è stato effettivamente addebitato sul tuo conto bancario. Sarà tipicamente una ricevuta di pagamento della tua app bancaria con i dettagli della transazione {code}, inclusi importo e data/ora.

## Supporto

Per il supporto del coordinatore o problemi con offerte o controversie, contatta direttamente l'operatore del coordinatore tramite DM Nostr;
il suo profilo è accessibile tramite il link ai termini d'uso nell'app client {app}.
