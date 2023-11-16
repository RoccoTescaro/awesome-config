-- ERROR handling

local naughty = require("naughty")

-- startup errors --
if awesome.startup_errors 
then
    naughty.notify(
        { 
            preset = naughty.config.presets.critical,
            title = "[ERROR] - startup - ",
            text = awesome.startup_errors 
        }
    )
end

-- runtime errors --
do
    local err_flag = false
    
    awesome.connect_signal(
        "debug::error", 
        function (err_msg)
            if err_flag then return end
            err_flag = true
            
            naughty.notify(
                { 
                    preset = naughty.config.presets.critical,
                    title = "[ERROR] - runtime - ",
                    text = tostring(err_msg) 
                }
            )

            err_flag = false
        end
    )
end