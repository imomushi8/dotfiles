return {
  -- ColorScheme
  {
    "catppuccin/nvim",
    config = function()
      vim.cmd.colorscheme "catppuccin"
    end,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      term_colors = true,
      transparent_background = false,
      no_italic = false,
      no_bold = false,
      styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
      },
      color_overrides = {
        mocha = {
          base = "#000000",
          mantle = "#000000",
          crust = "#000000",
        },
      },
      highlight_overrides = {
        mocha = function(C)
          return {
            TabLineSel = { bg = C.pink },
            CmpBorder = { fg = C.surface2 },
            Pmenu = { bg = C.none },
            TelescopeBorder = { link = "FloatBorder" },
          }
        end,
      },
      integrations = {
        aerial = true,
        mason = true,
        navic = {
            enabled = true,
            custom_bg = "NONE",
        },
        treesitter = true,
        lsp_trouble = true,
        gitgutter = true,
      },
    }
  },
}