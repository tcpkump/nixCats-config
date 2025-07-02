local conform = require("conform")
conform.setup({
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 2000,
  },
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

    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- Use a sub-list to run only the first available formatter
    -- javascript = { { "prettierd", "prettier" } },
  },
})
