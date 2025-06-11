vim.lsp.config("*", {
	root_markers = { ".git" },
})

-- point to matching file in lsp/<name>.lua
vim.lsp.enable({
	"ansible",
	"bash",
	"c",
	"docker",
	"helm",
	"lua",
	"nix",
	"yaml",

	-- TODO
	-- gopls
	-- jsonls
	-- perlnavigator
	-- phpactor
	-- ruby_lsp
	-- rust_analyzer
	-- sqls
	-- terraformls
	-- ts_ls
	-- zls
	-- python
	--   basedpyright
	--   ruff

	-- TODO lsp keymaps
})
