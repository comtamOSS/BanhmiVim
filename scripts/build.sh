#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

TARGET_DIR="$PROJECT_ROOT/dist/banhmivim"
BUNDLE_CONFIG="$TARGET_DIR/config"
BIN_DIR="$TARGET_DIR/bin"
LSP_DIR="$TARGET_DIR/lsp"
CACHE_DIR="$PROJECT_ROOT/.bmcache"

TS_CLI_VERSION="0.26.11"
TS_CLI_URL="https://github.com/tree-sitter/tree-sitter/releases/download/v${TS_CLI_VERSION}/tree-sitter-linux-x64.gz"
TS_CLI_GZ_NAME="tree-sitter-linux-x64-v${TS_CLI_VERSION}.gz"

echo "Creating bundle structure at: $TARGET_DIR"
mkdir -p "$BUNDLE_CONFIG" "$BIN_DIR" "$CACHE_DIR"

cp -r "$PROJECT_ROOT/banhmivim/config/"* "$BUNDLE_CONFIG/"
cp "$PROJECT_ROOT/banhmivim/bin/banhmivim" "$BIN_DIR/"

echo "--- Processing Tree-sitter CLI (v${TS_CLI_VERSION}) ---"
if [ ! -f "$CACHE_DIR/$TS_CLI_GZ_NAME" ]; then
    echo "Cache miss: Downloading Tree-sitter CLI..."
    curl -L "$TS_CLI_URL" -o "$CACHE_DIR/$TS_CLI_GZ_NAME"
else
    echo "Cache hit: Using cached Tree-sitter CLI archive."
fi

echo "Extracting Tree-sitter CLI to bundle..."
gzip -dc "$CACHE_DIR/$TS_CLI_GZ_NAME" > "$BIN_DIR/tree-sitter"
chmod +x "$BIN_DIR/tree-sitter"
