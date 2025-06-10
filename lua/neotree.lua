-- Configure neo-tree
require("neo-tree").setup({
  popup_border_style = "rounded",
})

-- Set up keymaps
vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle filesystem reveal left<CR>", { desc = "NeoTree toggle" })
