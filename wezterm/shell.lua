local M = {}

----------------------------------------------------
-- Shell
----------------------------------------------------
function M.setup(wezterm, config)
  -- Windows の場合は PowerShell を指定
  if wezterm.target_triple:find("windows") ~= nil then
    config.default_prog = { "pwsh.exe" }
    -- WSLだけで使いたい場合は以下のコメントを外す
    -- config.default_prog = { 'wsl', '-d', 'Arch' }

  -- 他の OS (例: Linux/macOS) の場合は fish を指定
  else
    config.default_prog = { "/usr/sbin/fish" }
  end
end

return M
