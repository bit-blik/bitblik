## FAQ do {app}

### Perguntas gerais

#### O que é o {app}?

O {app} é software livre e de código aberto, concebido para facilitar a troca peer-to-peer de Bitcoin por códigos {code} — focado no pagamento em **multibancos (Multibanco)** em {country}.\
A ideia fundamental é:
- gastar Bitcoin em qualquer multibanco que aceite pagamento {code}
- comprar Bitcoin gerando e vendendo códigos {code}

#### Porquê mais uma ferramenta P2P? Porque não usar simplesmente as que já existem, como o RoboSats, o Bisq ou o Hodl Hodl?

Embora esses serviços de escrow P2P sejam excelentes e devam ser usados para trocas maiores e de mais longo prazo, o {app} destina-se a ser usado como um método de pagamento rápido com códigos {code} em **multibancos (Multibanco)**, onde pode levantar dinheiro ou pagar contas com o Bitcoin que detém.
Todo o processo de troca não deve demorar mais do que alguns minutos, dependendo da rapidez com que os takers reparam na nova oferta e conseguem fornecer e confirmar prontamente o código {code}.
- **Makers** são utilizadores que querem vender Bitcoin.
- **Takers** são utilizadores que querem comprar Bitcoin.

#### Como funciona o processo de escrow?

O processo segue geralmente estes passos:
1.  **Criação da oferta (Maker):** Um maker cria uma oferta, especificando o montante de fiat que quer receber por um código {code}.
2.  **Financiamento do escrow (Maker):** O maker paga uma "hold invoice" da Lightning Network pelo montante de Bitcoin especificado. Isto bloqueia o Bitcoin com o coordenador, mas ainda não o transfere.
3.  **Aceitação da oferta (Taker):** Um taker encontra uma oferta de que gosta e aceita-a, depois gera um código {code} na app do seu banco e submete-o ao coordenador.
4.  **Pagamento em fiat (Maker):** O maker recebe o código {code} e introduz-no no **multibanco (Multibanco)** para completar o pagamento ou o levantamento de dinheiro.
5.  **Confirmação do {code} (Taker):** O taker recebe uma notificação da app do seu banco para confirmar o pagamento {code}.
6.  **Confirmação do pagamento (Maker):** O maker confirma dentro do sistema {app} que recebeu o pagamento {code}.
7.  **Libertação do Bitcoin (Coordenador):** Após a confirmação do maker, o coordenador usa o preimage secreto para "liquidar" a hold invoice. Esta ação liberta o Bitcoin bloqueado para o Lightning Address ou invoice fornecido pelo taker.

#### Como é que os takers ficam a saber de novas ofertas?

Os takers podem registar-se em vários canais de messenger (SimpleX, Matrix, Telegram, Signal) para receber notificações sobre novas ofertas.
Sempre que um maker paga a hold invoice para criar uma nova oferta, o coordenador envia uma mensagem para todos os canais de notificação com os detalhes da oferta e um link para a app {app} onde a podem aceitar.

#### O que é o {code}?

O {code} é um sistema de pagamento móvel usado em {country}. Permite aos utilizadores fazer pagamentos usando um código de {codeLength} dígitos gerado pela app do seu banco, que pode ser introduzido diretamente num multibanco. No {app}, os takers usam o {code} para pagar Bitcoin aos makers.

#### O que são as "hold invoices" da Lightning Network?

As hold invoices são um tipo especial de invoice Lightning. Quando uma hold invoice é paga pelo maker (vendedor de Bitcoin), os fundos não são liquidados imediatamente. Em vez disso, ficam "retidos" pelo nó Lightning do coordenador. Os fundos só são realmente libertados (liquidados) para o destinatário (taker) quando um "preimage" secreto é revelado. Se o preimage não for revelado dentro de um certo tempo, ou se a invoice for explicitamente cancelada, os fundos são devolvidos ao pagador (maker). Este é o núcleo do mecanismo de escrow do {app}.

---

### Segurança e riscos

#### Como estão os meus fundos de Bitcoin protegidos enquanto maker (vendedor)?

Enquanto maker, o seu Bitcoin é bloqueado através de uma hold invoice. O coordenador tem o preimage necessário para liquidar esta invoice. O sistema foi concebido para só liquidar (libertar o seu Bitcoin para o taker) *depois* de confirmar que recebeu o pagamento em fiat ({code}) do taker. Se o taker não pagar, ou se houver algum problema, a hold invoice é cancelada e o Bitcoin volta ao controlo do seu nó LN.

#### Como estou protegido enquanto taker (comprador) se enviar um pagamento {code}?

Enquanto taker, a sua principal proteção é que o maker já bloqueou o seu Bitcoin numa hold invoice com o coordenador *antes* de lhe ser pedido para enviar o pagamento {code}. Se o maker confirmar a receção do seu {code}, o sistema foi concebido para libertar automaticamente o Bitcoin para si. Existe um risco se o maker negar falsamente ter recebido o seu {code}. (Ver "Disputas").

