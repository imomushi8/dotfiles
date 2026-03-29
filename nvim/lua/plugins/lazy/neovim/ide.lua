local builtin = require('telescope.builtin')

return {
  -- Fuzzy Finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { mode = 'n', ';f', builtin.find_files, { desc = 'Telescope find files' } },
      { mode = 'n', ';g', builtin.live_grep,  { desc = 'Telescope live grep' }  },
      { mode = 'n', ';b', builtin.buffers,    { desc = 'Telescope buffers' }    },
      { mode = 'n', ';h', builtin.help_tags,  { desc = 'Telescope help tags' }  },
    }
  },

  -- プロジェクトルートに移動する
  {
    "notjedi/nvim-rooter.lua",
    opt = {
      rooter_patterns = { ".git", ".hg", ".svn", "build.sbt", "Cargo.toml"},
      trigger_patterns = { "*" },
      manual = false,
      fallback_to_parent = false,
      cd_scope = "global",
    }
  },

  -- バッファの削除強化
  {
    "famiu/bufdelete.nvim",
    lazy = false,
    keys = {
      { mode = "n", "<C-d>", "<Cmd>Bdelete<CR>", {noremap=true, silent=true} },
    },
  },

  -- Gitの操作をvimコマンドで行う
  {"tpope/vim-fugitive"},

  -- cmp系
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/vim-vsnip" },
}
