
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":BEFORE", function ()
  it("runs functions before middle", function ()
    local r = Rack.new()
    local o = {}

    r:AFTER( function () _.push(o, 3) end)
    r:MIDDLE(function () _.push(o, 2) end)
    r:BEFORE(function () _.push(o, 1) end)
    r:RUN()

    assert.same({1,2,3}, o)
  end)

  it("runs functions after VERY_TOP functions", function ()
    local r = Rack.new()
    local o = {}

    r:BEFORE(function () _.push(o, 2) end)
    r:MIDDLE(function () _.push(o, 3) end)
    r:AFTER( function () _.push(o, 4) end)
    r:VERY_TOP(function () _.push(o, 1) end)
    r:RUN()

    assert.same({1,2,3, 4}, o)
  end)

  it("stops running other BEFORE functions if content is returned", function ()
    local r = Rack.new()
    local o = {}

    r:BEFORE(function () _.push(o, 1) end)
    r:BEFORE(function () _.push(o, 2); return "done" end)
    r:BEFORE(function () _.push(o, 3) end)
    r:RUN()

    assert.same({1,2}, o)
  end)

  it("does not run MIDDLE functions if content is returned", function ()
    local r = Rack.new()
    local o = {}

    r:BEFORE(function () _.push(o, 1) end)
    r:BEFORE(function () _.push(o, 2); return "done" end)
    r:MIDDLE(function () _.push(o, 3) end)
    r:RUN()

    assert.same({1,2}, o)
  end)

  it("runs AFTER functions if content is returned", function ()
    local r = Rack.new()
    local o = {}

    r:BEFORE(function () _.push(o, 1) end)
    r:BEFORE(function () _.push(o, 2); return "done" end)
    r:AFTER(function () _.push(o, 4) end)
    r:AFTER(function () _.push(o, 3) end)
    r:RUN()

    assert.same({1,2,3,4}, o)
  end);

  it("runs VERY_BOTTOM functions if content is returned", function ()
    local r = Rack.new()
    local o = {}

    r:BEFORE(function () _.push(o, 1) end)
    r:BEFORE(function () _.push(o, 2); return "done" end)
    r:AFTER(function () _.push(o, 4) end)
    r:AFTER(function () _.push(o, 3) end)
    r:VERY_BOTTOM(function () _.push(o, 5) end)
    r:RUN()

    assert.same({1,2,3,4,5}, o)
  end);
end)



