## FAQ {app}

### Domande Generali

#### Cos'è {app}?

{app} è un software gratuito e open source progettato per facilitare lo scambio peer-to-peer di Bitcoin per codici {code}.\
L'idea fondamentale è:
- pagare con Bitcoin ovunque sia accettato il pagamento {code}
- acquistare Bitcoin generando e vendendo codici {code}

#### Perché un altro strumento P2P? Perché non usare quelli esistenti come RoboSats, Bisq o Hodlhodl?

Sebbene questi servizi di escrow P2P siano eccellenti e dovrebbero essere utilizzati per scambi più grandi e a lungo termine, {app} è destinato ad essere utilizzato come metodo di pagamento rapido utilizzando codici {code} in luoghi/situazioni in cui è appropriato, come negozi con self-checkout, ristoranti, acquisti online e persino sportelli bancomat.
L'intero processo di scambio non dovrebbe richiedere più di un paio di minuti, a seconda della rapidità con cui i taker notano la nuova offerta e sono in grado di fornire e confermare prontamente il codice {code}.
- I **Maker** sono utenti che cercano di vendere Bitcoin.
- I **Taker** sono utenti che cercano di acquistare Bitcoin.

#### Come funziona il processo di escrow?

Il processo segue generalmente questi passaggi:
1.  **Creazione Offerta (Maker):** Un Maker crea un'offerta, specificando l'importo in valuta fiat per cui desidera ricevere un codice {code}.
2.  **Finanziamento Escrow (Maker):** Il Maker paga una "fattura hold" Lightning Network per l'importo specificato in Bitcoin. Questo blocca il Bitcoin presso il coordinatore ma non lo trasferisce ancora.
3.  **Accettazione Offerta (Taker):** Un Taker trova un'offerta che gli piace e la accetta, quindi genera un codice {code} nella sua app bancaria e lo invia al coordinatore.
4.  **Pagamento Fiat (Maker):** Il Maker riceve il codice {code} e lo inserisce nel terminale di pagamento o nel sito di e-commerce online.
5.  **Conferma {code} (Taker):** Il Taker riceverà una notifica dalla sua app bancaria per confermare il pagamento {code}.
6.  **Conferma Pagamento (Maker):** Il Maker conferma all'interno del sistema {app} di aver ricevuto il pagamento {code}.
7.  **Rilascio Bitcoin (Coordinatore):** Dopo la conferma del Maker, il coordinatore utilizza la preimage segreta per "concludere" la fattura hold. Questa azione rilascia il Bitcoin bloccato all'indirizzo Lightning o alla fattura fornita dal Taker.

#### Come vengono informati i taker delle nuove offerte?

I taker possono registrarsi su diversi canali messenger (SimpleX, Matrix, Telegram, Signal) per ricevere notifiche sulle nuove offerte.
Ogni volta che un Maker paga la fattura hold per creare una nuova offerta, il coordinatore invierà un messaggio a tutti i canali di notifica con i dettagli dell'offerta e un link all'app {app} dove possono accettare l'offerta.

#### Cos'è {code}?

{code} è un sistema di pagamento mobile utilizzato in {country}. Permette agli utenti di effettuare pagamenti utilizzando un codice a 6 cifre generato dalla loro app bancaria. In {app}, i Taker utilizzano {code} per pagare i Maker in cambio di Bitcoin.

#### Cosa sono le "fatture hold" della Lightning Network?

Le fatture hold sono un tipo speciale di fattura Lightning. Quando una fattura hold viene pagata dal Maker (venditore di Bitcoin), i fondi non vengono immediatamente trasferiti. Invece, vengono "trattenuti" dal nodo Lightning del coordinatore. I fondi vengono realmente rilasciati al destinatario (Taker) solo quando viene rivelata una preimmagine segreta (preimage, in inglese). Se la preimage non viene rivelata entro un certo tempo, o se la fattura viene esplicitamente annullata, i fondi vengono restituiti al pagatore (Maker). Questo è il cuore del meccanismo di escrow di {app}.

---

