## FAQ {app}

### Perguntas gerais

#### O que é {app}?

{app} é um software livre e de código aberto concebido para facilitar a troca peer-to-peer de Bitcoin por pagamentos {code} — usado em {country}.\
A ideia fundamental é:
- pagar com Bitcoin em todo o lado onde o pagamento {code} seja aceite
- comprar Bitcoin pagando códigos {code} em nome de alguém que está a gastar Bitcoin

#### Porquê mais uma ferramenta P2P? Porque não usar as existentes, como RoboSats, Bisq ou Hodl Hodl?

Esses serviços de custódia (escrow) P2P são excelentes e devem ser usados para trocas maiores e de longo prazo. {app}, por outro lado, destina-se a ser um método de pagamento rápido através de códigos {code}, em locais/situações apropriados, como caixas de autoatendimento, restaurantes, compras online e até multibancos.
Todo o processo de troca não deve demorar mais do que alguns minutos, dependendo da rapidez com que os takers notam a nova oferta e conseguem pagar e confirmar prontamente o código {code}.
- **Makers** são utilizadores que querem vender Bitcoin.
- **Takers** são utilizadores que querem comprar Bitcoin.

#### Quem fornece o código {code}, o Maker ou o Taker?

É o **Maker que fornece o código {code}**. No pagamento {code} o código é mostrado ao pagador pelo terminal ou pela caixa do comerciante, por isso o Maker (que está no comerciante, a gastar Bitcoin) lê esse código {code} e fornece-o antecipadamente ao criar a oferta. O **Taker introduz depois esse código {code} na sua app {code}** e paga-o. O código viaja assim sempre do Maker para o Taker, e é a conta do Taker que é debitada.

#### Como funciona o processo de custódia (escrow)?

O processo segue geralmente estes passos:
1.  **Criação da oferta (Maker):** um Maker no comerciante lê o código {code} que lhe é mostrado (no terminal de pagamento ou na caixa) e cria uma oferta com esse código {code}, indicando o montante fiat a pagar.
2.  **Financiamento do escrow (Maker):** o Maker paga uma "hold invoice" da rede Lightning pelo montante de Bitcoin indicado. Isto bloqueia o Bitcoin junto do coordenador, mas ainda não o transfere.
3.  **Aceitação da oferta (Taker):** um Taker encontra uma oferta do seu agrado e aceita-a. O coordenador revela então ao Taker o código {code} do Maker.
4.  **Pagamento fiat (Taker):** o Taker introduz o código {code} na sua app {code} e paga-o. Isto debita a conta do Taker e liquida o pagamento ao comerciante.
5.  **Comunicação do pagamento (Taker):** depois de pago, o Taker marca o código {code} como pago na app {app}.
6.  **Confirmação do pagamento (Maker):** o Maker verifica junto do comerciante que o pagamento {code} foi bem-sucedido e confirma-o no sistema {app}.
7.  **Libertação do Bitcoin (Coordenador):** após a confirmação do Maker, o coordenador usa a preimage secreta para "settlar" a hold invoice. Esta ação liberta o Bitcoin bloqueado para o endereço ou fatura Lightning fornecidos pelo Taker.

#### Como é que os takers ficam a saber de novas ofertas?

Os takers podem registar-se em vários canais de mensagens (SimpleX, Matrix, Telegram, Signal) para receber notificações sobre novas ofertas.
Sempre que um Maker paga a hold invoice para criar uma nova oferta, o coordenador envia uma mensagem a todos os canais de notificação com os detalhes da oferta e uma ligação para a app {app} onde ela pode ser aceite.

#### O que é {code}?

{code} é um sistema de pagamento móvel usado em {country}. Para pagar, introduz-se um código de {codeLength} dígitos na app {code}, o que debita a conta bancária do pagador. Em {app}, o Maker fornece o código {code} e o Taker paga-o na sua app {code} para comprar o Bitcoin do Maker.

#### Durante quanto tempo é válido um código {code}?

