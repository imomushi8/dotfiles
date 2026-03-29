return {
  {
    "williamboman/mason.nvim",
    opt = {}
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opt = {
      ensure_installed = {
        'yamlls',
        'vimls',
        'pylsp',
        'rust_analyzer',
      },
      automatic_installation = true,
    },
  },

  -- Error List
  {
    "folke/trouble.nvim",
    lazy = false,
    keys = {
      { mode = 'n', '<S-t><S-t>', '<cmd>TroubleToggle workspace_diagnostics<CR>', {noremap=true, silent=true} },
      { mode = 'n', '<S-t><S-d>', '<cmd>TroubleToggle document_diagnostics<CR> ', {noremap=true, silent=true} },
    }
  },

  -- Rust
  {
    "rust-lang/rust.vim",
    lazy = true,
    ft = { "rust" },
  },

  -- Scala
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    ft = { "scala", "sbt", "java" },
    dependencies = { "scalameta/nvim-metals" },
  },

  {
    "scalameta/nvim-metals",
    lazy = true,
    ft = { "scala", "sbt", "java" },
    opts = function()
      local metals_config = require("metals").bare_config()
      metals_config.on_attach = function(client, bufnr)
      end

      return metals_config
    end,
    config = function(self, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = self.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
      })

-- nnoremap <silent> <leader>ws  <cmd>lua require("metals").worksheet_hover()<CR>
-- nnoremap <silent> <leader>a   <cmd>lua require("metals").open_all_diagnostics()<CR>

-- :command MetalsToggleTreeview lua require("metals.tvp").toggle_tree_view()
-- :command MetalsRevealTreeview lua require("metals.tvp").reveal_in_tree()
    end
  },
}
