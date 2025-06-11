vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local buffer = args.buf

		if client.name == "yamlls" then
			if vim.api.nvim_get_option_value("filetype", { buf = buffer }) == "helm" then
				vim.schedule(function()
					vim.cmd("LspStop ++force yamlls")
				end)
			end
		end
	end,
})
