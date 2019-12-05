--[[
theme overrides on top of gtk theme
--]]
local t = {}
local dpi = require('beautiful').xresources.apply_dpi
local theme_root = require('gears.filesystem').get_configuration_dir() .. '/theme/pop/'
local shape = require('gears.shape')




-- color scheme

local colors = { 
    '#274156', -- royal blue
    '#FBFCFF', -- white
    '#605856', -- brown
    '#274156', -- bright red
    '#D0CCD0', -- redish white mix
}

local invisible = '#12345600'

local font = 'Hack Nerd Font'

--GLOBAL DEFAULTS
t.bg_normal             = colors[4]
t.fg_normal             = colors[2]
t.bg_focus              = colors[3]
t.fg_focus              = colors[2]

t.wallpaper     = theme_root .. 'wallpaper.jpg'
t.font = font .. '11'
t.icon_font         = 'Hack Nerd Font'
t.icon_theme        = 'Paprius-Light'

-- CLIENT SECTION

t.corner_radius = dpi(0)
t.cust_border_width = dpi(0) -- use this to change side width
t.border_width  = dpi(2)
t.border_normal = colors[1]
t.border_focus  = colors[3]
t.border_marked = invisible



-- TITLEBAR SECTION

t.titlebar_height = dpi(27)
t.titlebar_fg_normal    = colors[1]
t.titlebar_bg_normal    = t.border_normal
t.titlebar_fg_focus     = colors[3]
t.titlebar_bg_focus     = t.border_focus
-- CUSTOM TITLEBAR
t.titlebar_bg_focus_custom  = colors[3]
t.titlebar_bg_normal_custom = colors[2]

local titlebar_ic = theme_root .. '/icons/titlebar/'

t.titlebar_close_button_normal = titlebar_ic .. "close_normal.svg"
t.titlebar_close_button_normal_hover = titlebar_ic .. "close_normal_hover.svg"
t.titlebar_close_button_focus  = titlebar_ic .."close_focus.svg"
t.titlebar_close_button_focus_hover = titlebar_ic .. "close_focus_hover.svg"

t.titlebar_minimize_button_normal = titlebar_ic .. "min_normal.svg"
t.titlebar_minimize_button_normal_hover = titlebar_ic .. "min_normal_hover.svg"
t.titlebar_minimize_button_focus  = titlebar_ic .. "min_focus.svg"
t.titlebar_minimize_button_focus_hover  = titlebar_ic .. "min_focus_hover.svg"

t.titlebar_maximized_button_normal_inactive = titlebar_ic .. "max_normal.svg"
t.titlebar_maximized_button_normal_active = titlebar_ic .. "max_normal.svg"
t.titlebar_maximized_button_normal_active_hover = titlebar_ic .."max_normal_hover_active.svg"
t.titlebar_maximized_button_normal_inactive_hover = titlebar_ic .."max_normal_hover.svg"
t.titlebar_maximized_button_focus_inactive  = titlebar_ic .. "max_focus.svg"
t.titlebar_maximized_button_focus_active  = titlebar_ic .. "max_focus.svg"
t.titlebar_maximized_button_focus_inactive_hover = titlebar_ic .. "max_focus_hover.svg"
t.titlebar_maximized_button_focus_active_hover = titlebar_ic .. "max_focus_hover_active.svg"

--TOOLTIP SECTION

t.tooltip_border_color  = colors[1] 
t.tooltip_bg            = colors[3]
t.tooltip_fg            = colors[1]
t.tooltip_font          = font .. '10'
t.tooltip_border_width  = dpi(1)
t.tooltip_opacity       = 50
t.tooltip_shape         = function(cr,w,h) shape.rounded_rect(cr,w,h,3) end
-- WIBAR SECTION

t.wibar_border_color    = invisible
t.wibar_border_width    = dpi(0)
t.wibar_ontop           = false
t.wibar_type            = 'dock'
t.wibar_font            = font .. '13'
t.wibar_fg              = colors[2]
t.wibar_bg              = invisible
t.wibar_shape           = shape.rectangle
t.wibar_height          = dpi(40)

--CUSTOM WIBAR VARS

t.wibar_inner_bg        = colors[4]
t.wibar_radius          = dpi(0)

-- TAG SECTION --
t.master_width_factor = 0.6
t.useless_gap = dpi(0)
t.gap_single_client = true
t.master_fill_policy = 'expand'
t.master_count = 1
t.column_count = 1

--TAGLIST SECTION --
local layout_ic = theme_root .. '/icons/layouts/'
t.layout_tile = layout_ic .. 'tiled.svg'
t.layout_floating = layout_ic .. 'floating.svg'
t.taglist_fg_focus  = colors[3]
t.taglist_height     = dpi(40)
t.taglist_spacing   =  dpi(0)
t.taglist_font      = 'Hack Nerd Font'
t.taglist_bg_focus  = colors[4]
t.taglist_fg_occupied = colors[5]

-- SYSTEM TRAY SECTION

t.systray_icon_spacing = dpi(1)

-- NOTIFICATION THEME
t.notification_font = font .. '13'
t.notification_bg   =  colors[3]
t.notification_max_width = dpi(500)
t.notification_icon_size = 75
t.notification_shape = function(cr,w,h) return shape.rounded_rect(cr,w,h,5) end

return t
