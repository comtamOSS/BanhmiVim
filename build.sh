#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="$(pwd)/dist/banhmivim"
BUNDLE_CONFIG="$TARGET_DIR/config"
BIN_DIR="$TARGET_DIR/bin"

echo "Creating bundle structure at: $TARGET_DIR"
mkdir -p "$BUNDLE_CONFIG" "$BIN_DIR"

cp -r ./banhmivim/config/* "$BUNDLE_CONFIG/"

ZIG_VERSION="0.16.0"
ZIG_URL="https://ziglang.org/download/${ZIG_VERSION}/zig-x86_64-linux-${ZIG_VERSION}.tar.xz"

echo "Downloading Zig Compiler..."
mkdir -p "$BIN_DIR/zig"
curl -L "$ZIG_URL" | tar -xJ --strip-components=1 -C "$BIN_DIR/zig"

# Add downloaded binaries temporarily to PATH so Neovim/Tree-sitter can see 'zig'
# export PATH="$BIN_DIR:$PATH"

LUA_LSP_VERSION="3.13.6"
LUA_LSP_URL="https://github.com/LuaLS/lua-language-server/releases/download/${LUA_LSP_VERSION}/lua-language-server-${LUA_LSP_VERSION}-linux-x64.tar.gz"

echo "Downloading Lua Language Server..."
mkdir -p "$BIN_DIR/lua-language-server"
curl -L "$LUA_LSP_URL" | tar -xz -C "$BIN_DIR/lua-language-server"

# Create a symlink or a wrapper in bin so it's globally executable inside the bundle
# ln -s "$BIN_DIR/lua-language-server/bin/lua-language-server" "$BIN_DIR/lua-language-server-binary"

# 4. Bootstrap and Download Tree-sitter Parsers
# We fake the environment variables so Neovim compiles them directly into the bundle config layout.
# export NVIM_APPNAME="banhmivim"
# export XDG_CONFIG_HOME="$BUNDLE_CONFIG"
# export XDG_DATA_HOME="$TARGET_DIR/.banhmivim/data"
# export XDG_STATE_HOME="$TARGET_DIR/.banhmivim/state"
# export XDG_CACHE_HOME="$TARGET_DIR/.banhmivim/cache"
#
# echo "Headlessly installing Tree-sitter parsers..."
# # Runs nvim headlessly, executes the TSUpdate Sync command, and quits
# nvim --headless "+TSUpdateSync" +qa
#
# echo "Bundle successfully built!"
