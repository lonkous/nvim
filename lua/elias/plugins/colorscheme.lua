return {
  "folke/tokyonight.nvim",
  priority = 1000,
  opts = {
    on_colors = function(colors)
      colors.border = colors.comment
    end,
    style = "storm",
  },
  config = function()
    vim.cmd([[colorscheme tokyonight-night]])
  end,
}
