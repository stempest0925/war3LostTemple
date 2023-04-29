local fs = require 'bee.filesystem'
local ydwe = require 'tools.ydwe'
local subprocess = require 'bee.subprocess'

if not ydwe then
    return
end

local root = fs.path(arg[1])
if not fs.exists(root / '.w3x') then
    print('地图不存在', root / '.w3x')
    return
end

subprocess.spawn {
    ydwe / 'ydwe.exe',
    '-war3',
    '-loadfile', root / '.w3x',
}
