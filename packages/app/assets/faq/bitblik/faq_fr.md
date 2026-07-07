## FAQ {app}

### Questions générales

#### Qu'est-ce que {app} ?

{app} est un logiciel gratuit et open source conçu pour faciliter l'échange pair à pair de Bitcoin contre des codes {code}.\
L'idée de base est de :
- payer en Bitcoin partout où le paiement par {code} est accepté
- acheter du Bitcoin en générant et en vendant des codes {code}

#### Pourquoi un autre outil P2P ? Pourquoi ne pas simplement utiliser ceux qui existent déjà comme RoboSats, Bisq ou Hodl Hodl ?

Même si ces services d'escrow P2P sont excellents et devraient être utilisés pour des échanges plus importants et à plus long terme, {app} est pensé comme une méthode de paiement rapide utilisant des codes {code} dans les lieux et situations où cela a du sens, comme les magasins en libre-service, les restaurants, les achats en ligne et même les distributeurs automatiques.
L'ensemble du processus d'échange ne devrait pas prendre plus de quelques minutes, selon la rapidité avec laquelle les takers voient la nouvelle offre et peuvent fournir puis confirmer le code {code}.
- Les **makers** sont les utilisateurs qui cherchent à vendre du Bitcoin.
- Les **takers** sont les utilisateurs qui cherchent à acheter du Bitcoin.

#### Comment fonctionne le processus d'escrow ?

Le processus suit généralement ces étapes :
1.  **Création de l'offre (Maker) :** un maker crée une offre en précisant le montant fiat contre lequel il souhaite recevoir un code {code}.
2.  **Financement de l'escrow (Maker) :** le maker paie une "hold invoice" du Lightning Network pour le montant de Bitcoin concerné. Cela verrouille le Bitcoin auprès du coordinateur sans encore le transférer.
3.  **Acceptation de l'offre (Taker) :** un taker trouve une offre qui lui convient, l'accepte, génère un code {code} dans son application bancaire et l'envoie au coordinateur.
4.  **Paiement fiat (Maker) :** le maker reçoit le code {code} et le saisit dans le terminal de paiement ou sur le site marchand.
5.  **Confirmation {code} (Taker) :** le taker reçoit une notification de son application bancaire pour confirmer le paiement {code}.
6.  **Confirmation du paiement (Maker) :** le maker confirme dans le système {app} qu'il a bien reçu le paiement {code}.
7.  **Libération du Bitcoin (Coordinateur) :** après la confirmation du maker, le coordinateur utilise la préimage secrète pour régler la hold invoice. Cette action libère le Bitcoin verrouillé vers l'adresse Lightning ou la facture fournie par le taker.

#### Comment les takers sont-ils informés des nouvelles offres ?

Les takers peuvent s'inscrire à plusieurs canaux de messagerie (SimpleX, Matrix, Telegram, Signal) pour recevoir des notifications sur les nouvelles offres.
Chaque fois qu'un maker paie la hold invoice pour créer une nouvelle offre, le coordinateur envoie un message sur tous les canaux de notification avec les détails de l'offre et un lien vers l'application {app} où elle peut être acceptée.

#### Qu'est-ce que {code} ?

{code} est un système de paiement mobile utilisé en {country}. Il permet aux utilisateurs de payer à l'aide d'un code à {codeLength} chiffres généré par leur application bancaire. Dans {app}, les takers utilisent {code} pour payer les makers en échange de Bitcoin.

#### Que sont les "hold invoices" du Lightning Network ?

Les hold invoices sont un type particulier de facture Lightning. Quand une hold invoice est payée par le maker (vendeur de Bitcoin), les fonds ne sont pas réglés immédiatement. Ils sont au contraire "retenus" par le nœud Lightning du coordinateur. Les fonds ne sont réellement libérés au destinataire (taker) que lorsqu'une préimage secrète est révélée. Si la préimage n'est pas révélée dans un certain délai, ou si la facture est explicitement annulée, les fonds sont renvoyés au payeur (maker). C'est le cœur du mécanisme d'escrow de {app}.

