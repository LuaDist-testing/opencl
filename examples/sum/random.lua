#!/usr/bin/env luajit
------------------------------------------------------------------------------
-- Random distributions.
-- Copyright © 2013–2015 Peter Colberg.
-- Distributed under the MIT license. (See accompanying file LICENSE.)
------------------------------------------------------------------------------

local _M = {}

-- Cache library functions.
local random, sqrt, log = math.random, math.sqrt, math.log

-- Returns two variates from standard normal distribution.
-- G. Marsaglia and T. Bray, SIAM Review, 6 (1964), 260.
-- http://dx.doi.org/10.1137/1006063
function _M.normal()
  local v, w, s
  repeat
    v = 2 * random() - 1
    w = 2 * random() - 1
    s = v * v + w * w
  until s < 1
  local t = sqrt(-2 * log(s) / s)
  return v * t, w * t
end

return _M
