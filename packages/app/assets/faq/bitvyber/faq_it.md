## FAQ {app}

### Domande generali

#### Cos'è {app}?

{app} è software libero e open source per lo scambio peer-to-peer di Bitcoin con **prelievi di contante senza carta** in {country} — presso **Tatra banka, Slovenská sporiteľňa e VÚB**.\
L'idea di fondo:
- prelevare contante a qualsiasi ATM di una banca slovacca con un codice di "prelievo senza carta" monouso, pagato in Bitcoin
- comprare Bitcoin generando e vendendo tali codici di prelievo

#### Perché un altro strumento P2P? Perché non RoboSats, Bisq o Hodl Hodl?

Quei servizi di escrow sono ottimi per scambi più grandi e a lungo termine. {app} serve per un **prelievo rapido di contante all'ATM** con i Bitcoin che possiedi. L'intero scambio richiede di solito un paio di minuti.
- I **maker** vendono Bitcoin (prelevano il contante all'ATM).
- I **taker** comprano Bitcoin (generano il codice nella loro app bancaria).

#### Quali banche sono supportate e come ne scelgo una?

La Slovacchia è un unico mercato (**{app}**) gestito da un coordinatore, che copre **Tatra banka, Slovenská sporiteľňa e VÚB**. Il **maker sceglie la banca quando crea l'offerta** — è lui che si troverà all'ATM di quella banca, quindi il codice funziona solo agli sportelli di essa. I taker vedono la banca di ogni offerta come un badge e prendono solo offerte di una banca di cui hanno l'app.

#### Quanto è valido un codice? Perché varia per banca?

Ogni banca imposta la durata di un codice di prelievo senza carta:
- **Tatra banka: 20 minuti**
- **Slovenská sporiteľňa: 15 minuti**
- **VÚB: 3 minuti**

La finestra di VÚB è molto breve; per un'offerta VÚB il taker dovrebbe essere già a (o molto vicino a) un ATM VÚB prima di prenotare. L'app mostra il tempo residuo con un conto alla rovescia.

#### Come funziona l'escrow?

1.  **Creazione offerta (Maker):** il maker crea un'offerta scegliendo l'importo fiat **e la banca**.
2.  **Finanziamento escrow (Maker):** il maker paga una "hold invoice" Lightning per l'importo in Bitcoin. Questo blocca i Bitcoin presso il coordinatore senza trasferirli.
3.  **Accettazione (Taker):** il taker prende l'offerta, genera un **{code} di prelievo senza carta** nella sua app bancaria (per quella banca) e lo invia.
4.  **Prelievo contante (Maker):** il maker riceve il {code} e lo inserisce all'**ATM di quella banca** per prelevare il contante, entro la finestra di validità.
5.  **Addebito (Taker):** l'importo viene addebitato sul conto del taker quando il maker preleva.
6.  **Conferma (Maker):** il maker conferma in {app} che il prelievo è riuscito.
7.  **Rilascio Bitcoin (Coordinatore):** dopo la conferma, il coordinatore salda la hold invoice e rilascia i Bitcoin all'indirizzo/fattura Lightning del taker.

#### Come vengono avvisati i taker delle nuove offerte?

I taker possono unirsi a canali (SimpleX, Matrix, Telegram, Signal) per ricevere notifiche. I canali possono essere **generali (tutte le banche)** o **per banca** — unisciti ai canali delle banche che puoi servire. Quando un maker finanzia un'offerta, il coordinatore la pubblica nei canali corrispondenti con un link per accettarla in {app}.

#### Cos'è il {code}?

Il {code} è un **codice di prelievo senza carta a {codeLength} cifre** monouso ("výber bez karty"), generato nell'app di una banca slovacca. Permette di prelevare contante all'ATM di quella banca senza carta. In {app} lo genera il taker e il maker lo inserisce all'ATM.

#### Cosa sono le "hold invoice" Lightning?

Una hold invoice è una fattura Lightning speciale. Quando il maker (venditore di Bitcoin) la paga, i fondi non vengono regolati subito — vengono "trattenuti" dal nodo Lightning del coordinatore e rilasciati solo quando viene rivelato un "preimage" segreto. Se non avviene in tempo, o la fattura viene annullata, i fondi tornano al maker. È il cuore del meccanismo di escrow di {app}.

---

### Sicurezza e rischi

#### Come sono protetti i miei Bitcoin come Maker (venditore)?

I tuoi Bitcoin sono bloccati tramite una hold invoice. Il coordinatore la salda (rilascia i Bitcoin al taker) **solo dopo** la tua conferma del prelievo riuscito. Se il prelievo fallisce, la hold invoice viene annullata e i Bitcoin tornano al tuo nodo.

#### Come sono protetto come Taker (acquirente)?

Il maker ha già bloccato i suoi Bitcoin in una hold invoice **prima** del tuo invio del codice. Quando il maker conferma il prelievo, i Bitcoin ti vengono rilasciati automaticamente. C'è un rischio se un maker nega falsamente di aver prelevato dopo l'addebito sul tuo conto — vedi "Controversie".

#### E se il codice è invalido o scade prima che il maker prelevi?

Se il maker non riesce a prelevare con il codice (invalido o scaduto — molto probabile con la finestra di 3 minuti di VÚB), lo scambio non può proseguire con quel codice. Il maker lo segna invalido, l'offerta viene ripubblicata e il taker può inviare un nuovo codice o annullare. Poiché il codice scade in fretta, coordinate i tempi e scegliete una banca il cui ATM il maker raggiunge in fretta.

#### Quali sono i rischi del protocollo?

- **Rischio di controparte:** l'altra parte non agisce onestamente. La hold invoice lo mitiga ma non lo elimina nella fase del contante.
- **Fiducia nel coordinatore:** ti fidi che gestisca i preimage e saldi/annulli correttamente.
- **Problemi del nodo LN:** il nodo del coordinatore (ed eventualmente il tuo) deve essere online.
- **Problemi bancari:** i problemi del sistema di prelievo senza carta sono fuori dal controllo di {app} e vanno gestiti con la tua banca.
- **Bug software:** come per ogni software; è open source e verificabile.
- **Privacy:** le chiavi pubbliche e i dettagli delle transazioni sono memorizzati dal coordinatore. **Per maggiore privacy, genera una nuova coppia di chiavi per ogni transazione.**

#### Il coordinatore è custodial?

Durante l'escrow i fondi del maker sono bloccati in una hold invoice che il coordinatore può saldare o annullare — un controllo temporaneo. Il pagamento finale al taker è non-custodial (alla sua fattura). Entrambe le parti si fidano che il coordinatore segua il protocollo.

#### Cosa motiva il Maker a essere onesto?

Il maker blocca i Bitcoin **prima** di ricevere il codice:
- Confermare un prelievo riuscito → il coordinatore rilascia i Bitcoin al taker; il maker tiene il contante.
- Negare falsamente un prelievo riuscito → il taker apre una controversia con prova bancaria; se il coordinatore decide a favore del taker, la fattura viene saldata comunque e il maker perde i Bitcoin.
- Abbandonare/temporeggiare → la hold invoice ha una finestra limitata, il maker non può temporeggiare all'infinito.

#### Cosa motiva il Taker a essere onesto?

- Fornire un codice valido che funziona → tutti soddisfatti.
- Fornire un codice invalido/scaduto → il maker non può prelevare, lo scambio fallisce, i Bitcoin tornano indietro, il taker non ottiene nulla.
- Sostenere falsamente l'addebito → senza prova bancaria il coordinatore annulla la hold invoice e restituisce i Bitcoin al maker.

Poiché il taker deve fornire prove verificabili in una controversia, non c'è modo praticabile di frodare un maker.

> **Nota:** è previsto un sistema di cauzione (bond) per i taker, che penalizza il tempo sprecato del coordinatore.

#### Cosa motiva il coordinatore a essere onesto?

Il coordinatore pubblica una chiave Nostr (profilo) che gli utenti possono taggare per segnalare esperienze. Verifica la reputazione di un coordinatore su Nostr (con un client Web-of-Trust) prima di usarlo, e preferiscine uno fidato nella tua comunità. La scelta di un coordinatore affidabile spetta a te; questa non è una piattaforma né un servizio, e non ci assumiamo responsabilità per le azioni dei coordinatori.

---

### Commissioni e aspetti tecnici

#### Ci sono commissioni?

Ogni coordinatore imposta le proprie commissioni maker e taker, mostrate nell'app prima di creare/prendere un'offerta.

#### Quali importi posso prelevare all'ATM?

Gli ATM slovacchi erogano banconote da **10 / 20 / 50 / 100 €**, quindi l'importo dell'offerta dev'essere componibile con esse (es. 30, 70, 200 — sì; 15 — no). Gli importi predefiniti del maker si adattano. Il limite del prelievo senza carta è di solito circa 500 € per prelievo.

#### E se il pagamento Lightning al taker fallisce?

Se il coordinatore non riesce a pagare la fattura Lightning del taker (nodo offline, nessuna rotta), il taker fornisce una nuova fattura o corregge la sua configurazione Lightning, poi il pagamento viene ritentato.

#### Posso annullare la mia offerta dopo averla finanziata ma prima che un taker l'accetti?

Sì — finché l'offerta è ancora `funded` (non prenotata), annullala e i Bitcoin tornano nel tuo wallet Lightning.

#### Perché le app non sono su Google Play o Apple App Store?

Sono giardini recintati con guardiani aziendali che possono rimuovere a piacimento le app pro-privacy o di economia alternativa — un singolo punto di guasto e di censura.

---

### Controversie

Se maker e taker non concordano sull'esito, l'offerta entra nello stato `conflict` e ciascuna parte fornisce prove che il coordinatore valuta manualmente.

> ⚠️ **Importante:** ogni coordinatore può avere requisiti/procedure diverse per le controversie — consulta la sua documentazione o contattalo direttamente.

#### Quali prove fornisco come Maker?

Se il codice all'ATM era invalido o scaduto: il rifiuto/scontrino dell'ATM, o uno screenshot/stampa del tentativo di prelievo fallito.

#### Quali prove fornisco come Taker?

Se il maker nega il prelievo dopo l'addebito sul tuo conto: un estratto conto/ricevuta dell'app bancaria con la transazione di prelievo senza carta, importo e orario.

## Supporto

Per il supporto del coordinatore o le controversie, contatta l'operatore direttamente via DM Nostr — il suo profilo è raggiungibile dal link dei termini d'uso in {app}.
