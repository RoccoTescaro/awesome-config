-- ERROR handling
local console = require("console")

-- startup errors --
if awesome.startup_errors 
then
    console.log{"ERROR","startup",awesome.startup_errors}
end

-- runtime errors -- #TODO not sure if works, to fix prob
do
    local err_flag = false
    
    awesome.connect_signal(
        "debug::error", 
        function (err_msg)
            if err_flag then return end
            err_flag = true
            
            console.log{"ERROR","runtime",tostring(err_msg)}

            err_flag = false
        end
    )
end
