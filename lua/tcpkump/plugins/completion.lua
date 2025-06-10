require('blink.cmp').setup({
  -- Keymap configuration
  keymap = {
    preset = 'none', -- We'll define custom mappings
    ['<C-j>'] = { 'select_next', 'fallback' },
    ['<C-k>'] = { 'select_prev', 'fallback' },
    ['<C-e>'] = { 'hide', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
    ['<S-CR>'] = { 'accept', 'fallback' }, -- Note: blink.cmp doesn't have replace behavior

    -- Additional QoL keymaps
    ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
  },

  -- Appearance configuration
  appearance = {
    use_nvim_cmp_as_default = false, -- Use blink's modern UI
    nerd_font_variant = 'mono', -- or 'normal' if you prefer
  },

  -- Window configuration
  completion = {
    menu = {
      border = 'rounded',
      winhighlight = 'Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
      scrolloff = 2,
      scrollbar = false,
      draw = {
        columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = {
        border = 'rounded',
        winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
        max_height = 20,
      },
    },
    -- Don't preselect first item (similar to your cmp config)
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
  },

  -- Sources configuration
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
    -- blink.cmp has built-in support for these, no need for external sources
    providers = {
      lsp = {
        name = 'LSP',
        enabled = true,
        module = 'blink.cmp.sources.lsp',
        score_offset = 90, -- Higher priority
      },
      path = {
        name = 'Path',
        enabled = true,
        module = 'blink.cmp.sources.path',
        score_offset = 30,
        opts = {
          trailing_slash = false,
          label_trailing_slash = true,
          get_cwd = vim.loop.cwd,
        },
      },
      snippets = {
        name = 'Snippets',
        enabled = true,
        module = 'blink.cmp.sources.snippets',
        score_offset = 80,
        opts = {
          friendly_snippets = true, -- Load friendly-snippets
          search_paths = { vim.fn.stdpath('config') .. '/snippets' },
        },
      },
      buffer = {
        name = 'Buffer',
        enabled = true,
        module = 'blink.cmp.sources.buffer',
        score_offset = 50,
        opts = {
          get_bufnrs = function()
            return vim.api.nvim_list_bufs()
          end,
        },
      },
    },
  },

  -- Additional features
  signature = {
    enabled = true,
    window = {
      border = 'rounded',
    },
  },
})

-- Set up highlight groups to match your theme
vim.api.nvim_set_hl(0, 'BlinkCmpMenu', { link = 'CmpPmenu' })
vim.api.nvim_set_hl(0, 'BlinkCmpMenuBorder', { link = 'CmpPmenu' })
vim.api.nvim_set_hl(0, 'BlinkCmpMenuSelection', { link = 'PmenuSel' })
vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { link = 'CmpPmenu' })
vim.api.nvim_set_hl(0, 'BlinkCmpDocBorder', { link = 'CmpPmenu' })
