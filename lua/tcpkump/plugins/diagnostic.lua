-- pretty display of diagnostics
require("tiny-inline-diagnostic").setup({
	preset = "classic",
	options = {
		show_source = {
			enabled = true,
		},
		multilines = {
			enabled = true,
			always_show = true,
		},
	},
})
vim.diagnostic.config({ virtual_text = false })