Um código {code} só é válido durante cerca de {validity} minutos. Devido a esta curta validade, o Taker deve introduzir e pagar o código na sua app {code} prontamente depois de aceitar a oferta. Se o código expirar antes de ser pago, o Maker pode fornecer um novo código {code} para que a troca possa continuar.

#### O que são as "hold invoices" da rede Lightning?

As hold invoices são um tipo especial de fatura Lightning. Quando uma hold invoice é paga pelo Maker (vendedor de Bitcoin), os fundos não são liquidados de imediato. Em vez disso, são "retidos" pelo nó Lightning do coordenador. Os fundos só são realmente libertados (liquidados) ao destinatário (Taker) quando uma "preimage" secreta é revelada. Se a preimage não for revelada dentro de um certo prazo, ou se a fatura for explicitamente cancelada, os fundos regressam ao pagador (Maker). Este é o cerne do mecanismo de escrow de {app}.

---

### Segurança & Riscos

#### Como estão protegidos os meus fundos em Bitcoin enquanto Maker (vendedor)?

Como Maker, o teu Bitcoin fica bloqueado através de uma hold invoice. O coordenador possui a preimage necessária para settlar esta fatura. O sistema foi concebido para só settlar (libertar o teu Bitcoin para o Taker) *depois* de confirmares que o pagamento {code} foi bem-sucedido. Se o Taker não pagar, ou se houver um problema, a hold invoice é cancelada e o Bitcoin regressa ao controlo do teu nó LN.

#### Como estou protegido enquanto Taker (comprador) quando pago um código {code}?

Como Taker, a tua principal proteção é que o Maker já bloqueou o seu Bitcoin numa hold invoice junto do coordenador *antes* de o código {code} te ser revelado e de o pagares. Se o Maker confirmar o pagamento {code}, o sistema foi concebido para te libertar o Bitcoin automaticamente. Há um risco se o Maker negar falsamente que o pagamento {code} foi bem-sucedido. (Ver "Disputas").

#### O que acontece se o Maker não confirmar o meu pagamento {code} apesar de eu o ter pago?

É um cenário de conflito. Nota que, se o Maker ficar em silêncio, a oferta é confirmada automaticamente a favor do Taker após um tempo limite. (Ver "Disputas")

#### O que acontece se o Taker aceitar a oferta mas não pagar de facto o código {code}?

Como Maker, não deves confirmar o pagamento enquanto os fundos {code} não tiverem efetivamente passado no comerciante. Se o Taker não pagar o código {code}, não confirmas, e a reserva expira — a oferta volta ao pool aberto ou a hold invoice é cancelada para que o teu Bitcoin te seja devolvido.

#### E se o código {code} fornecido pelo Maker for inválido ou expirar antes de o Taker o pagar?

Se o Taker não conseguir pagar o código {code} por este estar inválido ou expirado, a reserva caduca. O Maker pode fornecer um novo código {code} para que a troca continue, ou a oferta pode ser cancelada.

#### Quais são os riscos de usar este protocolo?

- **Risco de contraparte:** o principal risco é a outra parte não agir com honestidade (por ex. o Taker não pagar depois de o Maker bloquear BTC, ou o Maker não confirmar o pagamento depois de o Taker pagar). O mecanismo de hold invoice mitiga isto, mas não o elimina, sobretudo em torno da parte do pagamento fiat.
- **Confiança no coordenador:** estás a confiar no software coordenador de {app} e nos seus operadores para:
  -   gerirem em segurança as preimages das hold invoices.
  -   acionarem corretamente settlements ou cancelamentos consoante o fluxo do processo.
  -   operarem o serviço de forma fiável.
- **Problemas do nó LN:** tanto o nó LN do coordenador como, eventualmente, os nós dos utilizadores (se auto-alojados e a interagir diretamente) têm de estar online e operacionais. Problemas com nós LN podem atrasar ou complicar as transações.
- **Problemas do sistema {code}:** problemas com o próprio sistema de pagamento {code} estão fora do controlo de {app}. A sua resolução tem de passar pelo banco do Taker ou pelo fornecedor {code}.
- **Bugs de software:** como em qualquer software, há o risco de bugs no cliente ou no coordenador de {app} que possam causar erros ou perda de fundos. Sendo o software de código aberto, os utilizadores podem auditá-lo, mas isso requer conhecimentos técnicos.
- **Privacidade:** as tuas chaves públicas são guardadas pelo coordenador. Os detalhes das transações também são guardados na base de dados. **Para melhor privacidade, deves gerar um novo par de chaves para cada transação.**

