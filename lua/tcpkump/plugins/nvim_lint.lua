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
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
  callback = function()
    -- Only lint if a linter is configured for this filetype
    local linters = lint.linters_by_ft[vim.bo.filetype]
    if linters then
      lint.try_lint()
    end
  end,
})