---

### Sécurité et risques

#### Comment mes fonds en Bitcoin sont-ils sécurisés en tant que maker (vendeur) ?

En tant que maker, votre Bitcoin est verrouillé via une hold invoice. Le coordinateur possède la préimage nécessaire pour régler cette facture. Le système est conçu pour ne régler (libérer votre Bitcoin au taker) *qu'après* que vous avez confirmé avoir reçu le paiement fiat ({code}) du taker. Si le taker ne paie pas, ou s'il y a un problème, la hold invoice est annulée et le Bitcoin revient sous le contrôle de votre nœud LN.

#### Comment suis-je protégé en tant que taker (acheteur) si j'envoie un paiement {code} ?

En tant que taker, votre protection principale est que le maker a déjà verrouillé son Bitcoin dans une hold invoice auprès du coordinateur *avant* qu'on vous demande d'envoyer le paiement {code}. Si le maker confirme la réception de votre {code}, le système est conçu pour vous libérer automatiquement le Bitcoin. Il existe un risque si le maker nie faussement avoir reçu votre {code}. (Voir "Litiges".)

#### Que se passe-t-il si le maker ne confirme pas mon paiement {code} alors que je l'ai bien envoyé ?

Il s'agit d'un scénario de conflit. (Voir "Litiges".)

#### Que se passe-t-il si le taker fournit un code {code} mais n'effectue pas réellement le paiement ?

En tant que maker, vous ne devez pas confirmer la réception du paiement tant que les fonds fiat ne sont pas réellement arrivés. Si le taker ne paie pas après avoir fourni un code {code}, vous ne confirmez pas, et l'offre expirera probablement ou pourra être annulée. La hold invoice qui sécurise votre Bitcoin sera finalement annulée, ce qui vous rendra les fonds.

#### Que se passe-t-il si le code {code} fourni par le taker est invalide ou expire ?

Si le maker essaie d'utiliser le code {code} et que cela échoue, la transaction ne peut pas aboutir. Le taker devra peut-être fournir un nouveau code, ou l'offre pourra être annulée.

#### Quels sont les risques liés à l'utilisation de ce protocole ?

- **Risque de contrepartie :** le principal risque est que l'autre partie n'agisse pas honnêtement (par exemple un taker qui ne paie pas après que le maker a verrouillé les BTC, ou un maker qui ne confirme pas le paiement après que le taker a payé). Le mécanisme de hold invoice atténue ce risque sans l'éliminer totalement, surtout sur la partie fiat.
- **Confiance dans le coordinateur :** vous faites confiance au logiciel du coordinateur {app} et à ses opérateurs pour :
  -   gérer de façon sécurisée les préimages des hold invoices ;
  -   déclencher correctement les règlements ou les annulations selon le déroulement du processus ;
  -   exploiter le service de manière fiable.
