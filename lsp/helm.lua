return {
	cmd = { "helm_ls", "serve" },
	filetypes = { "helm", "yaml.helm-values" },
	root_markers = { "Chart.yaml" },
	settings = {
		["helm-ls"] = {
			yamlls = {
				config = {
					keyOrdering = false,
					validate = true,
					schemaStore = {
						enable = true,
					},
				},
			},
		},
	},
}
