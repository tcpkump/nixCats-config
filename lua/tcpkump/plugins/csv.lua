return {
  {
    "csvview.nvim",
    ft = { "csv", "tsv" },
    after = function()
      require("csvview").setup({
        view = {
          min_column_width = 5,
          spacing = 2,
        },
      })

      local function setup_buf()
        require("csvview").enable()
        vim.keymap.set("n", "<leader>ct", "<cmd>CsvViewToggle<cr>", {
          desc = "Toggle CSV aligned view",
          buffer = true,
        })
      end

      -- Enable for the buffer that triggered plugin load
      setup_buf()

      -- Enable for subsequent csv/tsv buffers
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = { "*.csv", "*.tsv" },
        callback = setup_buf,
      })

      -- Suspend aligned view in insert mode so cursor position is accurate;
      -- rainbow_csv column highlighting remains active throughout
      vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
          if vim.bo.filetype == "csv" or vim.bo.filetype == "tsv" then
            pcall(vim.cmd, "CsvViewDisable")
          end
        end,
      })
      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if vim.bo.filetype == "csv" or vim.bo.filetype == "tsv" then
            pcall(vim.cmd, "CsvViewEnable")
          end
        end,
      })
    end,
  },
}
