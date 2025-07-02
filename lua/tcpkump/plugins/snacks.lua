require("snacks").setup({
  picker = { enabled = true },
  lazygit = { enabled = true },
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
