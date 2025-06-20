require("schema-companion").setup({
	enable_telescope = true,
	matchers = {
		require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
	},
})
