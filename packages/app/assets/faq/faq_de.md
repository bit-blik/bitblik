## {app} FAQ

### Allgemeine Fragen

#### Was ist {app}?

{app} ist freie und quelloffene Software, die den Peer-to-Peer-Tausch von Bitcoin gegen {code}-Codes ermöglicht.\
Die Grundidee ist:
- mit Bitcoin überall dort zu bezahlen, wo {code}-Zahlungen akzeptiert werden
- Bitcoin zu kaufen, indem man {code}-Codes generiert und verkauft

#### Warum noch ein P2P-Tool? Warum nicht einfach bestehende wie RoboSats, Bisq oder Hodl Hodl nutzen?

Diese P2P-Escrow-Dienste sind ausgezeichnet und sollten für größere und längerfristige Trades genutzt werden. {app} hingegen ist als schnelle Zahlungsmethode mit {code}-Codes gedacht — für Orte und Situationen, in denen das passt, etwa Selbstbedienungskassen, Restaurants, Online-Shopping und sogar Geldautomaten.
Der gesamte Tauschvorgang sollte nicht länger als ein paar Minuten dauern, abhängig davon, wie schnell Taker das neue Angebot bemerken und den {code}-Code zügig bereitstellen und bestätigen können.
- **Maker** sind Nutzer, die Bitcoin verkaufen möchten.
- **Taker** sind Nutzer, die Bitcoin kaufen möchten.

#### Wie funktioniert der Escrow-Prozess?

Der Prozess folgt im Allgemeinen diesen Schritten:
1.  **Angebotserstellung (Maker):** Ein Maker erstellt ein Angebot und gibt den Fiat-Betrag an, für den er einen {code}-Code erhalten möchte.
2.  **Escrow-Finanzierung (Maker):** Der Maker bezahlt eine Lightning-Network-"Hold-Invoice" über den angegebenen Bitcoin-Betrag. Dadurch werden die Bitcoin beim Koordinator gesperrt, aber noch nicht übertragen.
3.  **Angebotsannahme (Taker):** Ein Taker findet ein passendes Angebot und nimmt es an, generiert dann in seiner Banking-App einen {code}-Code und übermittelt ihn an den Koordinator.
4.  **Fiat-Zahlung (Maker):** Der Maker erhält den {code}-Code und gibt ihn am Zahlungsterminal oder auf der E-Commerce-Website ein.
5.  **{code}-Bestätigung (Taker):** Der Taker erhält eine Benachrichtigung seiner Bank-App, um die {code}-Zahlung zu bestätigen.
6.  **Zahlungsbestätigung (Maker):** Der Maker bestätigt im {app}-System, dass er die {code}-Zahlung erhalten hat.
7.  **Bitcoin-Freigabe (Koordinator):** Nach der Bestätigung des Makers verwendet der Koordinator das geheime Preimage, um die Hold-Invoice abzuwickeln ("settle"). Damit werden die gesperrten Bitcoin an die vom Taker angegebene Lightning-Adresse oder Invoice freigegeben.

#### Wie erfahren Taker von neuen Angeboten?

Taker können sich auf mehreren Messenger-Kanälen (SimpleX, Matrix, Telegram, Signal) registrieren, um Benachrichtigungen über neue Angebote zu erhalten.
Immer wenn ein Maker die Hold-Invoice bezahlt und damit ein neues Angebot erstellt, sendet der Koordinator eine Nachricht mit den Angebotsdetails und einem Link zur {app}-App an alle Benachrichtigungskanäle, wo Taker das Angebot annehmen können.

#### Was ist {code}?

{code} ist ein mobiles Zahlungssystem, das in {country} verwendet wird. Es ermöglicht Zahlungen über einen {codeLength}-stelligen Code, der von der Banking-App generiert wird. In {app} verwenden Taker {code}, um Maker für Bitcoin zu bezahlen.

#### Was sind Lightning-Network-"Hold-Invoices"?

Hold-Invoices sind eine spezielle Art von Lightning-Invoice. Wenn eine Hold-Invoice vom Maker (Bitcoin-Verkäufer) bezahlt wird, werden die Gelder nicht sofort abgewickelt. Stattdessen werden sie vom Lightning-Node des Koordinators "gehalten". Die Gelder werden erst dann tatsächlich an den Empfänger (Taker) freigegeben (abgewickelt), wenn ein geheimes "Preimage" offengelegt wird. Wird das Preimage nicht innerhalb einer bestimmten Zeit offengelegt oder wird die Invoice ausdrücklich storniert, gehen die Gelder an den Zahler (Maker) zurück. Das ist der Kern des Escrow-Mechanismus von {app}.

---

