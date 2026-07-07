## FAQ {app}

### Questions générales

#### Qu'est-ce que {app} ?

{app} est un logiciel libre et open source conçu pour faciliter l'échange pair à pair de Bitcoin contre des codes {code} — axé sur le paiement aux **distributeurs automatiques (Multibanco)** au {country}.\
L'idée fondamentale est de :
- dépenser du Bitcoin à tout distributeur Multibanco qui accepte le paiement {code}
- acheter du Bitcoin en générant et en vendant des codes {code}

#### Pourquoi encore un outil P2P ? Pourquoi ne pas utiliser les outils existants comme RoboSats, Bisq ou Hodl Hodl ?

Ces services d'entiercement P2P sont excellents et devraient être utilisés pour des échanges plus importants et à plus long terme. {app}, en revanche, est destiné à servir de méthode de paiement rapide au moyen de codes {code} aux **distributeurs automatiques (Multibanco)**, où vous pouvez retirer des espèces ou payer des factures avec le Bitcoin que vous détenez.
L'ensemble du processus d'échange ne devrait pas prendre plus de quelques minutes, selon la rapidité avec laquelle les takers repèrent la nouvelle offre et parviennent à fournir et confirmer le code {code} sans tarder.
- **Makers** : utilisateurs qui souhaitent vendre du Bitcoin.
- **Takers** : utilisateurs qui souhaitent acheter du Bitcoin.

#### Comment fonctionne le processus d'entiercement ?

Le processus suit généralement ces étapes :
1.  **Création de l'offre (Maker) :** un Maker crée une offre en précisant le montant fiat pour lequel il souhaite recevoir un code {code}.
2.  **Financement de l'entiercement (Maker) :** le Maker paie une « hold invoice » du réseau Lightning pour le montant de Bitcoin indiqué. Cela verrouille le Bitcoin auprès du coordinateur sans encore le transférer.
3.  **Acceptation de l'offre (Taker) :** un Taker trouve une offre qui lui convient et l'accepte, puis génère un code {code} dans son application bancaire et le soumet au coordinateur.
4.  **Paiement fiat (Maker) :** le Maker reçoit le code {code} et le saisit au **distributeur Multibanco** pour effectuer le paiement ou le retrait d'espèces.
5.  **Confirmation {code} (Taker) :** le Taker reçoit une notification de son application bancaire pour confirmer le paiement {code}.
6.  **Confirmation du paiement (Maker) :** le Maker confirme dans le système {app} qu'il a bien reçu le paiement {code}.
7.  **Libération du Bitcoin (Coordinateur) :** dès la confirmation du Maker, le coordinateur utilise le preimage secret pour « settler » la hold invoice. Cette action libère le Bitcoin verrouillé vers l'adresse ou la facture Lightning fournie par le Taker.

#### Comment les takers sont-ils informés des nouvelles offres ?

Les takers peuvent s'inscrire sur plusieurs canaux de messagerie (SimpleX, Matrix, Telegram, Signal) pour recevoir des notifications sur les nouvelles offres.
Chaque fois qu'un Maker paie la hold invoice pour créer une nouvelle offre, le coordinateur envoie un message à tous les canaux de notification avec les détails de l'offre et un lien vers l'application {app} où elle peut être acceptée.

#### Qu'est-ce que {code} ?

{code} est un système de paiement mobile utilisé au {country}. Il permet d'effectuer des paiements au moyen d'un code à {codeLength} chiffres généré par l'application bancaire, qui peut être saisi directement à un distributeur Multibanco. Dans {app}, les Takers utilisent {code} pour payer les Makers en échange de Bitcoin.

#### Que sont les « hold invoices » du réseau Lightning ?

Les hold invoices sont un type particulier de facture Lightning. Lorsqu'une hold invoice est payée par le Maker (vendeur de Bitcoin), les fonds ne sont pas réglés immédiatement. Ils sont au contraire « retenus » par le nœud Lightning du coordinateur. Les fonds ne sont réellement libérés (réglés) au destinataire (Taker) que lorsqu'un « preimage » secret est révélé. Si le preimage n'est pas révélé dans un certain délai, ou si la facture est explicitement annulée, les fonds retournent au payeur (Maker). C'est le cœur du mécanisme d'entiercement de {app}.

