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

	-- TODO lsp keymaps
})
