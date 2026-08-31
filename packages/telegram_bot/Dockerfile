FROM ghcr.io/gmeligio/flutter-android:3.47.0 AS build

WORKDIR /workspace

USER root
RUN apt-get update && apt-get install -y curl build-essential
USER flutter
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/home/flutter/.cargo/bin:/opt/flutter/bin:${PATH}"

COPY --chown=flutter:flutter pubspec.yaml pubspec.lock ./
COPY --chown=flutter:flutter packages/app/pubspec.yaml packages/app/pubspec.yaml
COPY --chown=flutter:flutter packages/cli/pubspec.yaml packages/cli/pubspec.yaml
COPY --chown=flutter:flutter packages/coordinator/pubspec.yaml packages/coordinator/pubspec.yaml
COPY --chown=flutter:flutter packages/core/pubspec.yaml packages/core/pubspec.yaml
COPY --chown=flutter:flutter packages/telegram_bot/pubspec.yaml packages/telegram_bot/pubspec.yaml
RUN flutter pub get

COPY --chown=flutter:flutter packages/core/ packages/core/
COPY --chown=flutter:flutter packages/telegram_bot/ packages/telegram_bot/
WORKDIR /workspace/packages/telegram_bot
RUN dart build cli -t bin/server.dart -o bin/server

FROM dart:3.11.4-sdk AS dart-runtime

FROM alpine:latest
RUN apk add --no-cache ca-certificates zlib gmp tzdata libstdc++ \
    && mkdir -p /data \
    && chmod 0777 /data
COPY --from=dart-runtime /runtime/ /
COPY --from=build /workspace/packages/telegram_bot/bin/server /app/
WORKDIR /app
VOLUME ["/data"]
CMD ["/app/bundle/bin/server"]
