
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":VERY_BOTTOM", function ()
  it("adds function to BOTTOM of BOTTOM table", function ()
    local r = Rack.new()
    local f1 = function () end
    local f2 = function () end
    r:VERY_BOTTOM(f1);
    r:VERY_BOTTOM(f2);

    assert.same(f1, r._FUNCS.BOTTOM[1]);
    assert.same(f2, r._FUNCS.BOTTOM[2]);
  end);
end);
