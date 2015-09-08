

    -- local bar_menu = radical.bar{}
    -- local bar_menu_w = radical.bar{}
    bar_menu, bar_menu_w = radical.bar {
        item_style = radical.item.style.arrow_prefix,
        style = radical.style.arrow_single,
        arrow_type = radical.base.arrow_type.NONE,
        disable_submenu_icon = true,
        spacing = 4,
        bg_used = beautiful.bg_normal,
        bg = beautiful.bg_urgent,
        fg_focus = beautiful.fg_focus,
        fg = beautiful.fg_normal,
        default_item_margins = {
            TOP = 0,
            BOTTOM = 0,
            LEFT = 0,
            RIGHT = 20
        }
        -- bg_hover = "#00ff00",
        -- bg_focus = "#00ff00"
    }

    bar_menu:add_colors_namespace("toolbox")

    -- local app_menu = nil

    local it = bar_menu:add_item {
        text = "1",
        item_style = radical.item.style.arrow_prefix,
        icon = beautiful.ubuntu_drk,
        tooltip = "Application Menu",
        sub_menu = function ()
            local smenu = radical.context{
            }
            smenu:add_item{ text="Menu Item" }
            smenu:add_item{ text="Menu Item2", icon=beautiful.firefox }
            return smenu
        end}
    it.state[radical.base.item_flags.USED] = true

    it = bar_menu:add_item {
        text = "2",
        icon = beautiful.folder,
        tooltip = "Application Menu",
        sub_menu = function ()
            local smenu = radical.context{}
            smenu:add_item{ text="Home" }
            return smenu
        end}

    it.state[radical.base.item_flags.USED] = true

    -- bar_menu:add_item(rwidgets.battery())

    -- bar_menu:add_item(it)
    -- rmenubar:add_item { text = "Screen 1", icon = beautiful.awesome_icon }
    -- rmenubar:add_item { text = "Test", icon = beautiful.firefox }
    --
    -- local m = wibox.widget.textbox()
    -- m:set_menu(bar_menu)

    -- rbox = wibox.layout.align.horizontal()
    -- rbox:add(m)
    -- rbox:set_left(bar_menu)
    -- rbox:set_left(m)

    -- slayout:set_right(rmenubarbox)


