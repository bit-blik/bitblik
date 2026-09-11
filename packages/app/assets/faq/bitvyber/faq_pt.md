## FAQ {app}

### Perguntas gerais

#### O que é o {app}?

O {app} é software livre e de código aberto para a troca peer-to-peer de Bitcoin por **levantamentos de dinheiro sem cartão** na {country} — no **Tatra banka, Slovenská sporiteľňa e VÚB**.\
A ideia fundamental:
- levantar dinheiro em qualquer multibanco de um banco eslovaco com um código de "levantamento sem cartão" de uso único, pago em Bitcoin
- comprar Bitcoin gerando e vendendo esses códigos de levantamento

#### Porquê mais uma ferramenta P2P? Porquê não RoboSats, Bisq ou Hodl Hodl?

Esses serviços de escrow são ótimos para trocas maiores e de longo prazo. O {app} destina-se a um **levantamento rápido de dinheiro no multibanco** com o Bitcoin que possui. A troca costuma demorar alguns minutos.
- Os **makers** vendem Bitcoin (levantam o dinheiro no multibanco).
- Os **takers** compram Bitcoin (geram o código na sua app bancária).

#### Que bancos são suportados e como escolho um?

A Eslováquia é um único mercado (**{app}**) operado por um coordenador, cobrindo **Tatra banka, Slovenská sporiteľňa e VÚB**. O **maker escolhe o banco ao criar a oferta** — é ele que estará no multibanco desse banco, por isso o código só funciona nas máquinas dele. Os takers veem o banco de cada oferta como um crachá e só aceitam ofertas de um banco cuja app tenham.

#### Quanto tempo é válido um código? Porque varia por banco?

Cada banco define a validade de um código de levantamento sem cartão:
- **Tatra banka: 20 minutos**
- **Slovenská sporiteľňa: 15 minutos**
- **VÚB: 10–60 minutos**, definidos pelo taker ao gerar o código

O VÚB é o único banco em que a janela é escolhida pelo taker — de 10 a 60 minutos — ao gerar o código. O BitBlik não sabe que valor foi escolhido, por isso conta a partir do mínimo de 10 minutos. Peçam uma janela maior se o maker tiver mais caminho a fazer. A app mostra o tempo restante em contagem decrescente.

#### Como funciona o escrow?

1.  **Criação da oferta (Maker):** o maker cria uma oferta escolhendo o montante fiat **e o banco**.
2.  **Financiamento do escrow (Maker):** o maker paga uma "hold invoice" Lightning pelo montante em Bitcoin. Isto bloqueia o Bitcoin no coordenador sem o transferir.
3.  **Aceitação (Taker):** o taker aceita a oferta, gera um **{code} de levantamento sem cartão** na sua app bancária (para esse banco) e submete-o.
4.  **Levantamento (Maker):** o maker recebe o {code} e insere-o no **multibanco desse banco** para levantar o dinheiro, dentro da janela de validade.
5.  **Débito (Taker):** o montante é debitado da conta do taker quando o maker levanta.
6.  **Confirmação (Maker):** o maker confirma no {app} que o levantamento foi bem-sucedido.
7.  **Libertação do Bitcoin (Coordenador):** após a confirmação, o coordenador liquida a hold invoice e liberta o Bitcoin para o endereço/fatura Lightning do taker.

#### Como são os takers avisados de novas ofertas?

Os takers podem juntar-se a canais (SimpleX, Matrix, Telegram, Signal) para receber notificações. Os canais podem ser **gerais (todos os bancos)** ou **por banco** — junte-se aos canais dos bancos que consegue servir. Quando um maker financia uma oferta, o coordenador publica-a nos canais correspondentes com um link para a aceitar no {app}.

#### O que é o {code}?

O {code} é um **código de levantamento sem cartão de {codeLength} dígitos** de uso único ("výber bez karty"), gerado na app de um banco eslovaco. Permite levantar dinheiro no multibanco desse banco sem cartão. No {app}, o taker gera-o e o maker insere-o no multibanco.

#### O que são as "hold invoices" Lightning?

Uma hold invoice é uma fatura Lightning especial. Quando o maker (vendedor de Bitcoin) a paga, os fundos não são liquidados de imediato — são "retidos" pelo nó Lightning do coordenador e só libertados quando um "preimage" secreto é revelado. Se não for a tempo, ou a fatura for cancelada, os fundos voltam ao maker. É o núcleo do mecanismo de escrow do {app}.

---

### Segurança e riscos

#### Como está o meu Bitcoin protegido como Maker (vendedor)?

O seu Bitcoin está bloqueado via hold invoice. O coordenador só a liquida (liberta o Bitcoin ao taker) **depois** de você confirmar o levantamento bem-sucedido. Se o levantamento falhar, a hold invoice é cancelada e o Bitcoin volta ao seu nó.

#### Como estou protegido como Taker (comprador)?

O maker já bloqueou o seu Bitcoin numa hold invoice **antes** de você submeter o código. Quando o maker confirma o levantamento, o Bitcoin é-lhe libertado automaticamente. Há risco se um maker negar falsamente o levantamento após a sua conta ser debitada — ver "Disputas".

