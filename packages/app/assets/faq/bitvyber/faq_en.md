## {app} FAQ

### General Questions

#### What is {app}?

{app} is free and open source software for the peer-to-peer exchange of Bitcoin for **cardless ATM withdrawals** in {country} — across **Tatra banka, Slovenská sporiteľňa and VÚB**.\
The fundamental idea is to:
- withdraw cash at any Slovak bank ATM using a one-time "cardless withdrawal" code, paid for with Bitcoin
- buy Bitcoin by generating and selling those withdrawal codes

#### Why another P2P tool? Why not RoboSats, Bisq, or Hodl Hodl?

Those P2P escrow services are excellent for larger, longer-term trades. {app} is meant for a **quick cash withdrawal at an ATM** using the Bitcoin you hold. The whole exchange usually takes a couple of minutes.
- **Makers** sell Bitcoin (they withdraw the cash at the ATM).
- **Takers** buy Bitcoin (they generate the withdrawal code in their bank app).

#### Which banks are supported, and how do I choose one?

Slovakia is a single market (**{app}**) served by one coordinator, covering **Tatra banka, Slovenská sporiteľňa and VÚB**. The **maker chooses the bank when creating an offer** — they are the one who will stand at that bank's ATM, so the code only works at that bank's machines. Takers see each offer's bank as a badge and only take offers for a bank whose app they have.

#### How long is a code valid? Why does it differ per bank?

Each bank sets its own lifetime for a cardless-withdrawal code:
- **Tatra banka: 20 minutes**
- **Slovenská sporiteľňa: 15 minutes**
- **VÚB: 10–60 minutes**, set by the taker when generating the code

VÚB is the one bank where the taker picks the window — anywhere from 10 to 60 minutes — when generating the code. BitBlik cannot see which value they chose, so it counts down from the 10-minute floor. Ask for a longer window if the maker has further to walk. The app shows the remaining time as a countdown.

#### How does the escrow process work?

1.  **Offer creation (Maker):** A Maker creates an offer, choosing the fiat amount **and the bank**.
2.  **Funding escrow (Maker):** The Maker pays a Lightning "hold invoice" for the Bitcoin amount. This locks the Bitcoin with the coordinator without transferring it yet.
3.  **Offer acceptance (Taker):** A Taker takes the offer, generates a **cardless-withdrawal {code}** in their banking app (for that bank), and submits it to the coordinator.
4.  **Cash withdrawal (Maker):** The Maker receives the {code} and enters it at that **bank's ATM** to withdraw the cash, within the bank's validity window.
5.  **Charge (Taker):** The amount is debited from the Taker's bank account when the Maker withdraws.
6.  **Confirmation (Maker):** The Maker confirms in {app} that the withdrawal succeeded.
7.  **Bitcoin release (Coordinator):** On the Maker's confirmation, the coordinator settles the hold invoice, releasing the locked Bitcoin to the Taker's Lightning address or invoice.

#### How are takers made aware of new offers?

Takers can join messenger channels (SimpleX, Matrix, Telegram, Signal) to get notified of new offers. Channels can be **general (all banks)** or **per-bank** — join the bank channels you can serve. Whenever a Maker funds a new offer, the coordinator posts it to the matching channels with a link to accept it in the {app} app.

#### What is the {code}?

The {code} is a one-time **{codeLength}-digit cardless-withdrawal code** ("výber bez karty" / "výber mobilom") generated in a Slovak bank's app. It lets you withdraw cash from that bank's ATM without a card. In {app}, Takers generate it and Makers enter it at the ATM.

#### What are Lightning Network "hold invoices"?

Hold invoices are a special Lightning invoice. When the Maker (seller of Bitcoin) pays one, the funds are not settled immediately — they are "held" by the coordinator's Lightning node and only released when a secret "preimage" is revealed. If it is not revealed in time, or the invoice is cancelled, the funds return to the Maker. This is the core of {app}'s escrow mechanism.

---

### Security & Risks

#### How is my Bitcoin secured as a Maker (seller)?

Your Bitcoin is locked via a hold invoice. The coordinator only settles it (releases your Bitcoin to the Taker) **after** you confirm the cash withdrawal succeeded. If the withdrawal fails, the hold invoice is cancelled and the Bitcoin returns to your node.

#### How am I protected as a Taker (buyer)?

The Maker has already locked their Bitcoin in a hold invoice **before** you submit the withdrawal code. When the Maker confirms the withdrawal, the Bitcoin is released to you automatically. There is a risk if a Maker falsely denies withdrawing after your account was debited — see "Disputes".

#### What if the code is invalid or expires before the Maker withdraws?

