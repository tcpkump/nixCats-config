return {
  {
    "obsidian.nvim",
    ft = { "markdown" },
    cmd = {
      "ObsidianNew",
      "ObsidianToday",
      "ObsidianYesterday",
      "ObsidianQuickSwitch",
      "ObsidianSearch",
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

      local map = vim.keymap.set
      map("n", "<leader>od", "<cmd>ObsidianToday<CR>", { desc = "Daily note (today)" })
      map("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "New note" })
      map("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick switch note" })
      map("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search vault" })
    end,
  },
}
