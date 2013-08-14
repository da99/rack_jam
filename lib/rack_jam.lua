

local setmetatable = setmetatable
local print        = print
local select       = select
local error        = error
local unpack       = unpack

local _            = require("underscore")



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
  setmetatable(r, {__index = Rack.meta});
  r._FUNCS = {
    TOP    = {},
    BEFORE = {},
    MIDDLE = {},
    AFTER  = {},
    BOTTOM = {}
  };

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

function Rack.meta:RUN()

  local req  = {}
  local resp = {}
  local route_stop = false;
  local func = function (func)
    local result = func(req, resp)
    if result then
      resp.content = resp;
      route_stop = true
      return true
    end
  end

  _.detect(self._FUNCS.BEFORE_ALL, func);

  if not route_stop then
    _.detect(self._FUNCS.BEFORE, func);
  end -- if

  if not route_stop then
    _.detect(self._FUNCS.ROUTE, func);
  end -- if

  _.detect(self._FUNCS.AFTER, func);

  _.detect(self._FUNCS.AFTER_ALL, func);

end -- func

-- -----------------------------------------
-- Done
-- -----------------------------------------
return Rack









