#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

# Tested with libprotoc 3.21.12 and protoc_plugin 22.0.1.
protoc \
  --proto_path=protos/ldk_server \
  --dart_out=grpc:lib/src/generated/ldk_server \
  protos/ldk_server/api.proto \
  protos/ldk_server/error.proto \
  protos/ldk_server/events.proto \
  protos/ldk_server/types.proto
