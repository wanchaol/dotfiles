-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux


-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- config fonts
config.font = wezterm.font {
  family = 'JetBrains Mono',
  weight = 'Medium',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- disable ligatures
}
config.font_size = 13.0
config.line_height = 1.0

-- config window style
-- Slightly transparent and blurred background
--config.window_background_opacity = 0.9
--config.macos_window_background_blur = 30
-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'
-- Sets the font for the window frame (tab bar)
config.window_frame = {
  -- Berkeley Mono for me again, though an idea could be to try a
  -- serif font here instead of monospace for a nicer look?
  font = wezterm.font({ family = 'JetBrains Mono', weight = 'Bold' }),
  font_size = 13.5,
}
config.window_padding = {
  left=3,
  right=3,
  top=0,
  bottom=0,
}

-- config the color scheme:
config.color_scheme = 'Dracula (Gogh)'
-- config.color_scheme = 'Nord (Gogh)'


-- and finally, return the configuration to wezterm
return config
