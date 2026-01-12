-- nvim-lint configuration
-- Setup linters for various filetypes

local lint = require("lint")

-- Configure linters by filetype
-- nvim-lint has built-in support for puppet-lint that avoids stderr issues
lint.linters_by_ft = {
  puppet = { "puppet-lint" },
  -- Add other linters as needed
  -- terraform = { "tflint" },
}

-- Auto-lint on these events
-- Note: puppet-lint requires files to be on disk (stdin = false)
-- BufWritePost ensures file is saved before linting
-- BufEnter lints when opening existing files
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
  callback = function()
    lint.try_lint()
  end,
})

-- Lint when entering a buffer (for existing files)
-- Use defer to ensure buffer is fully loaded
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = "NvimLint",
  callback = function()
    -- Small delay to ensure buffer is fully loaded
    vim.defer_fn(function()
      lint.try_lint()
    end, 100)
  end,
})
