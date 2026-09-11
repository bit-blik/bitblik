## FAQ {app}

### Questions générales

#### Qu'est-ce que {app} ?

{app} est un logiciel libre et open source pour l'échange pair-à-pair de Bitcoin contre des **retraits d'espèces sans carte** en {country} — auprès de **Tatra banka, Slovenská sporiteľňa et VÚB**.\
L'idée fondamentale :
- retirer des espèces à n'importe quel distributeur d'une banque slovaque avec un code de « retrait sans carte » à usage unique, payé en Bitcoin
- acheter du Bitcoin en générant et vendant ces codes de retrait

#### Pourquoi un autre outil P2P ? Pourquoi pas RoboSats, Bisq ou Hodl Hodl ?

Ces services d'escrow sont parfaits pour des trades plus importants et à plus long terme. {app} sert à un **retrait rapide d'espèces au distributeur** avec le Bitcoin que vous détenez. L'échange prend généralement quelques minutes.
- Les **makers** vendent du Bitcoin (ils retirent les espèces au distributeur).
- Les **takers** achètent du Bitcoin (ils génèrent le code dans leur appli bancaire).

#### Quelles banques sont prises en charge et comment en choisir une ?

La Slovaquie est un marché unique (**{app}**) exploité par un coordinateur, couvrant **Tatra banka, Slovenská sporiteľňa et VÚB**. Le **maker choisit la banque à la création de l'offre** — c'est lui qui se tiendra au distributeur de cette banque, donc le code ne fonctionne qu'aux distributeurs de celle-ci. Les takers voient la banque de chaque offre sous forme de badge et ne prennent que les offres d'une banque dont ils ont l'appli.

#### Combien de temps un code est-il valable ? Pourquoi cela varie-t-il selon la banque ?

Chaque banque définit la durée de vie d'un code de retrait sans carte :
- **Tatra banka : 20 minutes**
- **Slovenská sporiteľňa : 15 minutes**
- **VÚB : 10 à 60 minutes**, choisi par le taker au moment de générer le code

VÚB est la seule banque où le taker choisit la fenêtre — de 10 à 60 minutes — en générant le code. BitBlik ignore la valeur retenue et décompte donc depuis le plancher de 10 minutes. Demandez une fenêtre plus longue si le maker a plus de chemin à faire. L'appli affiche le temps restant en compte à rebours.

#### Comment fonctionne l'escrow ?

1.  **Création de l'offre (Maker) :** le maker crée une offre en choisissant le montant fiat **et la banque**.
2.  **Financement de l'escrow (Maker) :** le maker paie une « hold invoice » Lightning pour le montant en Bitcoin. Cela verrouille les Bitcoin chez le coordinateur sans les transférer.
3.  **Acceptation (Taker) :** le taker prend l'offre, génère un **{code} de retrait sans carte** dans son appli bancaire (pour cette banque) et le soumet.
4.  **Retrait d'espèces (Maker) :** le maker reçoit le {code} et le saisit au **distributeur de cette banque** pour retirer les espèces, dans la fenêtre de validité.
5.  **Débit (Taker) :** le montant est débité du compte du taker lorsque le maker retire.
6.  **Confirmation (Maker) :** le maker confirme dans {app} que le retrait a réussi.
7.  **Libération du Bitcoin (Coordinateur) :** après confirmation, le coordinateur règle la hold invoice et libère les Bitcoin vers l'adresse/facture Lightning du taker.

#### Comment les takers sont-ils informés des nouvelles offres ?

Les takers peuvent rejoindre des canaux (SimpleX, Matrix, Telegram, Signal) pour être notifiés. Les canaux peuvent être **généraux (toutes banques)** ou **par banque** — rejoignez les canaux des banques que vous pouvez servir. Dès qu'un maker finance une offre, le coordinateur la publie dans les canaux correspondants avec un lien pour l'accepter dans {app}.

#### Qu'est-ce que le {code} ?

Le {code} est un **code de retrait sans carte à {codeLength} chiffres** à usage unique (« výber bez karty »), généré dans l'appli d'une banque slovaque. Il permet de retirer des espèces au distributeur de cette banque sans carte. Dans {app}, le taker le génère et le maker le saisit au distributeur.

#### Que sont les « hold invoices » Lightning ?

Une hold invoice est une facture Lightning spéciale. Quand le maker (vendeur de Bitcoin) la paie, les fonds ne sont pas réglés immédiatement — ils sont « retenus » par le nœud Lightning du coordinateur et libérés seulement lorsqu'un « preimage » secret est révélé. S'il ne l'est pas à temps, ou si la facture est annulée, les fonds reviennent au maker. C'est le cœur du mécanisme d'escrow de {app}.

---

### Sécurité et risques

#### Comment mes Bitcoin sont-ils sécurisés en tant que Maker (vendeur) ?

Vos Bitcoin sont verrouillés via une hold invoice. Le coordinateur ne la règle (ne libère les Bitcoin au taker) qu'**après** votre confirmation du retrait réussi. Si le retrait échoue, la hold invoice est annulée et les Bitcoin reviennent à votre nœud.

#### Comment suis-je protégé en tant que Taker (acheteur) ?

Le maker a déjà verrouillé ses Bitcoin dans une hold invoice **avant** votre soumission du code. Quand le maker confirme le retrait, les Bitcoin vous sont libérés automatiquement. Un risque existe si un maker nie faussement avoir retiré après le débit de votre compte — voir « Litiges ».

#### Et si le code est invalide ou expire avant le retrait du maker ?

