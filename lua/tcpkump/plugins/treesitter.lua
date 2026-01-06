-- nvim-treesitter setup (new API - no longer uses configs module)
require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Enable treesitter highlighting for filetypes with parsers
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    local buf = args.buf
    -- Try to start treesitter, silently ignore if no parser exists
    pcall(vim.treesitter.start, buf)
  end,
})

require("treesitter-context").setup({
  max_lines = 10,
  mode = "topline",
})

vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
