vim.lsp.set_log_level("WARN")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local bufopts = { noremap = true, silent = true, buffer = ev.buf }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)

		-- Stop yamlls when helm_ls attaches to helm files
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client.name == "helm_ls" and vim.bo[ev.buf].filetype == "helm" then
			vim.schedule(function()
				-- Find yamlls client and stop it for this buffer
				for _, yamlls_client in pairs(vim.lsp.get_clients({ bufnr = ev.buf, name = "yamlls" })) do
					vim.lsp.stop_client(yamlls_client.id, true)
				end
			end)
		end
	end,
})

-- Common YAML configuration for both yamlls and helm_ls
local yamlls_config = {
	keyOrdering = false,
	validate = true,
	schemaStore = {
		enable = false,
	},
	schemas = {
		["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
		["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
		["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = "roles/tasks/**/*.{yml,yaml}",
		["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
		["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
	},
}

-- LSP server configuration
local servers = {
	-- Language servers with default config
	"ansiblels",
	"bashls",
	"clangd",
	"gopls",
	"nixd",
	"terraformls",

	dockerls = {
		cmd = { "docker-language-server", "start", "--stdio" },
	},

	helm_ls = {
		settings = {
			["helm-ls"] = {
				yamlls = {
					config = yamlls_config,
				},
			},
		},
	},

	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				diagnostics = { globals = { "vim" } },
				signatureHelp = { enabled = true },
				telemetry = { enable = false },
			},
		},
	},

	yamlls = {
		settings = {
			redhat = { telemetry = { enabled = false } },
			yaml = yamlls_config,
		},
	},
}

-- Enable servers
for server, config in pairs(servers) do
	if type(server) == "number" then
		-- Simple server name in array part
		vim.lsp.enable(config)
	else
		-- Server with custom config
		vim.lsp.enable(server)
		vim.lsp.config(server, config)
	end
end
