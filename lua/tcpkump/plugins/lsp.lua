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
  completion = true,
  schemaStore = {
    enable = false,
    url = "", -- Explicitly disable schema store
  },
  schemas = {
    ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
    ["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
    ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = "roles/tasks/**/*.{yml,yaml}",
    -- Kubernetes
    ["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
    ["https://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
    ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.33.0/all.json"] = "*.k8s.{yml,yaml}",
    ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/monitoring.coreos.com/prometheus_v1.json"] = "*Prometheus*.{yml,yaml}",
    ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/monitoring.coreos.com/prometheusrule_v1.json"] = "*PrometheusRule*.{yml,yaml}",
    ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/monitoring.coreos.com/scrapeconfig_v1alpha1.json"] = "*ScrapeConfig*.{yml,yaml}",
    ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/monitoring.coreos.com/servicemonitor_v1.json"] = "*ServiceMonitor*.{yml,yaml}",
    ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/monitoring.coreos.com/probe_v1.json"] = "*Probe*.{yml,yaml}",
    ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/monitoring.coreos.com/podmonitor_v1.json"] = "*PodMonitor*.{yml,yaml}",
    ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/monitoring.coreos.com/alertmanagerconfig_v1alpha1.json"] = "*{AlertManagerConfig,InhibitRule}*.{yml,yaml}",
  },
}

local servers = {
  -- Language servers with default config
  ansiblels = {},
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "standard",
        },
      },
    },
  },
  bashls = {},
  clangd = {},
  gopls = {},
  nixd = {},
  terraformls = {},

  dockerls = {
    cmd = { "docker-language-server", "start", "--stdio" },
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

  jsonls = {
    cmd = { "vscode-json-languageserver", "--stdio" },
    settings = {
      json = {
        schemas = {
          {
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package.json",
          },
          {
            fileMatch = { "tsconfig.json", "tsconfig.*.json" },
            url = "https://json.schemastore.org/tsconfig.json",
          },
          {
            fileMatch = { ".prettierrc.json", ".prettierrc" },
            url = "https://json.schemastore.org/prettierrc.json",
          },
          {
            fileMatch = { "composer.json" },
            url = "https://json.schemastore.org/composer.json",
          },
        },
        validate = { enable = true },
      },
    },
  },

  yamlls = {
    settings = {
      redhat = { telemetry = { enabled = false } },
      yaml = yamlls_config,
    },
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
}

-- Configure servers first
for server, config in pairs(servers) do
  vim.lsp.config(server, config)
end

-- Then enable them
for server, _ in pairs(servers) do
  vim.lsp.enable(server)
end
