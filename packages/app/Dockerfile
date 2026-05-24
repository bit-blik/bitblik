# Build context: repo root (required for Dart workspace resolution)
# Stage 1: Build the Flutter web application
FROM instrumentisto/flutter:3.41.6 AS build

ARG BUILD_MODE=release

WORKDIR /workspace

# Copy workspace pubspec files first for layer caching
COPY pubspec.yaml pubspec.lock ./
COPY packages/app/pubspec.yaml packages/app/pubspec.yaml
COPY packages/core/pubspec.yaml packages/core/pubspec.yaml
COPY packages/cli/pubspec.yaml packages/cli/pubspec.yaml
COPY packages/coordinator/pubspec.yaml packages/coordinator/pubspec.yaml

RUN flutter pub get

# Copy source for packages used by app
COPY packages/app/ packages/app/
COPY packages/core/ packages/core/

WORKDIR /workspace/packages/app

RUN flutter config --enable-web

RUN flutter build web --${BUILD_MODE} --no-web-resources-cdn
#--wasm

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
