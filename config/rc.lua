-- Standard awesome library
local gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
wibox = require("wibox")
-- Theme handling library
beautiful = require("beautiful")
-- Notification library
naughty = require("naughty")
radical = require("radical")
vicious = require("vicious")

-- rwidgets = require("init")

menubar = require("menubar")
blingbling = require("blingbling")

-- Number of CPU cores
CORES = 4

-- Load Debian menu entries
-- require("debian.menu")




-- package.path = package.path .. ":/usr/local/lib/python2.7/dist-packages/powerline/bindings/awesome/"
-- require('powerline')



-- awful.util.spawn_with_shell("xcompmgr -cfF -t-9 -l-11 -r9 -o.95 -D6 > /dev/null &")
-- awful.util.spawn_with_shell("xcompmgr -cfF -t-9 -l-11 -r9 -o.95 -D6 > /dev/null &")
awful.util.spawn_with_shell("xcompmgr > /dev/null &")


awful.util.spawn_with_shell("echo 'pointer = 1 2 3 5 4 7 6 8 9 10 11 12' > ~/.Xmodmap && xmodmap ~/.Xmodmap &")
-- awful.util.spawn_with_shell("naturalscrolling &")
awful.util.spawn_with_shell("xscreensaver -nosplash &")
-- awful.util.spawn_with_shell("solaar &")
--
-- sets touch screen
awful.util.spawn_with_shell("xinput set-prop 'SYNAPTICS Synaptics Touch Digitizer V04' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1 &")

-- sets network monitor applet in taskbar
awful.util.spawn_with_shell("bash ~/.ubuntu/scripts/nm-applet.bash &")

-- used to start solaar applet for logitech keyboards
awful.util.spawn_with_shell("bash ~/.ubuntu/scripts/solaar.bash &")

-- starts conky widgets
awful.util.spawn_with_shell("bash ~/.ubuntu/scripts/conky.bash &")

-- awful.util.spawn_with_shell("sh ~/.wallpaper &")
-- awful.util.spawn_with_shell("sh ~/.conky/conky-startup.sh &")

sep = wibox.widget.textbox()
spacer = wibox.widget.textbox()
sep:set_text(' /  ')
spacer:set_text(' ')

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "ERROR",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
-- beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("~/.config/awesome/themes/powerarrow-darker/theme.lua")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts = {
    awful.layout.suit.floating,
    -- awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier
}
-- }}}

-- requires after theme has been loaded
require("cpu")
require("net")
require("volume")
require("calendar")
require("battery")
require("osk")
-- require("menu")
require("java")
require("tags")

-- This is used later as the default terminal and editor to run.
terminal = "terminator"
chrome = "chromium-browser"
ichrome = "chromium-browser --incognito"

--loads firefox with specified gtk-2.0 theme
-- firefox = "env GTK2_RC_FILES=/usr/share/themes/Zuki/gtk-2.0/gtkrc firefox"
firefox = "firefox"

fileman = "nemo --no-desktop"
-- fileman = 'thunar'
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

terminology = "terminology"

restart_cmd = "shutdown -r now"
shutdown_cmd = "shutdown now"

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.

-- tags = {}

-- ter_icon = wibox.widget.imagebox()
-- www_icon = wibox.widget.imagebox()
-- gmp_icon = wibox.widget.imagebox()

-- ter_icon:set_image(beautiful.term_icon)

-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "Manual", terminal .. " -e man awesome" },
   { "Edit Config", editor_cmd .. " " .. awesome.conffile },
   { "Reload Awesome", awesome.restart },
   { "Log Out", awesome.quit },
   { "", nil },
   { "Restart Computer", restart_cmd },
   { "Shutdown Computer", shutdown_cmd }
}

mymainmenu = awful.menu({ items = {
                                    { "Firefox", firefox, beautiful.firefox },
                                    { "Incognito Chrome", ichrome, beautiful.www_icon },
                                    { "Chrome", chrome, beautiful.www_icon },
                                    { "Terminal", terminal, beautiful.term_icon },
                                    { "Files", fileman, beautiful.files },
                                    { "Terminology", terminology, beautiful.term_icon },
                                    -- { "Main Menu", debian.menu.Debian_menu.Debian, beautiful.debian },
                                    { "Awesome", myawesomemenu, beautiful.awesome_icon }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Arrows
    arrl = wibox.widget.imagebox()
    arrl:set_image(beautiful.arrl)

    arrl_dl = wibox.widget.imagebox()
    arrl_dl:set_image(beautiful.arrl_dl)

    arrl_ld = wibox.widget.imagebox()
    arrl_ld:set_image(beautiful.arrl_ld)

    arrl_ld_sf = wibox.widget.imagebox()
    arrl_ld_sf:set_image(beautiful.arrl_ld_sf)


    -- colored arrows
    arr1 = wibox.widget.imagebox()
    arr1:set_image(beautiful.arr1)

    arr2 = wibox.widget.imagebox()
    arr2:set_image(beautiful.arr2)

    arr3 = wibox.widget.imagebox()
    arr3:set_image(beautiful.arr3)
    
    arr4 = wibox.widget.imagebox()
    arr4:set_image(beautiful.arr4)

    arr5 = wibox.widget.imagebox()
    arr5:set_image(beautiful.arr5)

    arr6 = wibox.widget.imagebox()
    arr6:set_image(beautiful.arr6)

    arr7 = wibox.widget.imagebox()
    arr7:set_image(beautiful.arr7)

    arr8 = wibox.widget.imagebox()
    arr8:set_image(beautiful.arr8)

    arr9 = wibox.widget.imagebox()
    arr9:set_image(beautiful.arr9)
-- }}}

