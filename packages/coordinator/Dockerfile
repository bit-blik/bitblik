FROM ghcr.io/gmeligio/flutter-android:3.47.0 AS build

WORKDIR /workspace

USER root

RUN apt-get update && apt-get install -y wget curl build-essential

RUN wget https://github.com/simplex-chat/simplex-chat/releases/download/v6.4.0/simplex-chat-ubuntu-22_04-x86-64 \
    && mv simplex-chat-ubuntu-22_04-x86-64 /workspace/simplex-chat \
    && chmod +x /workspace/simplex-chat

# Install Rust for the flutter user, not root
USER flutter
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/home/flutter/.cargo/bin:${PATH}"

ENV PATH="/opt/flutter/bin:${PATH}"

# Copy workspace pubspec files first for layer caching
COPY --chown=flutter:flutter pubspec.yaml pubspec.lock ./
COPY --chown=flutter:flutter packages/coordinator/pubspec.yaml packages/coordinator/pubspec.yaml
COPY --chown=flutter:flutter packages/core/pubspec.yaml packages/core/pubspec.yaml
COPY --chown=flutter:flutter packages/app/pubspec.yaml packages/app/pubspec.yaml
COPY --chown=flutter:flutter packages/cli/pubspec.yaml packages/cli/pubspec.yaml
COPY --chown=flutter:flutter packages/telegram_bot/pubspec.yaml packages/telegram_bot/pubspec.yaml

RUN flutter pub get

# Copy source for packages used by coordinator
COPY --chown=flutter:flutter packages/coordinator/ packages/coordinator/
COPY --chown=flutter:flutter packages/core/ packages/core/

WORKDIR /workspace/packages/coordinator

RUN dart build cli -t bin/server.dart -o bin/server

#######################################################
FROM dart:3.11.4-sdk AS dart-runtime

#######################################################
FROM alpine:latest

ARG APP_VERSION
ENV APP_VERSION=${APP_VERSION}

# The bundled Dart runtime loads glibc alongside Alpine's musl. Bound glibc's
# native arenas so transient NDK/Rust allocations are returned instead of
# accumulating across the coordinator's long-running relay workloads.
ENV MALLOC_ARENA_MAX=2 \
    MALLOC_TRIM_THRESHOLD_=65536

RUN apk add --no-cache zlib gmp tzdata sqlite-libs libstdc++
RUN ln -s /usr/lib/libsqlite3.so.0 /usr/lib/libsqlite3.so
RUN apk add signal-cli~=0.14

COPY --from=dart-runtime /runtime/ /
COPY --from=build /workspace/packages/coordinator/bin/server /app/bin/
COPY --from=build /workspace/simplex-chat /app/
COPY --from=build /workspace/packages/core/lib/flows/*.yml /app/flows/
ENV FLOW_DIR=/app/flows

RUN ls -la /app/bin/

WORKDIR /app

EXPOSE 8080

CMD ["/app/bin/bundle/bin/server"]
