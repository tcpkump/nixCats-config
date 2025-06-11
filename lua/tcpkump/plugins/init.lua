require("tcpkump.plugins.completion")
require("tcpkump.plugins.neotree")
require("tcpkump.plugins.smart_splits")
require("tcpkump.plugins.git")
require("tcpkump.plugins.statusline")
require("tcpkump.plugins.mini")
require("tcpkump.plugins.format")
require("tcpkump.plugins.linting_diagnostics")
require("tcpkump.plugins.indent_blankline")

require("lze").load({
	{ import = "tcpkump.plugins.telescope" },
	{ import = "tcpkump.plugins.git_lazy" },
	{ import = "tcpkump.plugins.search" },
})
