-- Write lazygit user config to cache dir so snacks can append its theme file after it
local lazygit_config = [[
gui:
  timeFormat: "02 Jan 06 15:04"

git:
  pagers:
    - colorArg: always
      pager: "delta --paging never --line-numbers"

  commitPrefix:
    - pattern: '(\w+)[-_](\d+).*'
      replace: '[$1-$2] '

  overrideGpg: true

customCommands:
  - key: 'D'
    command: "sh -c 'git diff {{.SelectedLocalBranch.Name}}...HEAD | delta --paging never --color always'"
    context: 'localBranches'
    description: 'PR Diff (against selected branch)'
    output: terminal
  - key: 'O'
    command: "gh pr view --web"
    context: 'global'
    description: 'Open current PR on GitHub'
    output: log
]]

local user_config_path = vim.fn.stdpath("cache") .. "/lazygit-user.yml"
vim.fn.writefile(vim.split(lazygit_config, "\n"), user_config_path)
vim.env.LG_CONFIG_FILE = user_config_path

require("snacks").setup({
  picker = {
    enabled = true,
    win = {
      list = {
        keys = {
          ["<c-h>"] = false,
          ["<c-j>"] = false,
          ["<c-k>"] = false,
          ["<c-l>"] = false,
        },
      },
      input = {
        keys = {
          ["<c-h>"] = false,
          ["<c-j>"] = false,
          ["<c-k>"] = false,
          ["<c-l>"] = false,
        },
      },
    },
  },
  lazygit = {
    enabled = true,
    configure = true,
  },
  explorer = {
    enabled = true,
    git_status = true,
    diagnostics = true,
  },
})

-- A helper function to get the root directory of the LSP for the current buffer.
-- It falls back to the current working directory if no LSP is found.
local function find_lsp_root()
  local bufnr = vim.api.nvim_get_current_buf()
  -- Get all active clients for the current buffer
  local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

  -- If there are clients, return the root_dir of the first one.
  -- You might have multiple (e.g., terraform-ls and null-ls), but the first is usually fine.
  if #clients > 0 and clients[1].root_dir then
    return clients[1].root_dir
  end

  -- Fallback to the current working directory
  return vim.fn.getcwd()
end

vim.keymap.set("n", "<leader>e", function()
  require("snacks").explorer()
end, { desc = "Explorer toggle" })

-- Quit Neovim if the explorer is the last thing open
vim.api.nvim_create_autocmd("WinClosed", {
  callback = function(ev)
    local closing_win = tonumber(ev.match)
    local remaining = vim.tbl_filter(function(w)
      if w == closing_win then return false end
      -- ignore floating windows
      return vim.api.nvim_win_get_config(w).relative == ""
    end, vim.api.nvim_list_wins())

    if #remaining == 0 then return end

    local all_snacks = true
    for _, w in ipairs(remaining) do
      local ft = vim.bo[vim.api.nvim_win_get_buf(w)].filetype
      if not vim.startswith(ft, "snacks_") then
        all_snacks = false
        break
      end
    end

    if all_snacks then
      vim.schedule(function()
        vim.cmd("qall")
      end)
    end
  end,
})

vim.keymap.set("n", "<leader>gg", function()
  require("snacks").lazygit()
end, { desc = "Lazygit" })

-- Custom live_grep function to search in lsp root
local function live_grep_lsp_root()
  local lsp_root = find_lsp_root()
  if lsp_root then
    require("snacks").picker.grep({ cwd = lsp_root })
  end
end

vim.keymap.set("n", "<leader>:", function()
  require("snacks").picker.command_history()
end, { desc = "Search Command History" })

vim.keymap.set("n", "<leader>ff", function()
  require("snacks").picker.files()
end, { desc = "Find File" })

vim.keymap.set("n", "<leader>fo", function()
  require("snacks").picker.recent()
end, { desc = "Find Recent File" })

vim.keymap.set("n", "<leader>fw", function()
  require("snacks").picker.grep()
end, { desc = "Grep in Files" })

vim.keymap.set("n", "<leader>km", function()
  require("snacks").picker.keymaps()
end, { desc = "Search Keymaps" })

-- git-related
vim.keymap.set("n", "<leader>gm", function()
  require("snacks").picker.git_status()
end, { desc = "Search Modified Files" })

vim.keymap.set("n", "<leader>gcb", function()
  require("snacks").picker.git_log_file()
end, { desc = "Search Buffer Commits" })

vim.keymap.set("n", "<leader>gcc", function()
  require("snacks").picker.git_log()
end, { desc = "Search All Commits" })

-- lsp
vim.keymap.set("n", "<leader>fl", live_grep_lsp_root, { desc = "Grep in LSP Root" })

vim.keymap.set("n", "gr", function()
  require("snacks").picker.lsp_references()
end, { desc = "Find References" })
