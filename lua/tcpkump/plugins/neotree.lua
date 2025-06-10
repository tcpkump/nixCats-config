require("neo-tree").setup({
	popup_border_style = "rounded",
	sort_case_insensitive = true,
	close_if_last_window = true,
	filesystem = {
		follow_current_file = {
			enabled = true,
			leave_dirs_open = true,
		},
		filtered_items = {
			hide_by_name = {
				"flake.lock",
			},
			always_show = {
				".gitattributes",
				".gitea",
				".github",
				".gitignore",
				".pre-commit-config.yaml",
				".terraform",
				".terraform.lock.hcl",
			},
		},
		use_libuv_file_watcher = true,
	},
})

require("window-picker").setup({
	-- switch selection chars to colemak home row
	selection_chars = "arstdhneio",
	hint = "floating-big-letter",
})

-- Set up keymaps
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle filesystem reveal left<CR>", { desc = "NeoTree toggle" })
