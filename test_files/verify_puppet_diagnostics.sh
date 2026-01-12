#!/usr/bin/env bash

# Automated test for puppet-lint diagnostics in Neovim
# This script will open the test puppet file and check if diagnostics appear

set -e

TEST_FILE="$(dirname "$0")/puppet/test.pp"
LOG_FILE="/tmp/puppet_diagnostics_test.log"

echo "Testing puppet-lint diagnostics in Neovim..."
echo ""

# Test 1: Verify puppet-lint works standalone
echo "Test 1: Checking puppet-lint standalone..."
# puppet-lint is only available in the nvim PATH, so we'll test via nvim
PUPPET_LINT_TEST=$(nvim --headless -c "lua vim.fn.system('puppet-lint --json $TEST_FILE 2>&1')" -c "lua print(vim.v.shell_error)" -c "quit" 2>&1 | tail -1)
if [ "$PUPPET_LINT_TEST" = "1" ] || [ "$PUPPET_LINT_TEST" = "0" ]; then
  echo "  ✓ puppet-lint is available and runs"
else
  echo "  ⚠ puppet-lint status unclear (continuing anyway)"
fi

# Test 2: Check filetype detection
echo "Test 2: Checking filetype detection..."
FILETYPE=$(nvim --headless -c "edit $TEST_FILE" -c "lua print(vim.bo.filetype)" -c "quit" 2>&1 | grep -v "^$")
if [ "$FILETYPE" = "puppet" ]; then
  echo "  ✓ Filetype detected as 'puppet'"
else
  echo "  ✗ Filetype detected as '$FILETYPE' (expected 'puppet')"
  exit 1
fi

# Test 3: Check if null-ls attaches and provides diagnostics
echo "Test 3: Checking null-ls diagnostics in Neovim..."
cat > /tmp/test_puppet_nvim.lua << 'EOF'
-- Open file and wait for LSP/diagnostics
vim.cmd('edit ' .. vim.fn.argv()[0])

-- Wait a bit for LSP to attach
vim.defer_fn(function()
  local log = io.open('/tmp/puppet_diagnostics_test.log', 'w')

  -- Check LSP clients
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  log:write("LSP Clients attached: " .. #clients .. "\n")
  for _, client in ipairs(clients) do
    log:write("  - " .. client.name .. "\n")
  end

  -- Check for null-ls
  local has_null_ls = false
  for _, client in ipairs(clients) do
    if client.name == "null-ls" then
      has_null_ls = true
      break
    end
  end
  log:write("\nnull-ls attached: " .. tostring(has_null_ls) .. "\n")

  -- Check diagnostics
  local diagnostics = vim.diagnostic.get(0)
  log:write("\nDiagnostics count: " .. #diagnostics .. "\n")
  for i, diag in ipairs(diagnostics) do
    log:write(string.format("  [%d] line %d, col %d: %s\n",
      i, diag.lnum + 1, diag.col + 1, diag.message))
  end

  log:close()
  vim.cmd('quitall!')
end, 3000)  -- Wait 3 seconds for everything to initialize
EOF

nvim --headless -S /tmp/test_puppet_nvim.lua "$TEST_FILE" 2>&1 >/dev/null &
NVIM_PID=$!

# Wait for nvim to finish (with timeout)
for i in {1..10}; do
  if ! kill -0 $NVIM_PID 2>/dev/null; then
    break
  fi
  sleep 1
done

# Kill nvim if still running
if kill -0 $NVIM_PID 2>/dev/null; then
  kill $NVIM_PID 2>/dev/null || true
fi

# Check results
if [ -f "$LOG_FILE" ]; then
  echo ""
  echo "=== Test Results ==="
  cat "$LOG_FILE"
  echo "===================="
  echo ""

  # Check if diagnostics were found
  DIAG_COUNT=$(grep "Diagnostics count:" "$LOG_FILE" | awk '{print $3}')
  NULL_LS_ATTACHED=$(grep "null-ls attached:" "$LOG_FILE" | awk '{print $3}')

  if [ "$NULL_LS_ATTACHED" = "true" ]; then
    echo "  ✓ null-ls attached successfully"
  else
    echo "  ✗ null-ls did not attach"
  fi

  if [ "$DIAG_COUNT" -gt 0 ] 2>/dev/null; then
    echo "  ✓ Diagnostics found: $DIAG_COUNT"
  else
    echo "  ✗ No diagnostics found (expected several)"
  fi

  rm "$LOG_FILE"
else
  echo "  ✗ Test did not complete (log file not created)"
  exit 1
fi

echo ""
echo "Manual testing:"
echo "  Run: nvim $TEST_FILE"
echo "  Then: :NullLsInfo"
echo "  Then: :lua =vim.diagnostic.get(0)"
