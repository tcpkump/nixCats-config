return {
  {
    "markview.nvim",
    ft = { "markdown", "mdx" },
    after = function()
      require("markview").setup({})
    end,
  },
}
