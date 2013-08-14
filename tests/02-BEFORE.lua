
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":BEFORE", function ()
  it("adds function to bottom of BEFORE table", function ()
    local r = Rack.new()
    local f = function () end
    r:BEFORE(f);

    assert.same(f, r._FUNCS.BEFORE[1]);
  end);
end);
