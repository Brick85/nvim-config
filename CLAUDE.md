# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration using **lazy.nvim** as the plugin manager. The config namespace is `qwe`. Primarily used for Python/Django development.

## Structure

- `init.lua` → loads `require("qwe")`
- `lua/qwe/init.lua` → loads `remap`, `set`, `scripts`, `lazy_init` in order
- `lua/qwe/lazy_init.lua` → bootstraps lazy.nvim, loads plugins from `lua/plugins/`
- `lua/plugins/` → active plugin configurations (each file returns a lazy.nvim spec)
- `lua/disabled_plugins/` → plugin configs moved here to disable them
- `lua/plugins-add/` → custom extensions (e.g., telescope multigrep)
- `lua/snippets.lua` → LuaSnip snippet definitions
- `plugin/floaterminal.lua` → custom floating terminal implementation

## Key Patterns

**Local config system:** `lua/qwe/localconf.lua` loads machine-specific settings from `$HOME/.dotfiles/nvim.lua` or `/app/.nvim.lua`. This drives which LSP servers are installed, which formatters are enabled, and whether DAP/tailwind-sorter are active. Plugin configs reference `localconf` fields like `ensure_installed.lsp`, `ensure_installed.null`, and `plugins.enable_dap`.

**LSP setup:** `lua/plugins/lsp.lua` uses mason + mason-lspconfig + none-ls. Servers are configured via `vim.lsp.config()` (Nvim 0.10+ API). Format-on-save is enabled by default and toggled with `<leader><F3>`. `lua_ls` has a custom setup for the vim API workspace library.

**Leader key:** `<Space>`

**Plugin config convention:** Each file in `lua/plugins/` returns a table with the lazy.nvim plugin spec. To disable a plugin, move its file to `lua/disabled_plugins/`.

## When Editing

- Follow the existing pattern of one plugin spec per file in `lua/plugins/`
- Use `localconf` for anything that varies between machines rather than hardcoding
- Keybindings go in `lua/qwe/remap.lua` for global mappings, or in the plugin's `config` function for plugin-specific ones (attached via `LspAttach` autocmd for LSP bindings)
- Autocommands go in `lua/qwe/scripts.lua`
- Editor options go in `lua/qwe/set.lua`

## TODO Items

1. Add custom snippets for scss, django templates
2. Consider using conform.nvim (formatter) instead of none-ls
3. Consider migrating from nvim-cmp to blink.cmp
