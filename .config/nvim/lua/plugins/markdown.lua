return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    heading = {
      enabled = true,
      sign = true,
      icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
    },

    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
    },

    checkbox = {
      enabled = true,
      checked = " ",
      unchecked = " ",
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 " },
      },
    },

    code = {
      enabled = true,
      sign = true,
      style = "full",
    },

    quote = {
      enabled = true,
      icon = "▌",
    },
  },
}