#### O coordenador é custodial?

O coordenador não é custodial no sentido tradicional para a liquidação *final* do Bitcoin ao Taker, pois paga para a fatura do Taker. No entanto, durante o período de escrow, os fundos do Maker ficam bloqueados numa hold invoice que o coordenador pode settlar (usando a preimage) ou mandar cancelar. Existe, portanto, um elemento de controlo temporário do coordenador sobre os fundos bloqueados. Tanto o Maker como o Taker confiam que o coordenador liberte esses fundos de acordo com o protocolo.

#### O que motiva o Maker a agir com honestidade?

O Maker já bloqueou o seu Bitcoin numa hold invoice da rede Lightning antes de o código {code} ser pago pelo Taker. Isto cria um forte incentivo para concluir a troca com honestidade:

- **Se o Maker confirmar um pagamento {code} válido:** o coordenador settla a hold invoice, libertando o Bitcoin para o Taker. A compra do Maker fica paga — todos ficam satisfeitos.
- **Se o Maker negar falsamente um pagamento {code} válido:** o Taker pode abrir uma disputa e fornecer provas bancárias que comprovem o pagamento. Se o coordenador decidir a favor do Taker, a hold invoice é settlada na mesma, e o Maker perde o seu Bitcoin sem recurso. Nota também que, se o Maker simplesmente ficar em silêncio, a troca é confirmada automaticamente a favor do Taker após um tempo limite.
- **Se o Maker abandonar a troca ou ficar incontactável:** o coordenador pode settlar a fatura a favor do Taker (se existirem provas de pagamento) ou, em casos ambíguos, manter os fundos bloqueados até a disputa ser resolvida.

As hold invoices têm uma janela de validade limitada (normalmente algumas horas), pelo que o Maker não pode protelar indefinidamente. Tem de concluir a troca com honestidade ou arriscar-se a perder o seu Bitcoin através do processo de resolução de disputas.

Com o Bitcoin retido numa hold invoice da rede Lightning, o Maker (vendedor) é incentivado a agir com honestidade. Sem provas em contrário, a fatura não será devolvida ao Maker.

#### O que motiva o Taker a agir com honestidade?

O Taker só entra na troca depois de o Maker já ter bloqueado Bitcoin numa hold invoice. Embora isto o proteja de um Maker que possa não ter fundos, o Taker também enfrenta fortes incentivos para agir com honestidade:

- **Se o Taker pagar o código {code} e o reportar como pago:** a compra do Maker é concretizada, o Maker confirma-a, e o coordenador liberta o Bitcoin para o Taker. Todos ficam satisfeitos.
- **Se o Taker não conseguir pagar porque o código {code} está inválido ou expirado:** a troca não pode concluir-se. O Maker fornece um novo código ou a oferta é cancelada e o Bitcoin do Maker devolvido através do cancelamento da hold invoice. O Taker não recebe nada.
- **Se o Taker afirmar falsamente ter pago:** numa disputa, o Taker tem de fornecer provas bancárias que comprovem que o pagamento {code} foi debitado da sua conta. Sem tais provas, o coordenador cancela a hold invoice após 48 horas, devolvendo o Bitcoin ao Maker. O Taker não ganha nada e faz todos perderem tempo.
- **Se o Taker abandonar a troca depois de reservar uma oferta:** a oferta acaba por expirar ou é cancelada, e o Bitcoin do Maker é devolvido. O Taker não ganha nada.

Como o Taker tem de fornecer provas verificáveis em qualquer disputa, não há forma viável de obter Bitcoin de forma fraudulenta. Um Taker desonesto só consegue fazer perder tempo — o seu, o do Maker e o do coordenador.

