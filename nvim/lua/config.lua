local M = {}

-- デフォルト設定値
M.runtime = ""

-------------------------------------
-- neovimの環境別の設定を行うモジュール
-------------------------------------
M.setup = function()
  -- 実行環境取得
  if vim.g.vscode then
    M.runtime = "vscode"
  else
    M.runtime = "neovim"
  end
end

-------------------------------------------------------------------------
-- neovim環境別のoption設定を行う
-------------------------------------------------------------------------
M.setOption = function()
  require("runtime."..M.runtime..".option")
end

-------------------------------------------------------------------------
-- neovim環境別のkeymap設定を行う
-------------------------------------------------------------------------
M.setKeymap = function()
  require("runtime."..M.runtime..".keymap")
end

-------------------------------------------------------------------------
-- neovim環境別のautocmd設定を行う
-------------------------------------------------------------------------
M.setAutocmd = function()
  require("runtime."..M.runtime..".autocmd")
end

-------------------------------------------------------------------------
-- neovim環境別のplugin設定を行う
-------------------------------------------------------------------------
M.setPlugins = function()
  require("plugins.lazy").setup({
    ref_path = vim.fs.joinpath("plugins", "lazy", M.runtime),
  })
end

return M
