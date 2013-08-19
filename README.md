

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
    print("  middle")
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

Usage: HTTP Methods
=====================

```lua
rj:GET('/hello-rusty', function (req, resp)
  return "<html><body>Hello</body></html>"
end)

--- That is the same as

local mj   = Mid_Jam.new()

local func = mj:GET('/hello', function (req, resp)
  return "<html><body>Hello</body></html>"
end)

rj:MIDDLE(func)

```

Note:
=====

(Mid\_Jam)[https://github.com/jam-lua/rack\_jam.git] is a tool
to generate functions that can be used in Rack\_Jam. The
check the `REQUEST_METHOD`, `PATH_INFO`, etc.

You don't have to know about it since `Rack\_Jam` uses
it in the background.
