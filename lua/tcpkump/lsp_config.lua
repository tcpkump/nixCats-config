vim.lsp.config("*", {
	root_markers = { ".git" },
})

vim.lsp.enable({
	"ansiblels",
	"helmls",
	"luals",
	"nixd",
	"yamlls",
})
