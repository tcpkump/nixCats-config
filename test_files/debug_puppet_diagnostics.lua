-- Debug script to check puppet-lint diagnostics configuration with nvim-lint
-- Run in Neovim with: :luafile test_files/debug_puppet_diagnostics.lua

print("=== Puppet Diagnostics Debug (nvim-lint) ===\n")

-- Check filetype
print("1. Current filetype: " .. vim.bo.filetype)

-- Check if nvim-lint is loaded
local ok, lint = pcall(require, "lint")
if ok then
  print("2. nvim-lint loaded: YES")

  -- Get configured linters for current filetype
  local linters = lint.linters_by_ft[vim.bo.filetype]
  print("3. Configured linters for current filetype:")
  if linters then
    for _, linter in ipairs(linters) do
      print("   - " .. linter)
    end
  else
    print("   NONE - No linters configured for this filetype!")
  end

  -- Check all registered linters
  print("\n4. All configured linters:")
  for ft, linter_list in pairs(lint.linters_by_ft) do
    print(string.format("   - %s: %s", ft, table.concat(linter_list, ", ")))
  end
else
  print("2. nvim-lint loaded: NO - " .. tostring(lint))
end

-- Check if none-ls is also loaded (for other linters)
local ok_null_ls, null_ls = pcall(require, "null-ls")
if ok_null_ls then
  print("\n5. none-ls loaded: YES (for other linters)")
  local sources = require("null-ls.sources")
  local all_sources = sources.get_all()
  if #all_sources > 0 then
    print("   Active none-ls sources:")
    for _, source in ipairs(all_sources) do
      local fts = source.filetypes or {}
      print(string.format("   - %s (filetypes: %s)", source.name, table.concat(fts, ", ")))
    end
  end
else
  print("\n5. none-ls loaded: NO")
end

-- Check LSP clients
print("\n6. LSP clients attached:")
local clients = vim.lsp.get_clients({ bufnr = 0 })
if #clients > 0 then
  for _, client in ipairs(clients) do
    print("   - " .. client.name)
  end
else
  print("   NONE")
end

-- Check diagnostics
print("\n7. Current diagnostics:")
local diagnostics = vim.diagnostic.get(0)
if #diagnostics > 0 then
  for i, diag in ipairs(diagnostics) do
    local severity = diag.severity == 1 and "ERROR" or "WARN"
    print(string.format("   [%s] line %d: %s (source: %s)", severity, diag.lnum + 1, diag.message, diag.source or "unknown"))
  end
else
  print("   NONE - Try running :lua require('lint').try_lint()")
end

-- Check if puppet-lint is in PATH
print("\n8. puppet-lint executable:")
local handle = io.popen("which puppet-lint 2>&1")
if handle then
  local result = handle:read("*a")
  handle:close()
  print("   " .. result:gsub("\n$", ""))
else
  print("   Could not check")
end

print("\n=== End Debug ===")
print("\nTo manually trigger linting: :lua require('lint').try_lint()")