### Sicurezza e Rischi

#### Come vengono protetti i miei fondi Bitcoin come Maker (venditore)?

Come Maker, i tuoi Bitcoin sono bloccati tramite una fattura hold. Il coordinatore ha la preimage necessaria per concludere questa fattura. Il sistema è progettato per concludere (rilasciare i tuoi bitcoin al Taker) solo *dopo* che confermi di aver ricevuto il pagamento fiat ({code}) dal Taker. Se il Taker non riesce a pagare, o se c'è un problema, la fattura hold viene annullata e i bitcoin ti vengono restituiti.

#### Come sono protetto come Taker (acquirente) se invio il pagamento {code}?

Come Taker, la tua protezione principale è che il Maker ha già bloccato i suoi bitcoin in una fattura hold presso il coordinatore *prima* che ti venga chiesto di inviare il pagamento {code}. Se il Maker conferma la ricezione del tuo codice {code}, il sistema è progettato per rilasciarti automaticamente i bitcoin. C'è un rischio se il Maker nega falsamente di aver ricevuto il tuo {code}. (Vedi "Dispute").

#### Cosa succede se il Maker non conferma il mio pagamento {code} anche se l'ho inviato?

Questo è uno scenario di conflitto. (Vedi "Dispute")

#### Cosa succede se il Taker fornisce un codice {code} ma non effettua realmente il pagamento?

Come Maker, non dovresti confermare la ricezione del pagamento finché i fondi fiat non sono effettivamente stati usati per concludere il pagamento. Se il Taker non riesce a pagare dopo aver fornito un codice {code}, non devi confermare, e l'offerta è destinata a scadere o essere annullata. La fattura hold che protegge il tuo Bitcoin verrebbe eventualmente annullata, restituendoti i fondi.

#### Cosa succede se il codice {code} fornito dal Taker non è valido o scade?

Se il Maker tenta di utilizzare il codice {code} e questo fallisce, la transazione non può procedere. Il Taker potrebbe dover fornire un nuovo codice, o l'offerta potrebbe essere annullata.

#### Quali sono i rischi dell'utilizzo di questo protocollo?

- **Rischio di Controparte:** Il rischio principale è che l'altra parte non agisca onestamente (es. il Taker non paga dopo che il Maker blocca BTC, o il Maker non conferma il pagamento dopo che il Taker paga). Il meccanismo della fattura hold mitiga questo rischio ma non lo elimina, specialmente per quanto riguarda la parte fiat dello scambio.
- **Fiducia nel Coordinatore:** Stai ponendo la tua fiducia nel software del coordinatore {app} e nei suoi operatori di:
  -   Gestire in modo sicuro le preimage delle fatture hold.
  -   Attivare correttamente le conclusioni o gli annullamenti in base al flusso del processo.
  -   Gestire il servizio in modo affidabile.
- **Problemi con i Nodi LN:** Sia il nodo Ligthning Network (LN) del coordinatore che potenzialmente i nodi LN degli utenti (se self-hosted e in interazione diretta) devono essere online e operativi. Problemi con i nodi LN possono ritardare o complicare le transazioni.
- **Problemi con il Sistema {code}:** I problemi con il sistema di pagamento {code} stesso sono al di fuori del controllo di {app}. La risoluzione di tali problemi deve essere gestita tramite la banca del Taker o il fornitore {code}.
- **Bug Software:** Come con qualsiasi software, c'è il rischio di bug nel client {app} o nel coordinatore che potrebbero portare a errori o perdita di fondi. Il software è open source, quindi gli utenti possono verificarlo, ma questo richiede competenze tecniche.
- **Privacy:** Le tue chiavi pubbliche sono memorizzate dal coordinatore. I dettagli delle transazioni sono anche memorizzati nel database. **Per una migliore privacy dovresti generare una nuova coppia di chiavi per ogni transazione.**

#### Il coordinatore è custodial?

