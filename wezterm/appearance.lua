local M = {}

-- ブランチ名:ディレクトリ名を記憶しておくテーブル
local title_cache = {}

----------------------------------------------------
-- 外観の設定
----------------------------------------------------
function M.setup(wezterm, config)
  ----------------------------------------------------
  -- 全体
  ----------------------------------------------------
  config.window_background_opacity = 0.95
  config.font_size = 11.0
  config.font = wezterm.font("JetBrainsMono Nerd Font")
  config.color_scheme = 'Afterglow'

  ----------------------------------------------------
  -- ウィンドウ
  ----------------------------------------------------
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

  ----------------------------------------------------
  -- タブ
  ----------------------------------------------------
  -- Windows Terminalっぽくするならこれ
  -- config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'
  -- config.tab_max_width = 20
  -- config.window_frame = {
  --   font = wezterm.font { family = 'JetBrainsMono Nerd Font' },
  --   font_size = 12.0, -- この値を大きくするとタブバーが太くなる
  -- }

  -- カスタマイズ性を重視するならこれ
  config.use_fancy_tab_bar = false
  config.tab_bar_at_bottom = true

  -- タブのタイトルを変更
  wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local original_title = tab.active_pane.title
    local title = original_title:match("^.+\\(.+)$") or original_title

    if string.find(original_title,"Administrator") ~= nil then
      title = "🛡️" .. title
    end

    if #title > 20 then
      title = string.sub(title, 1, 20) .. '..'
    end
    
    return {
      {Text = ' ' .. title .. ' '},
    }
  end)
end

return M
