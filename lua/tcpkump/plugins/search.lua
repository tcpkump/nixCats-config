return {
  {
    "grug-far.nvim",
    keys = {
      { "<leader>fr", "<cmd>GrugFar<cr>", desc = "Find and Replace" },
    },
    after = function(plugin)
      require("grug-far").setup({})
    end,
  },
}
