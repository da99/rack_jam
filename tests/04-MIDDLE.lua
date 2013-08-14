
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":MIDDLE", function ()
  it("runs functions after BEFORE", function ()
    local r = Rack.new()
    local o = {}

    r:MIDDLE(function () _.push(o, 2) end)
    r:BEFORE(function () _.push(o, 1) end)
    r:RUN()

    assert.same({1,2}, o)
  end)

  it("runs functions before AFTER", function ()
    local r = Rack.new()
    local o = {}

    r:MIDDLE(function () _.push(o, 3) end)
    r:AFTER( function () _.push(o, 4) end)
    r:RUN()

    assert.same({3, 4}, o)
  end)

  it("stops when a function returns a truthy val", function ()
    local r = Rack.new()
    local o = {}

    r:MIDDLE(function () _.push(o, 1) end)
    r:MIDDLE(function () _.push(o, 2) return "done" end)
    r:MIDDLE(function () _.push(o, 3) end)
    r:RUN()

    assert.same({1,2}, o)
  end)

  it("saves return value to resp.body", function ()
    local r = Rack.new()

    r:MIDDLE(function () return "done" end)
    r:RUN()

    assert.same("done", r.resp.body)
  end);
end)
