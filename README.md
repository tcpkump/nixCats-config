# nixCats Neovim Configuration

This is my personal Neovim configuration built with [nixCats](https://github.com/BirdeeHub/nixCats-nvim) - a Nix-based system for creating reproducible, declarative Neovim distributions.

## What is nixCats?

nixCats allows you to define your entire Neovim setup (plugins, LSPs, tools, configurations) in Nix, ensuring a fully reproducible development environment across machines.

## Usage

Build the configuration:
```bash
nix build
```

Run Neovim:
```bash
nix run .#nvim
```

Enter development shell:
```bash
nix develop
```

## Structure

- `flake.nix` - Main configuration defining plugins, LSPs, and build targets
- `init.lua` - Neovim entry point
- `lsp/` - LSP server configurations
- `lua/tcpkump/` - Custom Lua configuration modules