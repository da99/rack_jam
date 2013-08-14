
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":BOTTOM", function ()
  it("adds function to bottom of AFTER table", function ()
    local r = Rack.new()
    local f1 = function () end
    local f2 = function () end

    r:BOTTOM(f1)
    r:BOTTOM(f2)

    assert.same(f1, r._FUNCS.AFTER[1]);
    assert.same(f2, r._FUNCS.AFTER[2]);
  end);
end);

