local map = vim.keymap.set

map("x", "p", "p:let @+=@0<CR>", { desc = "Paste and preserve register" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Keep search results centered
map("n", "n", "nzzzv", { desc = "Move to next search result and center" })
map("n", "N", "Nzzzv", { desc = "Move to previous search result and center" })

map('n', '<leader>cd', vim.diagnostic.open_float, { desc = "Code Diagnostic", noremap = true, silent = true })
map('n', '[d', vim.diagnostic.goto_prev, { desc = "Prev Diagnostic", noremap = true, silent = true })
map('n', ']d', vim.diagnostic.goto_next, { desc = "Next Diagnostic", noremap = true, silent = true })
