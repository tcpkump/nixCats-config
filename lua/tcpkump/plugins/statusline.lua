-- Minimal mini.statusline configuration with relative path to CWD
local MiniStatusline = require("mini.statusline")

-- Custom filename function
local function relative_filename(args)
  if vim.bo.buftype ~= "" then
    return "%t"
  end

  local path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
  if path == "" then
    return "[No Name]"
  end

  -- Truncate to filename only if window is too narrow
  if args and args.trunc_width and vim.api.nvim_win_get_width(0) < args.trunc_width then
    return vim.fn.expand("%:t")
  end

  return path
end

-- Override the section_filename function
MiniStatusline.section_filename = relative_filename

-- Setup with explicitly defined active content using our custom filename
MiniStatusline.setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
      local git = MiniStatusline.section_git({ trunc_width = 75 })
      local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
      local filename = relative_filename({ trunc_width = 140 }) -- Use our custom function directly
      local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
      local location = MiniStatusline.section_location({ trunc_width = 75 })
      local search = MiniStatusline.section_searchcount({ trunc_width = 75 })

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { filename } },
        "%=", -- End left alignment
        { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
        { hl = mode_hl, strings = { search, location } },
      })
    end,
    inactive = function()
      local path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
      if path == "" then
        path = "[No Name]"
      end
      return "%#MiniStatuslineInactive#" .. path .. "%="
    end,
  },
})
