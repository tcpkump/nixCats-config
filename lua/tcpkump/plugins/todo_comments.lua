require("todo-comments").setup({
  signs = true,
  sign_priority = 8,
  keywords = {
    FIX = {
      icon = " ",
      color = "#FF5D62", -- peachRed
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
    },
    TODO = {
      icon = " ",
      color = "#FFA066", -- carpYellow
    },
    HACK = {
      icon = " ",
      color = "#FF5A67", -- autumnRed
    },
    WARN = {
      icon = " ",
      color = "#FF9E3B", -- autumnYellow
      alt = { "WARNING", "XXX" },
    },
    PERF = {
      icon = " ",
      color = "#7FB4CA", -- springBlue
      alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
    },
    NOTE = {
      icon = " ",
      color = "#6A9589", -- waveAqua1
      alt = { "INFO" },
    },
    TEST = {
      icon = "⏲ ",
      color = "#98BB6C", -- springGreen
      alt = { "TESTING", "PASSED", "FAILED" },
    },
  },
  gui_style = {
    fg = "NONE",
    bg = "BOLD",
  },
  merge_keywords = true,
  highlight = {
    multiline = true,
    multiline_pattern = "^.",
    multiline_context = 10,
    before = "",
    keyword = "wide_bg",
    after = "fg",
    pattern = [[.*<(KEYWORDS)\s*:?]],
    comments_only = true,
    max_line_len = 400,
    exclude = {},
  },
  colors = {
    error = { "#FF5D62" }, -- peachRed
    warning = { "#FF9E3B" }, -- autumnYellow
    info = { "#6A9589" }, -- waveAqua1
    hint = { "#7FB4CA" }, -- springBlue
    default = { "#FFA066" }, -- carpYellow
    test = { "#98BB6C" }, -- springGreen
  },
  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    pattern = [[\b(KEYWORDS):]],
  },
})