Si le maker ne peut pas retirer avec le code (invalide ou expiré), le trade ne peut pas continuer avec ce code. Le maker le marque invalide, l'offre est de nouveau publiée et le taker peut soumettre un nouveau code ou annuler. Comme le code expire vite, coordonnez le timing et choisissez une banque dont le maker atteint vite le distributeur.

#### Quels sont les risques du protocole ?

- **Risque de contrepartie :** l'autre partie n'agit pas honnêtement. La hold invoice l'atténue sans l'éliminer sur l'étape espèces.
- **Confiance dans le coordinateur :** vous lui faites confiance pour gérer les preimages et régler/annuler correctement.
- **Problèmes de nœud LN :** le nœud du coordinateur (et éventuellement le vôtre) doit être en ligne.
- **Problèmes bancaires :** les problèmes du système de retrait sans carte échappent à {app} et se règlent avec votre banque.
- **Bugs logiciels :** comme tout logiciel ; il est open source et auditable.
- **Vie privée :** vos clés publiques et détails de transaction sont stockés par le coordinateur. **Pour plus de confidentialité, générez une nouvelle paire de clés à chaque transaction.**

#### Le coordinateur est-il dépositaire (custodial) ?

Pendant l'escrow, les fonds du maker sont verrouillés dans une hold invoice que le coordinateur peut régler ou annuler — un contrôle temporaire. Le paiement final au taker est non-dépositaire (vers sa facture). Les deux parties font confiance au coordinateur pour suivre le protocole.

#### Qu'est-ce qui incite le Maker à l'honnêteté ?

Le maker verrouille les Bitcoin **avant** de recevoir le code :
- Confirmer un retrait réussi → le coordinateur libère les Bitcoin au taker ; le maker garde les espèces.
- Nier faussement un retrait réussi → le taker ouvre un litige avec preuve bancaire ; si le coordinateur tranche en faveur du taker, la facture est réglée quand même et le maker perd ses Bitcoin.
- Abandonner/temporiser → la hold invoice a une fenêtre limitée, le maker ne peut pas temporiser indéfiniment.

#### Qu'est-ce qui incite le Taker à l'honnêteté ?

- Fournir un code valide qui fonctionne → tout le monde est satisfait.
- Fournir un code invalide/expiré → le maker ne peut pas retirer, le trade échoue, les Bitcoin sont rendus, le taker n'a rien.
- Prétendre faussement au débit → sans preuve bancaire, le coordinateur annule la hold invoice et rend les Bitcoin au maker.

Comme le taker doit fournir des preuves vérifiables en litige, il n'existe aucun moyen viable d'escroquer un maker.

> **Note :** un système de caution (bond) pour les takers est prévu, pénalisant le temps gaspillé du coordinateur.

#### Qu'est-ce qui incite le coordinateur à l'honnêteté ?

Le coordinateur publie une clé Nostr (profil) que les utilisateurs peuvent taguer pour signaler leurs expériences. Vérifiez la réputation d'un coordinateur sur Nostr (avec un client Web-of-Trust) avant de l'utiliser, et préférez-en un de confiance dans votre communauté. Le choix d'un coordinateur réputé vous incombe ; ce n'est ni une plateforme ni un service, et nous déclinons toute responsabilité quant aux actions des coordinateurs.

---

### Frais et technique

#### Y a-t-il des frais ?

Chaque coordinateur fixe ses propres frais maker et taker, affichés dans l'appli avant de créer/prendre une offre.

#### Quels montants puis-je retirer au distributeur ?

Les distributeurs slovaques délivrent des billets de **10 / 20 / 50 / 100 €**, donc un montant d'offre doit être composable à partir de ceux-ci (ex. 30, 70, 200 — oui ; 15 — non). Les montants prédéfinis du maker s'y adaptent. Le plafond du retrait sans carte est généralement d'environ 500 € par retrait.

#### Et si le paiement Lightning au taker échoue ?

Si le coordinateur ne peut pas payer la facture Lightning du taker (nœud hors ligne, pas de route), le taker fournit une nouvelle facture ou corrige sa configuration Lightning, puis le paiement est réessayé.

#### Puis-je annuler mon offre après l'avoir financée mais avant qu'un taker l'accepte ?

Oui — tant que l'offre est encore `funded` (non réservée), annulez-la et les Bitcoin reviennent dans votre portefeuille Lightning.

#### Pourquoi les applis ne sont-elles pas sur Google Play ou l'App Store d'Apple ?

Ce sont des jardins clos avec des gardiens corporatifs qui peuvent retirer à leur gré les applis pro-vie privée ou d'économie alternative — un point unique de défaillance et de censure.

---

### Litiges

Si maker et taker sont en désaccord sur le résultat, l'offre passe en état `conflict` et chaque partie fournit des preuves que le coordinateur tranche manuellement.

> ⚠️ **Important :** chaque coordinateur peut avoir des exigences/procédures de litige différentes — consultez sa documentation ou contactez-le directement.

#### Quelles preuves fournir en tant que Maker ?

Si le code était invalide ou expiré au distributeur : le refus/ticket du distributeur, ou une capture/impression de la tentative de retrait échouée.

#### Quelles preuves fournir en tant que Taker ?

Si le maker nie avoir retiré après le débit de votre compte : un relevé/reçu de l'appli bancaire montrant la transaction de retrait sans carte, avec montant et horodatage.

## Support

Pour le support du coordinateur ou les litiges, contactez l'opérateur directement par DM Nostr — son profil est accessible via le lien des conditions d'utilisation dans {app}.
