local M = {}

function M.setup(wezterm, config)
  local act = wezterm.action
  local mux = wezterm.mux

  -- デフォルトのキーバインドを無効化
  config.disable_default_key_bindings = true
  config.leader = { key = ',', mods = 'CTRL', timeout_milliseconds = 1500 }
  config.keys = {
    -- 基本操作
    { key = 'Enter', mods = 'ALT', action = act.ToggleFullScreen },                           -- フルスクリーン
    { key = 'y', mods = 'LEADER|CTRL', action = act.ActivateCopyMode },                       -- コピーモードに入る(ヤンク)
    { key = 'p', mods = 'LEADER|CTRL', action = act.PasteFrom 'Clipboard' },                  -- ペースト
    { key = ',', mods = 'LEADER|CTRL', action = act.ActivateCommandPalette },                 -- コマンドパレット表示
    { key = 'q', mods = 'LEADER|CTRL', action = act.QuitApplication },                        -- 終了
    { key = 'r', mods = 'LEADER|CTRL', action = act.ReloadConfiguration },                    -- 設定リロード
    { key = 'f', mods = 'LEADER|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' }, -- 検索
    { key = 's', mods = 'LEADER|CTRL', action = act.QuickSelect },                            -- quick select
    { key = 'u', mods = 'LEADER|CTRL', action = act.QuickSelectArgs {                         -- open URL
      label = 'open url',
      patterns = { 'https?://\\S+' },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.open_with(url)
      end),
    }},

    -- タブ操作
    { key = 'Tab', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateTabRelative(-1) },      -- タブ移動
    { key = 'Tab', mods = 'CTRL',       action = wezterm.action.ActivateTabRelative(1) },       -- タブ移動
    { key = 't',   mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab 'CurrentPaneDomain'},  -- タブ作成
    -- 閉じる操作はペインがすべてなくなったのと同義にしようかな
    -- {key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab},              -- タブを閉じる

    -- ペイン操作
    { key = 'h',     mods = 'ALT',            action = act.ActivatePaneDirection 'Left' },
    { key = 'j',     mods = 'ALT',            action = act.ActivatePaneDirection 'Down' },
    { key = 'k',     mods = 'ALT',            action = act.ActivatePaneDirection 'Up' },
    { key = 'l',     mods = 'ALT',            action = act.ActivatePaneDirection 'Right' },
    { key = '\\',    mods = 'CTRL|ALT',       action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } }, -- 縦分割
    { key = '-',     mods = 'CTRL|ALT',       action = act.SplitVertical { domain = 'CurrentPaneDomain' } },   -- 横分割
    { key = 'w',     mods = 'CTRL|ALT',       action = act.CloseCurrentPane { confirm = true } },              -- 閉じる
    { key = 'z',     mods = 'CTRL|ALT',       action = act.TogglePaneZoomState },                              -- ペインの最大化
    { key = 'h', mods = 'CTRL|ALT', action = act.AdjustPaneSize { 'Left', 5 } },                               -- ペインサイズ変更
    { key = 'j', mods = 'CTRL|ALT', action = act.AdjustPaneSize { 'Down', 5 } },
    { key = 'k', mods = 'CTRL|ALT', action = act.AdjustPaneSize { 'Up', 5 } },
    { key = 'l', mods = 'CTRL|ALT', action = act.AdjustPaneSize { 'Right', 5 } },
    -- あんま使わんと思うからコメントアウト
    -- { key = 'Space',     mods = 'CTRL|ALT',       action = act.RotatePanes 'Clockwise' },                          -- cycle layout
    -- { key = 'Space',     mods = 'CTRL|ALT|SHIFT', action = act.RotatePanes 'CounterClockwise' },                   -- cycle layout counter
  }

  config.key_tables = {
    -- コピーモードのキーバインドはvimっぽく
    copy_mode = {
      -- Movement
      { key = 'h', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'j', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'k', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'l', mods = 'NONE', action = act.CopyMode 'MoveRight' },
      { key = 'LeftArrow', mods = 'NONE', action = act.CopyMode 'MoveLeft' },
      { key = 'DownArrow', mods = 'NONE', action = act.CopyMode 'MoveDown' },
      { key = 'UpArrow', mods = 'NONE', action = act.CopyMode 'MoveUp' },
      { key = 'RightArrow', mods = 'NONE', action = act.CopyMode 'MoveRight' },

      -- Word movement
      { key = 'w', mods = 'NONE', action = act.CopyMode 'MoveForwardWord' },
      { key = 'b', mods = 'NONE', action = act.CopyMode 'MoveBackwardWord' },
      { key = 'e', mods = 'NONE', action = act.CopyMode 'MoveForwardWordEnd' },

      -- Line movement
      { key = '0', mods = 'NONE', action = act.CopyMode 'MoveToStartOfLine' },
      { key = '$', mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
      { key = '^', mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },

      -- Page movement
      { key = 'g', mods = 'NONE', action = act.CopyMode 'MoveToScrollbackTop' },
      { key = 'G', mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
      { key = 'u', mods = 'CTRL', action = act.CopyMode 'PageUp' },
      { key = 'd', mods = 'CTRL', action = act.CopyMode 'PageDown' },

      -- Selection
      { key = 'v', mods = 'NONE', action = act.CopyMode { SetSelectionMode = 'Cell' } },
      { key = 'V', mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' } },
      { key = 'v', mods = 'CTRL', action = act.CopyMode { SetSelectionMode = 'Block' } },

      -- Copy and exit
      { key = 'y', mods = 'NONE', action = act.Multiple {
        { CopyTo = 'ClipboardAndPrimarySelection' },
        { CopyMode = 'Close' },
      }},

      -- Exit copy mode
      { key = 'q', mods = 'NONE', action = act.CopyMode 'Close' },
      { key = 'Escape', mods = 'NONE', action = act.CopyMode 'Close' },

      -- Search
      { key = '/', mods = 'NONE', action = act.Search 'CurrentSelectionOrEmptyString' },
      { key = 'n', mods = 'NONE', action = act.CopyMode 'NextMatch' },
      { key = 'N', mods = 'SHIFT', action = act.CopyMode 'PriorMatch' },
    },
  }

end

return M