### Sicherheit & Risiken

#### Wie sind meine Bitcoin als Maker (Verkäufer) gesichert?

Als Maker sind deine Bitcoin über eine Hold-Invoice gesperrt. Der Koordinator besitzt das Preimage, das zur Abwicklung dieser Invoice nötig ist. Das System ist so konzipiert, dass es erst dann abwickelt (deine Bitcoin an den Taker freigibt), *nachdem* du bestätigt hast, dass du die Fiat-Zahlung ({code}) vom Taker erhalten hast. Zahlt der Taker nicht oder gibt es ein Problem, wird die Hold-Invoice storniert und die Bitcoin kehren unter die Kontrolle deines LN-Nodes zurück.

#### Wie bin ich als Taker (Käufer) geschützt, wenn ich eine {code}-Zahlung sende?

Als Taker besteht dein wichtigster Schutz darin, dass der Maker seine Bitcoin bereits in einer Hold-Invoice beim Koordinator gesperrt hat, *bevor* du aufgefordert wirst, die {code}-Zahlung zu senden. Bestätigt der Maker den Erhalt deiner {code}-Zahlung, gibt das System die Bitcoin automatisch an dich frei. Ein Risiko besteht, wenn der Maker den Erhalt deiner {code}-Zahlung fälschlicherweise bestreitet. (Siehe "Streitfälle").

#### Was passiert, wenn der Maker meine {code}-Zahlung nicht bestätigt, obwohl ich sie gesendet habe?

Das ist ein Konfliktszenario. (Siehe "Streitfälle")

#### Was passiert, wenn der Taker einen {code}-Code bereitstellt, aber die Zahlung nicht tatsächlich durchführt?

Als Maker solltest du den Zahlungseingang erst bestätigen, wenn die Fiat-Gelder tatsächlich auf deinem Konto sind. Zahlt der Taker nach Bereitstellung eines {code}-Codes nicht, bestätigst du nicht, und das Angebot läuft voraussichtlich ab oder kann storniert werden. Die Hold-Invoice, die deine Bitcoin sichert, wird schließlich storniert und die Gelder kehren zu dir zurück.

#### Was ist, wenn der vom Taker bereitgestellte {code}-Code ungültig ist oder abläuft?

Wenn der Maker versucht, den {code}-Code zu verwenden, und dies fehlschlägt, kann die Transaktion nicht fortgesetzt werden. Der Taker muss möglicherweise einen neuen Code bereitstellen, oder das Angebot wird storniert.

#### Welche Risiken birgt die Nutzung dieses Protokolls?

- **Gegenparteirisiko:** Das Hauptrisiko ist, dass die andere Partei nicht ehrlich handelt (z. B. zahlt der Taker nicht, nachdem der Maker BTC gesperrt hat, oder der Maker bestätigt die Zahlung nicht, nachdem der Taker gezahlt hat). Der Hold-Invoice-Mechanismus mindert dieses Risiko, beseitigt es aber nicht — insbesondere beim Fiat-Zahlungsteil.
- **Vertrauen in den Koordinator:** Du vertraust der {app}-Koordinator-Software und ihren Betreibern, dass sie:
  -   Hold-Invoice-Preimages sicher verwalten.
  -   Abwicklungen oder Stornierungen korrekt gemäß dem Prozessablauf auslösen.
  -   Den Dienst zuverlässig betreiben.
- **LN-Node-Probleme:** Sowohl der LN-Node des Koordinators als auch gegebenenfalls die LN-Nodes der Nutzer (bei Selbst-Hosting und direkter Interaktion) müssen online und funktionsfähig sein. Probleme mit LN-Nodes können Transaktionen verzögern oder verkomplizieren.
- **Probleme im {code}-System:** Probleme mit dem {code}-Zahlungssystem selbst liegen außerhalb der Kontrolle von {app}. Solche Probleme müssen über die Bank des Takers oder den {code}-Anbieter gelöst werden.
- **Software-Fehler:** Wie bei jeder Software besteht das Risiko von Fehlern im {app}-Client oder -Koordinator, die zu Fehlern oder Geldverlust führen könnten. Die Software ist quelloffen, sodass Nutzer sie prüfen können — das erfordert jedoch technisches Fachwissen.
- **Privatsphäre:** Deine öffentlichen Schlüssel werden vom Koordinator gespeichert. Transaktionsdetails werden ebenfalls in der Datenbank gespeichert. **Für bessere Privatsphäre solltest du für jede Transaktion ein neues Schlüsselpaar generieren.**

#### Ist der Koordinator verwahrend (custodial)?

