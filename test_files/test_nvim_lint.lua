-- Test script to verify nvim-lint is working with puppet-lint
-- Run: nvim --headless -S test_files/test_nvim_lint.lua test_files/puppet/test.pp

-- Open the puppet file
local file = vim.fn.argv()[0]
if not file or file == "" then
  print("ERROR: No file specified")
  vim.cmd('quitall!')
  return
end
vim.cmd('edit ' .. file)

-- Wait for linting to complete
vim.defer_fn(function()
  print("\n=== nvim-lint Test Results ===")

  -- Check if nvim-lint is loaded
  local ok, lint = pcall(require, "lint")
  if not ok then
    print("ERROR: nvim-lint not loaded")
    vim.cmd('quitall!')
    return
  end

  print("✓ nvim-lint loaded")

  -- Check configured linters for puppet
  local puppet_linters = lint.linters_by_ft["puppet"]
  if puppet_linters then
    print("✓ Puppet linters configured: " .. vim.inspect(puppet_linters))
  else
    print("✗ No linters configured for puppet filetype")
  end

  -- Check current buffer filetype
  print("✓ Current filetype: " .. vim.bo.filetype)

  -- Wait a bit more for diagnostics to populate
  vim.defer_fn(function()
    -- Get diagnostics
    local diagnostics = vim.diagnostic.get(0)
    print("\nDiagnostics found: " .. #diagnostics)

    if #diagnostics > 0 then
      print("\n✓ SUCCESS: puppet-lint is working!\n")
      for i, diag in ipairs(diagnostics) do
        local severity = diag.severity == 1 and "ERROR" or "WARN"
        print(string.format("  [%s] line %d: %s", severity, diag.lnum + 1, diag.message))
      end
    else
      print("\n✗ ISSUE: No diagnostics found")
      print("Expected to find multiple warnings/errors in test file")
    end

    print("\n==============================\n")
    vim.cmd('quitall!')
  end, 2000)
end, 2000)
