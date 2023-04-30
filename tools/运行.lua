local fs = require 'bee.filesystem'
local subprocess = require 'bee.subprocess'

local map = fs.path(arg[1])
if not fs.exists(map) then
    print('地图不存在', map)
    return
end

-- local w2l = fs.path(arg[2])
-- do obj project

local ydwe = fs.path(arg[3])
if not fs.exists(ydwe) then
    print('YDWE路径不存在', ydwe)
    return
end

subprocess.spawn { ydwe, '-launchwar3', '-loadfile', map, }
