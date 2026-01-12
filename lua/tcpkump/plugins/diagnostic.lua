-- pretty display of diagnostics
require("tiny-inline-diagnostic").setup({
  preset = "classic",
  options = {
    show_source = {
      enabled = true,
    },
    multilines = {
      enabled = true,
      always_show = true,
    },
    -- Support both LSP and nvim-lint diagnostics
    -- DiagnosticChanged fires when nvim-lint reports diagnostics
    overwrite_events = { "DiagnosticChanged", "LspAttach" },
  },
})
vim.diagnostic.config({ virtual_text = false })
