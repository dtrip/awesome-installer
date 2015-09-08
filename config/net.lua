-- wifi
neticon = wibox.widget.imagebox()
neticon:set_image(beautiful.pa_net)

wifiwidget_txt = wibox.widget.textbox()
wifiwidget = wibox.widget.background()
wifiwidget:set_widget(wifiwidget_txt)
wifiwidget:set_bg(beautiful.arrow_bg_2)
wifiwidget:set_fg(beautiful.bg_normal)
-- wifiwidget:set_border_color(beautiful.arrow_bg_2)
vicious.register(wifiwidget_txt, vicious.widgets.wifi, "${ssid} ${linp}%", 3, 'wlan0')

-- network stuff

-- netwidget = blingbling.net({
--     interface = "wlan0",
--     background_color = beautiful.arrow_bg_2
-- })
--
-- netwidget:set_ippopup()
-- netwidget:set_show_text(true)
-- netwidget:set_v_margin(3)
-- netwidget:set_h_margin(5)
