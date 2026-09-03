# Build context: repo root (required for Dart workspace resolution)
# Stage 1: Build the Flutter web application
FROM ghcr.io/gmeligio/flutter-android:3.47.0 AS build

ARG APP_FLAVOR=bitblik
ARG BUILD_MODE=release
ARG FLUTTER_TARGET=lib/main_bitblik.dart

USER root
RUN apt-get update && apt-get install -y ca-certificates

USER flutter
ENV PATH="/opt/flutter/bin:${PATH}"

WORKDIR /workspace

# Copy workspace pubspec files first for layer caching
COPY --chown=flutter:flutter pubspec.yaml pubspec.lock ./
COPY --chown=flutter:flutter packages/app/pubspec.yaml packages/app/pubspec.yaml
COPY --chown=flutter:flutter packages/core/pubspec.yaml packages/core/pubspec.yaml
COPY --chown=flutter:flutter packages/cli/pubspec.yaml packages/cli/pubspec.yaml
COPY --chown=flutter:flutter packages/coordinator/pubspec.yaml packages/coordinator/pubspec.yaml
COPY --chown=flutter:flutter packages/telegram_bot/pubspec.yaml packages/telegram_bot/pubspec.yaml

RUN flutter pub get

# Copy source for packages used by app
COPY --chown=flutter:flutter packages/app/ packages/app/
COPY --chown=flutter:flutter packages/core/ packages/core/

WORKDIR /workspace/packages/app

RUN flutter config --enable-web

RUN cp web_shells/${APP_FLAVOR}/index.html web/index.html \
 && cp web_shells/${APP_FLAVOR}/manifest.json web/manifest.json \
 && cp web_shells/${APP_FLAVOR}/favicon.png web/favicon.png \
 && ([ -f web_shells/${APP_FLAVOR}/bitway-icon.png ] && cp web_shells/${APP_FLAVOR}/bitway-icon.png web/bitway-icon.png || true) \
 && ([ -f web_shells/${APP_FLAVOR}/bitblik-icon.png ] && cp web_shells/${APP_FLAVOR}/bitblik-icon.png web/bitblik-icon.png || true) \
 && ([ -f web_shells/${APP_FLAVOR}/bittwint-icon.png ] && cp web_shells/${APP_FLAVOR}/bittwint-icon.png web/bittwint-icon.png || true) \
 && cp web_shells/${APP_FLAVOR}/icons/Icon-192.png web/icons/Icon-192.png \
 && cp web_shells/${APP_FLAVOR}/icons/Icon-512.png web/icons/Icon-512.png \
 && cp web_shells/${APP_FLAVOR}/icons/Icon-maskable-192.png web/icons/Icon-maskable-192.png \
 && cp web_shells/${APP_FLAVOR}/icons/Icon-maskable-512.png web/icons/Icon-maskable-512.png \
 && cp web_shells/${APP_FLAVOR}/splash/img/light-1x.png web/splash/img/light-1x.png \
 && cp web_shells/${APP_FLAVOR}/splash/img/light-2x.png web/splash/img/light-2x.png \
 && cp web_shells/${APP_FLAVOR}/splash/img/light-3x.png web/splash/img/light-3x.png \
 && cp web_shells/${APP_FLAVOR}/splash/img/light-4x.png web/splash/img/light-4x.png \
 && cp web_shells/${APP_FLAVOR}/splash/img/dark-1x.png web/splash/img/dark-1x.png \
 && cp web_shells/${APP_FLAVOR}/splash/img/dark-2x.png web/splash/img/dark-2x.png \
 && cp web_shells/${APP_FLAVOR}/splash/img/dark-3x.png web/splash/img/dark-3x.png \
 && cp web_shells/${APP_FLAVOR}/splash/img/dark-4x.png web/splash/img/dark-4x.png \
 && flutter build web --${BUILD_MODE} --target=${FLUTTER_TARGET} --no-web-resources-cdn

# Stage 2: Serve via Nginx
FROM nginx:stable-alpine

COPY --from=build /workspace/packages/app/build/web /usr/share/nginx/html
COPY --from=build /workspace/packages/app/web/config.js /usr/share/nginx/html/config.js

COPY packages/app/nginx.conf /etc/nginx/conf.d/default.conf
COPY packages/app/robots.txt /usr/share/nginx/html/robots.txt
COPY packages/app/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/docker-entrypoint.sh"]
