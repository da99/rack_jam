

Rack-Jam
========

*NOTE:* Not ready yet.


Usage
=====

    ```lua
    local Rack_Jam = require("rack_jam")

    local rj = Rack_Jam.new()

    rj:BEFORE(function (req, resp)
        print("BEFORE #1")
    end)

    rj:BEFORE(function (req, resp)
        print("BEFORE #2")
    end)

    rj:MIDDLE(function (req, resp)
        print("  middle  ")
    end)

    rj:AFTER(function (req, resp)
        print("AFTER #1")
    end)

    rj:AFTER(function (req, resp)
        print("AFTER #2")
    end)

    rj:RUN()


    -- output --
    -- BEFORE #1
    -- BEFORE #2
    --   middle  
    -- AFTER #2
    -- AFTER #1
    ```
