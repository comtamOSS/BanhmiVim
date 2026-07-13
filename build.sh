#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="$(pwd)/dist/banhmivim"
BUNDLE_CONFIG="$TARGET_DIR/config"
BIN_DIR="$TARGET_DIR/bin"
LSP_DIR="$TARGET_DIR/lsp"
CACHE_DIR="$(pwd)/.bmcache"

ZIG_VERSION="0.16.0"
ZIG_URL="https://ziglang.org/download/${ZIG_VERSION}/zig-x86_64-linux-${ZIG_VERSION}.tar.xz"
ZIG_TAR_NAME="zig-linux-x86_64-${ZIG_VERSION}.tar.xz"

LUA_LSP_VERSION="3.13.6"
LUA_LSP_URL="https://github.com/LuaLS/lua-language-server/releases/download/${LUA_LSP_VERSION}/lua-language-server-${LUA_LSP_VERSION}-linux-x64.tar.gz"
LUA_LSP_TAR_NAME="lua-language-server-${LUA_LSP_VERSION}-linux-x64.tar.gz"


TS_CLI_VERSION="0.26.11"
TS_CLI_URL="https://github.com/tree-sitter/tree-sitter/releases/download/v${TS_CLI_VERSION}/tree-sitter-linux-x64.gz"
TS_CLI_GZ_NAME="tree-sitter-linux-x64-v${TS_CLI_VERSION}.gz"

echo "Creating bundle structure at: $TARGET_DIR"
mkdir -p "$BUNDLE_CONFIG" "$BIN_DIR" "$CACHE_DIR"

cp -r ./banhmivim/config/* "$BUNDLE_CONFIG/"

echo "--- Processing Zig Compiler (v${ZIG_VERSION}) ---"
mkdir -p "$BIN_DIR/zig"

if [ ! -f "$CACHE_DIR/$ZIG_TAR_NAME" ]; then
    echo "Cache miss: Downloading Zig..."
    curl -L "$ZIG_URL" -o "$CACHE_DIR/$ZIG_TAR_NAME"
else
    echo "Cache hit: Using cached Zig archive."
fi

echo "Extracting Zig to bundle..."
tar -xJ --strip-components=1 -C "$BIN_DIR/zig" -f "$CACHE_DIR/$ZIG_TAR_NAME"

echo "--- Processing Lua Language Server (v${LUA_LSP_VERSION}) ---"
mkdir -p "$LSP_DIR/lua-language-server"

if [ ! -f "$CACHE_DIR/$LUA_LSP_TAR_NAME" ]; then
    echo "Cache miss: Downloading Lua LS..."
    curl -L "$LUA_LSP_URL" -o "$CACHE_DIR/$LUA_LSP_TAR_NAME"
else
    echo "Cache hit: Using cached Lua LS archive."
fi

echo "Extracting Lua LS to bundle..."
tar -xz -C "$LSP_DIR/lua-language-server" -f "$CACHE_DIR/$LUA_LSP_TAR_NAME"


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

# ==========================================
# 3. Bootstrap and Download Tree-sitter Parsers
# ==========================================
# echo "--- Bootstrapping Tree-sitter Parsers ---"
# export NVIM_APPNAME="banhmivim"
# export XDG_CONFIG_HOME="$BUNDLE_CONFIG"
# export XDG_DATA_HOME="$TARGET_DIR/.banhmivim/data"
# export XDG_STATE_HOME="$TARGET_DIR/.banhmivim/state"
# export XDG_CACHE_HOME="$TARGET_DIR/.banhmivim/cache"
#
# echo "Headlessly installing Tree-sitter parsers..."
# nvim --headless "+TSUpdateSync" +qa
#
# echo "Bundle successfully built!"
