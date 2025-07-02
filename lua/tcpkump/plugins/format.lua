local conform = require("conform")
conform.setup({
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
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

vim.keymap.set({ "n", "v" }, "<leader>cf", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Code Format" })
