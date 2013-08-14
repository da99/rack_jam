
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":VERY_TOP", function ()
  it("runs functions before all others", function ()
    local r = Rack.new()
    local o = {}
    r:BEFORE(function ()  _.push(o, 3) end)
    r:BEFORE(function ()  _.push(o, 4) end)
    r:VERY_TOP(function ()  _.push(o, 2) end)
    r:VERY_TOP(function ()  _.push(o, 1) end)
    r:RUN()

    assert.same({1,2,3,4}, o)
  end);
end);

