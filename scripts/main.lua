require 'scripts.lib.init'
local console = require 'jass.console'

console.enable = true
console.write("你好，世界")

_F.FogEnable(false)
_F.FogMaskEnable(false)

-- _U.toc("UI\\path.toc")
_U.createFrame('TEXT', "txtDemo").position(0.3, 0.3).size(0.1, 0.1).show()

console.write(_U.frameHandle)

-- _J.DzFrameHideInterface()
-- _J.DzFrameEditBlackBorders(0, 0)