vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- General
vim.opt.updatetime = 100 -- Faster update time for plugins like git-signs
vim.opt.spell = false -- Disable spellcheck
vim.opt.conceallevel = 1 -- Hide some markdown syntax for better readability
vim.opt.wrap = false -- Do not wrap lines
vim.opt.swapfile = false -- Do not create a swapfile
vim.opt.undofile = true -- Persist undo history

-- Numbers and text formatting
vim.opt.number = true -- Show line numbers
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of (auto)indent
vim.opt.tabstop = 2 -- Number of spaces that a <Tab> in the file counts for
vim.opt.textwidth = 120 -- Line width
vim.opt.formatoptions = "cqj" -- See :help fo-table. Removes 't' to prevent auto-wrapping of text.

-- Search
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.incsearch = true -- Show search results as you type
vim.opt.smartcase = true -- Override 'ignorecase' if the search pattern contains upper case characters

-- UI and Behavior
vim.opt.wildmode = "list:longest" -- Command-line completion mode
vim.opt.splitright = true -- When splitting vertically, new window appears to the right
vim.opt.splitbelow = true -- When splitting horizontally, new window appears below

-- Cursor shape
vim.opt.guicursor = {
  "n-v-c-sm:block",
  "i-ci-ve:ver25",
  "r-cr-o:hor20",
  "i:blinkoff750-blinkon750-Cursor/lCursor", -- insert mode: blinking settings
}

require('keymaps')
require('completion')
require('lsp_config')
require('neotree')
require('smart_splits')
require('git')
