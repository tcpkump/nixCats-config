return {
  {
    "gitlinker.nvim",
    after = function(plugin)
      require("gitlinker").setup({})
    end,
  },
}
