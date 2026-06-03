# Build context: repo root (required for Dart workspace resolution)
# Flutter image needed: workspace includes Flutter packages, dart pub get alone can't resolve them
FROM instrumentisto/flutter:3.41.6 AS build

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

# simplex-chat is a glibc (ubuntu-22.04 / glibc 2.35) binary; glibc 2.35 ships a
# built-in C.UTF-8 locale needing no locale files, so this works on musl/alpine.
# Without a UTF-8 locale it fails to encode non-ASCII output (e.g. the "•"
# separator) with: commitBuffer: invalid argument (cannot encode character ...)
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN apk add --no-cache zlib gmp tzdata sqlite-libs libstdc++
RUN ln -s /usr/lib/libsqlite3.so.0 /usr/lib/libsqlite3.so
RUN apk add signal-cli~=0.14

COPY --from=dart-runtime /runtime/ /
COPY --from=build /workspace/packages/coordinator/bin/server /app/bin/
COPY --from=build /workspace/simplex-chat /app/

RUN ls -la /app/bin/

WORKDIR /app

EXPOSE 8080

CMD ["/app/bin/bundle/bin/server"]
