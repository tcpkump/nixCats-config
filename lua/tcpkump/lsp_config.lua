vim.lsp.config("*", {
	root_markers = { ".git" },
})

-- point to matching file in lsp/<name>.lua
vim.lsp.enable({
	"ansible",
	"bash",
	"helm",
	"lua",
	"nix",
	"yaml",
})
