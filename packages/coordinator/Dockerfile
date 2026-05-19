FROM dart:3.10.4-sdk AS build

WORKDIR /app

COPY . .
RUN apt-get update && apt-get install -y wget curl build-essential
RUN wget https://github.com/simplex-chat/simplex-chat/releases/download/v6.4.0/simplex-chat-ubuntu-22_04-x86-64
RUN mv simplex-chat-ubuntu-22_04-x86-64 /app/simplex-chat
RUN chmod +x /app/simplex-chat

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

RUN dart pub get

RUN dart build cli -t bin/server.dart -o bin/server

#######################################################
FROM alpine:latest

ARG APP_VERSION
ENV APP_VERSION=${APP_VERSION}

RUN apk add --no-cache zlib
RUN apk add --no-cache gmp
#RUN apk add signal-cli=0.13.22-r0
RUN apk add signal-cli~=0.14

RUN apk add --no-cache tzdata

RUN apk add --no-cache sqlite-libs libstdc++
RUN ln -s /usr/lib/libsqlite3.so.0 /usr/lib/libsqlite3.so

COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/
RUN ls -la /app/bin/
COPY --from=build /app/simplex-chat /app/

WORKDIR /app

EXPOSE 8080

CMD ["/app/bin/bundle/bin/server"]
