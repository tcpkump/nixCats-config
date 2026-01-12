local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.ansiblelint,
    -- puppet-lint moved to nvim-lint (none-ls has issues with puppet-lint stderr output)
    null_ls.builtins.diagnostics.terragrunt_validate,
    null_ls.builtins.diagnostics.trivy,
    -- null_ls.builtins.diagnostics.yamllint, -- disabled due to it triggering in helm templates
  },
})
