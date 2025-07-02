require("nvim-autopairs").setup()

require("blink.cmp").setup({
  keymap = {
    preset = "none",
    ["<C-j>"] = { "select_next", "fallback" },
    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<CR>"] = { "accept", "fallback" },

    -- Additional QoL keymaps
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    ["<C-u>"] = { "scroll_documentation_up", "fallback" },
  },

  appearance = {
    use_nvim_cmp_as_default = false, -- Use blink's modern UI
    nerd_font_variant = "mono",
  },

  completion = {
    menu = {
      border = "rounded",
      winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
      scrolloff = 2,
      scrollbar = false,
      draw = {
        columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = "rounded",
        winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        max_height = 20,
      },
    },
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
  },

  sources = {
    default = {
      "lsp",
      "buffer",
      "snippets",
      "path",
      "ripgrep",
    },
    providers = {
      ripgrep = {
        module = "blink-ripgrep",
        name = "Ripgrep",
      },
    },
  },

  signature = {
    enabled = true,
    window = {
      border = "rounded",
    },
  },
})

vim.api.nvim_set_hl(0, "BlinkCmpMenu", { link = "CmpPmenu" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { link = "CmpPmenu" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { link = "PmenuSel" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { link = "CmpPmenu" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { link = "CmpPmenu" })
