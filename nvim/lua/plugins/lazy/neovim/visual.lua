return {
  -- Scroll Bar
  {
    "petertriho/nvim-scrollbar",
    dependencies = { "catppuccin/nvim" },
    config = function()
      local colors = require("catppuccin.palettes").get_palette "mocha"
      require("scrollbar").setup({
        marks = {
          Search = { color = colors.flamingo },
          Error = { color = colors.red },
          Warn = { color = colors.yellow },
          Info = { color = colors.sky },
          Hint = { color = colors.teal },
          Misc = { color = colors.green },
        }
      })

      require("scrollbar.handlers.search").setup()
    end
  },

  -- 後は見やすくなるようなハイライト系
  {
    "kevinhwang91/nvim-hlslens"
  },

  {
    "t9md/vim-quickhl"
  },

  {
    "markonm/traces.vim"
  },

  -- TODO Coloring
  {
    "folke/todo-comments.nvim"
  },

  -- インデントを表示する
  {
    "Yggdroot/indentLine",
    init = function()
      vim.g.indentLine_setColors = 0
      vim.g.indentLine_char      = "¦"
    end
  },

  -- 行の横にgitの差分表示を行う
  {
    "airblade/vim-gitgutter",
    init = function()
      vim.g.gitgutter_sign_added    = "+"
      vim.g.gitgutter_sign_modified = "*"
      vim.g.gitgutter_sign_removed  = "-"
    end
  },
}
