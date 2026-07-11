## {app} FAQ

### Allgemeine Fragen

#### Was ist {app}?

{app} ist freie und quelloffene Software, die den Peer-to-Peer-Tausch von Bitcoin gegen {code}-Codes ermöglicht — mit Fokus auf das Bezahlen an **Geldautomaten (Multibanco)** in {country}.\
Die Grundidee ist:
- Bitcoin an jedem Multibanco-Geldautomaten auszugeben, der {code}-Zahlung akzeptiert
- Bitcoin zu kaufen, indem man {code}-Codes generiert und verkauft

#### Warum noch ein P2P-Tool? Warum nicht einfach bestehende wie RoboSats, Bisq oder Hodl Hodl nutzen?

Diese P2P-Treuhanddienste sind ausgezeichnet und sollten für grössere und längerfristige Trades genutzt werden. {app} hingegen ist als schnelle Zahlungsmethode mit {code}-Codes an **Geldautomaten (Multibanco)** gedacht, wo Sie mit dem gehaltenen Bitcoin Bargeld abheben oder Rechnungen bezahlen können.
Der gesamte Tauschvorgang sollte nicht länger als ein paar Minuten dauern, abhängig davon, wie schnell die Taker das neue Angebot bemerken und den {code}-Code zügig bereitstellen und bestätigen können.
- **Maker** sind Nutzer, die Bitcoin verkaufen wollen.
- **Taker** sind Nutzer, die Bitcoin kaufen wollen.

#### Wie funktioniert der Treuhandprozess?

Der Ablauf besteht im Wesentlichen aus diesen Schritten:
1.  **Angebotserstellung (Maker):** Ein Maker erstellt ein Angebot und gibt den Fiat-Betrag an, für den er einen {code}-Code erhalten möchte.
2.  **Treuhand-Finanzierung (Maker):** Der Maker bezahlt eine Lightning-Network-„Hold Invoice" über den angegebenen Bitcoin-Betrag. Damit wird das Bitcoin beim Koordinator gesperrt, aber noch nicht übertragen.
3.  **Angebotsannahme (Taker):** Ein Taker findet ein passendes Angebot und nimmt es an, generiert dann in seiner Banking-App einen {code}-Code und übermittelt ihn an den Koordinator.
4.  **Fiat-Zahlung (Maker):** Der Maker erhält den {code}-Code und gibt ihn am **Multibanco-Geldautomaten** ein, um die Zahlung oder Bargeldabhebung abzuschliessen.
5.  **{code}-Bestätigung (Taker):** Der Taker erhält von seiner Bank-App eine Benachrichtigung, um die {code}-Zahlung zu bestätigen.
6.  **Zahlungsbestätigung (Maker):** Der Maker bestätigt im {app}-System, dass er die {code}-Zahlung erhalten hat.
7.  **Bitcoin-Freigabe (Koordinator):** Nach der Bestätigung des Makers nutzt der Koordinator das geheime Preimage, um die Hold Invoice zu „settlen". Dadurch wird das gesperrte Bitcoin an die vom Taker angegebene Lightning-Adresse oder -Rechnung freigegeben.

#### Wie erfahren Taker von neuen Angeboten?

Taker können sich auf mehreren Messenger-Kanälen (SimpleX, Matrix, Telegram, Signal) registrieren, um Benachrichtigungen über neue Angebote zu erhalten.
Sobald ein Maker die Hold Invoice bezahlt, um ein neues Angebot zu erstellen, sendet der Koordinator eine Nachricht an alle Benachrichtigungskanäle mit den Angebotsdetails und einem Link zur {app}-App, über den das Angebot angenommen werden kann.

#### Was ist {code}?

{code} ist ein mobiles Zahlungssystem, das in {country} verwendet wird. Es ermöglicht Zahlungen mit einem {codeLength}-stelligen Code, der von der Banking-App generiert wird und direkt an einem Multibanco-Geldautomaten eingegeben werden kann. In {app} nutzen Taker {code}, um Maker für Bitcoin zu bezahlen.

#### Was sind Lightning-Network-„Hold Invoices"?

Hold Invoices sind eine besondere Art von Lightning-Rechnung. Wenn eine Hold Invoice vom Maker (Bitcoin-Verkäufer) bezahlt wird, werden die Mittel nicht sofort abgerechnet. Stattdessen werden sie vom Lightning-Node des Koordinators „gehalten". Die Mittel werden erst dann wirklich freigegeben (abgerechnet) an den Empfänger (Taker), wenn ein geheimes „Preimage" offengelegt wird. Wird das Preimage nicht innerhalb einer bestimmten Zeit offengelegt oder die Rechnung ausdrücklich storniert, gehen die Mittel an den Zahler (Maker) zurück. Das ist der Kern des Treuhandmechanismus von {app}.

