
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":AFTER", function ()
  it("adds function to top of AFTER table", function ()
    local r = Rack.new()
    local f1 = function () end
    local f2 = function () end

    r:AFTER(f1)
    r:AFTER(f2)

    assert.same(f1, r._FUNCS.AFTER[2]);
    assert.same(f2, r._FUNCS.AFTER[1]);
  end);
end);

