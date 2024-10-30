local wezterm = require 'wezterm'

local config = wezterm.config_builder()

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { 'C:\\Windows\\System32\\cmd.exe', '/c', 'C:\\Program Files\\Git\\bin\\sh.exe', '--cd-to-home' }
end

return config

