-- This function returns a formatted string with the current battery status. It
-- can be used to populate a text widget in the awesome window manager. Based
-- on the "Gigamo Battery Widget" found in the wiki at awesome.naquadah.org

-- local naughty = require("naughty")
-- local beautiful = require("beautiful")
--
-- function batteryInfo(adapter)
--   local fh = io.open("/sys/class/power_supply/"..adapter.."/present", "r")
--   if fh == nil then
--     battery = "A/C"
--     icon = ""
--     percent = ""
--   else
--     local fcur = io.open("/sys/class/power_supply/"..adapter.."/energy_now")  
--     local fcap = io.open("/sys/class/power_supply/"..adapter.."/energy_full")
--     local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
--     local cur = fcur:read()
--     local cap = fcap:read()
--     local sta = fsta:read()
--     fcur:close()
--     fcap:close()
--     fsta:close()
--     battery = math.floor(cur * 100 / cap)
--   
--     if sta:match("Charging") then
--       icon = "⚡"
--       percent = "%"
--     elseif sta:match("Discharging") then
--       icon = "⚠"
--       percent = "%"
--       if tonumber(battery) < 15 then
--         naughty.notify({ title    = "Battery Warning"
--                , text     = "Battery low!".."  "..battery..percent.."  ".."left!"
--                , timeout  = 5
--                , position = "top_right"
--                , fg       = beautiful.fg_focus
--                , bg       = beautiful.bg_focus
--         })
--       end
--     end
--   end
--   return " "..icon..battery..percent.." "
-- end


-- creates a battery indicator widget
-- batterywidget = wibox.widget.textbox()

-- batwidget = awful.widget.progressbar()
-- batwidget:set_width(8)
-- batwidget:set_height(8)
-- batwidget:set_vertical(true)
-- batwidget:set_background_color(beautiful.bg_normal)
-- batwidget:set_border_color(beautiful.bg_normal)
-- batwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 0, 8 }, stops = { { 0, "#AECF96" }, { 0.5, "#88A175" }, { 1, "#FF5656" }}})
-- -- batwidget:set_color('#FF0000')

-- battery graph
batg = blingbling.line_graph({
    height = 21,
    width = 8,
    rounded_size = 0.5
})


-- icon
baticon = wibox.widget.background()
baticon_img = wibox.widget.imagebox()
baticon:set_widget(baticon_img)
baticon:set_bg(beautiful.arrow_bg_5)


local btimer = 0 -- battery timer in seconds
local binterval = 5 -- interval to check battery
local bnotify = 120 -- notify user every 2 min
local ac = false -- set flag if on ac power

vicious.register(batg, vicious.widgets.bat,
    function (widget, args)

        local blvl = args[2]

        if args[1] == "-" then
            -- on battery power

            -- ac power has just been disconnected since last check
            -- will send a notification
            if ac == true then
               -- display notification
                naughty.notify({
                    title = "Battery",
                    text = "You are now running on battery power",
                    position = "top_right",
                    timeout = 3,
                    icon = beautiful.battery_60,
                    screen = 1,
                    ontop = true
                })
            end

            -- set ac power flag to false
            ac = false
            local nicon = beautiful.battery_40
            local msg = "Your battery is dying."

            if blvl >= 90 then
                baticon_img:set_image(beautiful.battery_100)
            elseif blvl >= 70 then
                baticon_img:set_image(beautiful.battery_80)
            elseif blvl >= 50 then
                baticon_img:set_image(beautiful.battery_60)
            elseif blvl >= 30 then
                baticon_img:set_image(beautiful.battery_40)
            elseif blvl >= 10 then
                baticon_img:set_image(beautiful.battery_20)
            else
                baticon_img:set_image(beautiful.battery_00)
            end

            -- if below 40%, warn user
            if args[2] <= 40 then

                -- 30%+
                if (args[2] >= 30) then
                    msg = 'Your battery is dying. ' .. args[2] .. '%'
                    nicon = beautiful.battery_40
                -- 20% - 29%
                elseif (args[2] >= 20) then
                    msg = 'Your battery is dying, and you\'re basically doing nothing... ' .. args[2] .. '%'
                    nicon = beautiful.battery_20
                -- 10% - 19%
                elseif (args[2] >= 10) then
                    msg = 'Wow do you even care?' .. args[2] .. '%'
                    nicon = beautiful.battery_00
                -- 5% - 9%
                elseif (args[2] >= 5) then
                    msg = 'Maann, if you let me die, watch what happens. Do it. Bet you wont. You aint that crazy' .. args[2] .. '%'
                    nicon = beautiful.battery_00
                -- 2% - 4%
                elseif (args[2] >= 2) then
                    msg = 'WFFDKLSF:#@R:EF!!! Dude!! comemon!!!?' .. args[2] .. '%'
                    nicon = beautiful.battery_00
                -- 1% - anything else - you got bigger issues
                elseif (args[2] >= 1) then
                    msg = 'nah I\'m actually just shutting down now.. I wanted to turn off is the thing' .. args[2] .. '%'
                    nicon = beautiful.battery_empty
                end -- fi


                -- checks if enough time has passed to notify user
                if btimer >= bnotify then

                    -- display notification
                    naughty.notify({
                        title = args[2] .. "Battery",
                        text = msg,
                        position = "top_right",
                        timeout = 3,
                        icon = nicon,
                        screen = 1,
                        ontop = true
                    })

                    -- reset timer
                    btimer = 0
                end -- fi
            end -- fi
        else
            -- on AC power

            -- ac power has just been connected since last check
            -- will send a notification
            if ac == false then
               -- display notification
                naughty.notify({
                    title = "Battery",
                    text = "Now running on AC power",
                    position = "top_right",
                    timeout = 3,
                    icon = beautiful.battery_ac,
                    screen = 1,
                    ontop = true
                })
            end

            -- set ac power flag to true
            ac = true

            -- if statement to figure out which icon for menu bar
            if blvl >= 90 then
                baticon_img:set_image(beautiful.battery_100_charging)
            elseif blvl >= 70 then
                baticon_img:set_image(beautiful.battery_80_charging)
            elseif blvl >= 50 then
                baticon_img:set_image(beautiful.battery_60_charging)
            elseif blvl >= 30 then
                baticon_img:set_image(beautiful.battery_40_charging)
            elseif blvl >= 10 then
                baticon_img:set_image(beautiful.battery_20_charging)
            else
                baticon_img:set_image(beautiful.battery_ac)
            end
        end

        -- adds timer increment
        btimer = btimer + binterval

        return args[2]
    end, binterval, "BAT0")

-- battery icon
-- baticon:set_image(beautiful.widget_battery)





-- batterywidget_timer = timer({timeout = 1})
-- batterywidget_timer:connect_signal("timeout", function()
    -- batterywidget:set_text(batteryInfo("BAT0"))
-- end)
-- batterywidget_timer:start()