---

### Sicherheit & Risiken

#### Wie sind meine Bitcoin-Mittel als Maker (Verkäufer) gesichert?

Als Maker ist Ihr Bitcoin über eine Hold Invoice gesperrt. Der Koordinator hat das Preimage, das zum Settlen dieser Rechnung nötig ist. Das System ist so konzipiert, dass es erst dann abrechnet (Ihr Bitcoin an den Taker freigibt), *nachdem* Sie bestätigt haben, dass Sie die Fiat-Zahlung ({code}) vom Taker erhalten haben. Zahlt der Taker nicht oder gibt es ein Problem, wird die Hold Invoice storniert und das Bitcoin geht in die Kontrolle Ihres LN-Nodes zurück.

#### Wie bin ich als Taker (Käufer) geschützt, wenn ich eine {code}-Zahlung sende?

Als Taker besteht Ihr Hauptschutz darin, dass der Maker sein Bitcoin bereits in einer Hold Invoice beim Koordinator gesperrt hat, *bevor* Sie zur {code}-Zahlung aufgefordert werden. Bestätigt der Maker den Erhalt Ihrer {code}, ist das System so ausgelegt, dass das Bitcoin automatisch an Sie freigegeben wird. Ein Risiko besteht, wenn der Maker fälschlich abstreitet, Ihre {code} erhalten zu haben. (Siehe „Streitfälle").

#### Was passiert, wenn der Maker meine {code}-Zahlung nicht bestätigt, obwohl ich sie gesendet habe?

Das ist ein Konfliktfall. (Siehe „Streitfälle")

#### Was passiert, wenn der Taker einen {code}-Code bereitstellt, aber die Zahlung nicht tatsächlich leistet?

Als Maker sollten Sie den Zahlungseingang nicht bestätigen, bevor die Fiat-Mittel tatsächlich auf Ihrem Konto sind. Zahlt der Taker nach Bereitstellung eines {code}-Codes nicht, würden Sie nicht bestätigen, und das Angebot läuft wahrscheinlich ab oder kann storniert werden. Die Hold Invoice, die Ihr Bitcoin sichert, wird schliesslich storniert und die Mittel an Sie zurückgegeben.

#### Was, wenn der vom Taker bereitgestellte {code}-Code ungültig ist oder abläuft?

Wenn der Maker versucht, den {code}-Code am Geldautomaten zu verwenden, und dies fehlschlägt, kann die Transaktion nicht fortgesetzt werden. Der Taker muss möglicherweise einen neuen Code bereitstellen oder das Angebot wird storniert.

#### Welche Risiken birgt die Nutzung dieses Protokolls?

- **Kontrahentenrisiko:** Das Hauptrisiko besteht darin, dass die andere Partei nicht ehrlich handelt (z. B. Taker zahlt nicht, nachdem der Maker BTC gesperrt hat, oder Maker bestätigt die Zahlung nicht, nachdem der Taker bezahlt hat). Der Hold-Invoice-Mechanismus mindert dies, beseitigt es aber nicht, besonders rund um den Fiat-Zahlungsteil.
- **Vertrauen in den Koordinator:** Sie vertrauen der {app}-Koordinator-Software und ihren Betreibern, dass sie:
  -   Hold-Invoice-Preimages sicher verwalten.
  -   Settlements oder Stornierungen korrekt gemäss dem Prozessablauf auslösen.
  -   Den Dienst zuverlässig betreiben.
- **LN-Node-Probleme:** Sowohl der LN-Node des Koordinators als auch möglicherweise die Nodes der Nutzer (bei Selbst-Hosting und direkter Interaktion) müssen online und funktionsfähig sein. Probleme mit LN-Nodes können Transaktionen verzögern oder erschweren.
- **{code}-Systemprobleme:** Probleme mit dem {code}-Zahlungssystem selbst liegen ausserhalb der Kontrolle von {app}. Solche Probleme müssen über die Bank des Takers oder den {code}-Anbieter gelöst werden.
- **Software-Fehler:** Wie bei jeder Software besteht das Risiko von Bugs im {app}-Client oder Koordinator, die zu Fehlern oder Geldverlust führen könnten. Die Software ist quelloffen, sodass Nutzer sie prüfen können, was jedoch technisches Fachwissen erfordert.
- **Privatsphäre:** Ihre öffentlichen Schlüssel werden vom Koordinator gespeichert. Auch Transaktionsdetails werden in der Datenbank gespeichert. **Für mehr Privatsphäre sollten Sie für jede Transaktion ein neues Schlüsselpaar generieren.**

#### Ist der Koordinator verwahrend (custodial)?

Der Koordinator ist im herkömmlichen Sinn nicht verwahrend für die *endgültige* Bitcoin-Abrechnung an den Taker, da er an dessen Rechnung auszahlt. Während der Treuhandphase sind die Mittel des Makers jedoch in einer Hold Invoice gesperrt, die der Koordinator settlen (mit dem Preimage) oder stornieren lassen kann. Es gibt also ein zeitweiliges Kontrollelement des Koordinators über die gesperrten Mittel. Sowohl Maker als auch Taker vertrauen darauf, dass der Koordinator diese Mittel gemäss dem Protokoll freigibt.

#### Was motiviert den Maker, ehrlich zu handeln?

Der Maker hat sein Bitcoin bereits in einer Lightning-Network-Hold-Invoice gesperrt, bevor er den {code}-Code erhält. Das schafft einen starken Anreiz, den Trade ehrlich abzuschliessen:

- **Bestätigt der Maker den Erhalt einer gültigen {code}-Zahlung:** Der Koordinator settelt die Hold Invoice und gibt das Bitcoin an den Taker frei. Der Maker erhält sein Fiat — alle sind zufrieden.
- **Streitet der Maker den Erhalt einer gültigen {code}-Zahlung fälschlich ab:** Der Taker kann einen Streitfall eröffnen und Bankbelege vorlegen, die die Zahlung beweisen. Entscheidet der Koordinator zugunsten des Takers, wird die Hold Invoice trotzdem gesettelt, und der Maker verliert sein Bitcoin ohne Rückgriff.
- **Bricht der Maker den Trade ab oder wird unerreichbar:** Der Koordinator kann die Rechnung zugunsten des Takers settlen (wenn Zahlungsbelege vorliegen) oder in unklaren Fällen die Mittel gesperrt lassen, bis der Streit gelöst ist.

Hold Invoices haben ein begrenztes Gültigkeitsfenster (typischerweise ein paar Stunden), sodass der Maker nicht unbegrenzt hinauszögern kann. Er muss den Trade entweder ehrlich abschliessen oder riskiert, sein Bitcoin über die Streitbeilegung zu verlieren.

Da das Bitcoin in einer Lightning-Network-Hold-Invoice gehalten wird, hat der Maker (Verkäufer) einen Anreiz, ehrlich zu handeln. Ohne gegenteilige Belege wird die Rechnung nicht an den Maker zurück freigegeben.

#### Was motiviert den Taker, ehrlich zu handeln?

Der Taker steigt erst in den Trade ein, nachdem der Maker bereits Bitcoin in einer Hold Invoice gesperrt hat. Das schützt den Taker zwar vor einem Maker, der keine Mittel hat, doch auch der Taker hat starke Anreize, ehrlich zu handeln:

- **Stellt der Taker einen gültigen {code}-Code bereit und bestätigt die Zahlung:** Der Maker erhält das Fiat, bestätigt den Eingang, und der Koordinator gibt das Bitcoin an den Taker frei. Alle sind zufrieden.
- **Stellt der Taker einen ungültigen oder abgelaufenen {code}-Code bereit:** Der Maker kann die Zahlung am Geldautomaten nicht abschliessen und bestätigt den Eingang nicht. Der Trade scheitert, und das Bitcoin des Makers wird über eine Storno der Hold Invoice zurückgegeben. Der Taker erhält nichts.
- **Behauptet der Taker fälschlich, bezahlt zu haben:** In einem Streitfall muss der Taker Bankbelege vorlegen, die beweisen, dass die {code}-Zahlung von seinem Konto abgebucht wurde. Ohne solche Belege storniert der Koordinator die Hold Invoice nach 48 Stunden und gibt das Bitcoin an den Maker zurück. Der Taker gewinnt nichts und verschwendet die Zeit aller.
- **Bricht der Taker den Trade nach Reservierung eines Angebots ab:** Das Angebot läuft schliesslich ab oder wird storniert, und das Bitcoin des Makers wird zurückgegeben. Der Taker gewinnt nichts.

Da der Taker in jedem Streitfall überprüfbare Belege vorlegen muss, gibt es keinen gangbaren Weg, betrügerisch an Bitcoin zu gelangen. Ein unehrlicher Taker schafft es nur, Zeit zu verschwenden — seine eigene, die des Makers und die des Koordinators.

> **Hinweis:** Ein Bond-System für Taker ist für die Zukunft geplant, das eine finanzielle Strafe für Taker vorsieht, die die Zeit des Koordinators mit mutwilligen Streitfällen oder abgebrochenen Trades verschwenden.

#### Was motiviert den Koordinator, ehrlich zu handeln?

Der Koordinator muss einen Nostr-Schlüssel (Profil) angeben, den Nutzer taggen können, um schlechte Erfahrungen mit einem Koordinator zu melden. Prüfen Sie vor der Wahl eines bestimmten Koordinators dessen Reputation auf Nostr. Aufgrund der zensurresistenten Natur von Nostr kann jeder Falschmeldungen fluten oder posten; nutzen Sie daher einen Client, der ein Web of Trust verwendet, um die Reputation der Meldungen jedes Nutzers zu bestimmen. Wählen Sie bevorzugt einen Koordinator mit gutem Ruf in Ihrer Bitcoin-Community oder unter Ihren vertrauenswürdigen Freunden. Letztlich sind Sie als Nutzer dieser Software dafür verantwortlich, einen Koordinator mit gutem Ruf zu wählen. Dies ist keine Plattform und kein Dienst, und wir übernehmen keine Verantwortung für die Handlungen eines Koordinators.

---

### Gebühren & Technisches

#### Fallen bei der Nutzung von {app} Gebühren an?

Jeder Koordinator legt seine Gebühren fest, sowohl für Maker als auch für Taker. Diese werden in der Client-Anwendung angezeigt, bevor ein Angebot erstellt oder angenommen wird.

#### Was passiert, wenn eine Lightning-Zahlung (Auszahlung an den Taker) fehlschlägt?

Wenn der Koordinator versucht, die Lightning-Rechnung des Takers zu bezahlen, und dies fehlschlägt (z. B. Node des Takers offline, keine Route), kann die Transaktion in diesen Zustand geraten. Der Taker muss möglicherweise eine neue Rechnung bereitstellen oder Probleme mit seinem Lightning-Setup lösen.

#### Was, wenn ich als Maker mein Angebot nach der Finanzierung, aber vor Annahme durch einen Taker stornieren möchte?

Sie können die Hold Invoice stornieren, und das Bitcoin sollte in Ihre LN-Wallet zurückkehren. Das ist in der Regel möglich, solange das Angebot noch im Zustand `funded` ist und noch nicht `reserved` oder weiter fortgeschritten.

#### Warum werden die mobilen Apps nicht über den Google Play Store oder Apple App Store verteilt?
Diese Plattformen sind nicht bloss Marktplätze; sie sind ummauerte Gärten unter der Kontrolle von Konzern-Torwächtern, die absolute Autorität darüber ausüben, welche Software Nutzer installieren dürfen. Dieses zentralisierte Modell schafft einen Single Point of Failure und einen Engpass für Zensur. Apps, die datenschutzfördernde Technologien, kontroverse politische Äusserungen oder alternative Wirtschaftsmodelle fördern, können nach alleinigem Ermessen der Plattformbetreiber entfernt werden — und werden es oft — was Innovation und den freien Ideenaustausch erstickt.

### Streitfälle

Wenn Maker und Taker sich über den Zahlungsstatus uneinig sind oder es Probleme mit der Transaktion gibt, gerät das Angebot in einen `conflict`-Zustand, in dem jede Partei Belege vorlegen muss, damit der Koordinator den Streit manuell auflöst.

> ⚠️ **Wichtig:** Jeder Koordinator kann unterschiedliche Anforderungen und/oder Verfahren zur Streitbeilegung haben; prüfen Sie daher die Dokumentation des Koordinators oder kontaktieren Sie ihn direkt, um sicherzugehen.

#### Welche Belege könnten allgemein von mir als Maker durch den Koordinator verlangt werden?
Wenn der {code}-Code, den Sie am Multibanco-Geldautomaten verwenden wollten, ungültig oder abgelaufen war, sollten Sie Belege für den fehlgeschlagenen Zahlungsversuch vorlegen. Das könnte sein:
- Beleg über den ungültigen {code}-Code, ausgedruckt vom Geldautomaten.
- Screenshot oder Ausdruck des fehlgeschlagenen Zahlungsversuchs am Geldautomaten

#### Welche Belege könnten allgemein von mir als Taker durch den Koordinator verlangt werden?

Wenn der Maker abstreitet, Ihre {code}-Zahlung erhalten zu haben, sollten Sie belegen, dass die {code}-Zahlung erfolgreich von Ihrem Bankkonto abgebucht wurde. Das ist typischerweise ein Zahlungsbeleg Ihrer Banking-App mit den {code}-Transaktionsdetails, einschliesslich Betrag & Zeitstempel.

## Support

Für Support des Koordinators oder Probleme mit Angeboten oder Streitfällen kontaktieren Sie den Koordinator-Betreiber direkt per Nostr-DM;
sein Profil ist über den Link zu den Nutzungsbedingungen in der {app}-Client-App erreichbar.
