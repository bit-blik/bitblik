## {app} FAQ

### Allgemeine Fragen

#### Was ist {app}?

{app} ist freie Open-Source-Software für den Peer-to-Peer-Tausch von Bitcoin gegen **kartenlose Bargeldabhebungen** in {country} — bei **Tatra banka, Slovenská sporiteľňa und VÚB**.\
Die Grundidee:
- Bargeld an jedem slowakischen Bankautomaten mit einem einmaligen „kartenlosen Abhebungscode" abheben, bezahlt mit Bitcoin
- Bitcoin kaufen, indem man solche Abhebungscodes erzeugt und verkauft

#### Warum noch ein P2P-Tool? Warum nicht RoboSats, Bisq oder Hodl Hodl?

Diese Escrow-Dienste sind ideal für größere, längerfristige Trades. {app} ist für die **schnelle Bargeldabhebung am Automaten** mit deinen Bitcoin gedacht. Der ganze Tausch dauert meist ein paar Minuten.
- **Maker** verkaufen Bitcoin (sie heben das Bargeld ab).
- **Taker** kaufen Bitcoin (sie erzeugen den Code in ihrer Banking-App).

#### Welche Banken werden unterstützt und wie wähle ich eine?

Die Slowakei ist ein einziger Markt (**{app}**), betrieben von einem Koordinator, und umfasst **Tatra banka, Slovenská sporiteľňa und VÚB**. Der **Maker wählt die Bank beim Erstellen des Angebots** — er steht am Automaten dieser Bank, daher funktioniert der Code nur an deren Automaten. Taker sehen die Bank jedes Angebots als Abzeichen und nehmen nur Angebote für eine Bank an, deren App sie haben.

#### Wie lange ist ein Code gültig? Warum je Bank unterschiedlich?

Jede Bank legt die Lebensdauer eines kartenlosen Abhebungscodes selbst fest:
- **Tatra banka: 20 Minuten**
- **Slovenská sporiteľňa: 15 Minuten**
- **VÚB: 10–60 Minuten**, vom Taker beim Erzeugen des Codes gewählt

VÚB ist die einzige Bank, bei der der Taker das Fenster wählt — 10 bis 60 Minuten — wenn er den Code erzeugt. BitBlik erfährt den gewählten Wert nicht und zählt daher ab der Untergrenze von 10 Minuten herunter. Bittet um ein längeres Fenster, wenn der Maker weiter laufen muss. Die App zeigt die verbleibende Zeit als Countdown.

#### Wie funktioniert der Escrow-Ablauf?

1.  **Angebotserstellung (Maker):** Der Maker erstellt ein Angebot und wählt den Fiat-Betrag **und die Bank**.
2.  **Escrow finanzieren (Maker):** Der Maker zahlt eine Lightning-„Hold-Invoice" über den Bitcoin-Betrag. Das sperrt die Bitcoin beim Koordinator, ohne sie zu übertragen.
3.  **Angebotsannahme (Taker):** Der Taker nimmt an, erzeugt einen **kartenlosen Abhebungs-{code}** in seiner Banking-App (für diese Bank) und übermittelt ihn.
4.  **Bargeldabhebung (Maker):** Der Maker erhält den {code} und gibt ihn am **Automaten dieser Bank** ein, um das Bargeld innerhalb des Zeitfensters abzuheben.
5.  **Belastung (Taker):** Der Betrag wird dem Konto des Takers belastet, wenn der Maker abhebt.
6.  **Bestätigung (Maker):** Der Maker bestätigt in {app}, dass die Abhebung erfolgreich war.
7.  **Bitcoin-Freigabe (Koordinator):** Nach der Bestätigung settlet der Koordinator die Hold-Invoice und gibt die Bitcoin an die Lightning-Adresse/-Invoice des Takers frei.

#### Wie erfahren Taker von neuen Angeboten?

Taker können Messenger-Kanälen (SimpleX, Matrix, Telegram, Signal) beitreten, um benachrichtigt zu werden. Kanäle können **allgemein (alle Banken)** oder **pro Bank** sein — tritt den Bank-Kanälen bei, die du bedienen kannst. Sobald ein Maker ein Angebot finanziert, postet der Koordinator es in die passenden Kanäle mit einem Link zur Annahme in {app}.