#### O que acontece se o maker não confirmar o meu pagamento {code} mesmo eu o tendo enviado?

Isto é um cenário de conflito. (Ver "Disputas")

#### O que acontece se o taker fornecer um código {code} mas não fizer de facto o pagamento?

Enquanto maker, não deve confirmar a receção do pagamento até os fundos em fiat estarem efetivamente na sua conta. Se o taker não pagar depois de fornecer um código {code}, não confirma, e a oferta provavelmente expirará ou poderá ser cancelada. A hold invoice que protege o seu Bitcoin acabará por ser cancelada, devolvendo-lhe os fundos.

#### E se o código {code} fornecido pelo taker for inválido ou expirar?

Se o maker tentar usar o código {code} no multibanco e este falhar, a transação não pode prosseguir. O taker pode ter de fornecer um novo código, ou a oferta pode ser cancelada.

#### Quais são os riscos de usar este protocolo?

- **Risco de contraparte:** O principal risco é a outra parte não agir com honestidade (por exemplo, o taker não pagar depois de o maker bloquear o BTC, ou o maker não confirmar o pagamento depois de o taker pagar). O mecanismo da hold invoice mitiga isto, mas não o elimina, sobretudo na parte do pagamento em fiat.
- **Confiança no coordenador:** Está a confiar no software do coordenador {app} e nos seus operadores para:
  -   Gerir com segurança os preimages das hold invoices.
  -   Acionar corretamente as liquidações ou cancelamentos com base no fluxo do processo.
  -   Operar o serviço de forma fiável.
- **Problemas com o nó LN:** Tanto o nó LN do coordenador como, potencialmente, os nós LN dos utilizadores (se forem auto-alojados e interagirem diretamente) têm de estar online e operacionais. Problemas com os nós LN podem atrasar ou complicar as transações.
- **Problemas com o sistema {code}:** Problemas com o próprio sistema de pagamento {code} estão fora do controlo do {app}. A resolução de tais problemas tem de ser tratada através do banco do taker ou do fornecedor do {code}.
- **Bugs de software:** Como com qualquer software, há o risco de bugs no cliente ou no coordenador do {app} que possam levar a erros ou perda de fundos. O software é de código aberto, por isso os utilizadores podem auditá-lo, mas isso requer conhecimentos técnicos.
- **Privacidade:** As suas chaves públicas são guardadas pelo coordenador. Os detalhes das transações também são guardados na base de dados. **Para melhor privacidade, deve gerar um novo par de chaves para cada transação.**

#### O coordenador é custodial?

O coordenador é não-custodial no sentido tradicional para a liquidação *final* do Bitcoin para o taker, já que paga para a invoice do taker. No entanto, durante o período de escrow, os fundos do maker ficam bloqueados numa hold invoice que o coordenador tem o poder de liquidar (usando o preimage) ou de mandar cancelar. Portanto, existe um elemento de controlo temporário por parte do coordenador sobre os fundos bloqueados. Tanto o maker como o taker confiam que o coordenador liberta esses fundos de acordo com o protocolo.

#### O que motiva o maker a agir com honestidade?

O maker já bloqueou o seu Bitcoin numa hold invoice da Lightning Network antes de receber o código {code}. Isto cria um forte incentivo para completar a troca com honestidade:

- **Se o maker confirmar a receção de um pagamento {code} válido:** O coordenador liquida a hold invoice, libertando o Bitcoin para o taker. O maker recebe o seu fiat — todos ficam satisfeitos.
- **Se o maker negar falsamente ter recebido um pagamento {code} válido:** O taker pode abrir uma disputa e fornecer prova bancária de que o pagamento foi feito. Se o coordenador decidir a favor do taker, a hold invoice é liquidada na mesma e o maker perde o seu Bitcoin sem recurso.
- **Se o maker abandonar a troca ou ficar sem responder:** O coordenador pode liquidar a invoice a favor do taker (se existir prova de pagamento) ou, em casos ambíguos, manter os fundos bloqueados até a disputa ser resolvida.

As hold invoices têm uma janela de validade limitada (tipicamente algumas horas), o que significa que o maker não pode adiar indefinidamente. Tem de completar a troca com honestidade ou arriscar perder o seu Bitcoin através do processo de resolução de disputas.

Com o Bitcoin retido numa hold invoice da Lightning Network, o maker (vendedor) é incentivado a agir com honestidade. Sem prova em contrário, a invoice não será libertada de volta para o maker.

#### O que motiva o taker a agir com honestidade?

O taker só entra na troca depois de o maker já ter bloqueado o Bitcoin numa hold invoice. Embora isto proteja o taker de um maker que possa não ter fundos, o taker também enfrenta fortes incentivos para agir com honestidade:

- **Se o taker fornecer um código {code} válido e confirmar o pagamento:** O maker recebe o fiat, confirma a receção, e o coordenador liberta o Bitcoin para o taker. Todos ficam satisfeitos.
- **Se o taker fornecer um código {code} inválido ou expirado:** O maker não consegue completar o pagamento no multibanco e não confirmará a receção. A troca falha, e o Bitcoin do maker é devolvido através do cancelamento da hold invoice. O taker não recebe nada.
- **Se o taker afirmar falsamente ter pago:** Numa disputa, o taker tem de fornecer prova bancária de que o pagamento {code} foi deduzido da sua conta. Sem essa prova, o coordenador cancelará a hold invoice ao fim de 48 horas, devolvendo o Bitcoin ao maker. O taker não ganha nada e faz perder tempo a todos.
- **Se o taker abandonar a troca depois de reservar uma oferta:** A oferta acaba por expirar ou ser cancelada, e o Bitcoin do maker é devolvido. O taker não ganha nada.

Como o taker tem de fornecer prova verificável em qualquer disputa, não há caminho viável para obter Bitcoin de forma fraudulenta. Um taker desonesto só consegue fazer perder tempo — o seu próprio, o do maker e o do coordenador.

> **Nota:** Está planeado para implementação futura um sistema de bond para takers, que adicionará uma penalização financeira para takers que façam perder tempo ao coordenador com disputas frívolas ou trocas abandonadas.

#### O que motiva o coordenador a agir com honestidade?

O coordenador tem de fornecer uma chave Nostr (perfil) que os utilizadores podem etiquetar e na qual podem reportar más experiências com um determinado coordenador. Antes de escolher usar um coordenador específico, verifique a sua reputação no Nostr. Dada a natureza resistente à censura do Nostr, qualquer pessoa pode inundar ou publicar reports inválidos, por isso use um cliente que utilize Web of Trust para determinar a reputação dos reports de cada utilizador. De preferência, escolha um coordenador que tenha boa reputação na sua comunidade Bitcoin ou entre os seus amigos de confiança. Em última análise, é você, enquanto utilizador deste software, o responsável por escolher um coordenador com boa reputação. Isto não é uma plataforma ou serviço e não assumimos qualquer responsabilidade pelas ações de nenhum coordenador.

---

### Taxas e aspetos técnicos

#### Existem taxas por usar o {app}?

Cada coordenador define as suas taxas, tanto para makers como para takers. Estas são mostradas na aplicação cliente, antes de uma oferta ser criada ou aceite.

#### O que acontece se um pagamento Lightning (pagamento ao taker) falhar?

Se o coordenador tentar pagar a invoice Lightning do taker e esta falhar (por exemplo, nó do taker offline, sem rota), a transação pode entrar neste estado. O taker pode ter de fornecer uma nova invoice ou resolver problemas com a sua configuração Lightning.

#### E se eu, enquanto maker, quiser cancelar a minha oferta depois de a financiar mas antes de um taker a aceitar?

Pode cancelar a hold invoice, e o Bitcoin deverá ser devolvido à sua carteira LN. Isto é tipicamente possível se a oferta ainda estiver no estado `funded` e ainda não estiver `reserved` ou mais à frente.

#### Porque é que as apps móveis não são distribuídas na Google Play Store ou na Apple App Store?
Estas plataformas não são meros mercados; são jardins murados governados por gatekeepers corporativos que exercem autoridade absoluta sobre que software os utilizadores podem instalar. Este modelo centralizado cria um único ponto de falha e um ponto de estrangulamento para a censura. Apps que promovem tecnologias de reforço de privacidade, discurso político controverso ou modelos económicos alternativos podem ser, e muitas vezes são, removidas ao critério exclusivo dos donos da plataforma, sufocando a inovação e a livre troca de ideias.

### Disputas

Se tanto o maker como o taker discordarem sobre o estado do pagamento ou se houver problemas com a transação, a oferta entra num estado de `conflict`, no qual cada parte tem de fornecer provas para o coordenador resolver a disputa manualmente.

> ⚠️ **Importante:** Cada coordenador pode ter requisitos e/ou procedimentos diferentes para a resolução de disputas, por isso consulte a documentação do coordenador ou contacte-o diretamente para se certificar.

#### Que tipo de prova poderá geralmente ser-me pedida enquanto maker pelo coordenador?
Se o código {code} que tentou usar no multibanco era inválido ou estava expirado, deve fornecer prova da tentativa de pagamento falhada. Isto pode incluir:
- talão de código {code} inválido impresso pelo multibanco.
- captura de ecrã ou talão da tentativa de pagamento falhada no multibanco

#### Que tipo de prova poderá geralmente ser-me pedida enquanto taker pelo coordenador?

Se o maker negar ter recebido o seu pagamento {code}, deve fornecer prova de que o pagamento {code} foi efetivamente deduzido da sua conta bancária. Tipicamente, será um comprovativo de pagamento da app do seu banco a mostrar os detalhes da transação {code}, incluindo o montante e a data/hora.

## Suporte

Para suporte do coordenador ou problemas com ofertas ou disputas, contacte o operador do coordenador diretamente através de DMs de Nostr;
o perfil dele está acessível pelo link dos termos de utilização na app cliente {app}.