---

### Sécurité & Risques

#### Comment mes fonds Bitcoin sont-ils sécurisés en tant que Maker (vendeur) ?

En tant que Maker, votre Bitcoin est verrouillé via une hold invoice. Le coordinateur détient le preimage nécessaire pour settler cette facture. Le système est conçu pour ne settler (libérer votre Bitcoin vers le Taker) qu'*après* que vous ayez confirmé avoir reçu le paiement fiat ({code}) du Taker. Si le Taker ne paie pas, ou en cas de problème, la hold invoice est annulée et le Bitcoin retourne sous le contrôle de votre nœud LN.

#### Comment suis-je protégé en tant que Taker (acheteur) si j'envoie un paiement {code} ?

En tant que Taker, votre principale protection est que le Maker a déjà verrouillé son Bitcoin dans une hold invoice auprès du coordinateur *avant* qu'on ne vous demande d'envoyer le paiement {code}. Si le Maker confirme la réception de votre {code}, le système est conçu pour libérer automatiquement le Bitcoin vers vous. Il existe un risque si le Maker nie faussement avoir reçu votre {code}. (Voir « Litiges »).

#### Que se passe-t-il si le Maker ne confirme pas mon paiement {code} alors que je l'ai envoyé ?

C'est un scénario de conflit. (Voir « Litiges »)

#### Que se passe-t-il si le Taker fournit un code {code} mais n'effectue pas réellement le paiement ?

En tant que Maker, vous ne devriez pas confirmer la réception du paiement tant que les fonds fiat ne sont pas réellement sur votre compte. Si le Taker ne paie pas après avoir fourni un code {code}, vous ne confirmez pas, et l'offre expirera probablement ou pourra être annulée. La hold invoice garantissant votre Bitcoin finira par être annulée, vous restituant les fonds.

#### Que se passe-t-il si le code {code} fourni par le Taker est invalide ou expire ?

Si le Maker tente d'utiliser le code {code} au distributeur et que cela échoue, la transaction ne peut pas se poursuivre. Le Taker devra peut-être fournir un nouveau code, ou l'offre pourra être annulée.

#### Quels sont les risques liés à l'utilisation de ce protocole ?

- **Risque de contrepartie :** le principal risque est que l'autre partie n'agisse pas honnêtement (p. ex. le Taker ne paie pas après que le Maker a verrouillé des BTC, ou le Maker ne confirme pas le paiement après que le Taker a payé). Le mécanisme de hold invoice atténue ce risque sans l'éliminer, notamment autour de la partie paiement fiat.
- **Confiance envers le coordinateur :** vous faites confiance au logiciel coordinateur de {app} et à ses opérateurs pour :
  -   gérer les preimages des hold invoices en toute sécurité.
  -   déclencher correctement les settlements ou annulations selon le déroulement du processus.
  -   exploiter le service de manière fiable.
- **Problèmes de nœud LN :** le nœud LN du coordinateur, et éventuellement ceux des utilisateurs (en auto-hébergement avec interaction directe), doivent être en ligne et opérationnels. Des problèmes de nœud LN peuvent retarder ou compliquer les transactions.
- **Problèmes du système {code} :** les problèmes du système de paiement {code} lui-même échappent au contrôle de {app}. Leur résolution doit passer par la banque du Taker ou le fournisseur {code}.
- **Bugs logiciels :** comme tout logiciel, le client ou le coordinateur {app} peut contenir des bugs susceptibles d'entraîner des erreurs ou des pertes de fonds. Le logiciel étant open source, les utilisateurs peuvent l'auditer, mais cela requiert une expertise technique.
- **Confidentialité :** vos clés publiques sont stockées par le coordinateur. Les détails des transactions sont aussi enregistrés dans la base de données. **Pour une meilleure confidentialité, générez une nouvelle paire de clés pour chaque transaction.**

