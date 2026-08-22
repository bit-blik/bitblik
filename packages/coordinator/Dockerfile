# Build context: repo root (required for Dart workspace resolution)
# Flutter image needed: workspace includes Flutter packages, dart pub get alone can't resolve them
#FROM instrumentisto/flutter:3.41.6 AS build
#FROM ghcr.io/cirruslabs/flutter:3.44.0 AS build
FROM ghcr.io/gmeligio/flutter-android:3.47.0 AS build


WORKDIR /workspace

RUN apt-get update && apt-get install -y wget curl build-essential

RUN wget https://github.com/simplex-chat/simplex-chat/releases/download/v6.4.0/simplex-chat-ubuntu-22_04-x86-64 \
    && mv simplex-chat-ubuntu-22_04-x86-64 /workspace/simplex-chat \
    && chmod +x /workspace/simplex-chat

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Copy workspace pubspec files first for layer caching
COPY pubspec.yaml pubspec.lock ./
COPY packages/coordinator/pubspec.yaml packages/coordinator/pubspec.yaml
COPY packages/core/pubspec.yaml packages/core/pubspec.yaml
COPY packages/app/pubspec.yaml packages/app/pubspec.yaml
COPY packages/cli/pubspec.yaml packages/cli/pubspec.yaml

RUN flutter pub get

# Copy source for packages used by coordinator
COPY packages/coordinator/ packages/coordinator/
COPY packages/core/ packages/core/

WORKDIR /workspace/packages/coordinator

RUN dart build cli -t bin/server.dart -o bin/server

#######################################################
FROM dart:3.11.4-sdk AS dart-runtime

#######################################################
FROM alpine:latest

ARG APP_VERSION
ENV APP_VERSION=${APP_VERSION}

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
