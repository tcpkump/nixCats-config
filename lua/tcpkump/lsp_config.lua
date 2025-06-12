vim.lsp.config("*", {
	root_markers = { ".git" },
})

-- point to matching file in lsp/<name>.lua
vim.lsp.enable({
	"ansible",
	"bash",
	"c",
	"docker",
	"go",
	"helm",
	"lua",
	"nix",
	"python", -- TODO do I still want ruff? formatting and/or linting?
	"terraform",
	"yaml",

	-- TODO
	-- jsonls
	-- perlnavigator
	-- phpactor
	-- ruby_lsp
	-- rust_analyzer
	-- sqls
	-- ts_ls
	-- zls
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	end,
})
