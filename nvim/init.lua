vim.scriptencoding = "utf-8"
vim.g.base_dir = vim.fs.joinpath(vim.env.XDG_CONFIG_HOME, vim.env.NVIM_APPNAME or "nvim")

local config = require("config") -- ランタイム別の設定読み込み
config.setup()
config.setOption()
config.setKeymap()
config.setAutocmd()
config.setPlugins()

-- この辺はセットアップ完了後にやらないと意味ないらしい
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")
