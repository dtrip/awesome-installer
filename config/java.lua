
function delay_raise ()
    -- 5 ms ages in computer time, but I won't notice it.
    local raise_timer = timer { timeout = 0.005 }
    raise_timer:add_signal("timeout",
    function()
        if client.focus then
            client.focus:raise()
        end
        raise_timer:stop()
    end)
    raise_timer:start()
end
