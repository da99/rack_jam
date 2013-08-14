
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":BOTTOM", function ()
  it("runs functions after all other AFTER functions", function ()
    local r = Rack.new()
    local o = {}

    r:AFTER(function () _.push(o, 3) end)
    r:AFTER(function () _.push(o, 4) end)
    r:BOTTOM(function () _.push(o, 2) end)
    r:BOTTOM(function () _.push(o, 1) end)
    r:RUN()

    assert.same({4,3,2,1}, o)
  end);
end);

