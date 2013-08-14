
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":VERY_TOP", function ()
  it("adds function to TOP of TOP table", function ()
    local r = Rack.new()
    local f1 = function () end
    local f2 = function () end
    r:VERY_TOP(f1);
    r:VERY_TOP(f2);

    assert.same(f1, r._FUNCS.TOP[2]);
    assert.same(f2, r._FUNCS.TOP[1]);
  end);
end);
