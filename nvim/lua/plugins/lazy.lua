local M = {}

-- デフォルト設定値
M.config = {
  lazy_cache = vim.fs.joinpath(vim.fn.stdpath("cache"), "nvim", "lazy.nvim"),
  ref_path = vim.fs.joinpath("plugins", "lazy", "neovim"),
}

-------------------------------------------------------------------------
-- setup関数
-------------------------------------------------------------------------
M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
  if not (vim.uv or vim.loop).fs_stat(M.config.lazy_cache) then
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", M.config.lazy_cache })
    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
        { out, "WarningMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(M.config.lazy_cache)

  -------------------------------------------------------------------------
  -- install
  -------------------------------------------------------------------------
  require("lazy").setup(M.config.ref_path, {
    performance = {
      rtp = {
        disabled_plugins = {
          "netrw",
          "netrwPlugin",
          "netrwSettings",
          "netrwFileHandlers",
        },
      },
    },
  })
end

return M
