
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.pa_cpu)

-- CPU Widget
-- cpuwidget_txt = wibox.widget.textbox()
-- cpuwidget = wibox.widget.background()

-- cpuwidget:set_widget(cpuwidget_txt)
-- cpuwidget:set_bg(beautiful.bg_focus)
-- vicious.register(cpuwidget_txt, vicious.widgets.cpu, "")


-- CPU Bling bling graph and friends
cpu_conf = {
    height = 21,
    width = 8,
    rounded_size = 0,
    -- graph_background_color = beautiful.arrow_bg_4,
    background_color = beautiful.arrow_bg_4,
    -- graph_background_border = beautiful.arrow_bg_4,
    background_border = beautiful.arrow_bg_4
}

cpu_graphs = {}

for i=1,CORES do
    cpu_graphs[i] = blingbling.progress_graph(cpu_conf)

    -- blingbling.popups.htop(cpu_graphs[i], { terminal = terminal })

    vicious.register(cpu_graphs[i], vicious.widgets.cpu, "$"..(i+1).."",1)
end

