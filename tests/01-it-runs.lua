
local Rack = require("lib/rack_jam")
local _    = require("underscore")


describe(":RUN", function ()
  it("runs funcstions in defined order", function ()
    local r = Rack.new()
    local o = {}
    r:BEFORE(function ()
      _.push(o, 1);
    end)
    r:MIDDLE(function ()
      _.push(o, 2);
    end)
    r:AFTER(function ()
      _.push(o, 3);
    end)
    r:RUN();

    assert.same({1,2,3}, o);
  end);
end);


