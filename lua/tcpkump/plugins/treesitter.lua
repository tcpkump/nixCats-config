require("nvim-treesitter.configs").setup({
	highlight = { enable = true },
	indent = { enable = false },
	matchup = { enable = true },
	textobjects = {
		swap = {
			enable = true,
			swap_next = {
				["<leader>sa"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>sA"] = "@parameter.inner",
			},
		},
	},
})

require("treesitter-context").setup({
	max_lines = 10,
	mode = "topline",
})

vim.keymap.set("n", "[c", function()
	require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true })
