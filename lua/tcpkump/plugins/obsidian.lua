return {
  {
    "obsidian.nvim",
    ft = { "markdown" },
    keys = {
      { "<leader>od", "<cmd>Obsidian today<CR>", desc = "Daily note (today)" },
      { "<leader>on", "<cmd>Obsidian new<CR>", desc = "New note" },
      { "<leader>oq", "<cmd>Obsidian quick_switch<CR>", desc = "Quick switch note" },
      { "<leader>os", "<cmd>Obsidian search<CR>", desc = "Search vault" },
    },
    after = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "personal",
            path = "~/obsidian",
          },
        },
        daily_notes = {
          folder = "daily",
          date_format = "%Y-%m-%d",
        },
        legacy_commands = false,
        completion = {
          nvim_cmp = false,
          min_chars = 2,
        },
        picker = {
          name = "snacks.pick",
        },
        ui = {
          enable = false, -- markview handles rendering
        },
      })
    end,
  },
}
