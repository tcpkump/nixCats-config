local function get_branch_url(mode)
  local gitlinker = require("gitlinker")
  local git = require("gitlinker.git")
  local buffer = require("gitlinker.buffer")

  local git_root = git.get_git_root()
  if not git_root then
    vim.notify("Not in a git repository", vim.log.levels.ERROR)
    return
  end

  local remote = git.get_branch_remote()
  if not remote then
    return
  end

  local repo_url_data = git.get_repo_data(remote)
  if not repo_url_data then
    return
  end

  local branch
  local upstream = vim.fn.systemlist({ "git", "-C", git_root, "rev-parse", "--abbrev-ref", "@{u}" })[1]
  if vim.v.shell_error == 0 and upstream then
    branch = upstream:match("^" .. vim.pesc(remote) .. "/(.+)$")
  end
  if not branch then
    local head = vim.fn.systemlist({ "git", "-C", git_root, "rev-parse", "--abbrev-ref", "HEAD" })[1]
    if head and head ~= "HEAD" and head ~= "" then
      branch = head
    end
  end
  if not branch then
    vim.notify("Could not determine current branch", vim.log.levels.ERROR)
    return
  end

  local range = buffer.get_range(mode, true)
  local url_data = vim.tbl_extend("force", repo_url_data, {
    rev = branch,
    file = buffer.get_relative_path(git_root),
    lstart = range.lstart,
    lend = range.lend,
  })

  local matching_callback = gitlinker.hosts.get_matching_callback(url_data.host)
  if not matching_callback then
    return
  end

  local url = matching_callback(url_data)
  gitlinker.actions.copy_to_clipboard(url)
  vim.notify(url)
end

return {
  {
    "gitlinker.nvim",
    after = function(plugin)
      require("gitlinker").setup({ mappings = "<leader>gcy" })

      vim.keymap.set("n", "<leader>gy", function()
        get_branch_url("n")
      end, { desc = "Copy git branch permalink" })
      vim.keymap.set("v", "<leader>gy", function()
        get_branch_url("v")
      end, { desc = "Copy git branch permalink" })
    end,
  },
}
