
package = "rack-lua"
version = "0.1-0"
source = {
  url = "http://github.com/da99/rack-lua.git",
  tag = "0.1-0",
  dir = "."
}
description = {
  summary = "Playing around with Rack-inspired DSL.",
  detailed = [[
    Don't use this. You won't like it.
  ]],
  homepage = "http://github.com/da99/rack-lua",
  license = "MIT/X11",
  maintainer = "da99@da99"
}
dependencies = {
  "lua >= 5.1",
  "penlight >= 0.1",
  "underscore >= 0.1"
}
build = {
  type = "builtin",
  modules = {
    rack = "lib/rack.lua",
  }
}