#### Le coordinateur est-il dépositaire (custodial) ?

Le coordinateur n'est pas dépositaire au sens traditionnel pour le règlement Bitcoin *final* au Taker, puisqu'il paie vers la facture du Taker. Cependant, pendant la période d'entiercement, les fonds du Maker sont verrouillés dans une hold invoice que le coordinateur peut settler (avec le preimage) ou faire annuler. Il existe donc un élément de contrôle temporaire du coordinateur sur les fonds verrouillés. Maker et Taker font tous deux confiance au coordinateur pour libérer ces fonds conformément au protocole.

#### Qu'est-ce qui incite le Maker à agir honnêtement ?

Le Maker a déjà verrouillé son Bitcoin dans une hold invoice du réseau Lightning avant de recevoir le code {code}. Cela crée une forte incitation à mener l'échange honnêtement :

- **Si le Maker confirme la réception d'un paiement {code} valide :** le coordinateur settle la hold invoice et libère le Bitcoin vers le Taker. Le Maker reçoit son fiat — tout le monde est satisfait.
- **Si le Maker nie faussement avoir reçu un paiement {code} valide :** le Taker peut ouvrir un litige et fournir des preuves bancaires attestant du paiement. Si le coordinateur tranche en faveur du Taker, la hold invoice est settlée malgré tout, et le Maker perd son Bitcoin sans recours.
- **Si le Maker abandonne l'échange ou devient injoignable :** le coordinateur peut settler la facture en faveur du Taker (si des preuves de paiement existent) ou, dans les cas ambigus, garder les fonds verrouillés jusqu'à la résolution du litige.

Les hold invoices ont une fenêtre de validité limitée (généralement quelques heures), de sorte que le Maker ne peut pas temporiser indéfiniment. Il doit soit conclure l'échange honnêtement, soit risquer de perdre son Bitcoin via la procédure de résolution des litiges.

Le Bitcoin étant retenu dans une hold invoice du réseau Lightning, le Maker (vendeur) est incité à agir honnêtement. Sans preuve contraire, la facture ne sera pas restituée au Maker.

#### Qu'est-ce qui incite le Taker à agir honnêtement ?

Le Taker n'entre dans l'échange qu'après que le Maker a déjà verrouillé du Bitcoin dans une hold invoice. Bien que cela le protège d'un Maker sans fonds, le Taker fait aussi face à de fortes incitations à agir honnêtement :

- **Si le Taker fournit un code {code} valide et confirme le paiement :** le Maker reçoit le fiat, confirme la réception, et le coordinateur libère le Bitcoin vers le Taker. Tout le monde est satisfait.
- **Si le Taker fournit un code {code} invalide ou expiré :** le Maker ne peut pas finaliser le paiement au distributeur et ne confirme pas la réception. L'échange échoue, et le Bitcoin du Maker est restitué via l'annulation de la hold invoice. Le Taker ne reçoit rien.
- **Si le Taker prétend faussement avoir payé :** en cas de litige, le Taker doit fournir des preuves bancaires attestant que le paiement {code} a été débité de son compte. Sans ces preuves, le coordinateur annule la hold invoice après 48 heures et restitue le Bitcoin au Maker. Le Taker ne gagne rien et fait perdre du temps à tous.
- **Si le Taker abandonne l'échange après avoir réservé une offre :** l'offre finit par expirer ou est annulée, et le Bitcoin du Maker est restitué. Le Taker ne gagne rien.

Comme le Taker doit fournir des preuves vérifiables en cas de litige, il n'existe aucun moyen viable d'obtenir frauduleusement du Bitcoin. Un Taker malhonnête ne parvient qu'à faire perdre du temps — le sien, celui du Maker et celui du coordinateur.

> **Remarque :** un système de caution (bond) pour les takers est prévu à l'avenir ; il ajoutera une pénalité financière pour les takers qui font perdre du temps au coordinateur avec des litiges frivoles ou des échanges abandonnés.

#### Qu'est-ce qui incite le coordinateur à agir honnêtement ?

