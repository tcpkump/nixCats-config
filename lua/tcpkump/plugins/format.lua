local conform = require("conform")
conform.setup({
  format_on_save = function(bufnr)
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("renovate%.json") then
      return
    end
    return { timeout_ms = 2000 }
  end,
  formatters_by_ft = {
    -- NOTE: download formatters in lspsAndRuntimeDeps
    -- and configure them here
    lua = { "stylua" },
    go = { "gofmt", "goimports" },
    hcl = { "hcl", "packer_fmt" },
    nix = { "nixfmt" },
    puppet = { "puppet-lint" },
    terraform = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
    zig = { "prettierd" },
    javascript = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },

    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    -- javascript = { { "prettierd", "prettier" } },
  },
})