- **Problèmes de nœuds LN :** le nœud LN du coordinateur et, potentiellement, les nœuds LN des utilisateurs (s'ils sont auto-hébergés et interagissent directement) doivent être en ligne et opérationnels. Des problèmes sur ces nœuds peuvent retarder ou compliquer les transactions.
- **Problèmes du système {code} :** les problèmes liés au système de paiement {code} lui-même sont hors du contrôle de {app}. Leur résolution doit être traitée via la banque du taker ou le fournisseur {code}.
- **Bugs logiciels :** comme pour tout logiciel, il existe un risque de bugs dans le client {app} ou chez le coordinateur pouvant entraîner des erreurs ou des pertes de fonds. Le logiciel est open source, donc les utilisateurs peuvent l'auditer, mais cela demande une expertise technique.
- **Vie privée :** vos clés publiques sont stockées par le coordinateur. Les détails des transactions sont aussi stockés dans la base de données. **Pour une meilleure confidentialité, vous devriez générer une nouvelle paire de clés pour chaque transaction.**

#### Le coordinateur est-il custodial ?

Le coordinateur n'est pas custodial au sens traditionnel pour le règlement *final* du Bitcoin vers le taker, puisqu'il paie la facture du taker. Cependant, pendant la période d'escrow, les fonds du maker sont verrouillés dans une hold invoice que le coordinateur a le pouvoir de régler (via la préimage) ou de faire annuler. Il existe donc un élément de contrôle temporaire du coordinateur sur les fonds verrouillés. Le maker comme le taker font confiance au coordinateur pour libérer ces fonds conformément au protocole.

#### Qu'est-ce qui motive le maker à agir honnêtement ?

Le maker a déjà verrouillé ses Bitcoin dans une hold invoice du Lightning Network avant de recevoir le code {code}. Cela crée une forte incitation à terminer l'échange honnêtement :

- **Si le maker confirme la réception d'un paiement {code} valide :** le coordinateur règle la hold invoice et libère le Bitcoin au taker. Le maker reçoit son fiat, tout le monde est satisfait.
- **Si le maker nie faussement avoir reçu un paiement {code} valide :** le taker peut ouvrir un litige et fournir des preuves bancaires montrant que le paiement a bien été effectué. Si le coordinateur tranche en faveur du taker, la hold invoice est réglée malgré tout et le maker perd son Bitcoin sans recours.
- **Si le maker abandonne l'échange ou devient injoignable :** le coordinateur peut régler la facture en faveur du taker (si des preuves de paiement existent) ou, dans les cas ambigus, garder les fonds verrouillés jusqu'à résolution du litige.

Les hold invoices ont une fenêtre de validité limitée (généralement quelques heures), ce qui signifie que le maker ne peut pas bloquer indéfiniment la situation. Il doit soit terminer l'échange honnêtement, soit risquer de perdre son Bitcoin via le processus de résolution des litiges.

Avec du Bitcoin verrouillé dans une hold invoice Lightning, le maker (vendeur) est incité à agir honnêtement. En l'absence de preuves contraires, la facture ne sera pas relibérée au maker.

#### Qu'est-ce qui motive le taker à agir honnêtement ?

Le taker n'entre dans l'échange qu'après que le maker a déjà verrouillé le Bitcoin dans une hold invoice. Même si cela protège le taker d'un maker qui n'aurait pas les fonds, le taker a aussi de fortes incitations à agir honnêtement :

- **Si le taker fournit un code {code} valide et confirme le paiement :** le maker reçoit le fiat, confirme sa réception, et le coordinateur libère le Bitcoin au taker. Tout le monde est satisfait.
- **Si le taker fournit un code {code} invalide ou expiré :** le maker ne peut pas finaliser le paiement et ne confirmera pas sa réception. L'échange échoue et le Bitcoin du maker est restitué via l'annulation de la hold invoice. Le taker ne reçoit rien.
- **Si le taker prétend faussement avoir payé :** en cas de litige, le taker doit fournir des preuves bancaires démontrant que le paiement {code} a été débité de son compte. Sans ces preuves, le coordinateur annulera la hold invoice après 48 heures et rendra le Bitcoin au maker. Le taker ne gagne rien et fait perdre du temps à tout le monde.
- **Si le taker abandonne l'échange après avoir réservé une offre :** l'offre finira par expirer ou être annulée, et le Bitcoin du maker lui sera restitué. Le taker ne gagne rien.

Comme le taker doit fournir des preuves vérifiables dans tout litige, il n'existe pas de voie réaliste pour obtenir frauduleusement du Bitcoin. Un taker malhonnête ne réussit qu'à faire perdre du temps, au maker, au coordinateur et à lui-même.

> **Remarque :** un système de caution pour les takers est prévu à l'avenir, ce qui ajoutera une pénalité financière pour ceux qui font perdre du temps au coordinateur avec des litiges frivoles ou des échanges abandonnés.

#### Qu'est-ce qui motive le coordinateur à agir honnêtement ?

Le coordinateur doit fournir une clé Nostr (profil) que les utilisateurs peuvent identifier et sur laquelle ils peuvent signaler de mauvaises expériences. Avant de choisir un coordinateur donné, vérifiez sa réputation sur Nostr. Compte tenu de la nature résistante à la censure de Nostr, n'importe qui peut inonder le réseau ou publier des signalements invalides ; utilisez donc un client qui s'appuie sur un Web of Trust pour évaluer la crédibilité des signalements. Choisissez de préférence un coordinateur qui a une bonne réputation dans votre communauté Bitcoin ou parmi vos proches de confiance. En définitive, en tant qu'utilisateur de ce logiciel, vous êtes responsable du choix d'un coordinateur réputé. Ceci n'est pas une plateforme ni un service, et nous n'assumons aucune responsabilité quant aux actions d'un coordinateur.

---

### Frais et aspects techniques

#### Y a-t-il des frais pour utiliser {app} ?

Chaque coordinateur fixe ses propres frais, aussi bien pour les makers que pour les takers. Ils sont affichés dans l'application cliente avant qu'une offre soit créée ou acceptée.

#### Que se passe-t-il si un paiement Lightning (versement au taker) échoue ?

Si le coordinateur tente de payer la facture Lightning du taker et que cela échoue (par exemple si le nœud du taker est hors ligne ou sans route), la transaction peut entrer dans cet état. Le taker devra peut-être fournir une nouvelle facture ou résoudre les problèmes de sa configuration Lightning.

#### Et si moi, en tant que maker, je veux annuler mon offre après l'avoir financée mais avant qu'un taker l'accepte ?

Vous pouvez annuler la hold invoice, et le Bitcoin devrait être renvoyé à votre portefeuille LN. C'est généralement possible tant que l'offre est encore dans l'état `funded` et n'est pas passée à `reserved` ou plus loin.

#### Pourquoi les applications mobiles ne sont-elles pas distribuées sur le Google Play Store ou l'Apple App Store ?
Ces plateformes ne sont pas de simples places de marché ; ce sont des jardins clos gouvernés par des gardiens d'entreprise qui exercent une autorité absolue sur les logiciels que les utilisateurs peuvent installer. Ce modèle centralisé crée un point de défaillance unique et un goulot d'étranglement pour la censure. Les applications qui favorisent les technologies de protection de la vie privée, les discours politiques controversés ou des modèles économiques alternatifs peuvent être, et sont souvent, retirées à la seule discrétion des propriétaires des plateformes, ce qui freine l'innovation et le libre échange des idées.

### Litiges

Si le maker et le taker ne sont pas d'accord sur l'état du paiement ou s'il y a un problème avec la transaction, l'offre passe dans un état `conflict`, dans lequel chaque partie doit fournir des preuves pour que le coordinateur résolve manuellement le litige.

> ⚠️ **Important :** chaque coordinateur peut avoir des exigences et/ou une procédure de résolution des litiges différentes, donc vérifiez sa documentation ou contactez-le directement pour en être sûr.

#### Quel type de preuve peut généralement m'être demandé en tant que maker par le coordinateur ?
Si le code {code} que vous avez essayé d'utiliser au terminal de paiement ou sur un site e-commerce était invalide ou expiré, vous devriez fournir une preuve de l'échec de la tentative de paiement. Cela peut inclure :
- un reçu de code {code} invalide imprimé par le terminal de paiement ou le distributeur automatique ;
- une capture d'écran de la tentative de paiement échouée sur le site e-commerce.

#### Quel type de preuve peut généralement m'être demandé en tant que taker par le coordinateur ?

Si le maker nie avoir reçu votre paiement {code}, vous devriez fournir une preuve que le paiement {code} a bien été débité de votre compte bancaire. Il s'agira généralement d'un reçu de paiement de votre application bancaire montrant les détails de la transaction {code}, y compris le montant et l'horodatage.

## Support

Pour l'assistance du coordinateur ou les problèmes liés aux offres ou aux litiges, contactez directement l'opérateur du coordinateur via les DM Nostr,
son profil est accessible via le lien vers les conditions d'utilisation dans l'application cliente {app}.
