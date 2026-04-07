local base_cmd = "GIT_EXTERNAL_DIFF='difft --color=always' git diff"

local function get_default_branch()
  local branch = vim.fn.system("git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null")
  if vim.v.shell_error == 0 then
    return branch:match("refs/remotes/origin/(.-)%s*$")
  end
  for _, b in ipairs({ "main", "master", "latest" }) do
    vim.fn.system("git rev-parse --verify " .. b .. " 2>/dev/null")
    if vim.v.shell_error == 0 then
      return b
    end
  end
  return "main"
end

local function toggle(cmd)
  local difft = require("difft")
  if difft.is_visible() then
    difft.close()
  else
    difft.diff({ cmd = cmd })
  end
end

return {
  {
    "difft-nvim",
    keys = {
      { "<leader>gd", desc = "Diff uncommitted (HEAD)" },
      { "<leader>gD", desc = "Diff staged only" },
      { "<leader>gb", desc = "Diff branch vs default branch" },
    },
    after = function()
      require("difft").setup({
        layout = "float",
        window = {
          border = "rounded",
          width = 0.9,
          height = 0.8,
        },
      })

      -- All uncommitted changes (staged + unstaged) vs HEAD
      vim.keymap.set("n", "<leader>gd", function()
        toggle(base_cmd .. " HEAD")
      end, { desc = "Diff uncommitted (HEAD)" })

      -- Staged changes only
      vim.keymap.set("n", "<leader>gD", function()
        toggle(base_cmd .. " --staged")
      end, { desc = "Diff staged only" })

      -- Everything on current branch vs default branch
      vim.keymap.set("n", "<leader>gb", function()
        toggle(base_cmd .. " " .. get_default_branch())
      end, { desc = "Diff branch vs default branch" })
    end,
  },
}
