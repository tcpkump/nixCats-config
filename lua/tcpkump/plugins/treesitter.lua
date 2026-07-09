-- nvim-treesitter setup (new API - no longer uses configs module)
require("nvim-treesitter").setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

-- Enable treesitter highlighting for filetypes with parsers.
-- csv/tsv are excluded so rainbow_csv's syntax-based column colours work.
local ts_exclude = { csv = true, tsv = true }
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function(args)
    if ts_exclude[vim.bo[args.buf].filetype] then return end
    pcall(vim.treesitter.start, args.buf)
  end,
})

require("treesitter-context").setup({
  max_lines = 10,
  mode = "topline",
})

vim.keymap.set("n", "[c", function()
  require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
