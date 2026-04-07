local wk = require("which-key")

wk.setup({
  preset = "helix",
  icons = {
    mappings = true,
  },
})

wk.add({
  -- Groups
  { "<leader>c", group = "Code", icon = { icon = "", color = "orange" } },
  { "<leader>f", group = "Find", icon = { icon = "", color = "cyan" } },
  { "<leader>g", group = "Git", icon = { icon = "", color = "orange" } },
  { "<leader>gc", group = "Commits", icon = { icon = "", color = "yellow" } },
  { "<leader>o", group = "Obsidian", icon = { icon = "󱓞", color = "green" } },
  { "<leader>r", group = "Rename", icon = { icon = "󰑕", color = "cyan" } },
  { "<leader>s", group = "Switch", icon = { icon = "󰁔", color = "azure" } },
  { "<leader>tf", group = "Terraform", icon = { icon = "", color = "purple" } },
  { "<leader><leader>", group = "Swap Buffers", icon = { icon = "󰛢", color = "azure" } },

  -- Individual key icon hints
  { "<leader>:", icon = { icon = "", color = "azure" } },
  { "<leader>cd", icon = { icon = "", color = "red" } },
  { "<leader>d", icon = { icon = "󰆴", color = "red" } },
  { "<leader>e", icon = { icon = "", color = "orange" } },
  { "<leader>gg", icon = { icon = "", color = "orange" } },
  { "<leader>km", icon = { icon = "󰌌", color = "azure" } },
  { "<leader>y", icon = { icon = "", color = "yellow" } },
  { "gd", icon = { icon = "", color = "cyan" } },
  { "gr", icon = { icon = "", color = "cyan" } },
  { "gt", icon = { icon = "", color = "cyan" } },
})
