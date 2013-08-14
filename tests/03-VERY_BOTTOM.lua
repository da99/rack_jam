
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":VERY_BOTTOM", function ()
  it("runs functions after all others", function ()
    local r = Rack.new()
    local o = {}
    r:VERY_BOTTOM( function () _.push(o, 4) end)
    r:AFTER( function () _.push(o, 3) end)
    r:MIDDLE(function () _.push(o, 2) end)
    r:BEFORE(function () _.push(o, 1) end)
    r:RUN()

    assert.same({1,2,3,4}, o)
  end)

  it("does not run other VERY_BOTTOM functions if content returned", function ()
    local r = Rack.new()
    local o = {}
    r:VERY_BOTTOM( function () _.push(o, 4); return "done" end)
    r:VERY_BOTTOM( function () _.push(o, 3); return "done" end)
    r:VERY_BOTTOM( function () _.push(o, 2); return "done" end)
    r:VERY_BOTTOM( function () _.push(o, 1); return "done" end)
    r:RUN()

    assert.same({4}, o)
  end)
end)


