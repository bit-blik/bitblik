#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

# Tested with libprotoc 29.3 and protoc_plugin 22.0.1. error_details.proto is
# only there so protoc can resolve lndkrpc.proto's (unused) import.
protoc \
  --proto_path=protos/lndk \
  --dart_out=grpc:lib/src/generated/lndk \
  protos/lndk/lndkrpc.proto