> **Nota:** está previsto para o futuro um sistema de caução (bond) para takers, que acrescentará uma penalização financeira aos takers que fazem o coordenador perder tempo com disputas frívolas ou trocas abandonadas.

#### O que motiva o coordenador a agir com honestidade?

O coordenador tem de fornecer uma chave Nostr (perfil) que os utilizadores podem etiquetar para reportar más experiências com um dado coordenador. Antes de escolheres um coordenador específico, verifica a sua reputação no Nostr. Dada a natureza resistente à censura do Nostr, qualquer pessoa pode inundar ou publicar denúncias falsas, por isso usa um cliente que recorra a uma Web of Trust para determinar a fiabilidade das denúncias de cada utilizador. Escolhe, de preferência, um coordenador com boa reputação na tua comunidade Bitcoin ou entre os teus amigos de confiança. Em última análise, és tu, utilizador deste software, o responsável por escolher um coordenador de boa reputação. Isto não é uma plataforma nem um serviço e não assumimos qualquer responsabilidade pelas ações de nenhum coordenador.

---

### Taxas & Aspetos técnicos

#### Há alguma taxa para usar {app}?

Cada coordenador define as suas taxas, tanto para makers como para takers. São mostradas na aplicação cliente antes de uma oferta ser criada ou aceite.

#### O que acontece se um pagamento Lightning (pagamento ao Taker) falhar?

Se o coordenador tentar pagar a fatura Lightning do Taker e falhar (por ex. nó do Taker offline, sem rota), a transação pode entrar neste estado. O Taker pode ter de fornecer uma nova fatura ou resolver problemas com a sua configuração Lightning.

#### E se eu, enquanto Maker, quiser cancelar a minha oferta depois de a financiar mas antes de um Taker a aceitar?

Podes cancelar a hold invoice, e o Bitcoin deverá regressar à tua carteira LN. Normalmente é possível enquanto a oferta ainda estiver no estado `funded` e ainda não `reserved` ou mais adiante.

#### Porque é que as apps móveis não são distribuídas na Google Play Store ou na Apple App Store?
Estas plataformas não são meros mercados; são jardins murados governados por guardiões corporativos que exercem autoridade absoluta sobre o software que os utilizadores podem instalar. Este modelo centralizado cria um ponto único de falha e um estrangulamento para a censura. As apps que promovem tecnologias de reforço da privacidade, discursos políticos controversos ou modelos económicos alternativos podem ser, e são muitas vezes, removidas ao critério exclusivo dos donos da plataforma, sufocando a inovação e a livre troca de ideias.

### Disputas

Se o maker e o taker discordarem sobre o estado do pagamento ou se houver problemas com a transação, a oferta entra num estado de `conflict`, no qual cada parte tem de fornecer provas para o coordenador resolver a disputa manualmente.

> ⚠️ **Importante:** cada coordenador pode ter requisitos e/ou um procedimento de resolução de disputas diferentes, por isso consulta a documentação do coordenador ou contacta-o diretamente para teres a certeza.

#### Que tipo de prova me poderá geralmente ser exigida, enquanto Maker, pelo coordenador?
Se alegares que o pagamento {code} não foi bem-sucedido, deves fornecer prova do pagamento falhado no comerciante. Isto pode incluir:
- recibo ou mensagem do terminal a mostrar que o pagamento {code} não foi concluído.
- captura de ecrã do pagamento falhado na caixa ou no site de e-commerce

#### Que tipo de prova me poderá geralmente ser exigida, enquanto Taker, pelo coordenador?

Se o Maker negar que o teu pagamento {code} foi bem-sucedido, deves comprovar que o pagamento {code} foi efetivamente debitado da tua conta bancária. Será, tipicamente, um comprovativo de pagamento na tua app {code} a mostrar os detalhes da transação, incluindo o montante e a data/hora.

## Suporte

Para suporte do coordenador ou problemas com ofertas ou disputas, contacta diretamente o operador do coordenador por DM no Nostr;
o seu perfil está acessível através da ligação para os termos de utilização na app cliente {app}.