Der Koordinator ist im klassischen Sinne nicht verwahrend, was die *endgültige* Bitcoin-Abwicklung für den Taker betrifft, da er an die Invoice des Takers auszahlt. Während der Escrow-Phase sind die Gelder des Makers jedoch in einer Hold-Invoice gesperrt, die der Koordinator abwickeln (mittels Preimage) oder stornieren lassen kann. Es besteht also ein temporäres Kontrollelement des Koordinators über die gesperrten Gelder. Sowohl Maker als auch Taker vertrauen darauf, dass der Koordinator diese Gelder gemäß dem Protokoll freigibt.

#### Was motiviert den Maker, ehrlich zu handeln?

Der Maker hat seine Bitcoin bereits in einer Lightning-Network-Hold-Invoice gesperrt, bevor er den {code}-Code erhält. Das schafft einen starken Anreiz, den Trade ehrlich abzuschließen:

- **Bestätigt der Maker den Erhalt einer gültigen {code}-Zahlung:** Der Koordinator wickelt die Hold-Invoice ab und gibt die Bitcoin an den Taker frei. Der Maker erhält sein Fiat — alle sind zufrieden.
- **Bestreitet der Maker fälschlicherweise den Erhalt einer gültigen {code}-Zahlung:** Der Taker kann einen Streitfall eröffnen und Bankbelege vorlegen, die die Zahlung nachweisen. Entscheidet der Koordinator zugunsten des Takers, wird die Hold-Invoice trotzdem abgewickelt, und der Maker verliert seine Bitcoin ohne Rückgriffsmöglichkeit.
- **Bricht der Maker den Trade ab oder reagiert nicht mehr:** Der Koordinator kann die Invoice zugunsten des Takers abwickeln (falls Zahlungsnachweise vorliegen) oder in unklaren Fällen die Gelder gesperrt lassen, bis der Streitfall gelöst ist.

Hold-Invoices haben ein begrenztes Gültigkeitsfenster (typischerweise einige Stunden), sodass der Maker nicht endlos verzögern kann. Er muss den Trade entweder ehrlich abschließen oder riskiert, seine Bitcoin im Streitbeilegungsverfahren zu verlieren.

Da die Bitcoin in einer Lightning-Network-Hold-Invoice gehalten werden, hat der Maker (Verkäufer) einen Anreiz, ehrlich zu handeln. Ohne gegenteilige Beweise wird die Invoice nicht an den Maker zurückgegeben.

#### Was motiviert den Taker, ehrlich zu handeln?

Der Taker steigt erst in den Trade ein, nachdem der Maker bereits Bitcoin in einer Hold-Invoice gesperrt hat. Das schützt den Taker vor einem Maker ohne Deckung — aber auch der Taker hat starke Anreize, ehrlich zu handeln:

- **Stellt der Taker einen gültigen {code}-Code bereit und bestätigt die Zahlung:** Der Maker erhält das Fiat, bestätigt den Erhalt, und der Koordinator gibt die Bitcoin an den Taker frei. Alle sind zufrieden.
- **Stellt der Taker einen ungültigen oder abgelaufenen {code}-Code bereit:** Der Maker kann die Zahlung nicht abschließen und wird den Erhalt nicht bestätigen. Der Trade scheitert, und die Bitcoin des Makers kehren durch Stornierung der Hold-Invoice zurück. Der Taker erhält nichts.
- **Behauptet der Taker fälschlicherweise, gezahlt zu haben:** In einem Streitfall muss der Taker Bankbelege vorlegen, die nachweisen, dass die {code}-Zahlung von seinem Konto abgebucht wurde. Ohne solche Belege storniert der Koordinator die Hold-Invoice nach 48 Stunden und gibt die Bitcoin an den Maker zurück. Der Taker gewinnt nichts und verschwendet nur die Zeit aller Beteiligten.
- **Bricht der Taker den Trade nach der Reservierung eines Angebots ab:** Das Angebot läuft schließlich ab oder wird storniert, und die Bitcoin des Makers kehren zurück. Der Taker gewinnt nichts.

Da der Taker in jedem Streitfall überprüfbare Belege vorlegen muss, gibt es keinen gangbaren Weg, betrügerisch an Bitcoin zu gelangen. Ein unehrlicher Taker verschwendet nur Zeit — seine eigene, die des Makers und die des Koordinators.

> **Hinweis:** Ein Kautionssystem (Bond) für Taker ist für eine zukünftige Version geplant. Es führt eine finanzielle Strafe für Taker ein, die die Zeit des Koordinators mit unbegründeten Streitfällen oder abgebrochenen Trades verschwenden.

#### Was motiviert den Koordinator, ehrlich zu handeln?

