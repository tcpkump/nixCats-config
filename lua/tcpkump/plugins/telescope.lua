-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
	-- Use the current buffer's path as the starting point for the git search
	local current_file = vim.api.nvim_buf_get_name(0)
	local current_dir
	local cwd = vim.fn.getcwd()
	-- If the buffer is not associated with a file, return nil
	if current_file == "" then
		current_dir = cwd
	else
		-- Extract the directory from the current file's path
		current_dir = vim.fn.fnamemodify(current_file, ":h")
	end

	-- Find the Git root directory from the current file's path
	local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
	if vim.v.shell_error ~= 0 then
		print("Not a git repository. Searching on current working directory")
		return cwd
	end
	return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
	local git_root = find_git_root()
	if git_root then
		require("telescope.builtin").live_grep({
			search_dirs = { git_root },
		})
	end
end

return {
	{
		"telescope.nvim",
		cmd = { "Telescope", "LiveGrepGitRoot" },
		-- NOTE: our on attach function defines keybinds that call telescope.
		-- so, the on_require handler will load telescope when we use those.
		on_require = { "telescope" },
		keys = {
			{ "<leader>:", "<Cmd>Telescope command_history<CR>", mode = { "n" }, desc = "Search Command History" },
			{ "<leader>ff", "<Cmd>Telescope find_files<CR>", mode = { "n" }, desc = "Find File" },
			{ "<leader>fo", "<Cmd>Telescope oldfiles<CR>", mode = { "n" }, desc = "Find Recent File" },
			{ "<leader>fw", "<Cmd>Telescope live_grep_args<CR>", mode = { "n" }, desc = "Grep in Files" },
			{ "<leader>fg", "<Cmd>LiveGrepGitRoot<CR>", mode = { "n" }, desc = "Grep in Git Root" },
			{ "<leader>gr", "<Cmd>Telescope lsp_references<CR>", mode = { "n" }, desc = "Find References" },
			{ "<leader>km", "<Cmd>Telescope keymaps<CR>", mode = { "n" }, desc = "Search Keymaps" },
			-- git-related
			{ "<leader>gm", "<Cmd>Telescope git_status<CR>", mode = { "n" }, desc = "Search Modified Files" },
			{ "<leader>gcb", "<Cmd>Telescope git_bcommits<CR>", mode = { "n" }, desc = "Search Buffer Commits" },
			{ "<leader>gcc", "<Cmd>Telescope git_commits<CR>", mode = { "n" }, desc = "Search All Commits" },
		},
		load = function(name)
			vim.cmd.packadd(name)
			vim.cmd.packadd("telescope-fzf-native.nvim")
			vim.cmd.packadd("telescope-ui-select.nvim")
			vim.cmd.packadd("telescope-live-grep-args.nvim")
		end,
		after = function(plugin)
			require("telescope").setup({
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable telescope extensions, if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "live_grep_args")

			vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})
		end,
	},
}
