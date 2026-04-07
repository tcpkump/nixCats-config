require("smart-splits").setup({
  at_edge = "move", -- Move to tmux panes when at the edge
  -- Ensure your .tmux.conf has a robust 'is_vim' check.
  -- Recommended for Nix users (handles wrapped nvim):
  -- is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?|nvim-wrapped)(diff)?$'"
  multiplexer_integration = "tmux",
  disable_multiplexer_nav_when_zoomed = true,
})

-- recommended mappings
-- resizing splits
vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize split left" })
vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize split down" })
vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize split up" })
vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize split right" })

-- moving between splits
-- Normal mode
vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Move to lower split" })
vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move to upper split" })
vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Move to right split" })
vim.keymap.set("n", "<C-\\>", require("smart-splits").move_cursor_previous, { desc = "Move to previous split" })

-- swapping buffers between windows
vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left, { desc = "Swap buffer left" })
vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down, { desc = "Swap buffer down" })
vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up, { desc = "Swap buffer up" })
vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right, { desc = "Swap buffer right" })