#### E se o código for inválido ou expirar antes de o maker levantar?

Se o maker não conseguir levantar com o código (inválido ou expirado), a troca não pode prosseguir com esse código. O maker marca-o inválido, a oferta é republicada e o taker pode submeter um novo código ou cancelar. Como o código expira depressa, combinem o timing e escolham um banco cujo multibanco o maker alcance rapidamente.

#### Quais são os riscos do protocolo?

- **Risco de contraparte:** a outra parte não agir honestamente. A hold invoice atenua-o mas não o elimina na etapa do dinheiro.
- **Confiança no coordenador:** confia que ele gere os preimages e liquida/cancela corretamente.
- **Problemas do nó LN:** o nó do coordenador (e eventualmente o seu) tem de estar online.
- **Problemas do banco:** problemas do sistema de levantamento sem cartão estão fora do {app} e resolvem-se com o seu banco.
- **Bugs de software:** como em qualquer software; é open source e auditável.
- **Privacidade:** as chaves públicas e detalhes das transações são guardados pelo coordenador. **Para mais privacidade, gere um novo par de chaves em cada transação.**

#### O coordenador é custodial?

Durante o escrow, os fundos do maker estão bloqueados numa hold invoice que o coordenador pode liquidar ou cancelar — um controlo temporário. O pagamento final ao taker é não-custodial (para a fatura dele). Ambas as partes confiam que o coordenador segue o protocolo.

#### O que motiva o Maker a ser honesto?

O maker bloqueia o Bitcoin **antes** de receber o código:
- Confirmar um levantamento bem-sucedido → o coordenador liberta o Bitcoin ao taker; o maker fica com o dinheiro.
- Negar falsamente um levantamento bem-sucedido → o taker abre uma disputa com prova bancária; se o coordenador decidir a favor do taker, a fatura é liquidada na mesma e o maker perde o Bitcoin.
- Abandonar/protelar → a hold invoice tem uma janela limitada, o maker não pode protelar indefinidamente.

#### O que motiva o Taker a ser honesto?

- Fornecer um código válido que funciona → todos satisfeitos.
- Fornecer um código inválido/expirado → o maker não consegue levantar, a troca falha, o Bitcoin é devolvido, o taker não recebe nada.
- Alegar falsamente o débito → sem prova bancária o coordenador cancela a hold invoice e devolve o Bitcoin ao maker.

Como o taker tem de fornecer provas verificáveis em disputa, não há forma viável de fraudar um maker.

> **Nota:** está planeado um sistema de caução (bond) para takers, penalizando o tempo desperdiçado do coordenador.

#### O que motiva o coordenador a ser honesto?

O coordenador publica uma chave Nostr (perfil) que os utilizadores podem etiquetar para reportar experiências. Verifique a reputação de um coordenador no Nostr (com um cliente Web-of-Trust) antes de o usar, e prefira um de confiança na sua comunidade. A escolha de um coordenador reputado é sua responsabilidade; isto não é uma plataforma nem um serviço, e não assumimos responsabilidade pelas ações dos coordenadores.

---

### Taxas e aspetos técnicos

#### Há taxas?

Cada coordenador define as suas próprias taxas de maker e taker, mostradas na app antes de criar/aceitar uma oferta.

#### Que montantes posso levantar no multibanco?

Os multibancos eslovacos dispensam notas de **10 / 20 / 50 / 100 €**, por isso o montante da oferta tem de ser componível a partir delas (ex. 30, 70, 200 — sim; 15 — não). Os montantes predefinidos do maker adaptam-se a isto. O limite do levantamento sem cartão é normalmente cerca de 500 € por levantamento.

#### E se o pagamento Lightning ao taker falhar?

Se o coordenador não conseguir pagar a fatura Lightning do taker (nó offline, sem rota), o taker fornece uma nova fatura ou corrige a sua configuração Lightning, e o pagamento é repetido.

#### Posso cancelar a minha oferta depois de a financiar mas antes de um taker a aceitar?

Sim — enquanto a oferta ainda estiver `funded` (não reservada), cancele-a e o Bitcoin volta para a sua carteira Lightning.

#### Porque é que as apps não estão na Google Play ou na App Store da Apple?

São jardins murados com guardiões corporativos que podem remover à vontade apps pró-privacidade ou de economia alternativa — um ponto único de falha e censura.

---

### Disputas

Se maker e taker discordam do resultado, a oferta entra no estado `conflict` e cada parte fornece provas que o coordenador avalia manualmente.

> ⚠️ **Importante:** cada coordenador pode ter requisitos/procedimentos de disputa diferentes — consulte a documentação dele ou contacte-o diretamente.

#### Que provas forneço como Maker?

Se o código no multibanco era inválido ou expirado: a recusa/talão do multibanco, ou uma captura/impressão da tentativa de levantamento falhada.

#### Que provas forneço como Taker?

Se o maker negar o levantamento após a sua conta ser debitada: um extrato/recibo da app bancária com a transação de levantamento sem cartão, montante e data/hora.

## Suporte

Para suporte do coordenador ou disputas, contacte o operador diretamente por DM Nostr — o perfil dele está acessível pelo link dos termos de utilização no {app}.