Der Koordinator muss einen Nostr-Schlüssel (Profil) bereitstellen, den Nutzer markieren können, um schlechte Erfahrungen mit einem bestimmten Koordinator zu melden. Prüfe vor der Wahl eines Koordinators dessen Reputation auf Nostr. Aufgrund der zensurresistenten Natur von Nostr kann jeder ungültige Meldungen fluten oder posten — nutze daher einen Client, der Web of Trust verwendet, um die Reputation der Meldungen einzelner Nutzer zu bewerten. Wähle vorzugsweise einen Koordinator mit gutem Ruf in deiner Bitcoin-Community oder unter deinen vertrauenswürdigen Freunden. Letztlich bist du als Nutzer dieser Software dafür verantwortlich, einen Koordinator mit gutem Ruf zu wählen. Dies ist keine Plattform und kein Dienst, und wir übernehmen keine Verantwortung für die Handlungen eines Koordinators.

---

### Gebühren & Technisches

#### Gibt es Gebühren für die Nutzung von {app}?

Jeder Koordinator legt seine Gebühren fest, sowohl für Maker als auch für Taker. Diese werden in der Client-Anwendung angezeigt, bevor ein Angebot erstellt oder angenommen wird.

#### Was passiert, wenn eine Lightning-Zahlung (Auszahlung an den Taker) fehlschlägt?

Wenn der Koordinator versucht, die Lightning-Invoice des Takers zu bezahlen, und dies fehlschlägt (z. B. Taker-Node offline, keine Route), kann die Transaktion in diesen Zustand geraten. Der Taker muss möglicherweise eine neue Invoice bereitstellen oder Probleme mit seinem Lightning-Setup beheben.

#### Was ist, wenn ich als Maker mein Angebot nach der Finanzierung, aber vor der Annahme durch einen Taker stornieren möchte?

Du kannst die Hold-Invoice stornieren, und die Bitcoin sollten in deine LN-Wallet zurückkehren. Das ist typischerweise möglich, solange das Angebot noch im Zustand `funded` ist und nicht bereits `reserved` oder weiter fortgeschritten.

#### Warum werden die mobilen Apps nicht über den Google Play Store oder Apple App Store vertrieben?
Diese Plattformen sind nicht bloß Marktplätze; sie sind abgeschottete Gärten, regiert von Konzern-Torwächtern, die absolute Kontrolle darüber ausüben, welche Software Nutzer installieren dürfen. Dieses zentralisierte Modell schafft einen Single Point of Failure und einen Engpass für Zensur. Apps, die datenschutzfördernde Technologien, kontroverse politische Meinungsäußerungen oder alternative Wirtschaftsmodelle fördern, können nach alleinigem Ermessen der Plattformbetreiber entfernt werden — und werden es oft —, was Innovation und den freien Austausch von Ideen erstickt.

### Streitfälle

Wenn Maker und Taker sich über den Zahlungsstatus uneinig sind oder es Probleme mit der Transaktion gibt, geht das Angebot in den Zustand `conflict` über. Dann muss jede Partei Belege vorlegen, damit der Koordinator den Streitfall manuell lösen kann.

> ⚠️ **Wichtig:** Jeder Koordinator kann unterschiedliche Anforderungen und/oder Verfahren für die Streitbeilegung haben. Prüfe daher die Dokumentation des Koordinators oder kontaktiere ihn direkt, um sicherzugehen.

#### Welche Belege kann der Koordinator im Allgemeinen von mir als Maker verlangen?
Wenn der {code}-Code, den du am Zahlungsterminal oder auf der E-Commerce-Website verwenden wolltest, ungültig oder abgelaufen war, solltest du Belege für den fehlgeschlagenen Zahlungsversuch vorlegen. Dazu können gehören:
- Beleg über den ungültigen {code}-Code, ausgedruckt vom Zahlungsterminal oder Geldautomaten.
- Screenshot des fehlgeschlagenen Zahlungsversuchs auf der E-Commerce-Website

#### Welche Belege kann der Koordinator im Allgemeinen von mir als Taker verlangen?

Wenn der Maker den Erhalt deiner {code}-Zahlung bestreitet, solltest du Belege dafür vorlegen, dass die {code}-Zahlung erfolgreich von deinem Bankkonto abgebucht wurde. Das ist typischerweise ein Zahlungsbeleg aus deiner Banking-App mit den Details der {code}-Transaktion, einschließlich Betrag und Zeitstempel.

## Support

Für Koordinator-Support oder bei Problemen mit Angeboten oder Streitfällen kontaktiere den Betreiber des Koordinators direkt über Nostr-DMs.
Sein Profil ist über den Link zu den Nutzungsbedingungen in der {app}-Client-App erreichbar.
