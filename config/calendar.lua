-- calendar blingbling and friends
-- calw = blingbling.calendar.new({
--     type = "textbox",
--     text = "Calendar"
-- })

-- calw:set_cell_padding(4)
-- calw:set_columns_lines_titles_text_color(beautiful.fg_focus)
-- calw:set_title_text_color(beautiful.bg_focus)

--  Date widget
datewidget_txt = wibox.widget.textbox()
datewidget = wibox.widget.background()
datewidget:set_widget(datewidget_txt)
datewidget:set_bg(beautiful.arrow_bg_1)
vicious.register(datewidget_txt, vicious.widgets.date, "%b %d %r", 1)

-- Create a textclock widget
-- mytextclock = awful.widget.textclock()
