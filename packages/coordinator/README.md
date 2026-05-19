# Bitblik coordinator

## External Requirements

For running a bitblik coordinator you will need a Lightning node.
Currently supported are LND or a NWC connection with `make_hold_invoice` capability.

## Setup

### 1. Copy docker-compose.example.yml to docker-compose.yml

### 2. Generate a new nostr keypair for the coordinator.

You can use any number of local tools for that, for example: :
- install `go install https://github.com/fiatjaf/nak`
- ```nak encode nsec `nak key generate` ```

Then copy the nsec to the `NOSTR_PRIVATE_KEY` field in the `docker-compose.yml`

### 3. Setup connection to your Lightning node

you have two options:
####  LND

Copy your `admin.macaroon` and `tls.cert` files from your LND.

#### NWC

generate a new NWC connection with supported permission `make_hold_invoice` and paste it to the `NWC_URI` field in the `docker-compose.yml`

### 4. Setup notifications (optional)

TODO

#### Simplex  

#### Matrix

#### Signal

How to find out signal group id:
`./signal-cli -u +XXXXXXXX sendSyncRequest`
`./signal-cli listGroups`

#### Telegram

How to find out telegram bot token & chat id:
- create bot with @BotFather
- add the bot to the group and make it admin
- send a message to your group to see the chat id in the response
- get chat id with https://api.telegram.org/bot<your-bot-token>/getUpdates