-- {{{ Wibox
-- memory icon
memicon = wibox.widget.background()
memicon_img = wibox.widget.imagebox()
memicon_img:set_image(beautiful.widget_mem)
memicon:set_widget(memicon_img)
memicon:set_bg(beautiful.arrow_bg_3)
memicon:set_fg(beautiful.bg_normal)

--  Memory Widget
memwidget_txt = wibox.widget.textbox()
memwidget = wibox.widget.background()
memwidget:set_widget(memwidget_txt)
memwidget:set_bg(beautiful.arrow_bg_3)
memwidget:set_fg(beautiful.bg_normal)
vicious.register(memwidget_txt, vicious.widgets.mem, "$1% $2MB ", 13)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mystatusbar = {}

mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({
                                                      theme = { width = 250 }
                                                  })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                              -- delay_raise()
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                              -- delay_raise()
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    -- [[
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- mystatusbar[s] = awful.wibox({ position = "bottom", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    -- left_layout:add(menubox)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()

    if s == 1 then

        right_layout:add(arrl)
        right_layout:add(spacer)
        right_layout:add(wibox.widget.systray())
        right_layout:add(spacer)
    end

    right_layout:add(arr8)
    right_layout:add(volicon)
    right_layout:add(bvol)
    -- right_layout:add(volwidget)
    right_layout:add(arr6)
    -- right_layout:add(spacer)
    right_layout:add(baticon)
    -- right_layout:add(rwidgets.battery())
    -- right_layout:add(spacer)
    -- right_layout:add(spacer)
    -- right_layout:add(batwidget)
    -- right_layout:add(batg)
    right_layout:add(arr5)
    right_layout:add(cpuicon)

    for i=1,CORES do
        right_layout:add(cpu_graphs[i])
    end

    -- right_layout:add(cpuwidget)
    right_layout:add(arr4)
    right_layout:add(memicon)
    right_layout:add(memwidget)
    right_layout:add(arr3)
    right_layout:add(neticon)
    right_layout:add(wifiwidget)
    -- right_layout:add(netwidget)
    right_layout:add(arr2)

    -- right_layout:add(volume_widget)
    -- right_layout:add(mytextclock)
    --
    -- right_layout:add(spacer)
    right_layout:add(datewidget)
    -- right_layout:add(calw)
    right_layout:add(arr1)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)

    -- mystatusbar[s]:set_widget(bar_menu_w)
    -- mystatusbar[s]:set_widget(rbox)
    -- ]]--
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
            -- delay_raise()
        end),

    awful.key({modkey, "Shift"}, "m",
        function()
            awful.util.spawn_with_shell("~/.ubuntu/scripts/trackpad-toggle.sh &", false)
            naughty.notify({
                title = "Trackpad",
                text = "Trackpad has been toggled",
                position = top_right,
                timeout = 2,
                ontop = true
            })
        end),

    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
            -- delay_raise()
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.history.previous()
            -- delay_raise()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),

    -- Brightness
    awful.key({ modkey, "Shift"      }, "p",
        function ()
            awful.util.spawn("xbacklight -dec 5") 
        end),

    awful.key({ modkey, "Shift"      }, "o",
        function ()
            awful.util.spawn("xbacklight -inc 5")
        end),

    awful.key({ modkey, "Control" }, "l",
        function ()
            awful.util.spawn("xscreensaver-command -lock")
        end),

    -- awful.key({ }, "F10", function() toggle_conky() end),
    awful.key({ }, "XF86AudioRaiseVolume",
        function ()
            awful.util.spawn("amixer -c 1 set Master 5%+", false)
        end),

    awful.key({ }, "XF86AudioLowerVolume",
        function ()
            awful.util.spawn("amixer -c 1 set Master 5%-", false)
        end),
    awful.key({ }, "XF86AudioMute",
        function ()
            awful.util.spawn("amixer -c 1 set Master toggle", false)
        end),

    -- executes script to enable only primary monitor
    awful.key({ modkey, "Shift" }, "Down",
        function ()
            awful.util.spawn_with_shell("~/.ubuntu/scripts/ext_monitor_disconnect &", false)
        end),
    -- executes script to enable secondary external monitor (in this case HDMI1)
    awful.key({ modkey, "Shift" }, "Up",
        function ()
            awful.util.spawn_with_shell("~/.ubuntu/scripts/ext_monitor_connect &", false)
        end)

)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     size_hints_honor = false,
                     callback = awful.client.setslave, } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[2][1] } },
    --
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- {
    --     rule = {
    --         class = "Chrome"
    --     },
    --     properties = {
    --         tag = tags[1][2]
    --     }
    -- },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
        -- awful.statusbar(c):set_widget(menubar)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.disconnect_signal("request::activate", awful.ewmh.activate)
function awful.ewmh.activate(c)
    if c:isvisible() then
        client.focus = c
        c:raise()
    end
end
client.connect_signal("request::activate", awful.ewmh.activate)

-- }}}
