local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.puppet_lint,
    null_ls.builtins.diagnostics.terragrunt_validate,
    null_ls.builtins.diagnostics.trivy,
    -- null_ls.builtins.diagnostics.yamllint, -- disabled due to it triggering in helm templates
  },
})