Le coordinateur doit fournir une clé Nostr (profil) que les utilisateurs peuvent taguer pour signaler de mauvaises expériences avec un coordinateur donné. Avant de choisir un coordinateur précis, vérifiez sa réputation sur Nostr. En raison de la nature résistante à la censure de Nostr, n'importe qui peut inonder ou publier de faux signalements ; utilisez donc un client qui s'appuie sur un Web of Trust pour évaluer la fiabilité des signalements de chaque utilisateur. Choisissez de préférence un coordinateur ayant bonne réputation au sein de votre communauté Bitcoin ou parmi vos amis de confiance. En fin de compte, c'est à vous, utilisateur de ce logiciel, qu'il revient de choisir un coordinateur de bonne réputation. Ceci n'est ni une plateforme ni un service, et nous déclinons toute responsabilité quant aux actions d'un coordinateur.

---

### Frais & Aspects techniques

#### Y a-t-il des frais pour utiliser {app} ?

Chaque coordinateur fixe ses frais, tant pour les makers que pour les takers. Ils sont affichés dans l'application cliente avant qu'une offre ne soit créée ou acceptée.

#### Que se passe-t-il si un paiement Lightning (versement au Taker) échoue ?

Si le coordinateur tente de payer la facture Lightning du Taker et que cela échoue (p. ex. nœud du Taker hors ligne, pas de route), la transaction peut entrer dans cet état. Le Taker devra peut-être fournir une nouvelle facture ou résoudre des problèmes liés à sa configuration Lightning.

#### Que se passe-t-il si, en tant que Maker, je veux annuler mon offre après l'avoir financée mais avant qu'un Taker ne l'accepte ?

Vous pouvez annuler la hold invoice, et le Bitcoin devrait revenir dans votre portefeuille LN. C'est généralement possible tant que l'offre est encore à l'état `funded` et pas encore `reserved` ou plus avancée.

#### Pourquoi les applications mobiles ne sont-elles pas distribuées sur le Google Play Store ou l'Apple App Store ?
Ces plateformes ne sont pas de simples places de marché ; ce sont des jardins clos gouvernés par des gardiens d'accès d'entreprise qui exercent une autorité absolue sur les logiciels que les utilisateurs peuvent installer. Ce modèle centralisé crée un point de défaillance unique et un goulot d'étranglement pour la censure. Les applications qui promeuvent des technologies protectrices de la vie privée, des discours politiques controversés ou des modèles économiques alternatifs peuvent être, et sont souvent, retirées à la seule discrétion des propriétaires de la plateforme, étouffant l'innovation et le libre échange des idées.

### Litiges

Si le maker et le taker sont en désaccord sur le statut du paiement ou en cas de problème avec la transaction, l'offre passe à l'état `conflict`, dans lequel chaque partie doit fournir des preuves pour que le coordinateur tranche le litige manuellement.

> ⚠️ **Important :** chaque coordinateur peut avoir des exigences et/ou une procédure de résolution des litiges différentes ; consultez donc la documentation du coordinateur ou contactez-le directement pour en être sûr.

#### Quel type de preuve pourrait généralement m'être demandé, en tant que Maker, par le coordinateur ?
Si le code {code} que vous avez tenté d'utiliser au distributeur Multibanco était invalide ou expiré, vous devriez fournir la preuve de la tentative de paiement échouée. Cela peut inclure :
- le reçu du code {code} invalide imprimé par le distributeur.
- une capture d'écran ou une impression de la tentative de paiement échouée au distributeur

#### Quel type de preuve pourrait généralement m'être demandé, en tant que Taker, par le coordinateur ?

Si le Maker nie avoir reçu votre paiement {code}, vous devriez prouver que le paiement {code} a bien été débité de votre compte bancaire. Ce sera généralement un reçu de paiement de votre application bancaire indiquant les détails de la transaction {code}, y compris le montant et l'horodatage.

## Support

Pour l'assistance du coordinateur ou en cas de problème avec des offres ou des litiges, contactez directement l'opérateur du coordinateur par DM Nostr ;
son profil est accessible via le lien vers ses conditions d'utilisation dans l'application client {app}.
