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
config.audible_bell = "Disabled"

require("appearance").setup(wezterm, config)
require("shell").setup(wezterm, config)
require("keymap").setup(wezterm, config)

return config