Il coordinatore è non-custodial nel senso tradizionale per la conclusione *finale* del Bitcoin per il Taker, poiché paga la fattura del Taker. Tuttavia, durante il periodo di escrow, i fondi del Maker sono bloccati in una fattura hold che il coordinatore ha il potere di concludere (usando la preimage) o di annullare. Quindi, c'è un elemento di controllo temporaneo da parte del coordinatore sui fondi bloccati. Sia il Maker che il Taker si fidano del coordinatore per rilasciare questi fondi secondo il protocollo.

#### Cosa motiva il Maker ad agire onestamente?

Il Maker ha già bloccato i propri Bitcoin in una hold invoice della Lightning Network prima di ricevere il codice {code}. Questo crea un forte incentivo a completare lo scambio in modo onesto:

- **Se il Maker conferma la ricezione di un pagamento {code} valido:** Il coordinatore chiude (settle) la hold invoice, rilasciando i Bitcoin al Taker. Il Maker riceve il suo denaro fiat—tutti sono soddisfatti.
- **Se il Maker nega falsamente di aver ricevuto un pagamento {code} valido:** Il Taker può aprire una disputa e fornire prove bancarie che dimostrano l'avvenuto pagamento. Se il coordinatore decide a favore del Taker, la hold invoice viene comunque chiusa e il Maker perde i propri Bitcoin senza possibilità di appello.
- **Se il Maker abbandona lo scambio o non risponde:** Il coordinatore può chiudere la invoice a favore del Taker (se esistono prove del pagamento) oppure, in casi ambigui, mantenere i fondi bloccati fino alla risoluzione della disputa.

Le hold invoice hanno una finestra di validità limitata (in genere poche ore), il che significa che il Maker non può procrastinare indefinitamente. Deve portare a termine la transazione onestamente, altrimenti rischia di perdere i suoi Bitcoin attraverso il processo di risoluzione delle controversie.

Con i Bitcoin bloccati in una hold invoice della rete Lightning, il Maker (venditore) è incentivato ad agire onestamente. In assenza di prove a suo favore, la fattura non verrà rilasciata nuovamente al Maker.

#### Cosa motiva il Taker ad agire onestamente?

Il Taker entra nello scambio solo dopo che il Maker ha già bloccato i Bitcoin in una hold invoice. Sebbene questo protegga il Taker da un Maker che potrebbe non avere fondi, anche il Taker ha forti incentivi ad agire onestamente:

- **Se il Taker fornisce un codice {code} valido e conferma il pagamento:** Il Maker riceve il denaro fiat, conferma la ricezione e il coordinatore rilascia i Bitcoin al Taker. Tutti sono soddisfatti.
- **Se il Taker fornisce un codice {code} invalido o scaduto:** Il Maker non può completare il pagamento e non confermerà la ricezione. Lo scambio fallisce e i Bitcoin del Maker vengono restituiti tramite la cancellazione della hold invoice. Il Taker non riceve nulla.
- **Se il Taker afferma falsamente di aver pagato:** In caso di disputa, il Taker deve fornire prove bancarie che dimostrino che il pagamento {code} è stato addebitato sul proprio conto. Senza tali prove, il coordinatore cancellerà la hold invoice dopo 48 ore, restituendo i Bitcoin al Maker. Il Taker non ottiene nulla e fa perdere tempo a tutti.
- **Se il Taker abbandona lo scambio dopo aver riservato un'offerta:** L'offerta alla fine scade o viene cancellata e i Bitcoin del Maker vengono restituiti. Il Taker non ottiene nulla.

Poiché il Taker deve fornire prove verificabili in qualsiasi disputa, non esiste un percorso praticabile per ottenere Bitcoin in modo fraudolento. Un Taker disonesto riesce solo a far perdere tempo: il proprio, quello del Maker e quello del coordinatore.

> **Nota:** È prevista per il futuro l'implementazione di un sistema di bond per i Taker, che aggiungerà una penalità finanziaria per i Taker che fanno perdere tempo al coordinatore con dispute futili o scambi abbandonati.


#### Cosa motiva il coordinatore ad agire onestamente?

