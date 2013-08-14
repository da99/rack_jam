
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":TOP", function ()
  it("adds function to TOP of before table", function ()
    local r = Rack.new()
    local f1 = function () end
    local f2 = function () end
    r:TOP(f1);
    r:TOP(f2);

    assert.same(f1, r._FUNCS.BEFORE[2]);
    assert.same(f2, r._FUNCS.BEFORE[1]);
  end);
end);
