

--Volume Widget
-- volwidget_txt = wibox.widget.textbox()
-- volwidget = wibox.widget.background()

volicon_img = wibox.widget.imagebox()
volicon = wibox.widget.background()
volicon_img:set_image(beautiful.widget_vol_mute)
volicon:set_widget(volicon_img)
volicon:set_bg(beautiful.arrow_bg_6)

-- volwidget:set_widget(volwidget_txt)
-- volwidget:set_bg(beautiful.bg_focus)
-- vicious.register(volwidget_txt, vicious.widgets.volume,
-- function(widget, args)
--     local label = { ["♫"] = "O", ["♩"] = "M" }
--     return args[1] .. "% " .. label[args[2]]
-- end, 2, "PCM")

-- bling bling volume widget
bvol = blingbling.volume()
-- bvol:set_height(16)
bvol:set_width(30)
bvol:set_background_color(beautiful.arrow_bg_6)
-- bvol:update_master()
bvol:set_master_control()
bvol:set_bar(true)

vicious.register(bvol, vicious.widgets.volume,
function(widget, args)
    -- local label = { ["♫"] = "O", ["♩"] = "M" }
    return args[1]
end, 2, "PCH")




-- local wibox = require("wibox")
-- local awful = require("awful")
--
-- volume_widget = wibox.widget.textbox()
-- volume_widget:set_align("right")
--
-- function update_volume(widget)
--    local fd = io.popen("amixer sget Master")
--    local status = fd:read("*all")
--    fd:close()
--
--    local volume = tonumber(string.match(status, "(%d?%d?%d)%%")) / 100
--    -- volume = string.format("% 3d", volume)
--
--    status = string.match(status, "%[(o[^%]]*)%]")
--
--    -- starting colour
--    local sr, sg, sb = 0x3F, 0x3F, 0x3F
--    -- ending colour
--    local er, eg, eb = 0xDC, 0xDC, 0xCC
--
--    local ir = volume * (er - sr) + sr
--    local ig = volume * (eg - sg) + sg
--    local ib = volume * (eb - sb) + sb
--    interpol_colour = string.format("%.2x%.2x%.2x", ir, ig, ib)
--    if string.find(status, "on", 1, true) then
--        volume = " <span background='#" .. interpol_colour .. "'>   </span>"
--    else
--        volume = " <span color='red' background='#" .. interpol_colour .. "'> M </span>"
--    end
--    widget:set_markup(volume)
-- end
--
-- update_volume(volume_widget)
--
-- mytimer = timer({ timeout = 1 })
-- mytimer:connect_signal("timeout", function () update_volume(volume_widget) end)
-- mytimer:start()
