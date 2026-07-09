return {
  {
    "csvview.nvim",
    ft = { "csv", "tsv" },
    after = function()
      require("csvview").setup({
        view = {
          min_column_width = 5,
          spacing = 2,
          -- "border" adds │ separators without competing background colours;
          -- rainbow_csv owns the column foreground colours
          display_mode = "border",
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

      -- Suspend aligned view in insert mode. csvview sets syntax="" on enable and
      -- captures orig_syntax before rainbow_csv's ftplugin runs, so on_detach
      -- restores "" instead of "csv". After disabling, we re-trigger the Syntax
      -- autocmd (rainbow_csv#handle_syntax_change) by setting syntax explicitly.
      vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
          local ft = vim.bo.filetype
          if ft ~= "csv" and ft ~= "tsv" then return end
          pcall(vim.cmd, "CsvViewDisable")
          vim.schedule(function()
            local buf = vim.api.nvim_get_current_buf()
            if not vim.api.nvim_buf_is_valid(buf) then return end
            if vim.bo[buf].filetype == ft then
              vim.bo[buf].syntax = ft
            end
          end)
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
