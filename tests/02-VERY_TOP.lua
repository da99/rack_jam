
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
  end)

  it("does not runs BEFORE functions if content returned", function ()
    local r = Rack.new()
    local o = {}
    r:BEFORE(function () _.push(o, 3) end)
    r:BEFORE(function () _.push(o, 4) end)
    r:VERY_TOP(function () _.push(o, 2); return "done" end)
    r:VERY_TOP(function () _.push(o, 1) end)
    r:RUN()

    assert.same({1,2}, o)
  end)

  it("does not runs MIDDLE functions if content returned", function ()
    local r = Rack.new()
    local o = {}
    r:MIDDLE(function () _.push(o, 3) end)
    r:MIDDLE(function () _.push(o, 4) end)
    r:VERY_TOP(function () _.push(o, 2); return "done" end)
    r:VERY_TOP(function () _.push(o, 1) end)
    r:RUN()

    assert.same({1,2}, o)
  end)

  it("runs AFTER functions if content returned", function ()
    local r = Rack.new()
    local o = {}
    r:AFTER(function () _.push(o, 4) end)
    r:AFTER(function () _.push(o, 3) end)
    r:VERY_TOP(function () _.push(o, 2); return "done" end)
    r:VERY_TOP(function () _.push(o, 1) end)
    r:RUN()

    assert.same({1,2,3,4}, o)
  end)

  it("runs VERY_BOTTOM functions if content returned", function ()
    local r = Rack.new()
    local o = {}
    r:VERY_BOTTOM(function () _.push(o, 3) end)
    r:VERY_BOTTOM(function () _.push(o, 4) end)
    r:VERY_TOP(function () _.push(o, 2); return "done" end)
    r:VERY_TOP(function () _.push(o, 1) end)
    r:RUN()

    assert.same({1,2,3,4}, o)
  end)

  it("does not run other VERY_TOP functions if content returned", function ()
    local r = Rack.new()
    local o = {}
    r:VERY_TOP( function () _.push(o, 4); return "done" end)
    r:VERY_TOP( function () _.push(o, 3); return "done" end)
    r:VERY_TOP( function () _.push(o, 2); return "done" end)
    r:VERY_TOP( function () _.push(o, 1); return "done" end)
    r:RUN()

    assert.same({1}, o)
  end)

end)

