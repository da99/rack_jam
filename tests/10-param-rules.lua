local assert   = assert
local require  = require
local describe = describe
local it       = it

local Rack     = require("lib/rack_jam")
local _        = require("underscore")

local ENV = {}
setfenv(1, ENV)

require('mid_jam.test_dsl').to(ENV)

describe("param rules", function ()

  it("does not run callback if param rules are not met", function ()
    local r = Rack.new()
    local o = {}

    r:GET("/:name")
    :param('name', 'length min', 7)
    :run(function ()
      _.push(o, 1)
    end)

    r:GET("/:name", function ()
      _.push(o, 1)
    end)

    r:RUN(GET('/hello'), {}, {})

    assert.same({1}, o)
  end)

  it("runs callback if param rules are met", function ()
    local r = Rack.new()
    local o = {}

    r:GET("/:name")
    :param('name', 'length min', 1)
    :run(function ()
      _.push(o, 5)
    end)

    r:GET("/:name", function ()
      _.push(o, 5)
    end)

    r:RUN(GET('/hello'), {}, {})

    assert.same({5,5}, o)
  end)

end) -- describe

