return {
  {
    "lazygit.nvim",
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    on_require = { "lazygit", },
    keys = {
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
  },
  {
    "gitlinker.nvim",
    after = function (plugin)
      require('gitlinker').setup {}
    end,
  },
}
