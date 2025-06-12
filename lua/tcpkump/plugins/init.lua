require("tcpkump.plugins.completion")
require("tcpkump.plugins.neotree")
require("tcpkump.plugins.smart_splits")
require("tcpkump.plugins.git")
require("tcpkump.plugins.statusline")
require("tcpkump.plugins.mini")
require("tcpkump.plugins.format")
require("tcpkump.plugins.diagnostic")
require("tcpkump.plugins.linting_diagnostics")
require("tcpkump.plugins.indent_blankline")
require("tcpkump.plugins.treesitter")
require("tcpkump.plugins.welcome")

require("lze").load({
	{ import = "tcpkump.plugins.telescope" },
	{ import = "tcpkump.plugins.git_lazy" },
	{ import = "tcpkump.plugins.search" },
})
