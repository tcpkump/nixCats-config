return {
	{
		"switch.vim",
		keys = {
			{
				"<leader>sx",
				function()
					vim.cmd("Switch")
				end,
				desc = "Switch",
			},
			{
				"<leader>sX",
				function()
					vim.cmd("SwitchReverse")
				end,
				desc = "Switch Reverse",
			},
		},
		after = function(plugin)
			vim.g.switch_mapping = ""
			vim.g.switch_custom_definitions = {
				{ "up", "down" },
				{ "row", "column" },
				{ "yes", "no" },
				{ "on", "off" },
			}
		end,
	},
}
