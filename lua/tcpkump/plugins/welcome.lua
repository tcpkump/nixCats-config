require("alpha").setup({
  layout = {
    {
      type = "padding",
      val = 10,
    },
    {
      type = "text",
      val = {
        "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗",
        "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║",
        "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║",
        "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║",
        "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
      },
      opts = {
        hl = "Type",
        position = "center",
      },
    },
    {
      type = "padding",
      val = 2,
    },
    {
      type = "padding",
      val = 2,
    },
    {
      type = "text",
      val = "You made this? I made this.",
      opts = {
        hl = "Keyword",
        position = "center",
      },
    },
  },
})
