
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":AFTER", function ()
  it("runs functions after BEFORE, MIDDLE", function ()
    local r = Rack.new()
    local o = {}

    r:MIDDLE(function () _.push(o, 2) end)
    r:BEFORE(function () _.push(o, 1) end)
    r:AFTER( function () _.push(o, 4) end)
    r:AFTER( function () _.push(o, 3) end)
    r:RUN()

    assert.same({1,2,3,4}, o)
  end);
end);

