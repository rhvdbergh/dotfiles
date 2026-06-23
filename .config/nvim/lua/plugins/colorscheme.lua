return {
  -- add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        palette_overrides = {
          neutral_red = "#ea6962",
        },
        highlights = {
          GruvboxRed = { fg = "#ea6962" },
          GruvboxRedBold = { fg = "#ea6962", bold = true },
        },
      })
    end,
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
