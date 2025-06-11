vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.lsp.enable({
	"helmls",
	"luals",
	"nixd",
	"yamlls",
})
