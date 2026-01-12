#!/usr/bin/env bash

# Script to test LSP and diagnostics in Neovim
# Usage: ./test_diagnostics.sh <filetype>

set -e

FILETYPE=${1:-puppet}
TEST_DIR="$(dirname "$0")"

case $FILETYPE in
  puppet)
    FILE="$TEST_DIR/puppet/test.pp"
    ;;
  yaml)
    FILE="$TEST_DIR/yaml/test.yaml"
    ;;
  python)
    FILE="$TEST_DIR/python/test.py"
    ;;
  terraform)
    FILE="$TEST_DIR/terraform/test.tf"
    ;;
  lua)
    FILE="$TEST_DIR/lua/test.lua"
    ;;
  *)
    echo "Unknown filetype: $FILETYPE"
    echo "Usage: $0 <puppet|yaml|python|terraform|lua>"
    exit 1
    ;;
esac

if [ ! -f "$FILE" ]; then
  echo "Error: Test file not found: $FILE"
  exit 1
fi

echo "Testing diagnostics for $FILETYPE"
echo "File: $FILE"
echo ""
echo "Opening in Neovim. Run these commands to check diagnostics:"
echo "  :LspInfo          - Check LSP servers attached"
echo "  :lua =vim.diagnostic.get(0)  - Show diagnostics for current buffer"
echo "  :NullLsInfo       - Check null-ls sources"
echo ""

nvim "$FILE"