If the Maker cannot withdraw with the code (invalid or expired), the trade cannot proceed with that code. The Maker marks it invalid, the offer is re-listed, and the Taker may submit a fresh code or cancel. Because the code expires fast, coordinate timing and choose a bank whose ATM the maker can reach quickly.

#### What are the risks of using this protocol?

- **Counterparty risk:** the other party not acting honestly. The hold invoice mitigates but does not eliminate this around the cash leg.
- **Coordinator trust:** you trust the {app} coordinator to manage preimages and settle/cancel correctly.
- **LN node issues:** the coordinator's (and possibly your) Lightning node must be online.
- **Bank issues:** problems with a bank's cardless-withdrawal system are outside {app}'s control and must be handled with your bank.
- **Software bugs:** as with any software; it is open source and auditable.
- **Privacy:** your public keys and transaction details are stored by the coordinator. **For better privacy, generate a new key pair for each transaction.**

#### Is the coordinator custodial?

During escrow, the Maker's funds are locked in a hold invoice the coordinator can settle or cancel — a temporary control element. The final payout to the Taker is non-custodial (paid to the Taker's invoice). Both parties trust the coordinator to follow the protocol.

#### What motivates the Maker to act honestly?

The Maker locks Bitcoin **before** receiving the code:
- Confirm a successful withdrawal → the coordinator releases Bitcoin to the Taker; the Maker keeps the cash.
- Falsely deny a successful withdrawal → the Taker disputes with bank evidence; if the coordinator rules for the Taker, the invoice settles anyway and the Maker loses their Bitcoin.
- Abandon / stall → the hold invoice has a limited window, so the Maker cannot stall indefinitely.

#### What motivates the Taker to act honestly?

- Provide a valid code and it works → everyone is satisfied.
- Provide an invalid/expired code → the Maker cannot withdraw, the trade fails, the Maker's Bitcoin is returned, the Taker gets nothing.
- Falsely claim a charge → without bank evidence the coordinator cancels the hold invoice and returns the Bitcoin to the Maker.

Since the Taker must show verifiable evidence in any dispute, there is no viable path to defraud a Maker.

> **Note:** A bond system for Takers is planned, adding a penalty for wasted coordinator time.

#### What motivates the coordinator to act honestly?

The coordinator publishes a Nostr key (profile) that users can tag to report experiences. Check a coordinator's reputation on Nostr (via a Web-of-Trust client) before using it, and prefer one trusted in your community. You are responsible for choosing a reputable coordinator; this is not a platform or service and we take no responsibility for coordinators' actions.

---

### Fees & Technicals

#### Are there fees?

Each coordinator sets its own maker and taker fees, shown in the app before an offer is created or taken.

#### Which ATM amounts can I withdraw?

Slovak ATMs dispense **10 / 20 / 50 / 100 €** notes, so an offer amount must be composable from these (e.g. 30, 70, 200 — yes; 15 — no). The maker's amount presets adapt to this. The cardless-withdrawal cap is typically around €500 per withdrawal.

#### What if the Lightning payout to the Taker fails?

If the coordinator cannot pay the Taker's Lightning invoice (node offline, no route), the Taker provides a new invoice or fixes their Lightning setup, then the payout is retried.

#### Can I cancel my offer after funding it but before a Taker accepts?

Yes — while the offer is still `funded` (not yet reserved), cancel it and the Bitcoin returns to your Lightning wallet.

#### Why aren't the mobile apps in Google Play or the Apple App Store?

Those are walled gardens with corporate gatekeepers who can delist privacy-enhancing or alternative-economic apps at will — a single point of failure and censorship chokepoint.

---

### Disputes

If maker and taker disagree on the outcome, the offer enters a `conflict` state and each party provides evidence for the coordinator to resolve manually.

> ⚠️ **Important:** Each coordinator may have different requirements/procedures for disputes — check its documentation or contact it directly.

#### What evidence might I provide as a Maker?

If the code was invalid or expired at the ATM: the ATM's rejection/receipt, or a screenshot/printout of the failed withdrawal attempt.

#### What evidence might I provide as a Taker?

If the Maker denies withdrawing after your account was debited: a bank statement / app receipt showing the cardless-withdrawal transaction, with amount and timestamp.

## Support

For coordinator support or disputes, contact the coordinator operator directly via Nostr DMs — their profile is reachable through their terms-of-use link in the {app} app.

#### How do private dispute messages and picture evidence work?

Each party gets a separate encrypted NIP-17 conversation with the coordinator; there is no maker/taker group room. Pictures are stripped of metadata, encrypted on your device, and uploaded only as ciphertext to a coordinator-selected Blossom server. Relay and Blossom operators can still observe IP address, timing, and ciphertext size. Chat never authorizes a payment. A Maker refund invoice must be submitted through the separate exact-amount invoice form. After a ruling, history is read-only and remote deletion is best-effort.