Il coordinatore deve fornire una chiave nostr (profilo) che gli utenti possono taggare e segnalare esperienze negative con un determinato coordinatore. Prima di scegliere di utilizzare un coordinatore specifico, controlla la sua reputazione su Nostr. Data la natura resistente alla censura di Nostr, chiunque può inondare o pubblicare segnalazioni non valide, quindi utilizza un client che utilizza il Web of Trust per determinare la reputazione delle segnalazioni di ciascun utente. Preferibilmente scegli un coordinatore che ha una buona reputazione tra la tua comunità Bitcoin o i tuoi amici di fiducia. In definitiva, tu come utente di questo software sei responsabile della scelta di un coordinatore con una buona reputazione. Questa non è una piattaforma o un servizio e non ci assumiamo alcuna responsabilità per le azioni di alcun coordinatore.

---

### Commissioni e Aspetti Tecnici

#### Ci sono commissioni per l'utilizzo di {app}?

Ogni coordinatore stabilisce le proprie commissioni, sia per i maker che per i taker. Queste vengono visualizzate nell'applicazione client, prima che un'offerta venga creata o accettata.

#### Cosa succede se un pagamento Lightning (pagamento al Taker) fallisce?

Se il coordinatore tenta di pagare la fattura Lightning del Taker e questa fallisce (es. nodo del Taker offline, nessuna route), la transazione potrebbe entrare in questo stato. Il Taker potrebbe dover fornire una nuova fattura o risolvere problemi con la sua configurazione Lightning.

#### Cosa succede se io, come Maker, voglio annullare la mia offerta dopo averla finanziata ma prima che un Taker l'accetti?

Puoi annullare la fattura hold, e il Bitcoin dovrebbe essere restituito al tuo wallet LN. Questo è tipicamente possibile se l'offerta è ancora in stato `funded` e non ancora `reserved` o oltre.

#### Perché le app mobili non sono distribuite su Google Play Store o Apple App Store?
Queste piattaforme non sono semplici mercati; sono giardini recintati governati da custodi aziendali che esercitano autorità assoluta su quale software gli utenti possono installare. Questo modello centralizzato crea un punto di criticità e un canale privilegiato per la censura. Le app che promuovono tecnologie che migliorano la privacy, discorsi politici controversi o modelli economici alternativi possono essere, e spesso sono, rimossi a sola discrezione dei proprietari della piattaforma, soffocando l'innovazione e il libero scambio di idee.

### Dispute

Se sia il maker che il taker non sono d'accordo sullo stato del pagamento o se ci sono problemi con la transazione, l'offerta entra in uno stato di `conflict`, in cui ogni partecipante deve fornire prove edlla propria buonafede affinché il coordinatore risolva manualmente la disputa.

> ⚠️ **Importante:** Ogni coordinatore può avere requisiti e/o procedure diverse per la risoluzione delle dispute, quindi controlla la documentazione del coordinatore o contattalo direttamente per essere sicuro.

#### Quale tipo di prova potrebbe essere generalmente richiesta a me come Maker dal coordinatore?
Se il codice {code} che hai provato a utilizzare al terminale di pagamento o al sito di e-commerce non era valido o era scaduto, dovresti fornire prova del tentativo di pagamento fallito. Questo potrebbe includere:
- ricevuta del codice {code} non valido stampata dal terminale di pagamento o dal bancomat.
- screenshot del tentativo di pagamento fallito nel sito di e-commerce

#### Quale tipo di prova potrebbe essermi richiesta come Taker dal coordinatore?

Se il Maker nega di aver ricevuto il tuo pagamento {code}, dovresti fornire prova che il pagamento {code} è stato effettivamente detratto dal tuo conto bancario. Questo sarà tipicamente una ricevuta di pagamento dalla tua app bancaria che mostra i dettagli della transazione {code}, inclusi importo e timestamp.

## Supporto

Per supporto del coordinatore o problemi con offerte o dispute, contatta direttamente l'operatore del coordinatore tramite DM Nostr, 
il suo profilo è accessibile tramite il link dei termini di utilizzo nell'app client {app}.
