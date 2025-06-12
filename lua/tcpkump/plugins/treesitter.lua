require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = false },
})

require("treesitter-context").setup({
	max_lines = 10,
	mode = "topline",
})

vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
