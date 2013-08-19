

local setmetatable = setmetatable
local print        = print
local select       = select
local error        = error
local unpack       = unpack

local _            = require("underscore")
local Mid_Jam      = require("mid_jam")



-- -----------------------------------------
-- Clear globals. --------------------------
-- -----------------------------------------
setfenv(1, {})
-- -----------------------------------------

local Rack = {
  meta = {}
}

function Rack.new()
  local r = {}
  setmetatable(r, {__index = Rack.meta})

  r.mid_jam = Mid_Jam.new()

  r._FUNCS  = {
    TOP     = {},
    BEFORE  = {},
    MIDDLE  = {},
    AFTER   = {},
    BOTTOM  = {}
  }

  return r
end -- func


-- -----------------------------------------
-- "instance" functions
-- -----------------------------------------

-- -----------------------------------------

function Rack.meta:VERY_TOP(func)
  _.unshift(self._FUNCS.TOP, func)
  return func
end -- func

function Rack.meta:TOP(func)
  _.unshift(self._FUNCS.BEFORE, func)
  return func
end -- func

function Rack.meta:BEFORE(func)
  _.push(self._FUNCS.BEFORE, func)
  return func
end -- func

function Rack.meta:MIDDLE(func)
  _.push(self._FUNCS.MIDDLE, func)
  return func
end -- func

function Rack.meta:AFTER(func)
  _.unshift(self._FUNCS.AFTER, func)
  return func
end -- func

function Rack.meta:BOTTOM(func)
  _.push(self._FUNCS.AFTER, func)
  return func
end -- func

function Rack.meta:VERY_BOTTOM(func)
  _.push(self._FUNCS.BOTTOM, func)
  return func
end -- func

-- -----------------------------------------

function Rack.meta:RUN(req, resp, env)

  local route_stop = false
  local func = function (func)
    local result = func(req, resp, env)
    if result then
      self.resp.body = result
      route_stop = true
      return true
    end
  end

  _.detect(self._FUNCS.TOP, func)

  if not route_stop then
    _.detect(self._FUNCS.BEFORE, func)
  end -- if

  if not route_stop then
    _.detect(self._FUNCS.MIDDLE, func)
  end -- if

  _.detect(self._FUNCS.AFTER, func)

  _.detect(self._FUNCS.BOTTOM, func)

end -- func

-- -----------------------------------------
-- HTTP Methods
-- -----------------------------------------

Rack.New_Method = function (name)

  if not _.contains(Mid_Jam.HTTP_Methods, name) then
    Mid_Jam.New_Method(name)
  end

  Rack.meta[name] = function (self, ...)
    local me = self
    local f  = me.mid_jam[name](me.mid_jam, ...)
    me:MIDDLE(f)
    return f
  end

  return Rack

end -- func

-- HEAD, GET, etc. -------------------------
_.each(Mid_Jam.HTTP_Methods, function (m)
  Rack.New_Method(m)
end)

-- -----------------------------------------

-- -----------------------------------------
-- Done
-- -----------------------------------------
return Rack









