local M = {}

----------------------------------------------------
-- Tab Bar
----------------------------------------------------
function M.setup(wezterm, config)
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
