# Test Files for LSP and Linting Configuration

This directory contains test files for various languages to verify that LSP servers, formatters, and linters are properly configured.

Each subdirectory contains files with intentional issues to trigger diagnostics and verify the tooling is working correctly.

## Usage

Open files in Neovim and check for:
- LSP attachment (`:LspInfo`)
- Diagnostic warnings/errors appearing
- Code actions available
- Formatting working

## Directories

- `puppet/` - Puppet manifests (.pp files) - Uses **nvim-lint** for puppet-lint diagnostics
- `yaml/` - YAML files
- `python/` - Python scripts
- `terraform/` - Terraform configurations
- `lua/` - Lua scripts

## Testing Puppet-Lint

Puppet-lint diagnostics are handled by **nvim-lint** (not none-ls) to avoid stderr parsing issues with Ruby/Bundler warnings.

### Quick Test

```bash
# Open the test file
nvim test_files/puppet/test.pp

# In Neovim, check diagnostics are appearing
:lua =vim.diagnostic.get(0)

# Manually trigger linting
:lua require('lint').try_lint()

# Or use the debug script
:luafile test_files/debug_puppet_diagnostics.lua
```

### Expected Issues in test.pp

The test file contains intentional issues:
- Line 4: Line too long (> 140 chars)
- Line 13: Missing trailing comma
- Line 17: Variable not enclosed in braces
- Line 20: Double quoted string (should be single quotes)
- Line 23: Hard tab character
- Line 3: Class not documented
- Line 3: Autoloader layout error

## Debug Scripts

- `debug_puppet_diagnostics.lua` - Check nvim-lint configuration for puppet
- `test_diagnostics.sh` - Interactive script to test any filetype
- `test_nvim_lint.lua` - Automated test for nvim-lint