#### Was ist der {code}?

Der {code} ist ein einmaliger **{codeLength}-stelliger kartenloser Abhebungscode** („výber bez karty"), erzeugt in der App einer slowakischen Bank. Damit hebst du ohne Karte Bargeld am Automaten dieser Bank ab. In {app} erzeugt ihn der Taker und der Maker gibt ihn am Automaten ein.

#### Was sind Lightning-„Hold-Invoices"?

Eine Hold-Invoice ist eine besondere Lightning-Rechnung. Zahlt der Maker (Bitcoin-Verkäufer) sie, werden die Mittel nicht sofort verrechnet — sie werden vom Lightning-Node des Koordinators „gehalten" und erst freigegeben, wenn ein geheimes „Preimage" offengelegt wird. Geschieht das nicht rechtzeitig oder wird die Invoice storniert, gehen die Mittel an den Maker zurück. Das ist der Kern des Escrow-Mechanismus von {app}.

---

### Sicherheit & Risiken

#### Wie ist mein Bitcoin als Maker (Verkäufer) gesichert?

Dein Bitcoin ist über eine Hold-Invoice gesperrt. Der Koordinator settlet sie (gibt Bitcoin an den Taker frei) **erst**, nachdem du die erfolgreiche Abhebung bestätigt hast. Scheitert die Abhebung, wird die Hold-Invoice storniert und der Bitcoin geht an deinen Node zurück.

#### Wie bin ich als Taker (Käufer) geschützt?

Der Maker hat seine Bitcoin bereits **vor** deiner Code-Übermittlung in einer Hold-Invoice gesperrt. Bestätigt der Maker die Abhebung, wird der Bitcoin automatisch an dich freigegeben. Ein Risiko besteht, wenn ein Maker die Abhebung fälschlich bestreitet, nachdem dein Konto belastet wurde — siehe „Streitfälle".

#### Was, wenn der Code ungültig ist oder abläuft, bevor der Maker abhebt?

Kann der Maker mit dem Code nicht abheben (ungültig oder abgelaufen), kann der Trade mit diesem Code nicht fortgesetzt werden. Der Maker markiert ihn als ungültig, das Angebot wird neu gelistet und der Taker kann einen neuen Code senden oder abbrechen. Da der Code schnell abläuft: Timing abstimmen und eine Bank wählen, deren Automat der Maker rasch erreicht.

#### Welche Risiken hat das Protokoll?

- **Gegenparteirisiko:** die andere Partei handelt unehrlich. Die Hold-Invoice mindert dies, beseitigt es aber nicht bei der Bargeld-Etappe.
- **Vertrauen in den Koordinator:** du vertraust dem Koordinator, Preimages zu verwalten und korrekt zu settlen/stornieren.
- **LN-Node-Probleme:** der Node des Koordinators (und ggf. deiner) muss online sein.
- **Bank-Probleme:** Probleme mit dem kartenlosen Abhebungssystem liegen außerhalb von {app} und sind mit deiner Bank zu klären.
- **Software-Bugs:** wie bei jeder Software; sie ist Open Source und prüfbar.
- **Privatsphäre:** öffentliche Schlüssel und Transaktionsdetails speichert der Koordinator. **Für mehr Privatsphäre erzeuge für jede Transaktion ein neues Schlüsselpaar.**

#### Ist der Koordinator verwahrend (custodial)?

Während des Escrow sind die Mittel des Makers in einer Hold-Invoice gesperrt, die der Koordinator settlen oder stornieren kann — eine temporäre Kontrolle. Die finale Auszahlung an den Taker ist nicht-verwahrend (an dessen Invoice). Beide Parteien vertrauen dem Koordinator, das Protokoll einzuhalten.

#### Was motiviert den Maker zu Ehrlichkeit?

Der Maker sperrt Bitcoin **vor** Erhalt des Codes:
- Erfolgreiche Abhebung bestätigen → der Koordinator gibt Bitcoin an den Taker frei; der Maker behält das Bargeld.
- Erfolgreiche Abhebung fälschlich bestreiten → der Taker eröffnet einen Streitfall mit Bankbeleg; entscheidet der Koordinator für den Taker, wird die Invoice trotzdem gesettlet und der Maker verliert Bitcoin.
- Abbrechen/verzögern → die Hold-Invoice hat ein begrenztes Fenster, der Maker kann nicht endlos verzögern.

#### Was motiviert den Taker zu Ehrlichkeit?

- Gültigen Code liefern, der funktioniert → beide zufrieden.
- Ungültigen/abgelaufenen Code liefern → der Maker kann nicht abheben, der Trade scheitert, der Bitcoin geht zurück, der Taker bekommt nichts.
- Belastung fälschlich behaupten → ohne Bankbeleg storniert der Koordinator die Hold-Invoice und gibt Bitcoin an den Maker zurück.

Da der Taker im Streitfall überprüfbare Belege vorlegen muss, gibt es keinen gangbaren Weg, einen Maker zu betrügen.

> **Hinweis:** Ein Bond-System für Taker ist geplant, das verschwendete Koordinatorzeit bestraft.

#### Was motiviert den Koordinator zu Ehrlichkeit?

Der Koordinator veröffentlicht einen Nostr-Schlüssel (Profil), den Nutzer taggen können, um Erfahrungen zu melden. Prüfe die Reputation eines Koordinators auf Nostr (mit einem Web-of-Trust-Client), bevor du ihn nutzt, und bevorzuge einen, dem deine Community vertraut. Für die Wahl eines seriösen Koordinators bist du verantwortlich; dies ist keine Plattform oder Dienstleistung, und wir übernehmen keine Verantwortung für das Handeln von Koordinatoren.

---

### Gebühren & Technik

#### Fallen Gebühren an?

Jeder Koordinator legt eigene Maker- und Taker-Gebühren fest, angezeigt in der App vor dem Erstellen/Annehmen eines Angebots.

#### Welche Automatenbeträge kann ich abheben?

Slowakische Automaten geben **10 / 20 / 50 / 100 €**-Scheine aus, ein Angebotsbetrag muss daraus zusammensetzbar sein (z. B. 30, 70, 200 — ja; 15 — nein). Die Betragsvorschläge des Makers passen sich daran an. Das Limit der kartenlosen Abhebung liegt meist bei etwa 500 € pro Abhebung.

#### Was, wenn die Lightning-Auszahlung an den Taker scheitert?

Kann der Koordinator die Lightning-Invoice des Takers nicht zahlen (Node offline, keine Route), liefert der Taker eine neue Invoice oder korrigiert sein Lightning-Setup, dann wird die Auszahlung erneut versucht.

#### Kann ich mein Angebot nach der Finanzierung, aber vor der Annahme, stornieren?

Ja — solange das Angebot noch `funded` (nicht reserviert) ist, storniere es und der Bitcoin geht in deine Lightning-Wallet zurück.

#### Warum sind die Apps nicht im Google Play oder Apple App Store?

Das sind ummauerte Gärten mit Konzern-Gatekeepern, die datenschutzfördernde oder alternativ-ökonomische Apps jederzeit entfernen können — ein einzelner Ausfall- und Zensurpunkt.

---

### Streitfälle

Sind sich Maker und Taker über das Ergebnis uneinig, geht das Angebot in den Zustand `conflict`, und jede Partei legt Belege vor, die der Koordinator manuell prüft.

> ⚠️ **Wichtig:** Jeder Koordinator kann andere Anforderungen/Abläufe für Streitfälle haben — prüfe seine Doku oder kontaktiere ihn direkt.

#### Welche Belege liefere ich als Maker?

War der Code am Automaten ungültig oder abgelaufen: die Ablehnung/Beleg des Automaten oder ein Screenshot/Ausdruck des fehlgeschlagenen Abhebungsversuchs.

#### Welche Belege liefere ich als Taker?

Bestreitet der Maker die Abhebung, nachdem dein Konto belastet wurde: ein Kontoauszug/App-Beleg mit der kartenlosen Abhebungstransaktion, Betrag und Zeitstempel.

## Support

Für Koordinator-Support oder Streitfälle kontaktiere den Betreiber direkt per Nostr-DM — sein Profil ist über den Nutzungsbedingungen-Link in {app} erreichbar.
