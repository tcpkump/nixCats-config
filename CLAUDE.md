# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A declarative Neovim configuration using the [nixCats](https://github.com/BirdeeHub/nixCats-nvim) framework. All plugins, LSPs, formatters, and linters are declared in `flake.nix` and packaged by Nix. The Lua configuration lives under `lua/tcpkump/`.

## Commands

```bash
nix build          # Build the Neovim package (produces ./result symlink)
nix run .#nvim     # Run Neovim directly without installing
nix develop        # Enter dev shell with the built nvim on PATH
```

Lua code is formatted with `stylua` (2-space indent, configured in `.stylua.toml`).

After making changes, validate with:

```bash
nix flake check    # Validates flake schema and runs any Nix checks
nix build          # Full build; catches eval errors and missing packages
```

For lint/diagnostic config changes, `test_nvim_lint.lua` can be run headlessly:

```bash
nvim --headless -S test_files/test_nvim_lint.lua test_files/puppet/test.pp
```

It prints pass/fail results to stdout and exits. The remaining test helpers (`test_diagnostics.sh`, `:LspInfo`, `:lua vim.diagnostic.get(0)`) require an interactive Neovim session and can only be used by a human.

## Architecture

### Two-layer design

1. **Nix layer (`flake.nix`)** — declares everything that comes from the outside world: plugins, LSPs, formatters, linters. Organized into named categories (`general`, `gitPlugins`, `neoTree`, `snacks`, `yaml`) which are toggled on/off per package in `packageDefinitions`.

2. **Lua layer (`lua/tcpkump/`)** — configures those plugins. The entry point is `lua/tcpkump/init.lua`, which loads options, keymaps, filetypes, and then all plugin modules.

### Plugin loading model

- **`startupPlugins`** in `flake.nix` → automatically available at startup, configured in `lua/tcpkump/plugins/` via direct `require()` calls in `plugins/init.lua`.
- **`optionalPlugins`** in `flake.nix` → must be explicitly loaded. These are registered with `lze` (lazy loader) via `require("lze").load({...})` at the bottom of `plugins/init.lua`.

### Adding a plugin

1. Add it to the appropriate category in `categoryDefinitions` inside `flake.nix` (`startupPlugins` or `optionalPlugins`).
2. Create a config file in `lua/tcpkump/plugins/`.
3. Register it: either `require("tcpkump.plugins.yourplugin")` (eager) or `{ import = "tcpkump.plugins.yourplugin" }` in the `lze.load` block (lazy).
4. Run `nix flake check && nix build` to validate and rebuild.

### nixCats runtime API

Inside Lua, use `nixCats("categoryName")` to check if a category is enabled. This allows conditional logic without hardcoding capability checks.

### Key configuration files

| File | Purpose |
|---|---|
| `flake.nix` | All external dependencies; single source of truth for what's installed |
| `lua/tcpkump/options.lua` | Vim options, leader keys (`<space>` / `,`), colorscheme (kanagawa) |
| `lua/tcpkump/keymaps.lua` | Global keymaps, clipboard ops, diagnostic navigation, Terraform shortcuts |
| `lua/tcpkump/filetypes.lua` | Custom filetype detection (Terraform, Ansible YAML patterns) |
| `lua/tcpkump/plugins/lsp.lua` | All LSP server configs with custom YAML schemas (GitHub Actions, Ansible, k8s, etc.) |
| `lua/tcpkump/plugins/format.lua` | conform.nvim formatter mappings per filetype |
| `lua/tcpkump/plugins/nvim_lint.lua` | nvim-lint linter mappings (puppet-lint, ansible-lint, tflint) |

### Keymaps documentation

`KEYMAPS.md` contains a full cheat sheet of custom and plugin keybindings. When adding or changing keymaps (in `lua/tcpkump/keymaps.lua` or any plugin config), keep `KEYMAPS.md` updated to reflect the change.

### Language support

Python, Go, Lua, Nix, Bash, C/C++, Docker, JSON, YAML, Helm, Terraform/HCL, Ansible, Puppet.

### System integration

The flake exports `nixosModules.default` and `homeModules.default` so the config can be consumed from a NixOS or home-manager configuration, and `overlays` for use as a nixpkgs overlay.
