local wezterm = require("wezterm")

-- 設定開始
local config = wezterm.config_builder()

-- 基本設定等
config.automatically_reload_config = true
config.status_update_interval = 1000
config.use_ime = true
config.animation_fps = 60
config.scrollback_lines = 1000
config.front_end = "WebGpu" -- 画面のちらつきを防ぐ

-- 外観
config.window_background_opacity = 0.95
config.font_size = 11.0
config.color_scheme = "Ayu Dark (Gogh)"
config.font = wezterm.font("JetBrainsMono Nerd Font")


-- 各タブの「ブランチ名:ディレクトリ名」を記憶しておくテーブル
local title_cache = {}

-- 各タブ（正確にはpane）に「ブランチ名:ディレクトリ名」を記憶させる
wezterm.on("update-status", function(window, pane)
  local cwd_uri = wezterm.to_string(pane:get_current_working_dir())
  local cwd = cwd_uri:gsub("\\", "/"):gsub("^file://", "")

  if cwd then
    local title = cwd

    -- Gitのブランチ名を取得
    local success, stdout, stderr = wezterm.run_child_process({
      "git", "-C", cwd, "branch", "--show-current"
    })

    -- Gitブランチ名を取得できたら「ブランチ名:ディレクトリ名」と表示できるようにする
    if success then
      local branch = stdout:gsub("%s+", "")
      title = branch .. ":" .. title
    end

    title_cache[pane:pane_id()] = title
  end
end)

-- ウィンドウのタイトルを変更
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
  local zoomed = ''
  if tab.active_pane.is_zoomed then
    zoomed = '[Z] '
  end

  local index = ''
  if #tabs > 1 then
    index = string.format('[%d/%d] ', tab.tab_index + 1, #tabs)
  end

  local title = tab.active_pane.title

  local pane_id = pane.pane_id

  -- 記憶させていた「ブランチ名:ディレクトリ名」を取り出す
  if title_cache[pane_id] then
    title = title_cache[pane_id]
  end

  return zoomed .. index .. title

end)

require("tabbar").setup(wezterm, config)
require("shell").setup(wezterm, config)

return config

