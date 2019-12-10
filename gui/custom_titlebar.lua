local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local shape = require('util.custom_shapes')
local gears = require('gears')

local module = {}

local v_border = beautiful.vertical_border_width
local h_border = beautiful.side_border_width
-- set top height based on if titlebars are requested
local titlebar_enabled = beautiful.titlebar_enabled
local titlebar_height = 0
if titlebar_enabled then 
    titlebar_height = beautiful.titlebar_height 
else
    titlebar_height = v_border
end


-- creates initial titlebar, and sets shape
function module.create_titlebar(client)
    local titlebar_buttons = gears.table.join(
        -- if clicked, raise the window. Hold to move.
        awful.button({ }, 1, function()
            client:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(client)
        end),
        -- right click will raise the window, hold will resize
        awful.button({ }, 3, function()
            client:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(client)
        end)
    )
    local border_buttons = gears.table.join(
        -- if clicked, raise the window. Hold to resize.
        awful.button({ }, 1, function()
            client:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(client)
        end)
    )

    awful.titlebar.enable_tooltip = false
    -- setup titlebar content based on if we expect to create a border or titlebar
    local titlebar_content = {}
    if (titlebar_enabled) then
        titlebar_content = 
        {
            { -- empty left widget placeholder
                buttons = titlebar_buttons,
                layout = wibox.layout.fixed.horizontal
            },
            { -- center client title
                {
                    align = 'center',
                    widget = awful.titlebar.widget.titlewidget(client)
                },
                -- enable titlebar control here (drag and move)
                buttons = titlebar_buttons,
                layout = wibox.layout.flex.horizontal
            },
            { -- Right bottom set
                awful.titlebar.widget.maximizedbutton(client),
                awful.titlebar.widget.minimizebutton(client),
                awful.titlebar.widget.closebutton(client),
                layout = wibox.layout.fixed.horizontal
            },
            layout = wibox.layout.align.horizontal
        }
    else
        -- empty textbox so our titlebars still get created
        titlebar_content = {
            text = '',
            widget = wibox.widget.textbox,
            buttons = border_buttons
        }
    end
    -- manual setup for top titlebar, since it can have buttons and text
    awful.titlebar(client,{size = titlebar_height, position = 'top'}) : setup {
        -- can be either content, or empty textbox (depending on if titlebar is enabled)
        titlebar_content,
        id = 'custom_bg',
        bg = beautiful.titlebar_bg_focus_override,
        widget = wibox.container.background,
        clip = true,
        shape = function (cr,w,h)
                    if (beautiful.smooth_corners) then
                        return shape.full_round_rect(cr,w,h,'top',beautiful.corner_radius)
                    else
                        return gears.shape.rectangle(cr,w,h)
                    end
                end,
    }
    -- add titlebars on all sides, so that we can smooth corners
    for pos,thick in pairs({left = h_border,right = h_border, bottom = v_border}) do
        -- setup titlebar on each side of window (some will look like border)
        awful.titlebar(client,{size = thick, position = pos}) : setup {
            {
                text = '',
                widget = wibox.widget.textbox
            },
            id = 'custom_bg',
            bg = beautiful.titlebar_bg_focus_override,
            widget = wibox.container.background,
            clip = true,
            shape = function (cr,w,h)
                if ((pos == 'top' or pos == 'bottom') and beautiful.smooth_corners) then
                    return shape.full_round_rect(cr,w,h,pos,beautiful.corner_radius)
                else
                    return gears.shape.rectangle(cr,w,h)
                end
            end,
            buttons = border_buttons,
        }
    end
end

-- updates custom color of titlebar as mouse enters 
function module.focus_titlebar(client)
    if (not client.requests_no_titlebar) then 
        for pos,thick in pairs({top = titlebar_height ,left = h_border,right = h_border, bottom = v_border}) do
            awful.titlebar(client,{size = thick, position = pos}).custom_bg.bg = beautiful.titlebar_bg_focus_override
        end
    end
end

-- updates custom color of titlebar as mouse exits 
function module.unfocus_titlebar(client)
    if (not client.requests_no_titlebar) then
        for pos,thick in pairs({top = titlebar_height ,left = h_border,right = h_border, bottom = v_border}) do
            awful.titlebar(client,{size = thick, position = pos}).custom_bg.bg = beautiful.titlebar_bg_normal_override    
        end
    end
end

return module
